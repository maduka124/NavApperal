page 50615 "Table Creation"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = TableCreation;
    CardPageId = "Table Creation Card";
    SourceTableView = sorting(TableCreNo) order(descending);
    Caption = 'Cutting Table Planning';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(TableCreNo; Rec.TableCreNo)
                {
                    ApplicationArea = All;
                    Caption = 'Table Creation No';
                }

                field("Plan Date"; Rec."Plan Date")
                {
                    ApplicationArea = All;
                }

                field("Table Name"; Rec."Table Name")
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
        TableCreLineRec.SetRange("TableCreNo.", Rec.TableCreNo);
        TableCreLineRec.DeleteAll();
    end;
}