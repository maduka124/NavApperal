page 50334 "Learning Curve"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Learning Curve";
    CardPageId = "Learning Curve Card";
    SourceTableView = sorting("No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Curve No';
                }

                field(Type; rec.Type)
                {
                    ApplicationArea = All;
                }

                field(Day1; rec.Day1)
                {
                    ApplicationArea = All;
                    Caption = 'Day 1';
                }

                field(Day2; rec.Day2)
                {
                    ApplicationArea = All;
                    Caption = 'Day 2';
                }

                field(Day3; rec.Day3)
                {
                    ApplicationArea = All;
                    Caption = 'Day 3';
                }

                field(Day4; rec.Day4)
                {
                    ApplicationArea = All;
                    Caption = 'Day 4';
                }

                field(Day5; rec.Day5)
                {
                    ApplicationArea = All;
                    Caption = 'Day 5';
                }

                field(Day6; rec.Day6)
                {
                    ApplicationArea = All;
                    Caption = 'Day 6';
                }

                field(Day7; rec.Day7)
                {
                    ApplicationArea = All;
                    Caption = 'Day 7';
                }

                field(Active; rec.Active)
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