page 50794 "ContractBBLC Summary ListPart2"
{
    PageType = ListPart;
    SourceTable = "Purchase Header";
    SourceTableView = sorting("Buy-from Vendor No.") where("Assigned PI No." = filter(''));
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Buy-from Vendor Name"; "Buy-from Vendor Name")
                {
                    ApplicationArea = All;
                    Caption = 'Supplier';
                }

                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'PO No';
                }

                field("Amount Including VAT"; "Amount Including VAT")
                {
                    ApplicationArea = All;
                    Caption = 'Amount';
                }

                field("Document Date"; "Document Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}