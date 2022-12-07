page 50518 "Hourly Production List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Hourly Production Master";
    CardPageId = "Hourly Production Card";
    SourceTableView = sorting("No.") order(descending);


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Prod Date"; rec."Prod Date")
                {
                    ApplicationArea = All;
                }

                field("Factory Name"; rec."Factory Name")
                {
                    ApplicationArea = All;
                    Caption = 'Factory';
                }

                field(Type; rec.Type)
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
        HourlyProdLinesRec: Record "Hourly Production Lines";
    begin
        HourlyProdLinesRec.SetRange("No.", rec."No.");
        HourlyProdLinesRec.DeleteAll();
    end;
}