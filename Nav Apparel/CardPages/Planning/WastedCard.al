page 71012745 "Wastage Card"
{
    PageType = Card;
    SourceTable = Wastage;
    Caption = 'Quantity Wise Extra %';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Start Qty"; rec."Start Qty")
                {
                    ApplicationArea = All;
                }

                field("Finish Qty"; rec."Finish Qty")
                {
                    ApplicationArea = All;
                }

                field(Percentage; rec.Percentage)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}