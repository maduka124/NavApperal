page 50615 "Table Creation"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = TableCreation;
    CardPageId = "Table Creation Card";
    SourceTableView = sorting(TableCreNo) order(descending);


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(TableCreNo; TableCreNo)
                {
                    ApplicationArea = All;
                    Caption = 'Table Creation No';
                }

                field("Plan Date"; "Plan Date")
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


    trigger OnDeleteRecord(): Boolean
    var
        TableCreLineRec: Record TableCreartionLine;
    begin
        TableCreLineRec.SetRange("TableCreNo.", TableCreNo);
        TableCreLineRec.DeleteAll();
    end;
}