page 71012745 "Wastage Card"
{
    PageType = Card;
    SourceTable = Wastage;
    Caption = 'Wastage Percentage';

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