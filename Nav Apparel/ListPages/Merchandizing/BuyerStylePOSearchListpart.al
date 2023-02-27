page 51249 "Buyer Style PO Search Listpart"
{
    PageType = ListPart;
    SourceTable = "Buyer Style PO Search";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("PO No"; Rec."PO No")
                {
                    ApplicationArea = All;
                }

                field(Supplier; Rec.Supplier)
                {
                    ApplicationArea = All;
                }

                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                    Caption = 'Factory';
                }

                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }

                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }

                field("Amount Including VAT"; Rec."Amount Including VAT")
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
        UsersetupRec: Record "User Setup";
        BuyerStylePoSearchRec: Record "Buyer Style PO Search";
    begin

        //Check whether user logged in or not
        LoginSessionsRec.Reset();
        LoginSessionsRec.SetRange(SessionID, SessionId());

        if not LoginSessionsRec.FindSet() then begin  //not logged in
            Clear(LoginRec);
            LoginRec.LookupMode(true);
            LoginRec.RunModal();

            LoginSessionsRec.Reset();
            LoginSessionsRec.SetRange(SessionID, SessionId());
            LoginSessionsRec.FindSet();
            //     "Secondary UserID" := LoginSessionsRec."Secondary UserID";
        end;
        // else begin   //logged in
        //     "Secondary UserID" := LoginSessionsRec."Secondary UserID";
        // end;

        // BuyerStylePoSearchRec.Reset();
        // BuyerStylePoSearchRec.SetRange("Secondary UserID", LoginSessionsRec."Secondary UserID");
        // BuyerStylePoSearchRec.FindSet();

        // LoginSessionsRec.SetRange("Secondary UserID", Rec."Secondary UserID");
        // LoginSessionsRec.FindSet()

        rec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");

    end;
}