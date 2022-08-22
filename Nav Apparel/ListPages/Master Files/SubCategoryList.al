page 71012649 "Sub Category"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sub Category";
    CardPageId = "Sub Category Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = '"Sub Category No';
                }

                field("Sub Category Name"; "Sub Category Name")
                {
                    ApplicationArea = All;
                }

                field("Main Category Name"; "Main Category Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}