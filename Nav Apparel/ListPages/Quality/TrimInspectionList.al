page 50571 "Trim Inspection List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Purch. Rcpt. Header";
    SourceTableView = sorting("No.") order(descending) where(FabricPO = filter(false));
    //where("Trim Inspected" = filter(true));
    CardPageId = "Trim Inspection Card";
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'GRN No';
                }

                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = All;
                    Caption = 'GRN Date';
                }

                field("Buy-from Vendor Name"; rec."Buy-from Vendor Name")
                {
                    ApplicationArea = All;
                    Caption = 'Supplier';
                }

                field("Order No."; rec."Order No.")
                {
                    ApplicationArea = All;
                    Caption = 'PO No';
                }

                field("Trim Inspected"; rec."Trim Inspected")
                {
                    ApplicationArea = All;
                    Caption = 'Trim Inspected (Yes/No)';
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
}