pageextension 50100 Prod_Order_Components extends "Prod. Order Components"
{
    layout
    {
        addbefore("Item No.")
        {
            field("Prod. Order No."; rec."Prod. Order No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Transfer Order Created"; rec."Transfer Order Created")
            {
                ApplicationArea = All;
            }
        }
    }
}
