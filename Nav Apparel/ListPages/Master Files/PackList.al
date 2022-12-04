page 71012625 "Pack List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Pack;
    CardPageId = "Pack Card";
    SourceTableView = sorting("No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Pack No';
                }

                field(Pack; Rec.Pack)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}