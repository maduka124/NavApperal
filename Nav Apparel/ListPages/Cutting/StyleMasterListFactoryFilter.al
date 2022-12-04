page 50623 "Style Master Filter"
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

                field("Style No."; Rec."Style No.")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Order Qty"; Rec."Order Qty")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}