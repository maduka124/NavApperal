page 50340 "Property Card"
{
    PageType = Card;
    Caption = 'Property';
    SourceTable = "Planning Queue";
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            group(Properties)
            {
                field(buyer; Buyer)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Buyer';
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                    Editable = false;
                }

                field("Lot No."; rec."Lot No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Lot No';
                }

                field("PO No."; rec."PO No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'PO No';
                }

                field(Qty; rec.Qty)
                {
                    ApplicationArea = All;
                    Caption = 'Qty';
                    Editable = false;
                }

                field(SMV; rec.SMV)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Carder; rec.Carder)
                {
                    ApplicationArea = All;
                    Caption = 'Man/Machine Req.';

                    trigger OnValidate()
                    var
                    begin
                        Cal();
                    end;
                }

                field(Eff; rec.Eff)
                {
                    ApplicationArea = All;
                    Caption = 'Plan Efficiency (%)';

                    trigger OnValidate()
                    var
                    begin
                        Cal();
                    end;
                }

                field(HoursPerDay; rec.HoursPerDay)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Working Hours Per Day';

                    trigger OnValidate()
                    var
                    begin
                        Cal();
                    end;
                }

                field(Target; rec.Target)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(HourlyTarget; HourlyTarget)
                {
                    ApplicationArea = All;
                    Caption = 'Hourly Target';
                    Editable = false;
                    DecimalPlaces = 0;
                }

                field("Learning Curve No."; rec."Learning Curve No.")
                {
                    ApplicationArea = All;
                    Caption = 'Learning Curve';
                }

                field("TGTSEWFIN Date"; rec."TGTSEWFIN Date")
                {
                    ApplicationArea = All;
                    Caption = 'Req. Saw. Finish Date';
                }

                field(BPCD; BPCD)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(ShipDate; ShipDate)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Ship Date';
                }
            }

            part("Property Picture FactBox Q"; "Property Picture FactBox Q")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("Style No.");
                Caption = ' ';
            }

        }
    }

    procedure Cal();
    var
    begin
        if rec.SMV <> 0 then begin
            HourlyTarget := round(((60 / rec.SMV) * rec.Carder * rec.Eff) / 100, 1);
            rec.Target := round(HourlyTarget * rec.HoursPerDay, 1);
        end
        else
            Message('SMV is zero. Cannot continue.');


        // if rec.SMV <> 0 then begin
        //     rec.Target := round(((60 / rec.SMV) * rec.Carder * rec.HoursPerDay * rec.Eff) / 100, 1);
        // end
        // else
        //     Message('SMV is zero. Cannot continue.');
    end;


    trigger OnAfterGetCurrRecord()
    var
        StyeMastePORec: Record "Style Master PO";
        StyeMasteRec: Record "Style Master";
        NavAppSetupRec: Record "NavApp Setup";
    begin
        NavAppSetupRec.Reset();
        NavAppSetupRec.FindSet();

        rec.HoursPerDay := 10;

        if rec.SMV = 0 then
            HourlyTarget := 0
        else
            HourlyTarget := round(((60 / rec.SMV) * rec.Carder * rec.Eff) / 100, 1);

        rec.Target := round(HourlyTarget * rec.HoursPerDay, 1);

        StyeMasteRec.Reset();
        StyeMasteRec.SetRange("No.", rec."Style No.");
        if StyeMasteRec.FindSet() then
            Buyer := StyeMasteRec."Buyer Name"
        else
            Buyer := '';

        StyeMastePORec.Reset();
        StyeMastePORec.SetRange("Style No.", rec."Style No.");
        StyeMastePORec.SetRange("PO No.", rec."PO No.");
        if StyeMastePORec.FindSet() then begin
            OrderQty := StyeMastePORec.Qty;
            BPCD := StyeMastePORec.BPCD;
            ShipDate := StyeMastePORec."Ship Date";
            rec."TGTSEWFIN Date" := ShipDate - NavAppSetupRec."Sewing Finished"
        end
        else begin
            BPCD := 0D;
            OrderQty := 0;
            ShipDate := 0D;
        end;
    end;


    var
        OrderQty: BigInteger;
        Buyer: Text[500];
        HourlyTarget: Decimal;
        BPCD: Date;
        ShipDate: Date;

}