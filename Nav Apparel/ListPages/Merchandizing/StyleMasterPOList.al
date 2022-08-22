page 71012797 "Style Master PO List"
{
    PageType = List;
    SourceTable = "Style Master PO";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Lot No."; "Lot No.")
                {
                    ApplicationArea = All;
                    Caption = 'Lot No';
                }

                field("PO No."; "PO No.")
                {
                    ApplicationArea = All;
                    Caption = 'Po No';
                }

                field(Qty; Qty)
                {
                    ApplicationArea = All;
                }

                field(Mode; Mode)
                {
                    ApplicationArea = All;
                }

                field("Ship Date"; "Ship Date")
                {
                    ApplicationArea = All;
                }

                field(SID; SID)
                {
                    ApplicationArea = All;
                }

                field("Unit Price"; "Unit Price")
                {
                    ApplicationArea = All;
                }

                field(Status; Status)
                {
                    ApplicationArea = All;
                }

                field("Confirm Date"; "Confirm Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}