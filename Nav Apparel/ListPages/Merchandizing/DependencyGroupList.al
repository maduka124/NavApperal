page 71012705 "Dependency Group"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Dependency Group";
    CardPageId = "Dependency Group Card";


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Dependency Group No';
                }

                field("Dependency Group"; "Dependency Group")
                {
                    ApplicationArea = All;
                    Caption = 'Dependency Group Name';
                }
            }
        }
    }
}