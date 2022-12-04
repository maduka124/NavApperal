page 50698 FabShadeShrinkageList
{
    PageType = List;
    SourceTable = FabShadeBandShriHeader;
    CardPageId = FabShadeShrinkageCard;
    SourceTableView = sorting("FabShadeNo.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("FabShadeNo."; rec."FabShadeNo.")
                {
                    ApplicationArea = all;
                    Caption = 'Fab. Shade No';
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

                field("Fabric Code"; rec."Fabric Code")
                {
                    ApplicationArea = All;
                    Caption = 'Fabric';
                }

                field(Composition; rec.Composition)
                {
                    ApplicationArea = All;
                }

                field(Construction; rec.Construction)
                {
                    ApplicationArea = All;
                }

                field("No of Roll"; rec."No of Roll")
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