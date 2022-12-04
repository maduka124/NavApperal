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