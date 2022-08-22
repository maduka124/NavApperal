page 50675 GRNPOListPart
{
    PageType = List;
    Caption = 'PO List';
    SourceTable = "Purch. Rcpt. Line";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Order No."; "Order No.")
                {
                    ApplicationArea = All;
                    Caption = 'Order No';
                }
            }
        }
    }
}