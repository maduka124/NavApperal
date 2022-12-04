page 50663 "Cutting Progress List"
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
                field("CutProNo."; Rec."CutProNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Cutting Progress No';
                }

                field(LaySheetNo; Rec.LaySheetNo)
                {
                    ApplicationArea = All;
                    Caption = 'Lay Sheet No';
                }

                field("Style Name"; Rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Item Name"; Rec."Item Name")
                {
                    ApplicationArea = All;
                    Caption = 'Item';
                }

                field("Cut No."; Rec."Cut No.")
                {
                    ApplicationArea = All;
                    Caption = 'Cut No';
                }

                field("Marker Name"; Rec."Marker Name")
                {
                    ApplicationArea = All;
                    Caption = 'Marker';
                }

                field("Marker Length"; Rec."Marker Length")
                {
                    ApplicationArea = All;
                }

                field(UOM; Rec.UOM)
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
        CuttingProgressLineRec.SetRange("CutProNo.", Rec."CutProNo.");
        CuttingProgressLineRec.DeleteAll();
    end;
}