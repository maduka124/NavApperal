pageextension 71012798 SalesOrderListExt extends "Sales Order List"
{
    layout
    {
        addlast(Control1)
        {
            field("Style Name"; "Style Name")
            {
                ApplicationArea = ALL;
                Caption = 'Style';
            }

            field("PO No"; "PO No")
            {
                ApplicationArea = ALL;
            }

            field(Lot; Lot)
            {
                ApplicationArea = ALL;
            }
        }
    }
}