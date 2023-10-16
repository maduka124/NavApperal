page 50363 "Daily Finishing Out"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = false;
    SourceTable = ProductionOutHeader;
    SourceTableView = sorting("No.") order(descending) where(Type = filter('Fin'));
    CardPageId = "Daily Finishing Out Card";



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

            // LoginSessionsRec.Reset();
            // LoginSessionsRec.SetRange(SessionID, SessionId());
            // if LoginSessionsRec.FindSet() then
            //     rec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
        end
        else begin   //logged in
            //rec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
        end;

        UserRec.Reset();
        UserRec.Get(UserId);

        if UserRec."Factory Code" <> '' then
            Rec.SetFilter("Factory Code", '=%1', UserRec."Factory Code");

    end;


    trigger OnDeleteRecord(): Boolean
    var
        NavAppCodeUnit: Codeunit NavAppCodeUnit;
        UserRec: Record "User Setup";
        NavappProdRec: Record "NavApp Prod Plans Details";
        ProdOutHeaderRec: Record ProductionOutHeader;
    begin

        UserRec.Reset();
        UserRec.Get(UserId);


        if rec.Type = rec.Type::Fin then begin
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




        if UserRec."Factory Code" <> '' then begin
            if (UserRec."Factory Code" <> rec."Factory Code") then
                Error('You are not authorized to delete this record.')
            else begin
                NavappProdRec.Reset();
                NavappProdRec.SetRange("Factory No.", Rec."Factory Code");
                NavappProdRec.SetRange("Style No.", Rec."Style No.");
                NavappProdRec.SetRange(PlanDate, Rec."Prod Date");
                NavappProdRec.SetRange("PO No.", Rec."PO No");
                NavappProdRec.SetRange("Lot No.", Rec."Lot No.");
                NavappProdRec.SetRange(ProdUpd, 1);
                if NavappProdRec.FindSet() then begin
                    Error('Production updated against this entry. You cannot delete it.');
                end;

            end;
        end
        else
            Error('You are not authorized to delete records.');

        NavAppCodeUnit.Delete_Prod_Records(Rec."No.", Rec."Style No.", Rec."Lot No.", 'OUT', 'Fin', Rec.Type::Fin);


    end;
}