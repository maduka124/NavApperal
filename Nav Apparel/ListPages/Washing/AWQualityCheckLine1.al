page 50668 aWQualityChecklist1
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = IntermediateTable;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Line No"; "Line No")
                {
                    Caption = 'Seq No';
                    ApplicationArea = All;
                }

                field("FG Item Name"; "FG Item Name")
                {
                    ApplicationArea = all;
                    Caption = 'Fabrication';
                }

                field("Split Qty"; "Split Qty")
                {
                    Caption = 'Qty';
                    ApplicationArea = All;
                }
            }
        }
    }
}