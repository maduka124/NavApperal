pageextension 51058 SalesOrderListExt extends "Sales Order List"
{
    layout
    {
        addlast(Control1)
        {
            field("Style Name"; Rec."Style Name")
            {
                ApplicationArea = ALL;
                Caption = 'Style';
            }

            field("PO No"; Rec."PO No")
            {
                ApplicationArea = ALL;
            }

            field(Lot; Rec.Lot)
            {
                ApplicationArea = ALL;
            }
        }
    }
}