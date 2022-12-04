page 50798 "Workers List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Workers;
    CardPageId = "Workers Card";
    SourceTableView = sorting("No.") order(descending);
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Worker Name"; Rec."Worker Name")
                {
                    ApplicationArea = All;
                }

                field("Worker Type"; Rec."Worker Type")
                {
                    ApplicationArea = All;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}