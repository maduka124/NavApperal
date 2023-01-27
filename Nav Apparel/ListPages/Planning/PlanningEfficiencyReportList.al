page 50846 "PlanningEfficiencyReportList"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = PlanEffDashboardReportTable;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Year; rec.Year)
                {
                    ApplicationArea = All;
                }

                field(MonthName; rec.MonthName)
                {
                    ApplicationArea = All;
                }

                field(MonthNo; rec.MonthNo)
                {
                    ApplicationArea = All;
                }

                field("Factory No."; rec."Factory No.")
                {
                    ApplicationArea = All;
                }

                field("Factory Name"; rec."Factory Name")
                {
                    ApplicationArea = All;
                    Caption = 'Day 3';
                }

                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All;
                }

                field("Line Name"; rec."Line Name")
                {
                    ApplicationArea = All;
                }

                field("Style No."; rec."Style No.")
                {
                    ApplicationArea = All;
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                }

                field("Factory Eff."; rec."Factory Eff.")
                {
                    ApplicationArea = All;
                }

                field("Line Eff."; rec."Line Eff.")
                {
                    ApplicationArea = All;
                }

                field("Style Eff."; rec."Style Eff.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    // trigger OnOpenPage()
    // var
    //     LoginRec: Page "Login Card";
    //     LoginSessionsRec: Record LoginSessions;
    // begin

    //     //Check whether user logged in or not
    //     LoginSessionsRec.Reset();
    //     LoginSessionsRec.SetRange(SessionID, SessionId());

    //     if not LoginSessionsRec.FindSet() then begin  //not logged in
    //         Clear(LoginRec);
    //         LoginRec.LookupMode(true);
    //         LoginRec.RunModal();

    //         // LoginSessionsRec.Reset();
    //         // LoginSessionsRec.SetRange(SessionID, SessionId());
    //         // if LoginSessionsRec.FindSet() then
    //         //     rec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
    //     end
    //     else begin   //logged in
    //         //rec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
    //     end;

    // end;
}