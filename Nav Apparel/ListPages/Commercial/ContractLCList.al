page 50503 "Contract/LC List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Contract/LCMaster";
    CardPageId = "Contract/LC Card";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Seq No';
                }

                field("Contract No"; "Contract No")
                {
                    ApplicationArea = All;
                    Caption = 'Contract/LC No';
                }

                field("Contract Value"; "Contract Value")
                {
                    ApplicationArea = All;
                }

                field(Buyer; Buyer)
                {
                    ApplicationArea = All;
                }

                field(Season; Season)
                {
                    ApplicationArea = All;
                }

                field(Factory; Factory)
                {
                    ApplicationArea = All;
                }

                field("B2B Payment Type"; "B2B Payment Type")
                {
                    ApplicationArea = All;
                }

                field(BBLC; BBLC)
                {
                    ApplicationArea = All;
                }

                field("Opening Date"; "Opening Date")
                {
                    ApplicationArea = All;
                }

                field("Amend Date"; "Amend Date")
                {
                    ApplicationArea = All;
                }

                field("Last Shipment Date"; "Last Shipment Date")
                {
                    ApplicationArea = All;
                }

                field("Expiry Date"; "Expiry Date")
                {
                    ApplicationArea = All;
                }

                field("Status of LC"; "Status of LC")
                {
                    ApplicationArea = All;
                }

                field("Payment Terms (Days)"; "Payment Terms (Days)")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    var
        "Contract/LCMasterRec": Record "Contract/LCMaster";
        "Contract/LCStyleRec": Record "Contract/LCStyle";
        "Contract CommisionRec": Record "Contract Commision";
    begin
        "Contract/LCMasterRec".SetRange("No.", "No.");
        "Contract/LCMasterRec".DeleteAll();

        "Contract/LCStyleRec".SetRange("No.", "No.");
        "Contract/LCStyleRec".DeleteAll();

        "Contract CommisionRec".SetRange("No.", "No.");
        "Contract CommisionRec".DeleteAll();
    end;
}