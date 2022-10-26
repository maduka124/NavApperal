page 50758 "ProdOutHeaderListFilter"
{
    PageType = List;
    SourceTable = ProductionOutHeader;
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
                field("Style No."; "Style No.")
                {
                    ApplicationArea = All;
                    Caption = 'Style No';
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}