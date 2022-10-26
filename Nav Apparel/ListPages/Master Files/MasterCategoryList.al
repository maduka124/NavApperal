page 71012622 "Master Category List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Master Category";
    CardPageId = "Master Category Card";
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
                    Caption = 'Master Category No';
                }

                field("Master Category Name"; "Master Category Name")
                {
                    ApplicationArea = All;

                }
            }
        }
    }
}