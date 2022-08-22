page 71012619 "Marker Category List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = MarkerCategory;
    CardPageId = "Marker Category Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Marker Category No';
                }

                field("Marker Category"; "Marker Category")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}