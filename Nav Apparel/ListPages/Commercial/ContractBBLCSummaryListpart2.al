page 50794 "ContractBBLC Summary ListPart2"
{
    PageType = ListPart;
    SourceTable = AwaitingPOs;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = All;
                    Caption = 'Supplier';
                }

                field("PO No"; Rec."PO No")
                {
                    ApplicationArea = All;
                }

                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                    Caption = 'Amount';
                }

                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}