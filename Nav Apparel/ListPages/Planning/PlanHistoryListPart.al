page 50347 "Plan History List part"
{
    PageType = ListPart;
    SourceTable = "NavApp Planning Lines";
    SourceTableView = sorting("Style No.", "Lot No.", "Line No.") order(ascending);
    Editable = false;
    Caption = 'Plan History';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Resource Name"; rec."Resource Name")
                {
                    ApplicationArea = All;
                    Caption = 'Line';
                }
                field(Buyer; Buyer)
                {
                    ApplicationArea = All;
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                }

                field("Lot No."; rec."Lot No.")
                {
                    ApplicationArea = All;
                    Caption = 'Lot No';
                }

                field("PO No."; rec."PO No.")
                {
                    ApplicationArea = All;
                    Caption = 'PO No';
                }

                field(OrderQty; OrderQty)
                {
                    ApplicationArea = All;
                    Caption = 'Order Qty';
                }

                field(Qty; rec.Qty)
                {
                    ApplicationArea = All;
                    Caption = 'Plan Qty';
                }

                field(ShipDate; ShipDate)
                {
                    ApplicationArea = All;
                    Caption = 'Ship Date';
                }

                field(BPCD; BPCD)
                {
                    ApplicationArea = All;
                }

                field(StartDateTime; rec.StartDateTime)
                {
                    ApplicationArea = All;
                    Caption = 'Start Date/Time';
                }

                field(FinishDateTime; rec.FinishDateTime)
                {
                    ApplicationArea = All;
                    Caption = 'Finish Date/Time';
                }

                field(Carder; rec.Carder)
                {
                    ApplicationArea = All;
                    Caption = 'No of Machines';
                }

                field(Eff; rec.Eff)
                {
                    ApplicationArea = All;
                    Caption = 'Efficiency';
                }

                field(SMV; rec.SMV)
                {
                    ApplicationArea = All;
                }
                field("Learning Curve No."; rec."Learning Curve No.")
                {
                    ApplicationArea = All;
                    Caption = 'Learning Curve';
                }
            }
        }
    }

    trigger OnOpenPage()
    var
    begin
        rec.SetFilter("Style No.", StyleNo);
    end;


    trigger OnAfterGetRecord()
    var
        StyleMasPoRec: Record "Style Master PO";
        StyleMasRec: Record "Style Master";
    begin
        StyleMasPoRec.Reset();
        StyleMasPoRec.SetRange("Style No.", rec."Style No.");
        StyleMasPoRec.SetRange("PO No.", rec."PO No.");
        if StyleMasPoRec.FindSet() then begin
            ShipDate := StyleMasPoRec."Ship Date";
            OrderQty := StyleMasPoRec.Qty;
            BPCD := StyleMasPoRec.BPCD;
        end
        else begin
            ShipDate := 0D;
            OrderQty := 0;
            BPCD := 0D;
        end;

        StyleMasRec.Reset();
        StyleMasRec.SetRange("No.", rec."Style No.");
        if StyleMasRec.FindSet() then
            Buyer := StyleMasRec."Buyer Name"
        else
            Buyer := '';
    end;


    procedure PassParameters(StyleNoPara: Text);
    var
    begin
        StyleNo := StyleNoPara;
    end;

    var
        StyleNo: Text;
        ShipDate: Date;
        Buyer: Text[500];
        OrderQty: BigInteger;
        BPCD: Date;
}