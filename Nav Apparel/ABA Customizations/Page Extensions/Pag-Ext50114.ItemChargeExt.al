pageextension 50114 Item_Charge_Ext extends "Item Charges"
{
    layout
    {
        addafter("Search Description")
        {
            field("Bank Charge"; rec."Bank Charge")
            {
                ApplicationArea = All;
            }
        }
    }
}
