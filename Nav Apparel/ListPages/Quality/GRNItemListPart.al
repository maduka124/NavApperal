page 50677 GRNItemListPart
{
    PageType = List;
    Caption = 'Item List';
    SourceTable = "Purch. Rcpt. Line";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Item No';
                }

                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Item Description';
                }
            }
        }
    }
}