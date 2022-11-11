pageextension 50805 "Consumption Jrnl List Ext" extends "Consumption Journal"
{
    layout
    {
        addafter("Document No.")
        {
            field("Cut No"; "Cut No")
            {
                ApplicationArea = All;
            }
        }
    }


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
                    MaterialReport: Report MaterialRequition;
                begin
                    RPORec.Reset();
                    RPORec.SetRange("No.", "Order No.");
                    RPORec.SetRange(Status, RPORec.Status::Released);
                    // RPORec.FindSet();
                    // ManuPrintReport.PrintProductionOrder(RPORec, 1);
                    MaterialReport.Set_Value("Document No.");
                    MaterialReport.Run();

                end;
            }
        }
    }

    var
        ManuPrintReport: Codeunit "Manu. Print Report";
}