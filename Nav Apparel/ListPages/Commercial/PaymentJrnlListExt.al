pageextension 51190 PaymentJrnlList extends "Payment Journal"
{
    layout
    {
        addafter("Document No.")
        {
            field("LC/Contract No."; rec."LC/Contract No.")
            {
                ApplicationArea = all;
                Caption = 'LC/Contract No';
                Editable = false;
            }

            field("B2BLC No"; rec."B2BLC No")
            {
                ApplicationArea = all;
                Caption = 'B2BLC No';
                Editable = false;
            }
        }
    }
}