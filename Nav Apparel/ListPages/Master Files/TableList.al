page 71012652 TableList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = TableMaster;
    CardPageId = TableCard;
    Caption = 'Cutting Table';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Table No."; "Table No.")
                {
                    ApplicationArea = All;
                }

                field("Table Name"; "Table Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}