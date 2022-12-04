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
                field("PI No."; rec."PI No.")
                {
                    ApplicationArea = All;
                    Caption = 'PI No';
                }

                field("PO No."; rec."PO No.")
                {
                    ApplicationArea = All;
                    Caption = 'PO No';
                }

                field("Item Name"; rec."Item Name")
                {
                    ApplicationArea = All;
                    Caption = 'Item';
                }

                field(UOM; rec.UOM)
                {
                    ApplicationArea = All;
                }

                field("Main Category Name"; rec."Main Category Name")
                {
                    ApplicationArea = All;
                }

                field(Qty; rec.Qty)
                {
                    ApplicationArea = All;
                }

                field("Unit Price"; rec."Unit Price")
                {
                    ApplicationArea = All;
                }

                field(Value; rec.Value)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}