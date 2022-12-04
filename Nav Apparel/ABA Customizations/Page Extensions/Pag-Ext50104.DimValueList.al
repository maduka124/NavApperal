pageextension 50104 DimValueList extends "Dimension Values"
{
    layout
    {
        addafter(Blocked)
        {
            field("No. Series"; rec."No. Series - PO")
            {
                ApplicationArea = All;
            }
            field("No. Series - Invoicing"; rec."No. Series - Invoicing")
            {
                ApplicationArea = All;
            }
            field("No. Series - Shipping"; rec."No. Series - Shipping")
            {
                ApplicationArea = All;
            }
        }
    }
}
