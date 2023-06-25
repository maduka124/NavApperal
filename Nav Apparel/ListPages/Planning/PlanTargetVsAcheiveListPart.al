page 50348 "Plan Target Vs Acheive"
{
    PageType = ListPart;
    SourceTable = "NavApp Prod Plans Details";
    SourceTableView = sorting("No.") order(ascending);
    Editable = false;
    Caption = 'Planned Vs Acheived';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(ResourceName; ResourceName)
                {
                    ApplicationArea = All;
                    Caption = 'Line';
                }

                field(Buyer; Buyer)
                {
                    ApplicationArea = All;
                }

                field("Brand Name"; Rec."Brand Name")
                {
                    ApplicationArea = All;
                    Caption = 'Brand Name';
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
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

                field(PlanDate; rec.PlanDate)
                {
                    ApplicationArea = All;
                    Caption = 'Plan Date';
                }

                field("Learning Curve No."; rec."Learning Curve No.")
                {
                    ApplicationArea = All;
                    Caption = 'Learning Curve';
                }

                field(HoursPerDay; rec.HoursPerDay)
                {
                    ApplicationArea = All;
                    Caption = 'Hours Per Day';
                }

                field(OrderQty; OrderQty)
                {
                    ApplicationArea = All;
                    Caption = 'Order Qty';
                }

                field(Qty; rec.Qty)
                {
                    ApplicationArea = All;
                    Caption = 'Planned Qty';
                    DecimalPlaces = 0;
                }

                field(ProdUpdQty; rec.ProdUpdQty)
                {
                    ApplicationArea = All;
                    Caption = 'Achieved Qty';
                }

                field(Variance; Variance)
                {
                    ApplicationArea = All;
                    Caption = 'Variance';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        WorkCEnterRec: Record "Work Center";
        StyleRec: Record "Style Master";
        StyleMasPoRec: Record "Style Master PO";
    begin
        if rec.ProdUpd = 1 then
            Variance := rec.ProdUpdQty - rec.qty
        else
            Variance := 0;

        //Get Resource Name
        WorkCEnterRec.Reset();
        WorkCEnterRec.SetRange("No.", rec."Resource No.");
        if WorkCEnterRec.FindSet() then
            ResourceName := WorkCEnterRec.Name;

        StyleMasPoRec.Reset();
        StyleMasPoRec.SetRange("Style No.", rec."Style No.");
        StyleMasPoRec.SetRange("Lot No.", rec."Lot No.");
        if StyleMasPoRec.FindSet() then begin
            OrderQty := StyleMasPoRec.Qty;
        end
        else begin
            OrderQty := 0;
        end;

        StyleRec.Reset();
        StyleRec.SetRange("No.", Rec."Style No.");
        if StyleRec.FindFirst() then begin
            Buyer := StyleRec."Buyer Name";
            Rec."Brand Name" := StyleRec."Brand Name";
        end
        else begin
            Buyer := '';
            Rec."Brand Name" := '';
        end;
    end;


    trigger OnOpenPage()
    var
    begin
        rec.SetFilter("Line No.", LineNo);
    end;


    procedure PassParameters(ResourceNoPara: Code[20]);
    var
    begin
        //ResourceNo := ResourceNoPara;
        LineNo := ResourceNoPara // Line No is the parameter value
    end;

    var
        StartDate: Date;
        //ResourceNo: Code[20];
        LineNo: Code[20];
        Variance: BigInteger;
        ResourceName: Text[50];
        Buyer: Text[500];
        OrderQty: BigInteger;
}