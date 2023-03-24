page 50356 "Daily Sewing In/Out"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ProductionOutHeader;
    SourceTableView = sorting("No.") order(descending) where(Type = filter('Saw'));
    CardPageId = "Daily Sewing In/Out Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Prod Date"; rec."Prod Date")
                {
                    ApplicationArea = All;
                    Caption = 'Production Date';
                }

                field("Resource Name"; rec."Resource Name")
                {
                    ApplicationArea = All;
                    Caption = 'Resource';
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("PO No"; rec."PO No")
                {
                    ApplicationArea = All;
                }
                //Mihiranga 2023/02/26
                field("Input Qty"; Rec."Input Qty")
                {
                    ApplicationArea = All;
                }
                //
                field("Output Qty"; rec."Output Qty")
                {
                    ApplicationArea = All;
                }

                field("Prod Updated"; rec."Prod Updated")
                {
                    ApplicationArea = All;
                    Caption = 'Prod. Updated Status';
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
        if UserRec."Factory Code" <> '' then begin
            rec.SetFilter("Factory Code", '=%1', UserRec."Factory Code");
        end;
    end;


    trigger OnAfterGetRecord()
    var
        UserRec: Record "User Setup";
    begin
        UserRec.Reset();
        UserRec.Get(UserId);
        if UserRec."Factory Code" <> '' then begin
            if rec."Factory Code" <> UserRec."Factory Code" then
                Error('You are not authorized to view other factory information.');
        end;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        NavAppCodeUnit: Codeunit NavAppCodeUnit;
    begin
        if rec."Prod Updated" = 1 then
            Error('Production updated against this entry. You cannot delete it.');

        NavAppCodeUnit.Delete_Prod_Records(rec."No.", rec."Style No.", rec."PO No", 'IN', 'Saw', rec.Type::Saw);
        NavAppCodeUnit.Delete_Prod_Records(rec."No.", rec."Style No.", rec."PO No", 'OUT', 'Saw', rec.Type::Saw);
    end;
}