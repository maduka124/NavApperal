page 71012581 "AQL"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = AQL;
    CardPageId = "AQL Card";


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("From Qty"; "From Qty")
                {
                    ApplicationArea = All;
                }

                field("To Qty"; "To Qty")
                {
                    ApplicationArea = All;
                }

                field("SMPL Qty"; "SMPL Qty")
                {
                    ApplicationArea = All;
                }

                field("Reject Qty"; "Reject Qty")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}