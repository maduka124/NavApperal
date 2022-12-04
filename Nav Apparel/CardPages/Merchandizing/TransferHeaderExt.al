pageextension 50632 TransferHeaderExt extends "Transfer Order"
{
    layout
    {
        addlast(General)
        {
            field("Style No."; rec."Style No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            // field("Style Name"; rec."Style Name")
            // {
            //     ApplicationArea = All;
            //     Editable = false;
            // }
            // field(PO; rec.PO)
            // {
            //     ApplicationArea = All;
            //     Editable = false;
            // }
        }
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
                    TransferHeaderReport.Set_Value(rec."No.");
                    TransferHeaderReport.RunModal();
                end;
            }
        }
    }

}
