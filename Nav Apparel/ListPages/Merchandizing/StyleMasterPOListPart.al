page 51069 "Style Master PO ListPart"
{
    PageType = ListPart;
    SourceTable = "Style Master PO";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Lot No."; rec."Lot No.")
                {
                    ApplicationArea = All;
                    Caption = 'Lot No';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        BOMEstCostRec: Record "BOM Estimate Cost";
                        StyleMasRec: Record "Style Master";
                        LOTVar: Text[20];
                        NavappPlanLineRec: Record "NavApp Planning Lines";
                        AssorColorSizeRatioRec: Record AssorColorSizeRatio;
                        NavAppProdPlanRec: Record "NavApp Prod Plans Details";
                        PlanningQueueRec: Record "Planning Queue";
                    begin
                        CurrPage.Update();
                        NavappPlanLineRec.Reset();
                        NavappPlanLineRec.SetRange("Style No.", rec."Style No.");
                        NavappPlanLineRec.SetRange("Lot No.", xrec."Lot No.");
                        if NavappPlanLineRec.FindSet() then
                            Error('LOT already planned. Cannot change Lot No.');

                        PlanningQueueRec.Reset();
                        PlanningQueueRec.SetRange("Style No.", rec."Style No.");
                        PlanningQueueRec.SetRange("Lot No.", xrec."Lot No.");
                        if PlanningQueueRec.FindSet() then
                            Error('LOT already in the Queue. Cannot change Lot No.');


                        AssorColorSizeRatioRec.Reset();
                        AssorColorSizeRatioRec.SetRange("Style No.", rec."Style No.");
                        AssorColorSizeRatioRec.SetRange("Lot No.", xrec."Lot No.");
                        if AssorColorSizeRatioRec.FindSet() then
                            Error('Color Size entered for the LOT. Cannot change Lot No.');

                        NavAppProdPlanRec.Reset();
                        NavAppProdPlanRec.SetRange("Style No.", rec."Style No.");
                        NavAppProdPlanRec.SetRange("Lot No.", xrec."Lot No.");
                        if NavAppProdPlanRec.FindSet() then
                            Error('LOT already planned. Cannot change Lot No.');


                        LOTVar := rec."Lot No.";

                        if LOTVar.Contains('/') then
                            Error('Cannot use "/" within Lot No');


                        BOMEstCostRec.Reset();
                        BOMEstCostRec.SetCurrentKey("Style No.");
                        BOMEstCostRec.SetRange("Style No.", rec."Style No.");

                        if BOMEstCostRec.FindSet() then begin
                            rec."Unit Price" := BOMEstCostRec."FOB Pcs";
                        end;

                        //Get BPCD
                        StyleMasRec.Reset();
                        StyleMasRec.SetRange("No.", rec."Style No.");

                        if StyleMasRec.FindSet() then begin
                            //rec.BPCD := StyleMasRec.BPCD;
                            rec."Style Name" := StyleMasRec."Style No.";
                        end;

                    end;
                }

                field("PO No."; rec."PO No.")
                {
                    ApplicationArea = All;
                    Caption = 'PO No';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        SalesHeaderRec: Record "Sales Header";
                        PONOVar: Text[50];
                        NavappPlanLineRec: Record "NavApp Planning Lines";
                        AssorColorSizeRatioRec: Record AssorColorSizeRatio;
                        NavAppProdPlanRec: Record "NavApp Prod Plans Details";
                        PlanningQueueRec: Record "Planning Queue";
                    begin

                        NavappPlanLineRec.Reset();
                        NavappPlanLineRec.SetRange("Style No.", rec."Style No.");
                        NavappPlanLineRec.SetRange("PO No.", xrec."PO No.");
                        if NavappPlanLineRec.FindSet() then
                            Error('PO already planned. Cannot change PO No.');

                        PlanningQueueRec.Reset();
                        PlanningQueueRec.SetRange("Style No.", rec."Style No.");
                        PlanningQueueRec.SetRange("PO No.", xrec."PO No.");
                        if PlanningQueueRec.FindSet() then
                            Error('PO already in the Queue. Cannot change PO No.');


                        AssorColorSizeRatioRec.Reset();
                        AssorColorSizeRatioRec.SetRange("Style No.", rec."Style No.");
                        AssorColorSizeRatioRec.SetRange("PO No.", xrec."PO No.");
                        if AssorColorSizeRatioRec.FindSet() then
                            Error('Color Size entered for the PO. Cannot change PO No.');

                        NavAppProdPlanRec.Reset();
                        NavAppProdPlanRec.SetRange("Style No.", rec."Style No.");
                        NavAppProdPlanRec.SetRange("PO No.", xrec."PO No.");
                        if NavAppProdPlanRec.FindSet() then
                            Error('PO already planned. Cannot change PO No.');

                        PONOVar := rec."PO No.";
                        if PONOVar.Contains('/') then
                            Error('Cannot use "/" within PO No');

                        CurrPage.Update();
                        SalesHeaderRec.Reset();
                        SalesHeaderRec.SetCurrentKey("Style No", Lot);
                        SalesHeaderRec.SetRange("Style No", rec."Style No.");
                        SalesHeaderRec.SetRange(Lot, rec."Lot No.");

                        if SalesHeaderRec.FindSet() then
                            SalesHeaderRec.ModifyAll("PO No", rec."PO No.");
                    end;
                }

                field(Qty; rec.Qty)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        StyleMasterRec: Record "Style Master";
                        StyleMasterPORec: Record "Style Master PO";
                        Tot: BigInteger;
                        NavappPlanLineRec: Record "NavApp Planning Lines";
                        AssorColorSizeRatioRec: Record AssorColorSizeRatio;
                        NavAppProdPlanRec: Record "NavApp Prod Plans Details";
                        PlanningQueueRec: Record "Planning Queue";
                    begin

                        NavappPlanLineRec.Reset();
                        NavappPlanLineRec.SetRange("Style No.", rec."Style No.");
                        NavappPlanLineRec.SetRange("PO No.", rec."PO No.");
                        if NavappPlanLineRec.FindSet() then
                            Error('PO already planned. Cannot change quantity.');

                        PlanningQueueRec.Reset();
                        PlanningQueueRec.SetRange("Style No.", rec."Style No.");
                        PlanningQueueRec.SetRange("PO No.", rec."PO No.");
                        if PlanningQueueRec.FindSet() then
                            Error('PO already planned. Cannot change quantity.');


                        AssorColorSizeRatioRec.Reset();
                        AssorColorSizeRatioRec.SetRange("Style No.", rec."Style No.");
                        AssorColorSizeRatioRec.SetRange("PO No.", rec."PO No.");
                        if AssorColorSizeRatioRec.FindSet() then
                            Message('Color Size entered for the PO. Cannot change quantity.');

                        NavAppProdPlanRec.Reset();
                        NavAppProdPlanRec.SetRange("Style No.", rec."Style No.");
                        NavAppProdPlanRec.SetRange("PO No.", rec."PO No.");
                        NavAppProdPlanRec.SetFilter(ProdUpd, '=%1', 0);
                        if NavAppProdPlanRec.FindSet() then
                            Error('PO already planned. Cannot change quantity.');

                        CurrPage.Update();
                        StyleMasterPORec.Reset();
                        StyleMasterPORec.SetRange("Style No.", rec."Style No.");
                        StyleMasterPORec.FindSet();

                        repeat
                            Tot += StyleMasterPORec.Qty;
                        until StyleMasterPORec.Next() = 0;

                        StyleMasterRec.Reset();
                        StyleMasterRec.SetRange("No.", rec."Style No.");
                        if StyleMasterRec.FindSet() then
                            StyleMasterRec.ModifyAll("PO Total", Tot)

                    end;
                }

                field(Mode; rec.Mode)
                {
                    ApplicationArea = All;
                }

                field(BPCD; rec.BPCD)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                    begin
                        if rec.BPCD < WorkDate() then
                            Error('BPCD should be greater than todays date');
                    end;
                }

                field("Ship Date"; rec."Ship Date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        NavappRec: Record "NavApp Setup";
                        StyleMasRec: Record "Style Master";
                        NavappPlanLineRec: Record "NavApp Planning Lines";
                        AssorColorSizeRatioRec: Record AssorColorSizeRatio;
                        NavAppProdPlanRec: Record "NavApp Prod Plans Details";
                        PlanningQueueRec: Record "Planning Queue";
                    begin

                        NavappPlanLineRec.Reset();
                        NavappPlanLineRec.SetRange("Style No.", rec."Style No.");
                        NavappPlanLineRec.SetRange("PO No.", rec."PO No.");
                        if NavappPlanLineRec.FindSet() then
                            Error('PO already planned. Cannot change Ship Date.');

                        PlanningQueueRec.Reset();
                        PlanningQueueRec.SetRange("Style No.", rec."Style No.");
                        PlanningQueueRec.SetRange("PO No.", rec."PO No.");
                        if PlanningQueueRec.FindSet() then
                            Error('PO already planned. Cannot change Ship Date.');

                        // AssorColorSizeRatioRec.Reset();
                        // AssorColorSizeRatioRec.SetRange("Style No.", rec."Style No.");
                        // AssorColorSizeRatioRec.SetRange("PO No.", rec."PO No.");
                        // if AssorColorSizeRatioRec.FindSet() then
                        //     Error('Color Size entered for the LOT. Cannot change Ship Date.');

                        NavAppProdPlanRec.Reset();
                        NavAppProdPlanRec.SetRange("Style No.", rec."Style No.");
                        NavAppProdPlanRec.SetRange("PO No.", rec."PO No.");
                        NavAppProdPlanRec.SetFilter(ProdUpd, '=%1', 0);
                        if NavAppProdPlanRec.FindSet() then
                            Error('PO already planned. Cannot change Ship Date.');


                        NavappRec.Reset();
                        NavappRec.FindSet();

                        if (rec."Ship Date" <> 0D) and (rec.BPCD <> 0D) then begin
                            if rec."Ship Date" < (rec.BPCD + NavappRec."BPCD To Ship Date") then
                                Error('There should be %1 days gap between BPCD and Ship Date', NavappRec."BPCD To Ship Date");
                        end;

                    end;
                }

                field(SID; rec.SID)
                {
                    ApplicationArea = All;
                }

                field("Unit Price"; rec."Unit Price")
                {
                    ApplicationArea = All;
                }

                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                }

                field("Confirm Date"; rec."Confirm Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        if rec."Confirm Date" <> 0D then begin
                            if (rec.Status = rec.Status::Confirm) and (rec."Confirm Date" > WorkDate()) then
                                Error('Confirm date cannot be a future date.');

                            if (rec.Status = rec.Status::"Projection Confirm") and (rec."Confirm Date" > WorkDate()) then
                                Error('Confirm date cannot be a future date.');

                            if (rec.Status = rec.Status::Projection) and (rec."Confirm Date" < WorkDate()) then
                                Error('Confirm date cannot be old date.');
                        end
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        StyleMasterRec: Record "Style Master";
        StyleMasterPORec: Record "Style Master PO";
        Tot: BigInteger;
    begin
        //Update Po Total         
        StyleMasterPORec.Reset();
        StyleMasterPORec.SetRange("Style No.", rec."Style No.");
        StyleMasterPORec.FindSet();

        repeat
            Tot += StyleMasterPORec.Qty;
        until StyleMasterPORec.Next() = 0;

        StyleMasterRec.Reset();
        StyleMasterRec.SetRange("No.", rec."Style No.");
        if StyleMasterRec.FindSet() then begin
            StyleMasterRec."PO Total" := Tot;
            StyleMasterRec.Modify();
        end;
    end;


    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
    begin
        rec.TestField("Lot No.");
        rec.TestField(Qty);
        rec.TestField(BPCD);
        rec.TestField("Ship Date");
        rec.TestField("PO No.");
    end;

    trigger OnDeleteRecord(): Boolean
    var
        NavappPlanLineRec: Record "NavApp Planning Lines";
        AssorColorSizeRatioRec: Record AssorColorSizeRatio;
        NavAppProdPlanRec: Record "NavApp Prod Plans Details";
        PlanningQueueRec: Record "Planning Queue";
    begin
        CurrPage.Update();

        PlanningQueueRec.Reset();
        PlanningQueueRec.SetRange("Style No.", rec."Style No.");
        PlanningQueueRec.SetRange("Lot No.", rec."Lot No.");
        if PlanningQueueRec.FindSet() then
            Error('PO already in the Queue. Cannot delete.');

        NavappPlanLineRec.Reset();
        NavappPlanLineRec.SetRange("Style No.", rec."Style No.");
        NavappPlanLineRec.SetRange("Lot No.", rec."Lot No.");
        if NavappPlanLineRec.FindSet() then
            Error('PO already planned. Cannot delete.');

        AssorColorSizeRatioRec.Reset();
        AssorColorSizeRatioRec.SetRange("Style No.", rec."Style No.");
        AssorColorSizeRatioRec.SetRange("PO No.", rec."PO No.");
        if AssorColorSizeRatioRec.FindSet() then
            Error('Color Size entered for the PO. Cannot delete.');

        NavAppProdPlanRec.Reset();
        NavAppProdPlanRec.SetRange("Style No.", rec."Style No.");
        NavAppProdPlanRec.SetRange("Lot No.", rec."Lot No.");
        if NavAppProdPlanRec.FindSet() then
            Error('PO already planned. Cannot delete.');

    end;

}