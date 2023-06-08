pageextension 50314 PostedSalesInvoice extends "Posted Sales Invoices"
{

    layout
    {
        modify("No.")
        {
            Visible = false;
        }
        modify("Sell-to Customer No.")
        {
            Visible = false;
        }

        modify("Due Date")
        {
            Visible = false;
        }
        addafter("Due Date")
        {
            field("Payment Due Date"; Rec."Payment Due Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Sell-to Customer Name")
        {
            field("Sell-to Contact No."; Rec."Sell-to Contact No.")
            {
                ApplicationArea = all;
            }
        }
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
        addafter("Currency Code")
        {
            field("External Document No"; Rec."External Document No.")
            {
                ApplicationArea = all;
                // Caption = 'Master Lc No';
            }
        }

        addbefore(Amount)
        {
            field("UD No"; Rec."UD No")
            {
                ApplicationArea = all;
            }
            field("Exp No"; Rec."Exp No")
            {
                ApplicationArea = all;
            }
            field("Exp Date"; Rec."Exp Date")
            {
                ApplicationArea = all;
            }
        }

    }

    // trigger OnAfterGetRecord()

    // begin
    //     SalesRec.Reset();
    //     SalesRec.SetRange("Document Type", SalesRec."Document Type"::Order);
    //     SalesRec.SetRange("Sell-to Customer No.", Rec."Sell-to Customer No.");
    //     SalesRec.SetRange("No.", Rec."Order No.");
    //     SalesRec.SetRange("Last Posting No.", Rec."No.");
    //     if SalesRec.FindSet() then begin
    //         repeat
    //             LcNo := SalesRec."External Document No.";
    //             SalesRec.Modify()
    //         until salesInvRec.Next() = 0;
    //     end;
    // end;


    var
        // PaymentDueDate: Date;
        LcNo: Code[20];
        myInt: Integer;
        SalesRec: Record "Sales Header";
        salesInvRec: Record "Sales Invoice Header";
}