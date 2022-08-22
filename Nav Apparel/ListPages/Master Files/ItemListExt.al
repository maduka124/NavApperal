pageextension 71012727 ItemListExt extends "Item List"
{
    layout
    {
        addlast(Control1)
        {
            field("Sub Category Name"; "Sub Category Name")
            {
                ApplicationArea = ALL;
                Caption = 'Sub Category';
            }

            field("Color Name"; "Color Name")
            {
                ApplicationArea = ALL;
                Caption = 'Color';
            }

            field("Size Range No."; "Size Range No.")
            {
                ApplicationArea = ALL;
                Caption = 'Size Range';
            }

            field(Article; Article)
            {
                ApplicationArea = ALL;
            }

            field("Dimension Width"; "Dimension Width")
            {
                ApplicationArea = ALL;
            }

            field(Remarks; Remarks)
            {
                ApplicationArea = ALL;
            }

            field("EstimateBOM Item"; "EstimateBOM Item")
            {
                ApplicationArea = ALL;
                Caption = 'EstimateBOM Item (Y/N)';
            }
        }
    }
}