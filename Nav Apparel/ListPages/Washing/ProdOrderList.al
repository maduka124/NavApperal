page 50756 JobCardList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Production Order";
    CardPageId = "Firm Planned Prod. Order";
    Caption = 'Job Card/Production Order';
    SourceTableView = sorting(Status, "No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Job Card/Prod. Order No';
                }

                field(Buyer; rec.Buyer)
                {
                    ApplicationArea = All;
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                }

                field(Color; rec.Color)
                {
                    ApplicationArea = All;
                }

                field("Wash Type"; rec."Wash Type")
                {
                    ApplicationArea = All;
                }

                field(Fabric; rec.Fabric)
                {
                    ApplicationArea = All;
                }

                field("Gament Type"; rec."Gament Type")
                {
                    ApplicationArea = All;
                }

                field("Sample/Bulk"; rec."Sample/Bulk")
                {
                    ApplicationArea = All;
                }

                field("Machine Type"; rec."Machine Type")
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