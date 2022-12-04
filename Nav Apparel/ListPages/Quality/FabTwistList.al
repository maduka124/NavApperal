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
                field("FabTwistNo."; rec."FabTwistNo.")
                {
                    ApplicationArea = all;
                    Caption = 'Fab. Twist No';
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

                field("PO No.";rec. "PO No.")
                {
                    ApplicationArea = All;
                    Caption = 'PO No';
                }

                field(GRN;rec. GRN)
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

                field("Fabric Code";rec. "Fabric Code")
                {
                    ApplicationArea = All;
                    Caption = 'Fabric';
                }

                field(Composition;rec. Composition)
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
        FabTwistLineRec: Record FabTwistLine;
    begin
        FabTwistLineRec.reset();
        FabTwistLineRec.SetRange("FabTwistNo.", rec."FabTwistNo.");
        if FabTwistLineRec.FindSet() then
            FabTwistLineRec.DeleteAll();
    end;
}