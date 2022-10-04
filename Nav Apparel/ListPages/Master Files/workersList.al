page 50798 "Workers List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Workers;
    CardPageId = "Workers Card";


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Worker Name"; "Worker Name")
                {
                    ApplicationArea = All;
                }

                field("Worker Type"; "Worker Type")
                {
                    ApplicationArea = All;
                }

                field(Status; Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}