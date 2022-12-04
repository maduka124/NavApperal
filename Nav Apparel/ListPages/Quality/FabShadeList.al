page 50694 FabShadeList
{
    PageType = List;
    SourceTable = FabShadeHeader;
    CardPageId = FabShadeCard;
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
                    Caption = 'PO';
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
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    var
        FabShadeLine1Rec: Record FabShadeLine1;
    begin
        FabShadeLine1Rec.reset();
        FabShadeLine1Rec.SetRange("FabShadeNo.", rec."FabShadeNo.");
        if FabShadeLine1Rec.FindSet() then
            FabShadeLine1Rec.DeleteAll();
    end;
}