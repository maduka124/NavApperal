page 71012637 Shade
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Shade;
    CardPageId = "Shade Card";
    SourceTableView = sorting("No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Shade No';
                }

                field(Shade; Shade)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}