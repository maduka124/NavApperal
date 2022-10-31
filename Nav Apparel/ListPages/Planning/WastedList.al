page 50369 "Wastage"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Wastage;
    CardPageId = "Wastage Card";
    Caption = 'Quantity Wise Extra %';
    //SourceTableView = sorting("Start Qty") order(descending);


    layout
    {
        area(Content)
        {
            repeater(General)
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