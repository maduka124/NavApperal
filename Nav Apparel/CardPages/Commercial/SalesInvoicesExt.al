pageextension 51317 SalesInvoicesExt extends "Sales Invoice"
{
    layout
    {
        addafter("Sell-to Customer No.")
        {
            field("Style Name"; Rec."Style Name")
            {
                ApplicationArea = All;
            }
            field("PO No"; Rec."PO No")
            {
                ApplicationArea = All;
            }
            field(Lot; Rec.Lot)
            {
                ApplicationArea = All;
            }
            field("No of Cartons"; Rec."No of Cartons")
            {
                ApplicationArea = All;
            }
            field(CBM; Rec.CBM)
            {
                ApplicationArea = All;
            }
            field("Exp No"; Rec."Exp No")
            {
                ApplicationArea = All;
            }
            field("Exp Date"; Rec."Exp Date")
            {
                ApplicationArea = All;
            }
            field("UD No"; Rec."UD No")
            {
                ApplicationArea = All;
            }
            field("Contract No"; Rec."Contract No")
            {
                ApplicationArea = All;
            }
        }
    }
}