page 51254 "BuyerStyle PO Search Listpart2"
{
    PageType = ListPart;
    SourceTable = "Buyer Style PO Search GRN";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    //CardPageId = "Posted Purchase Receipt";
    Caption = 'GRN Details';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("GRN No"; Rec."GRN No")
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

    actions
    {
        area(Processing)
        {
            action("View GRN")
            {
                ApplicationArea = All;
                Image = ViewOrder;
                // PromotedOnly = true;
                // Promoted = true;

                trigger OnAction()
                var
                    GRNRec: Record "Purch. Rcpt. Header";
                begin
                    GRNRec.Reset();
                    GRNRec.SetRange("No.", rec."GRN No");

                    if GRNRec.FindSet() then begin
                        Page.RunModal(136, GRNRec);
                    end
                    else
                        Error('Cannot find GRN details');
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        LoginRec: Page "Login Card";
        LoginSessionsRec: Record LoginSessions;
        UsersetupRec: Record "User Setup";
        BuyerStylePoSearchRec: Record "Buyer Style PO Search";
        BuyerStyleGRNSearchRec: Record "Buyer Style PO Search GRN";
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
        end;

        //Delete old Records
        BuyerStyleGRNSearchRec.Reset();
        BuyerStyleGRNSearchRec.SetRange("Secondary UserID", LoginSessionsRec."Secondary UserID");
        if BuyerStyleGRNSearchRec.findset then
            BuyerStyleGRNSearchRec.DeleteAll();

        rec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");

    end;
}