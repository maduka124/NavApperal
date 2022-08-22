page 71012656 "Wash Type"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Wash Type";
    CardPageId = "Wash Type Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Wash Type No';
                }

                field("Wash Type Name"; "Wash Type Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}