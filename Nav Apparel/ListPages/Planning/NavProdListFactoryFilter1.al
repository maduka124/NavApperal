page 50519 "Nav Prod Filter PO"
{
    PageType = List;
    SourceTable = "NavApp Prod Plans Details";
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    SourceTableView = sorting("No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Editable = false;

                field(PlanDate; PlanDate)
                {
                    ApplicationArea = All;
                    Caption = 'Plan Date';
                }

                field("Style No."; "Style No.")
                {
                    ApplicationArea = All;
                    Caption = 'No';
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                }

                field("Lot No."; "Lot No.")
                {
                    ApplicationArea = All;
                    Caption = 'Lot';
                }

                field("PO No."; "PO No.")
                {
                    ApplicationArea = All;
                    Caption = 'PO No';
                }
            }
        }
    }
}