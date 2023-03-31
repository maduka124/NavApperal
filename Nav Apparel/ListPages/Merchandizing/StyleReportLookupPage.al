page 51281 StyleReportLookupage
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = StyleReport;
    Caption = 'Style';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Style No"; Rec."Style No")
                {
                    ApplicationArea = All;
                }

                field("Style Name"; Rec."Style Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}