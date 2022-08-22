page 50684 "FabShrinkageTestList"
{
    PageType = List;
    SourceTable = FabShrinkageTestHeader;
    CardPageId = FabShrinkageTestCard;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("FabShrTestNo."; "FabShrTestNo.")
                {
                    ApplicationArea = all;
                    Caption = 'Doc No';
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

                field("Fabric Code"; "Fabric Code")
                {
                    ApplicationArea = All;
                    Caption = 'Fabric';
                }

                field(Composition; Composition)
                {
                    ApplicationArea = All;
                }

                field(Construction; Construction)
                {
                    ApplicationArea = All;
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
        FabShrTestLineRec: Record FabShrinkageTestLine;
    begin
        FabShrTestLineRec.reset();
        FabShrTestLineRec.SetRange("FabShrTestNo.", "FabShrTestNo.");
        if FabShrTestLineRec.FindSet() then
            FabShrTestLineRec.DeleteAll();
    end;
}