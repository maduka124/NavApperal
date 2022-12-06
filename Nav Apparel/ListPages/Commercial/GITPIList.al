page 50538 "GIT Baseon PI List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = GITBaseonPI;
    CardPageId = "GIT Baseon PI Card";
    Editable = false;
    SourceTableView = sorting("GITPINo.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("GITPINo."; Rec."GITPINo.")
                {
                    ApplicationArea = All;
                    Caption = 'Seq No';
                }

                field("Suppler Name"; Rec."Suppler Name")
                {
                    ApplicationArea = All;
                    Caption = 'Suppler';
                }

                field("Invoice No"; Rec."Invoice No")
                {
                    ApplicationArea = All;
                }

                field("Invoice Date"; Rec."Invoice Date")
                {
                    ApplicationArea = All;
                }

                field("Invoice Value"; Rec."Invoice Value")
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
        GITBaseonPILineRec: Record GITBaseonPILine;
        GITPIPIRec: Record GITPIPI;
    begin
        GITBaseonPILineRec.Reset();
        GITBaseonPILineRec.SetRange("GITPINo.", Rec."GITPINo.");
        GITBaseonPILineRec.DeleteAll();

        GITPIPIRec.Reset();
        GITPIPIRec.SetRange("GITPINo.", Rec."GITPINo.");
        GITPIPIRec.DeleteAll();
    end;
}