page 50469 "Folder Detail List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Folder Detail";
    CardPageId = "Folder Detail Card";
    SourceTableView = sorting("No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No.";rec. "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Folder No';
                }

                field("Folder Name"; rec."Folder Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}