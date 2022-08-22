page 50547 "Acc Inv Items ListPart"
{
    PageType = ListPart;
    SourceTable = AcceptanceLine;
    DeleteAllowed = false;
    InsertAllowed = false;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("PI No"; "PI No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Inv No"; "Inv No")
                {
                    ApplicationArea = All;
                }

                field("Item Name"; "Item Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Item';
                }

                field("Unit Name"; "Unit Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Unit';
                }

                field(Color; Color)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Size; Size)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Article "; "Article ")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Dimension; Dimension)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Qty; Qty)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Unit Price"; "Unit Price")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Total Value"; "Total Value")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("GRN Qty"; "GRN Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Rec. Value"; "Rec. Value")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'GRN Value';
                }
            }
        }
    }
}