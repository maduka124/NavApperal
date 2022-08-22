page 50521 "B2B LC List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "B2BLCMaster";
    CardPageId = "B2B LC Card";
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

                field("B2B LC No"; "B2B LC No")
                {
                    ApplicationArea = All;
                }

                field("B2B LC Value"; "B2B LC Value")
                {
                    ApplicationArea = All;
                }

                field("LC/Contract No."; "LC/Contract No.")
                {
                    ApplicationArea = All;
                    Caption = 'LC/Contract No';
                }

                field("LC Value"; "LC Value")
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

                field("Opening Date"; "Opening Date")
                {
                    ApplicationArea = All;
                }

                field("AMD Date"; "AMD Date")
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

                field("B2B LC Status"; "B2B LC Status")
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
        B2BLCPIRec: Record B2BLCPI;
    begin
        B2BLCPIRec.SetRange("B2BNo.", "No.");
        B2BLCPIRec.SetRange("B2BNo.", "No.");
        B2BLCPIRec.DeleteAll();
    end;
}