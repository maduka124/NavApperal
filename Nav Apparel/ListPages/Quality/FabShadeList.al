page 50694 FabShadeList
{
    PageType = List;
    SourceTable = FabShadeHeader;
    CardPageId = FabShadeCard;

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
                    Caption = 'PO';
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
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    var
        FabShadeLine1Rec: Record FabShadeLine1;
    begin
        FabShadeLine1Rec.reset();
        FabShadeLine1Rec.SetRange("FabShadeNo.", "FabShadeNo.");
        if FabShadeLine1Rec.FindSet() then
            FabShadeLine1Rec.DeleteAll();
    end;
}