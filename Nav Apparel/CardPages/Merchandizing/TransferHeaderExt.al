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
            trigger OnBeforeAction()
            var
                myInt: Integer;
                TransferHeaderReport: Report TransferOrderCardPageReport;
            begin
                TransferHeaderReport.Set_Value("No.");
                TransferHeaderReport.RunModal();
            end;
        }
    }

    var
        myInt: Integer;
}
