page 51265 Garmentpart
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = BundleCardGMTType;
    Caption = 'Garment Parts Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Garment Part Code"; Rec."Garment Part Code")
                {
                    ApplicationArea = All;

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;

                }
            }

        }
    }

    actions
    {
        area(Processing)
        {
            action(Load)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}