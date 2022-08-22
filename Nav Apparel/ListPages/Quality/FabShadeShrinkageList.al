page 50698 FabShadeShrinkageList
{
    PageType = List;
    SourceTable = FabShadeBandShriHeader;
    CardPageId = FabShadeShrinkageCard;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("FabShadeNo."; "FabShadeNo.")
                {
                    ApplicationArea = all;
                    Caption = 'Fab. Shade No';
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

    // trigger OnDeleteRecord(): Boolean
    // var
    //     FabShadeLineRec: Record FabShadeLine;
    // begin
    //     FabShadeLineRec.reset();
    //     FabShadeLineRec.SetRange("FabShadeNo.", "FabShadeNo.");
    //     if FabShadeLineRec.FindSet() then
    //         FabShadeLineRec.DeleteAll();
    // end;
}