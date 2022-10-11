pageextension 50805 "Consumption Jrnl List Ext" extends "Consumption Journal"
{
    actions
    {
        addafter("Pro&d. Order")
        {
            action("Mat. Req. Report")
            {
                Caption = 'Mat. &Requisition';
                Image = PrintCover;
                ApplicationArea = All;

                trigger OnAction();
                var
                    RPORec: Record "Production Order";
                begin
                    RPORec.Reset();
                    RPORec.SetRange("No.", "Order No.");
                    RPORec.SetRange(Status, RPORec.Status::Released);
                    RPORec.FindSet();
                    ManuPrintReport.PrintProductionOrder(RPORec, 1);
                end;
            }
        }
    }

    var
        ManuPrintReport: Codeunit "Manu. Print Report";
}