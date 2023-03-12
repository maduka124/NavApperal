pageextension 51147 PostedPurchaseReciptLinesExt extends "Posted Purchase Receipt Lines"
{
    layout
    {

    }
    actions
    {
        addafter(Dimensions)
        {
            action("Print")
            {
                Caption = 'Print';
                Image = Print;
                ApplicationArea = All;

                trigger OnAction()
                var
                    DetailGRNReportRec: Report DetailGRNReport;
                begin
                    DetailGRNReportRec.RunModal();
                end;

            }
        }
    }
}