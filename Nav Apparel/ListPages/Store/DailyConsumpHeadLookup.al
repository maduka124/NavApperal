page 51388 "Daily Consumption List Lookup"
{
    PageType = List;
    SourceTable = "Daily Consumption Header";
    SourceTableView = sorting("No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Editable = false;

                field("Style Name"; Rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }
            }
        }
    }
}