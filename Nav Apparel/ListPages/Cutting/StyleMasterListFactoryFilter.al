page 71012799 "Style Master Filter"
{
    PageType = List;
    SourceTable = "Style Master";
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
                    Caption = 'Style';
                }

                field("Order Qty"; "Order Qty")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}