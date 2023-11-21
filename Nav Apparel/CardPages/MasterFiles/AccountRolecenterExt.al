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

                action("CashReceiptReport")
                {
                    Caption = 'Cash Receipt Report';
                    Enabled = true;
                    RunObject = report CashReceiptReport;
                    ApplicationArea = all;
                }

                action("CostBreakupReport")
                {
                    Caption = 'Cost Breakup Report';
                    Enabled = true;
                    RunObject = report CostBreakupReport;
                    ApplicationArea = all;
                }

                action("Estimate Costing Report")
                {
                    Caption = 'Estimate Costing Report';
                    Enabled = true;
                    RunObject = report EstimateCostSheetReport;
                    ApplicationArea = all;
                }

                action("GenaralLedgerReport")
                {
                    Caption = 'General Ledger Report';
                    Enabled = true;
                    RunObject = report "General Ledger Report";
                    ApplicationArea = all;
                }

                action("Journal Voucher")
                {
                    Caption = 'Journal Voucher';
                    Enabled = true;
                    RunObject = report "Journal Voucher";
                    ApplicationArea = all;
                }

                action("Order Completion Report - Finace")
                {
                    Caption = 'Order Completion Report';
                    Enabled = true;
                    RunObject = report OCR;
                    ApplicationArea = all;
                }

                action("Payment Journal")
                {
                    Caption = 'Payment Journal';
                    Enabled = true;
                    RunObject = report "Payment Journal";
                    ApplicationArea = all;
                }
            }
        }

    }
}