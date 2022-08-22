page 50346 "Plan Target List part"
{
    PageType = ListPart;
    SourceTable = "NavApp Prod Plans Details";
    SourceTableView = sorting("No.") order(ascending) where(HoursPerDay = filter(<> 0));
    Editable = false;
    Caption = 'Plan Targets';

    layout
    {
        area(Content)
        {
            repeater(General)
            {              
                field(PlanDate; PlanDate)
                {
                    ApplicationArea = All;
                    Caption = 'Plan Date';
                }

                field("Start Time"; "Start Time")
                {
                    ApplicationArea = All;
                }

                field("Finish Time"; "Finish Time")
                {
                    ApplicationArea = All;
                }

                field(Hours; Hours)
                {
                    ApplicationArea = All;
                    Caption = 'Hours';
                }

                field(Qty; Qty)
                {
                    ApplicationArea = All;
                    Caption = 'Target';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
    begin
        Hours := ("Finish Time" - "Start Time") / (60 * 60 * 1000);
    end;

    trigger OnOpenPage()
    var
    begin
        SetFilter("Line No.", LineNo);
    end;

    procedure PassParameters(LineNoPara: Text);
    var
    begin
        LineNo := LineNoPara;
    end;

    var
        LineNo1: BigInteger;
        LineNo: Text;
        Hours: Decimal;
}