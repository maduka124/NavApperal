pageextension 51415 SalesInvoicesHeaderExt extends "Posted Sales Invoice"
{
    layout
    {
        addafter("Your Reference")
        {
            field("Export Ref No."; rec."Export Ref No.")
            {
                ApplicationArea = All;
            }
        }
    }
}