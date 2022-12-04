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
                field("Style Name"; Rec."Style Name")
                {
                    ApplicationArea = All;
                }

                field(Qty; Rec.Qty)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}