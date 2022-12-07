page 50814 "Factory Manpower Budget List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = FactoryManpowerBudgetHeader;
    SourceTableView = sorting(Date, "Factory Name") order(descending);
    CardPageId = "Factory Manpower Budget Card";
    Caption = 'Factory Manpower Budget List';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                }

                field("Factory Name"; rec."Factory Name")
                {
                    ApplicationArea = All;
                }

                field(Date; rec.Date)
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
        ManpowBudLineRec: Record FactoryManpowerBudgetLine;
    begin
        ManpowBudLineRec.Reset();
        ManpowBudLineRec.SetRange("No.", rec."No.");
        if ManpowBudLineRec.FindSet() then begin
            ManpowBudLineRec.DeleteAll();
        end;
    end;
}