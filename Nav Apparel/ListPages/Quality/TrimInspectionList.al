page 50571 "Trim Inspection List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Purch. Rcpt. Header";
    SourceTableView = sorting("No.") order(descending);
    //where("Trim Inspected" = filter(true));
    CardPageId = "Trim Inspection Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'GRN No';
                }

                field("Document Date"; "Document Date")
                {
                    ApplicationArea = All;
                    Caption = 'GRN Date';
                }

                field("Buy-from Vendor Name"; "Buy-from Vendor Name")
                {
                    ApplicationArea = All;
                    Caption = 'Supplier';
                }

                field("Order No."; "Order No.")
                {
                    ApplicationArea = All;
                    Caption = 'PO No';
                }

                field("Trim Inspected"; "Trim Inspected")
                {
                    ApplicationArea = All;
                    Caption = 'Trim Inspected (Yes/No)';
                }
            }
        }
    }
}