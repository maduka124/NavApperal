pageextension 50639 ItemListExt extends "Item List"
{
    layout
    {
        addlast(Control1)
        {
            field("Sub Category Name"; Rec."Sub Category Name")
            {
                ApplicationArea = ALL;
                Caption = 'Sub Category';
            }

            field("Color Name"; Rec."Color Name")
            {
                ApplicationArea = ALL;
                Caption = 'Color';
            }

            field("Size Range No."; Rec."Size Range No.")
            {
                ApplicationArea = ALL;
                Caption = 'Size Range';
            }

            field(Article; Rec.Article)
            {
                ApplicationArea = ALL;
            }

            field("Dimension Width"; Rec."Dimension Width")
            {
                ApplicationArea = ALL;
            }

            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = ALL;
            }

            field("EstimateBOM Item"; Rec."EstimateBOM Item")
            {
                ApplicationArea = ALL;
                Caption = 'EstimateBOM Item (Y/N)';
            }
        }
    }
}