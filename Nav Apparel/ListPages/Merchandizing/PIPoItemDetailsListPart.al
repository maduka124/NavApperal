page 71012792 "PI Po Item Details ListPart"
{
    PageType = ListPart;
    SourceTable = "PI Po Item Details";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("PI No."; "PI No.")
                {
                    ApplicationArea = All;
                    Caption = 'PI No';
                }

                field("PO No."; "PO No.")
                {
                    ApplicationArea = All;
                    Caption = 'PO No';
                }

                field("Item Name"; "Item Name")
                {
                    ApplicationArea = All;
                    Caption = 'Item';
                }

                field(UOM; UOM)
                {
                    ApplicationArea = All;
                }

                field("Main Category Name"; "Main Category Name")
                {
                    ApplicationArea = All;
                }

                field(Qty; Qty)
                {
                    ApplicationArea = All;
                }

                field("Unit Price"; "Unit Price")
                {
                    ApplicationArea = All;
                }

                field(Value; Value)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}