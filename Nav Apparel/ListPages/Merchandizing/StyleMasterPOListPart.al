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
                    begin

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
                    begin
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
                    begin

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
                    begin
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
        rec.TestField("Ship Date");
        rec.TestField("PO No.");
    end;

}