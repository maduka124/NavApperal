page 51298 "WIP Style PO Listpart"
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
                    begin
                        CurrPage.Update();
                        NavappPlanLineRec.Reset();
                        NavappPlanLineRec.SetRange("Style No.", rec."Style No.");
                        NavappPlanLineRec.SetRange("Lot No.", xrec."Lot No.");
                        if NavappPlanLineRec.FindSet() then
                            Error('PO already planned. Cannot change Lot No.');

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
                    Editable = false;

                    trigger OnValidate()
                    var
                        SalesHeaderRec: Record "Sales Header";
                        PONOVar: Text[50];
                        NavappPlanLineRec: Record "NavApp Planning Lines";
                    begin

                        NavappPlanLineRec.Reset();
                        NavappPlanLineRec.SetRange("Style No.", rec."Style No.");
                        NavappPlanLineRec.SetRange("PO No.", xrec."PO No.");
                        if NavappPlanLineRec.FindSet() then
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
                    Editable = false;

                    trigger OnValidate()
                    var
                        StyleMasterRec: Record "Style Master";
                        StyleMasterPORec: Record "Style Master PO";
                        Tot: BigInteger;
                        NavappPlanLineRec: Record "NavApp Planning Lines";
                    begin

                        NavappPlanLineRec.Reset();
                        NavappPlanLineRec.SetRange("Style No.", rec."Style No.");
                        NavappPlanLineRec.SetRange("PO No.", rec."PO No.");
                        if NavappPlanLineRec.FindSet() then
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
                    Editable = false;
                }

                field(BPCD; rec.BPCD)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = false;

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
                    Editable = false;

                    trigger OnValidate()
                    var
                        NavappRec: Record "NavApp Setup";
                        StyleMasRec: Record "Style Master";
                        NavappPlanLineRec: Record "NavApp Planning Lines";
                    begin

                        NavappPlanLineRec.Reset();
                        NavappPlanLineRec.SetRange("Style No.", rec."Style No.");
                        NavappPlanLineRec.SetRange("PO No.", rec."PO No.");
                        if NavappPlanLineRec.FindSet() then
                            Error('Style already planned. Cannot change Ship Date.');

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
                    Editable = false;
                }

                field("Unit Price"; rec."Unit Price")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Confirm Date"; rec."Confirm Date")
                {
                    ApplicationArea = All;
                    Editable = false;

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

                field("Cut In Qty"; Rec."Cut In Qty")
                {
                    ApplicationArea = All;
                }
                field("Sawing In Qty"; Rec."Sawing In Qty")
                {
                    ApplicationArea = All;
                }
                field("Sawing Out Qty"; Rec."Sawing Out Qty")
                {
                    ApplicationArea = All;
                }
                field("Wash In Qty"; Rec."Wash In Qty")
                {
                    ApplicationArea = All;
                }
                field("Wash Out Qty"; Rec."Wash Out Qty")
                {
                    ApplicationArea = All;
                }
                field("Poly Bag"; Rec."Poly Bag")
                {
                    ApplicationArea = All;
                }
                field("Shipped Qty"; Rec."Shipped Qty")
                {
                    ApplicationArea = All;
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
    begin
        CurrPage.Update();
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
    end;

}