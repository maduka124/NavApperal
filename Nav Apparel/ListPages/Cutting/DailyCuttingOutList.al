page 50352 "Daily Cutting Out"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = false;
    SourceTable = ProductionOutHeader;
    SourceTableView = sorting("No.") order(descending) where(Type = filter('Cut'));
    CardPageId = "Daily Cutting Out Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Prod Date"; Rec."Prod Date")
                {
                    ApplicationArea = All;
                    Caption = 'Production Date';
                }

                field("Resource Name"; Rec."Resource Name")
                {
                    ApplicationArea = All;
                    Caption = 'Resource';
                }

                field("Style Name"; Rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("PO No"; Rec."PO No")
                {
                    ApplicationArea = All;
                }

                field("Output Qty"; Rec."Output Qty")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        LoginRec: Page "Login Card";
        LoginSessionsRec: Record LoginSessions;
        UserRec: Record "User Setup";
    begin
        //Check whether user logged in or not
        LoginSessionsRec.Reset();
        LoginSessionsRec.SetRange(SessionID, SessionId());
        if not LoginSessionsRec.FindSet() then begin  //not logged in
            Clear(LoginRec);
            LoginRec.LookupMode(true);
            LoginRec.RunModal();
        end;

        UserRec.Reset();
        UserRec.Get(UserId);
        if UserRec."Factory Code" <> '' then
            rec.SetFilter("Factory Code", '=%1', UserRec."Factory Code");
    end;


    trigger OnDeleteRecord(): Boolean
    var
        ProdOutHeaderRec: Record ProductionOutHeader;
        NavAppCodeUnit: Codeunit NavAppCodeUnit;
        UserRec: Record "User Setup";
        SawOut: Integer;
        SawIn: Integer;
    begin
        SawIn := 0;
        ProdOutHeaderRec.Reset();
        ProdOutHeaderRec.SetRange("Style No.", Rec."Style No.");
        ProdOutHeaderRec.SetRange("PO No", Rec."PO No");
        ProdOutHeaderRec.SetRange("Lot No.", Rec."Lot No.");
        ProdOutHeaderRec.SetRange(Type, ProdOutHeaderRec.Type::Saw);
        if ProdOutHeaderRec.FindSet() then begin
            repeat
                SawIn += ProdOutHeaderRec."Input Qty";
            until ProdOutHeaderRec.Next() = 0;
        end;
        SawOut := 0;
        ProdOutHeaderRec.Reset();
        ProdOutHeaderRec.SetRange("Out Style No.", Rec."Style No.");
        ProdOutHeaderRec.SetRange("PO No", Rec."PO No");
        ProdOutHeaderRec.SetRange("Lot No.", Rec."Lot No.");
        ProdOutHeaderRec.SetRange(Type, ProdOutHeaderRec.Type::Saw);
        if ProdOutHeaderRec.FindSet() then begin
            repeat
                SawOut += ProdOutHeaderRec."Output Qty";
            until ProdOutHeaderRec.Next() = 0;
        end;

        if SawOut > SawIn - Rec."Output Qty" then
            Error('This Record Cannot delete');


        UserRec.Reset();
        UserRec.Get(UserId);
        if UserRec."Factory Code" <> '' then begin
            if (UserRec."Factory Code" <> rec."Factory Code") then
                Error('You are not authorized to delete this record.');
        end
        else
            Error('You are not authorized to delete records.');

        if rec.Type = rec.Type::Cut then begin
            ProdOutHeaderRec.Reset();
            ProdOutHeaderRec.SetRange("Prod Date", rec."Prod Date");
            ProdOutHeaderRec.SetRange("Factory Code", rec."Factory Code");
            ProdOutHeaderRec.SetFilter(Type, '=%1', ProdOutHeaderRec.Type::Saw);
            ProdOutHeaderRec.SetFilter("Prod Updated", '=%1', 1);
            if ProdOutHeaderRec.FindSet() then
                Error('Production updated against Date : %1 , Factory : %2 has been updates. You cannot delete this entry.', rec."Prod Date", rec."Factory Name");
        end;

        UserRec.Reset();
        UserRec.Get(UserId);
        if UserRec."Factory Code" <> '' then begin
            if (UserRec."Factory Code" <> rec."Factory Code") then
                Error('You are not authorized to delete this record.');
        end
        else
            Error('You are not authorized to delete records.');

        NavAppCodeUnit.Delete_Prod_Records(Rec."No.", Rec."Style No.", Rec."Lot No.", 'OUT', 'Cut', Rec.Type::Cut);
    end;
}