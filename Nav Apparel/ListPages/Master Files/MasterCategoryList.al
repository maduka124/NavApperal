page 50644 "Master Category List"
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
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Master Category No';
                }

                field("Master Category Name"; Rec."Master Category Name")
                {
                    ApplicationArea = All;

                }
            }
        }
    }
}