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
                // field("Resource No."; rec."Resource No.")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Line No';
                // }

                field(ResourceName; ResourceName)
                {
                    ApplicationArea = All;
                    Caption = 'Line';
                }

                field(PlanDate; rec.PlanDate)
                {
                    ApplicationArea = All;
                    Caption = 'Plan Date';
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

                field(Qty; rec.Qty)
                {
                    ApplicationArea = All;
                    Caption = 'Planned Qty';
                }

                field("Learning Curve No."; rec."Learning Curve No.")
                {
                    ApplicationArea = All;
                    Caption = 'Learning Curve';
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
    begin
        Variance := rec.ProdUpdQty - rec.qty;

        //Get Resource Name
        WorkCEnterRec.Reset();
        WorkCEnterRec.SetRange("No.", rec."Resource No.");
        if WorkCEnterRec.FindSet() then
            ResourceName := WorkCEnterRec.Name;
    end;


    trigger OnOpenPage()
    var
    begin
        //SetFilter("Resource No.", ResourceNo);
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


}