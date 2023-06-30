page 51336 "Style Master PO Lookup"
{
    PageType = List;
    SourceTable = "Style Master PO";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Lot No."; rec."Lot No.")
                {
                    ApplicationArea = All;
                    Caption = 'Lot No';
                }

                field("PO No."; rec."PO No.")
                {
                    ApplicationArea = All;
                    Caption = 'PO No';
                }

                field(Qty; rec.Qty)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}