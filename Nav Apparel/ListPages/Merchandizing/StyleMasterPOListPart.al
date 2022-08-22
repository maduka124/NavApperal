page 71012731 "Style Master PO ListPart"
{
    PageType = ListPart;
    SourceTable = "Style Master PO";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Lot No."; "Lot No.")
                {
                    ApplicationArea = All;
                    Caption = 'Lot No';

                    trigger OnValidate()
                    var
                        BOMEstCostRec: Record "BOM Estimate Cost";
                        StyleMasRec: Record "Style Master";
                    begin

                        BOMEstCostRec.Reset();
                        BOMEstCostRec.SetCurrentKey("Style No.");
                        BOMEstCostRec.SetRange("Style No.", "Style No.");

                        if BOMEstCostRec.FindSet() then begin
                            "Unit Price" := BOMEstCostRec."FOB Pcs";
                        end;

                        //Get BPCD
                        StyleMasRec.Reset();
                        StyleMasRec.SetRange("No.", "Style No.");

                        if StyleMasRec.FindSet() then begin
                            BPCD := StyleMasRec.BPCD;
                            "Style Name" := StyleMasRec."Style No.";
                        end;

                    end;
                }

                field("PO No."; "PO No.")
                {
                    ApplicationArea = All;
                    Caption = 'PO No';

                    trigger OnValidate()
                    var
                        SalesHeaderRec: Record "Sales Header";
                    begin
                        CurrPage.Update();
                        SalesHeaderRec.Reset();
                        SalesHeaderRec.SetCurrentKey("Style No", Lot);
                        SalesHeaderRec.SetRange("Style No", "Style No.");
                        SalesHeaderRec.SetRange(Lot, "Lot No.");

                        if SalesHeaderRec.FindSet() then
                            SalesHeaderRec.ModifyAll("PO No", "PO No.");
                    end;
                }

                field(Qty; Qty)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        StyleMasterRec: Record "Style Master";
                        StyleMasterPORec: Record "Style Master PO";
                        Tot: BigInteger;
                    begin

                        CurrPage.Update();
                        StyleMasterPORec.Reset();
                        StyleMasterPORec.SetRange("Style No.", "Style No.");
                        StyleMasterPORec.FindSet();

                        repeat
                            Tot += StyleMasterPORec.Qty;
                        until StyleMasterPORec.Next() = 0;

                        StyleMasterRec.Reset();
                        StyleMasterRec.SetRange("No.", "Style No.");
                        if StyleMasterRec.FindSet() then
                            StyleMasterRec.ModifyAll("PO Total", Tot)

                    end;
                }

                field(Mode; Mode)
                {
                    ApplicationArea = All;
                }

                field("Ship Date"; "Ship Date")
                {
                    ApplicationArea = All;
                }

                field(SID; SID)
                {
                    ApplicationArea = All;
                }

                field("Unit Price"; "Unit Price")
                {
                    ApplicationArea = All;
                }

                field(Status; Status)
                {
                    ApplicationArea = All;
                }

                field("Confirm Date"; "Confirm Date")
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
        StyleMasterPORec.SetRange("Style No.", "Style No.");
        StyleMasterPORec.FindSet();

        repeat
            Tot += StyleMasterPORec.Qty;
        until StyleMasterPORec.Next() = 0;

        StyleMasterRec.Reset();
        StyleMasterRec.SetRange("No.", "Style No.");
        if StyleMasterRec.FindSet() then begin
            StyleMasterRec."PO Total" := Tot;
            StyleMasterRec.Modify();
        end;
    end;


}