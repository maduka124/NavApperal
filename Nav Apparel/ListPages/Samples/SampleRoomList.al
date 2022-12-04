page 50429 "Sample Room List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sample Room";
    CardPageId = "Sample Room Card";
    SourceTableView = sorting("Sample Room No.") order(descending);


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Sample Room No."; rec."Sample Room No.")
                {
                    ApplicationArea = All;
                    Caption = 'Sample Room No';
                }

                field("Sample Room Name"; rec."Sample Room Name")
                {
                    ApplicationArea = All;
                }

                field("Global Dimension Code"; rec."Global Dimension Code")
                {
                    ApplicationArea = All;
                }


            }
        }
    }
}