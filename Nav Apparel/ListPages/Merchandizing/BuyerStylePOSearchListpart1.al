page 51249 "BuyerStyle PO Search Listpart1"
{
    PageType = ListPart;
    SourceTable = "Buyer Style PO Search New";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    //CardPageId = "Purchase Order";
    Caption = 'PO Details';

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

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = true;
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
            action("View PO")
            {
                ApplicationArea = All;
                Image = ViewOrder;
                // PromotedOnly = true;
                // Promoted = true;

                trigger OnAction()
                var
                    POPage: Page "Purchase Order";
                    PORec: Record "Purchase Header";
                begin
                    PORec.Reset();
                    PORec.SetRange("No.", rec."PO No");
                    PORec.SetFilter("Document Type", '=%1', PORec."Document Type"::Order);

                    if PORec.FindSet() then begin
                        Page.RunModal(50, PORec);
                    end
                    else
                        Error('Cannot find PO details');
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        LoginRec: Page "Login Card";
        LoginSessionsRec: Record LoginSessions;
        UsersetupRec: Record "User Setup";
        BuyerStylePoSearchRec: Record "Buyer Style PO Search New";
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

        //Delete Old Records
        BuyerStylePoSearchRec.Reset();
        BuyerStylePoSearchRec.SetRange("Secondary UserID", LoginSessionsRec."Secondary UserID");
        if BuyerStylePoSearchRec.findset then
            BuyerStylePoSearchRec.DeleteAll();


        rec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");

    end;
}