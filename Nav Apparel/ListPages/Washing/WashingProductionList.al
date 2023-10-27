page 51455 WashingProductionlist
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = WashingProductionHeader;
    CardPageId = WashProductionCard;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field(No; Rec.No)
                {
                    ApplicationArea = All;
                }

                field("Production Date"; Rec."Production Date")
                {
                    ApplicationArea = All;
                }

                field("Washing Plant"; Rec."Washing Plant")
                {
                    ApplicationArea = All;
                }

                field("Buyer Name"; Rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                }

                field("Style Name"; Rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Lot No"; Rec."Lot No")
                {
                    ApplicationArea = All;
                    Caption = 'Lot';
                }

                field("PO No"; Rec."PO No")
                {
                    ApplicationArea = All;
                    Caption = 'PO';
                    Editable = False;
                }

                field("Color Name"; Rec."Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'Color';
                }

                field("Process Name"; Rec."Process Name")
                {
                    ApplicationArea = All;
                }

                field("Day Production Qty"; Rec."Day Production Qty")
                {
                    ApplicationArea = All;
                }

                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }

                field("Secondary UserID"; Rec."Secondary UserID")
                {
                    ApplicationArea = All;
                    Caption = 'Create User';
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    var
        WashingMasterRec: Record WashingMaster;
        WashProductionLine: Record WashinProductionLine;
    begin

        if Rec.PostingStatus = true then begin

            WashingMasterRec.Reset();
            WashingMasterRec.SetRange("Style No", Rec."Style No.");
            WashingMasterRec.SetRange(Lot, Rec."Lot No");
            WashingMasterRec.SetRange("PO No", Rec."PO No");
            WashingMasterRec.SetRange("Color Name", Rec."Color Name");

            if WashingMasterRec.FindSet() then begin

                if Rec."Process Code" = 'WHISKERS' then begin
                    WashingMasterRec."Production WHISKERS" := WashingMasterRec."Production WHISKERS" - Rec."Day Production Qty";
                    WashingMasterRec.Modify(true);
                end;

                if Rec."Process Code" = 'ACID/ RANDOM WASH' then begin
                    WashingMasterRec."Production ACID/ RANDOM WASH" := WashingMasterRec."Production ACID/ RANDOM WASH" - Rec."Day Production Qty";
                    WashingMasterRec.Modify(true);
                end;

                if Rec."Process Code" = 'BASE WASH' then begin
                    WashingMasterRec."Production BASE WASH" := WashingMasterRec."Production BASE WASH" - Rec."Day Production Qty";
                    WashingMasterRec.Modify(true);
                end;

                if Rec."Process Code" = 'BRUSH' then begin
                    WashingMasterRec."Production BRUSH" := WashingMasterRec."Production BRUSH" - Rec."Day Production Qty";
                    WashingMasterRec.Modify(true);
                end;

                if Rec."Process Code" = 'DESTROY' then begin
                    WashingMasterRec."Production DESTROY" := WashingMasterRec."Production DESTROY" - Rec."Day Production Qty";
                    WashingMasterRec.Modify(true);
                end;

                if Rec."Process Code" = 'FINAL WASH' then begin
                    WashingMasterRec."Production FINAL WASH" := WashingMasterRec."Production FINAL WASH" - Rec."Day Production Qty";
                    WashingMasterRec.Modify(true);
                end;

                if Rec."Process Code" = 'LASER BRUSH' then begin
                    WashingMasterRec."Production LASER BRUSH" := WashingMasterRec."Production LASER BRUSH" - Rec."Day Production Qty";
                    WashingMasterRec.Modify(true);
                end;

                if Rec."Process Code" = 'LASER DESTROY' then begin
                    WashingMasterRec."Production LASER DESTROY" := WashingMasterRec."Production LASER DESTROY" - Rec."Day Production Qty";
                    WashingMasterRec.Modify(true);
                end;

                if Rec."Process Code" = 'LASER WHISKERS' then begin
                    WashingMasterRec."Production LASER WHISKERS" := WashingMasterRec."Production LASER WHISKERS" - Rec."Day Production Qty";
                    WashingMasterRec.Modify(true);
                end;

                if Rec."Process Code" = 'PP SPRAY' then begin
                    WashingMasterRec."Production PP SPRAY" := WashingMasterRec."Production PP SPRAY" - Rec."Day Production Qty" + Rec."Day Production Qty";
                    WashingMasterRec.Modify(true);
                end;
            end;
        end;

        WashProductionLine.Reset();
        WashProductionLine.SetRange(No, Rec.No);

        if WashProductionLine.FindSet() then
            WashProductionLine.Delete(true);

    end;

}