page 50521 "B2B LC List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "B2BLCMaster";
    CardPageId = "B2B LC Card";
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

                field("B2B LC No"; Rec."B2B LC No")
                {
                    ApplicationArea = All;
                }

                field("B2B LC Value"; Rec."B2B LC Value")
                {
                    ApplicationArea = All;
                }

                field("LC/Contract No."; Rec."LC/Contract No.")
                {
                    ApplicationArea = All;
                    Caption = 'LC/Contract No';
                }

                field("LC Value"; Rec."LC Value")
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

                field("Opening Date"; Rec."Opening Date")
                {
                    ApplicationArea = All;
                }

                field("AMD Date"; Rec."AMD Date")
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

                field("B2B LC Status"; Rec."B2B LC Status")
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


    trigger OnDeleteRecord(): Boolean
    var
        B2BLCPIRec: Record B2BLCPI;
    begin
        B2BLCPIRec.SetRange("B2BNo.", Rec."No.");
        B2BLCPIRec.SetRange("B2BNo.", Rec."No.");
        B2BLCPIRec.DeleteAll();
    end;
}