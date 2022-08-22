page 71012628 "Plant Type List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Plant Type";
    CardPageId = "Plant Type Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Plant Type No."; "Plant Type No.")
                {
                    ApplicationArea = All;
                    Caption = 'Plant Type No';
                }

                field("Plant Type Name"; "Plant Type Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}