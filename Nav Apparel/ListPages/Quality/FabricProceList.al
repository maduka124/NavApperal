page 50673 "FabricProceList"
{
    PageType = List;
    SourceTable = FabricProceHeader;
    CardPageId = FabricProceCard;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("FabricProceNo."; "FabricProceNo.")
                {
                    ApplicationArea = all;
                    Caption = 'Fabric Proc. No';
                }

                field("Buyer Name."; "Buyer Name.")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("PO No."; "PO No.")
                {
                    ApplicationArea = All;
                    Caption = 'PO No';
                }

                field(GRN; GRN)
                {
                    ApplicationArea = All;
                }

                field("Color Name"; "Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'Color';
                }

                field("Item Name"; "Item Name")
                {
                    ApplicationArea = All;
                    Caption = 'Item';
                }

                field("No of Roll"; "No of Roll")
                {
                    ApplicationArea = All;
                    Caption = 'No of Rolls';
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    var
        FabricProLineRec: Record FabricProceLine;
    begin
        FabricProLineRec.reset();
        FabricProLineRec.SetRange("FabricProceNo.", "FabricProceNo.");
        if FabricProLineRec.FindSet() then
            FabricProLineRec.DeleteAll();
    end;
}