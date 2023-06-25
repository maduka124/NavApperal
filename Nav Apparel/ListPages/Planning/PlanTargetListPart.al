page 50346 "Plan Target List part"
{
    PageType = ListPart;
    SourceTable = "NavApp Prod Plans Details";
    //SourceTableView = sorting("No.") order(ascending) where(HoursPerDay = filter(<> 0));
    SourceTableView = sorting("No.") order(ascending);
    Editable = false;
    Caption = 'Plan Targets';

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

                field(PlanDate; rec.PlanDate)
                {
                    ApplicationArea = All;
                    Caption = 'Plan Date';
                }

                field("Start Time"; rec."Start Time")
                {
                    ApplicationArea = All;
                }

                field("Finish Time"; rec."Finish Time")
                {
                    ApplicationArea = All;
                }

                field(Hours; Hours)
                {
                    ApplicationArea = All;
                    Caption = 'Hours';
                }

                field("Learning Curve No."; rec."Learning Curve No.")
                {
                    ApplicationArea = All;
                    Caption = 'Learning Curve';
                }

                field(Qty; rec.Qty)
                {
                    ApplicationArea = All;
                    Caption = 'Target';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        WorkCEnterRec: Record "Work Center";
    begin
        Hours := (rec."Finish Time" - rec."Start Time") / (60 * 60 * 1000);

        //Get Resource Name
        WorkCEnterRec.Reset();
        WorkCEnterRec.SetRange("No.", rec."Resource No.");
        if WorkCEnterRec.FindSet() then
            ResourceName := WorkCEnterRec.Name;
    end;


    trigger OnOpenPage()
    var
    begin
        rec.SetFilter("Line No.", LineNo);
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
        ResourceName: Text[50];
}