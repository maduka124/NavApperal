pageextension 50314 PostedSalesInvoice extends "Posted Sales Invoices"
{
    layout
    {
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


    trigger OnAfterGetRecord()
    var        
        SalesInVLineRec: Record "Sales Invoice Line";
    begin      
        SalesInVLineRec.Reset();
        SalesInVLineRec.SetRange("Document No.", rec."No.");
        SalesInVLineRec.SetRange(Type, SalesInVLineRec.Type::Item);
        if SalesInVLineRec.FindSet() then begin
            repeat
                Rec."Ship Qty" += SalesInVLineRec.Quantity;
            until SalesInVLineRec.Next() = 0;
        end;
    end;   
}