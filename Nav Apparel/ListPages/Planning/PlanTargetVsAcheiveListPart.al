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
                field("Resource No."; "Resource No.")
                {
                    ApplicationArea = All;
                    Caption = 'Line No';
                }

                field(PlanDate; PlanDate)
                {
                    ApplicationArea = All;
                    Caption = 'Plan Date';
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Lot No."; "Lot No.")
                {
                    ApplicationArea = All;
                    Caption = 'Lot No';
                }

                field("PO No."; "PO No.")
                {
                    ApplicationArea = All;
                    Caption = 'PO No';
                }

                field(Qty; Qty)
                {
                    ApplicationArea = All;
                    Caption = 'Planned Qty';
                }

                field(ProdUpdQty; ProdUpdQty)
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
    begin
        Variance := ProdUpdQty - qty;
    end;


    trigger OnOpenPage()
    var
    begin
        //SetFilter("Resource No.", ResourceNo);
        SetFilter("Line No.", LineNo);
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


}