pageextension 71012787 SalesOrderCardExt extends "Sales Order"
{
    layout
    {
        addafter("Work Description")
        {

            field("Style Name"; rec."Style Name")
            {
                ApplicationArea = All;
            }

            field("PO No"; rec."PO No")
            {
                ApplicationArea = All;
            }

            field(Lot; rec.Lot)
            {
                ApplicationArea = All;
            }
        }
    }
}