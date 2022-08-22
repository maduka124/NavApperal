page 50541 "Acceptance List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = AcceptanceHeader;
    SourceTableView = where(Approved = filter(false));
    CardPageId = "Acceptance Card";
    Editable = false;
    Caption = 'Acceptance List (Unapproved)';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("AccNo."; "AccNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Seq No';
                }

                field("B2BLC No"; "B2BLC No")
                {
                    ApplicationArea = All;
                }

                field("Suppler Name"; "Suppler Name")
                {
                    ApplicationArea = All;
                    Caption = 'Suppler';
                }

                field("Accept Value"; "Accept Value")
                {
                    ApplicationArea = All;
                }

                field("Accept Date"; "Accept Date")
                {
                    ApplicationArea = All;
                }

                field("Acceptance S/N"; "Acceptance S/N")
                {
                    ApplicationArea = All;
                }

                field("Maturity Date"; "Maturity Date")
                {
                    ApplicationArea = All;
                }

                field("Payment Mode"; "Payment Mode")
                {
                    ApplicationArea = All;
                }

                field(Approved; Approved)
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
                Image = List;

                trigger OnAction()
                var

                begin
                    Approved := true;
                    ApproveDate := Today;
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
        AcceptanceLineRec.SetRange("AccNo.", "AccNo.");
        AcceptanceLineRec.DeleteAll();

        AcceptanceInv1Rec.reset();
        AcceptanceInv1Rec.SetRange("AccNo.", "AccNo.");
        AcceptanceInv1Rec.DeleteAll();

        AcceptanceInv2Rec.reset();
        AcceptanceInv2Rec.SetRange("AccNo.", "AccNo.");
        AcceptanceInv2Rec.DeleteAll();

        GITBaseonLCRec.reset();
        GITBaseonLCRec.SetRange(AssignedAccNo, "AccNo.");
        if GITBaseonLCRec.FindSet() then
            GITBaseonLCRec.ModifyAll(AssignedAccNo, '');

        GITBaseonPIRec.reset();
        GITBaseonPIRec.SetRange(AssignedAccNo, "AccNo.");
        if GITBaseonPIRec.FindSet() then
            GITBaseonPIRec.ModifyAll(AssignedAccNo, '');

    end;
}