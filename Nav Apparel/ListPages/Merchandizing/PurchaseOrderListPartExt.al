pageextension 71012832 PurchaseOrderListExt extends "Purchase Order Subform"
{
    layout
    {
        modify("Location Code")
        {
            ShowMandatory = true;
        }

        addafter(Description)
        {
            field(StyleName; StyleName)
            {
                ApplicationArea = all;
                Caption = 'Style Name';
            }

        }

    }
}