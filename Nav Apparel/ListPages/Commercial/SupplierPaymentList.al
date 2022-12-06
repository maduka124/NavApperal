page 50551 "SupplierPaymentList"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = SupplierPayments;
    SourceTableView = sorting(Year, "Suppler Name") order(ascending);
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    Caption = 'Supplier Wise Payment List';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Suppler Name"; Rec."Suppler Name")
                {
                    ApplicationArea = All;
                    Caption = 'Suppler';
                }

                field(January; Rec.January)
                {
                    ApplicationArea = All;
                }

                field(February; Rec.February)
                {
                    ApplicationArea = All;
                }

                field(March; Rec.March)
                {
                    ApplicationArea = All;
                }

                field(April; Rec.April)
                {
                    ApplicationArea = All;
                }

                field(May; Rec.May)
                {
                    ApplicationArea = All;
                }

                field(June; Rec.June)
                {
                    ApplicationArea = All;
                }

                field(July; Rec.July)
                {
                    ApplicationArea = All;
                }

                field(August; Rec.August)
                {
                    ApplicationArea = All;
                }

                field(September; Rec.September)
                {
                    ApplicationArea = All;
                }

                field(October; Rec.October)
                {
                    ApplicationArea = All;
                }

                field(November; Rec.November)
                {
                    ApplicationArea = All;
                }

                field(December; Rec.December)
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
}