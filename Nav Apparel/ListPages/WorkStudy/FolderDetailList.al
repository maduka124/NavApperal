page 50469 "Folder Detail List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Folder Detail";
    CardPageId = "Folder Detail Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Folder No';
                }

                field("Folder Name"; "Folder Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}