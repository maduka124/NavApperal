page 50474 "Maning Level List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Maning Level";
    CardPageId = "Maning Level Card";
    Caption = 'Maning Levels';
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
                    Caption = 'Maning No';
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'Line';
                }

                field(Type; rec.Type)
                {
                    ApplicationArea = All;
                }

                field(Val; rec.Val)
                {
                    ApplicationArea = All;
                    Caption = 'Qty';
                }

                field(Eff; rec.Eff)
                {
                    ApplicationArea = All;
                    Caption = 'Expected Eff %';
                }

                field("Total SMV"; rec."Total SMV")
                {
                    ApplicationArea = All;
                    Caption = 'Total Sewing SMV';
                }

                field("Sewing SMV"; rec."Sewing SMV")
                {
                    ApplicationArea = All;
                    Caption = 'Sewing SMV';
                }

                field("Manual SMV"; rec."Manual SMV")
                {
                    ApplicationArea = All;
                    Caption = 'Manual SMV';
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
        ManingLevelsLineRec: Record "Maning Levels Line";
    begin

        ManingLevelsLineRec.Reset();
        ManingLevelsLineRec.SetRange("No.", rec."No.");
        ManingLevelsLineRec.DeleteAll();

    end;
}