page 50643 "Marker Category List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = MarkerCategory;
    CardPageId = "Marker Category Card";
    SourceTableView = sorting("No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Marker Category No';
                }

                field("Marker Category"; Rec."Marker Category")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}