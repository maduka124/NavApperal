page 50689 "FabTwistList"
{
    PageType = List;
    SourceTable = FabTwistHeader;
    CardPageId = FabTwistCard;
    SourceTableView = sorting("FabTwistNo.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("FabTwistNo."; "FabTwistNo.")
                {
                    ApplicationArea = all;
                    Caption = 'Fab. Twist No';
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
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    var
        FabTwistLineRec: Record FabTwistLine;
    begin
        FabTwistLineRec.reset();
        FabTwistLineRec.SetRange("FabTwistNo.", "FabTwistNo.");
        if FabTwistLineRec.FindSet() then
            FabTwistLineRec.DeleteAll();
    end;
}