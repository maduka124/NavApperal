page 71012848 ChemicalTypeList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ChemicalType;
    CardPageId = "Chemical Type Card";
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
                    Caption = 'Chemical Type No';
                }

                field("Chemical Type Name"; "Chemical Type Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}