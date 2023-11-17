pageextension 51473 AccountRoleExt extends "Accountant Role Center"
{
    actions
    {
        addafter("Posted Documents")
        {
            group("Finnce Report")
            {
                Caption = 'Finnace Report';
                Image = Marketing;

                action("CostBreakupReport")
                {
                    Caption = 'Cost Breakup Report';
                    Enabled = true;
                    RunObject = report CostBreakupReport;
                    ApplicationArea = all;
                }

                action("GenaralLedgerReport")
                {
                    Caption = 'General Ledger Report';
                    Enabled = true;
                    RunObject = report "General Ledger Report";
                    ApplicationArea = all;
                }

                action("Order Completion Report - Finace")
                {
                    Caption = 'Order Completion Report';
                    Enabled = true;
                    RunObject = report OCR;
                    ApplicationArea = all;
                }

                action("Estimate Costing Report")
                {
                    Caption = 'Estimate Costing Report';
                    Enabled = true;
                    RunObject = report EstimateCostSheetReport;
                    ApplicationArea = all;
                }
            }
        }

    }
}