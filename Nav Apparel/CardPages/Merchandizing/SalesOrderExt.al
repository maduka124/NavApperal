pageextension 71012787 SalesOrderCardExt extends "Sales Order"
{
    layout
    {
        addafter("Work Description")
        {

            field("Style Name"; "Style Name")
            {
                ApplicationArea = All;
            }

            field("PO No"; "PO No")
            {
                ApplicationArea = All;
            }

            field(Lot; Lot)
            {
                ApplicationArea = All;
            }
        }
    }
}