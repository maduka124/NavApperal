page 51390 "Daily Consumption List"
{
    PageType = List;
    SourceTable = "Daily Consumption Header";
    SourceTableView = sorting("No.") order(descending);
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Editable = false;

                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Req No';
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                }

                field(PO; rec.PO)
                {
                    ApplicationArea = All;
                }

                field("Prod. Order No."; rec."Prod. Order No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}