page 50429 "Sample Room List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sample Room";
    CardPageId = "Sample Room Card";
    SourceTableView = sorting("Sample Room No.") order(descending);


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Sample Room No."; rec."Sample Room No.")
                {
                    ApplicationArea = All;
                    Caption = 'Sample Room No';
                }

                field("Sample Room Name"; rec."Sample Room Name")
                {
                    ApplicationArea = All;
                }

                field("Global Dimension Code"; rec."Global Dimension Code")
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