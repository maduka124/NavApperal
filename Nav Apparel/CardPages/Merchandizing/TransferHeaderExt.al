pageextension 50632 TransferHeaderExt extends "Transfer Order"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        modify("&Print")
        {
            Visible = false;
        }

        addafter("P&osting")
        {
            action("Transfer Order Report")
            {
                ApplicationArea = all;
                trigger OnAction()
                var
                    myInt: Integer;
                    TransferHeaderReport: Report TransferOrderCardPageReport;
                begin
                    TransferHeaderReport.Set_Value("No.");
                    TransferHeaderReport.RunModal();
                end;
            }
        }
    }

}
