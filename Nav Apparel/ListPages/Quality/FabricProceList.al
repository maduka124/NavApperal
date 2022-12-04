page 50673 "FabricProceList"
{
    PageType = List;
    SourceTable = FabricProceHeader;
    CardPageId = FabricProceCard;
    SourceTableView = sorting("FabricProceNo.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("FabricProceNo."; rec."FabricProceNo.")
                {
                    ApplicationArea = all;
                    Caption = 'Fabric Proc. No';
                }

                field("Buyer Name."; rec."Buyer Name.")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("PO No."; rec."PO No.")
                {
                    ApplicationArea = All;
                    Caption = 'PO No';
                }

                field(GRN; rec.GRN)
                {
                    ApplicationArea = All;
                }

                field("Color Name"; rec."Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'Color';
                }

                field("Item Name"; rec."Item Name")
                {
                    ApplicationArea = All;
                    Caption = 'Item';
                }

                field("No of Roll"; rec."No of Roll")
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
        FabricProLineRec.SetRange("FabricProceNo.", rec."FabricProceNo.");
        if FabricProLineRec.FindSet() then
            FabricProLineRec.DeleteAll();
    end;
}