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
                field("PI No"; Rec."PI No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Inv No"; Rec."Inv No")
                {
                    ApplicationArea = All;
                }

                field("Item Name"; Rec."Item Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Item';
                }

                field("Unit Name"; Rec."Unit Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Unit';
                }

                field(Color; Rec.Color)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Size; Rec.Size)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Article "; Rec."Article")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Dimension; Rec.Dimension)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Qty; Rec.Qty)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Total Value"; Rec."Total Value")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("GRN Qty"; Rec."GRN Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Rec. Value"; Rec."Rec. Value")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'GRN Value';
                }
            }
        }
    }
}