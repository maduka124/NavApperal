pageextension 50314 PostedSalesInvoice extends "Posted Sales Invoices"
{

    layout
    {
        // modify("External Document No.")
        // {
        //     ApplicationArea = all;
        //     Visible = false;
        // }
        // modify("No.")
        // {
        //     Visible = false;
        // }
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
            field("Contract No"; Rec."Contract No")
            {
                ApplicationArea = all;
            }
            field("Style Name"; Rec."Style Name")
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
            field("PO QTY"; Rec."PO QTY")
            {
                ApplicationArea = All;
            }
            field("Unit Price"; Rec."Unit Price")
            {
                ApplicationArea = All;
            }
            field("Invoice Qty"; Rec."Invoice Qty")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Ship Qty"; Rec."Ship Qty")
            {
                ApplicationArea = All;
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


    trigger OnAfterGetRecord()
    var
        ShipmentLineRec: Record "Sales Shipment Line";
        SalesInVLineRec: Record "Sales Invoice Line";
    begin
        // ShipmentLineRec.Reset();
        // ShipmentLineRec.SetRange("Order No.", Rec."Order No.");
        // ShipmentLineRec.SetRange(Type, ShipmentLineRec.Type::Item);
        // if ShipmentLineRec.FindSet() then begin
        //     repeat
        //         Rec."Ship Qty" += ShipmentLineRec.Quantity;
        //     until ShipmentLineRec.Next() = 0;
        // end;

        SalesInVLineRec.Reset();
        SalesInVLineRec.SetRange("Order No.", Rec."Order No.");
        SalesInVLineRec.SetRange(Type, SalesInVLineRec.Type::Item);
        if SalesInVLineRec.FindSet() then begin
            repeat
                Rec."Ship Qty" += SalesInVLineRec.Quantity;
            until SalesInVLineRec.Next() = 0;
        end;
    end;

    var
    // PaymentDueDate: Date;

}