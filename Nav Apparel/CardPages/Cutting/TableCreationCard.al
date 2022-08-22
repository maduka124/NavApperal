page 50616 "Table Creation Card"
{
    PageType = Card;
    SourceTable = TableCreation;
    Caption = 'Cutting Table Creation';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(TableCreNo; TableCreNo)
                {
                    ApplicationArea = All;
                    Caption = 'Table Creation No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Plan Date"; "Plan Date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field("Table Name"; "Table Name")
                {
                    ApplicationArea = All;
                    Caption = 'Table No';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        TableMasterRec: Record TableMaster;
                    begin
                        TableMasterRec.Reset();
                        TableMasterRec.SetRange("Table Name", "Table Name");
                        if TableMasterRec.FindSet() then
                            "Table No." := TableMasterRec."Table No.";
                    end;
                }
            }

            group("Tables")
            {
                part("Table Creation Line ListPart"; "Table Creation Line ListPart")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "TableCreNo." = FIELD(TableCreNo);
                }
            }
        }
    }


    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."TableCre Nos.", xRec.TableCreNo, TableCreNo) THEN BEGIN
            NoSeriesMngment.SetSeries(TableCreNo);
            CurrPage.Update();
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        TableCreLineRec: Record TableCreartionLine;
    begin
        TableCreLineRec.SetRange("TableCreNo.", TableCreNo);
        TableCreLineRec.DeleteAll();
    end;
}