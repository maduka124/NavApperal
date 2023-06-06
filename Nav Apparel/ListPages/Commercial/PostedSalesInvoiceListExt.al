pageextension 50314 PostedSalesInvoice extends "Posted Sales Invoices"
{

    layout
    {
        modify("Sell-to Customer No.")
        {
            Visible = false;
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
            field("External Doc No Sales"; Rec."External Doc No Sales")
            {
                ApplicationArea = all;
                Caption = 'Master Lc No';
            }
        }
        addbefore(Amount)
        {
            field("UD No"; Rec."UD No")
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
        LcNo: Code[20];
        myInt: Integer;
        SalesRec: Record "Sales Header";
        salesInvRec: Record "Sales Invoice Header";
}