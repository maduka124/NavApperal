page 71012628 "Plant Type List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Plant Type";
    CardPageId = "Plant Type Card";
    SourceTableView = sorting("Plant Type No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Plant Type No."; Rec."Plant Type No.")
                {
                    ApplicationArea = All;
                    Caption = 'Plant Type No';
                }

                field("Plant Type Name"; Rec."Plant Type Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}