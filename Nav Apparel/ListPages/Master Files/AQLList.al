page 71012581 "AQL"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = AQL;
    CardPageId = "AQL Card";
    //SourceTableView = sorting("From Qty") order(descending);


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("From Qty"; Rec."From Qty")
                {
                    ApplicationArea = All;
                }

                field("To Qty"; Rec."To Qty")
                {
                    ApplicationArea = All;
                }

                field("SMPL Qty"; Rec."SMPL Qty")
                {
                    ApplicationArea = All;
                }

                field("Reject Qty"; Rec."Reject Qty")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}