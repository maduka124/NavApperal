pageextension 51384 GRNHeaderExt extends "Posted Purchase Receipt"
{
    actions
    {
        modify("&Print")
        {
            Visible = false;
        }

        addafter("&Print")
        {
            action(Print)
            {
                ApplicationArea = All;
                Image = Print;

                trigger OnAction()
                var
                    PurchRecHedd: Record "Purch. Rcpt. Header";
                    GRNReport: Report GNRReportExt;
                begin
                    PurchRecHedd.Reset();
                    PurchRecHedd.SetRange("No.", rec."No.");
                    PurchRecHedd.SetRange("Buy-from Vendor No.", Rec."Buy-from Vendor No.");
                    Report.RunModal(51383, true, true, PurchRecHedd);
                end;
            }
        }
    }
}