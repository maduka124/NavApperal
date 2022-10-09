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
                field("Start Qty"; "Start Qty")
                {
                    ApplicationArea = All;
                }

                field("Finish Qty"; "Finish Qty")
                {
                    ApplicationArea = All;
                }

                field(Percentage; Percentage)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}