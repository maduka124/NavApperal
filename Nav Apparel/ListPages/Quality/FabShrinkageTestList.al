page 50684 "FabShrinkageTestList"
{
    PageType = List;
    SourceTable = FabShrinkageTestHeader;
    CardPageId = FabShrinkageTestCard;
    SourceTableView = sorting("FabShrTestNo.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("FabShrTestNo.";rec. "FabShrTestNo.")
                {
                    ApplicationArea = all;
                    Caption = 'Doc No';
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

                field("Fabric Code"; rec."Fabric Code")
                {
                    ApplicationArea = All;
                    Caption = 'Fabric';
                }

                field(Composition; rec.Composition)
                {
                    ApplicationArea = All;
                }

                field(Construction;rec. Construction)
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

    trigger OnDeleteRecord(): Boolean
    var
        FabShrTestLineRec: Record FabShrinkageTestLine;
    begin
        FabShrTestLineRec.reset();
        FabShrTestLineRec.SetRange("FabShrTestNo.", rec."FabShrTestNo.");
        if FabShrTestLineRec.FindSet() then
            FabShrTestLineRec.DeleteAll();
    end;
}