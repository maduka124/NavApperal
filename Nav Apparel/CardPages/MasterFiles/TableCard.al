page 71012653 "TableCard"
{
    PageType = Card;
    SourceTable = TableMaster;
    Caption = 'Cutting Tables';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Table No.";rec. "Table No.")
                {
                    ApplicationArea = All;
                    Caption = 'Table No';
                }

                field("Table Name"; rec."Table Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        TableMasterRec: Record TableMaster;
                    begin
                        TableMasterRec.Reset();
                        TableMasterRec.SetRange("Table Name",rec. "Table Name");

                        if TableMasterRec.FindSet() then
                            Error('Table Name already exists.');
                    end;
                }
            }
        }
    }
}