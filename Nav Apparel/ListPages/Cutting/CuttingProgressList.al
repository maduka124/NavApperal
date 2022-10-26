page 50661 "Cutting Progress List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = CuttingProgressHeader;
    CardPageId = "Cutting Progress Card";
    SourceTableView = sorting("CutProNo.") order(descending);


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("CutProNo."; "CutProNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Cutting Progress No';
                }

                field(LaySheetNo; LaySheetNo)
                {
                    ApplicationArea = All;
                    Caption = 'Lay Sheet No';
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Item Name"; "Item Name")
                {
                    ApplicationArea = All;
                    Caption = 'Item';
                }

                field("Cut No."; "Cut No.")
                {
                    ApplicationArea = All;
                    Caption = 'Cut No';
                }

                field("Marker Name"; "Marker Name")
                {
                    ApplicationArea = All;
                    Caption = 'Marker';
                }

                field("Marker Length"; "Marker Length")
                {
                    ApplicationArea = All;
                }

                field(UOM; UOM)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    var
        CuttingProgressLineRec: Record CuttingProgressLine;
    begin
        CuttingProgressLineRec.reset();
        CuttingProgressLineRec.SetRange("CutProNo.", "CutProNo.");
        CuttingProgressLineRec.DeleteAll();
    end;
}