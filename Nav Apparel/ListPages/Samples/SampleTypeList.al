page 71012773 "Sample Type"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sample Type";
    CardPageId = "Sample Type Card";
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
                    Caption = 'Sample Type No';
                }

                field("Sample Type Name"; "Sample Type Name")
                {
                    ApplicationArea = All;
                }

                field("Lead Time"; "Lead Time")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}