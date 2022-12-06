page 50503 "Contract/LC List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Contract/LCMaster";
    CardPageId = "Contract/LC Card";
    Editable = false;
    SourceTableView = sorting("No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Seq No';
                }

                field("Contract No"; Rec."Contract No")
                {
                    ApplicationArea = All;
                    Caption = 'Contract/LC No';
                }

                field("Contract Value"; Rec."Contract Value")
                {
                    ApplicationArea = All;
                }

                field(Buyer; Rec.Buyer)
                {
                    ApplicationArea = All;
                }

                field(Season; Rec.Season)
                {
                    ApplicationArea = All;
                }

                field(Factory; Rec.Factory)
                {
                    ApplicationArea = All;
                }

                field("B2B Payment Type"; Rec."B2B Payment Type")
                {
                    ApplicationArea = All;
                }

                field(BBLC; Rec.BBLC)
                {
                    ApplicationArea = All;
                }

                field("Opening Date"; Rec."Opening Date")
                {
                    ApplicationArea = All;
                }

                field("Amend Date"; Rec."Amend Date")
                {
                    ApplicationArea = All;
                }

                field("Last Shipment Date"; Rec."Last Shipment Date")
                {
                    ApplicationArea = All;
                }

                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = All;
                }

                field("Status of LC"; Rec."Status of LC")
                {
                    ApplicationArea = All;
                }

                field("Payment Terms (Days)"; Rec."Payment Terms (Days)")
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
        "Contract/LCMasterRec": Record "Contract/LCMaster";
        "Contract/LCStyleRec": Record "Contract/LCStyle";
        "Contract CommisionRec": Record "Contract Commision";
    begin
        "Contract/LCMasterRec".SetRange("No.", Rec."No.");
        "Contract/LCMasterRec".DeleteAll();

        "Contract/LCStyleRec".SetRange("No.", Rec."No.");
        "Contract/LCStyleRec".DeleteAll();

        "Contract CommisionRec".SetRange("No.", Rec."No.");
        "Contract CommisionRec".DeleteAll();
    end;
}