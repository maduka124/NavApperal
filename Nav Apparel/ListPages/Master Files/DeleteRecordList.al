page 50759 "DeleteRecordList"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "NavApp Planning Lines";
    SourceTableView = sorting("Style No.") order(descending);


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                }

                field(Qty; Qty)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}