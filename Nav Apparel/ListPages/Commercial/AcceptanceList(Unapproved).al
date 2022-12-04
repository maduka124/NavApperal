page 50541 "Acceptance List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = AcceptanceHeader;
    SourceTableView = sorting("AccNo.") order(descending) where(Approved = filter(false));
    CardPageId = "Acceptance Card";
    Editable = false;
    Caption = 'Acceptance List (Unapproved)';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("AccNo."; Rec."AccNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Seq No';
                }

                field("B2BLC No"; Rec."B2BLC No")
                {
                    ApplicationArea = All;
                }

                field("Suppler Name"; Rec."Suppler Name")
                {
                    ApplicationArea = All;
                    Caption = 'Suppler';
                }

                field("Accept Value"; Rec."Accept Value")
                {
                    ApplicationArea = All;
                }

                field("Accept Date"; Rec."Accept Date")
                {
                    ApplicationArea = All;
                }

                field("Acceptance S/N"; Rec."Acceptance S/N")
                {
                    ApplicationArea = All;
                }

                field("Maturity Date"; Rec."Maturity Date")
                {
                    ApplicationArea = All;
                }

                field("Payment Mode"; Rec."Payment Mode")
                {
                    ApplicationArea = All;
                }

                field(Approved; Rec.Approved)
                {
                    ApplicationArea = All;
                    Caption = 'Approved Status';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {

            action("Approve")
            {
                ApplicationArea = all;
                Image = Approve;

                trigger OnAction()
                var

                begin
                    Rec.Approved := true;
                    Rec.ApproveDate := Today;
                    CurrPage.Update();
                end;

            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        AcceptanceLineRec: Record AcceptanceLine;
        AcceptanceInv1Rec: Record AcceptanceInv1;
        AcceptanceInv2Rec: Record AcceptanceInv2;
        GITBaseonLCRec: Record GITBaseonLC;
        GITBaseonPIRec: Record GITBaseonPI;
    begin
        AcceptanceLineRec.reset();
        AcceptanceLineRec.SetRange("AccNo.", Rec."AccNo.");
        AcceptanceLineRec.DeleteAll();

        AcceptanceInv1Rec.reset();
        AcceptanceInv1Rec.SetRange("AccNo.", Rec."AccNo.");
        AcceptanceInv1Rec.DeleteAll();

        AcceptanceInv2Rec.reset();
        AcceptanceInv2Rec.SetRange("AccNo.", Rec."AccNo.");
        AcceptanceInv2Rec.DeleteAll();

        GITBaseonLCRec.reset();
        GITBaseonLCRec.SetRange(AssignedAccNo, Rec."AccNo.");
        if GITBaseonLCRec.FindSet() then
            GITBaseonLCRec.ModifyAll(AssignedAccNo, '');

        GITBaseonPIRec.reset();
        GITBaseonPIRec.SetRange(AssignedAccNo, Rec."AccNo.");
        if GITBaseonPIRec.FindSet() then
            GITBaseonPIRec.ModifyAll(AssignedAccNo, '');

    end;
}