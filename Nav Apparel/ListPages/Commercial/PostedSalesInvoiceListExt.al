pageextension 50314 PostedSalesInvoice extends "Posted Sales Invoices"
{

    layout
    {
        addbefore("Currency Code")
        {
            field("PO No"; Rec."PO No")
            {
                ApplicationArea = all;
            }
            field("Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = all;

            }
        }

    }

    var
        myInt: Integer;
}