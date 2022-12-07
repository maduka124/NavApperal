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
                    Caption = 'Resource';
                }

                field("PO No"; rec."PO No")
                {
                    ApplicationArea = All;
                }

                field("Output Qty"; rec."Output Qty")
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

    end;



    trigger OnDeleteRecord(): Boolean
    var
        NavAppCodeUnit: Codeunit NavAppCodeUnit;
    begin
        NavAppCodeUnit.Delete_Prod_Records(rec."No.", rec."Style No.", rec."PO No", 'IN', 'Saw', rec.Type::Saw);
        NavAppCodeUnit.Delete_Prod_Records(rec."No.", rec."Style No.", rec."PO No", 'OUT', 'Saw', rec.Type::Saw);
    end;
}