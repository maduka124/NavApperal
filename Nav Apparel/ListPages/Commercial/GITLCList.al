page 50527 "GIT Baseon LC List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = GITBaseonLC;
    CardPageId = "GIT Baseon LC Card";
    Editable = false;
    SourceTableView = sorting("GITLCNo.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("GITLCNo."; Rec."GITLCNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Seq No';
                }

                field("Suppler Name"; Rec."Suppler Name")
                {
                    ApplicationArea = All;
                    Caption = 'Suppler';
                }

                field("ContractLC No"; Rec."ContractLC No")
                {
                    ApplicationArea = All;
                }

                field("B2B LC No."; Rec."B2B LC No.")
                {
                    ApplicationArea = All;
                    Caption = 'B2B LC No';
                }

                field("B2B LC Value"; Rec."B2B LC Value")
                {
                    ApplicationArea = All;
                }

                field("B2B LC Balance"; Rec."B2B LC Balance")
                {
                    ApplicationArea = All;
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
        GITBaseonLCLineRec: Record GITBaseonLCLine;
    begin
        GITBaseonLCLineRec.SetRange("GITLCNo.", Rec."GITLCNo.");
        GITBaseonLCLineRec.DeleteAll();
    end;

    trigger OnAfterGetRecord()
    var
        GITRec: Record GITBaseonLC;
        Tot: Decimal;
    begin
        GITRec.Reset();
        GITRec.SetRange("B2B LC No.", rec."B2B LC No.");
        if GITRec.FindSet() then begin
            repeat
                tot += GITRec."Invoice Value";
            until GITRec.Next() = 0;
        end;
        rec."B2B LC Balance" := rec."B2B LC Value" - Tot;
        rec.Modify();
    end;
}