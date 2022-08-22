page 71012620 "Marker Category Card"
{
    PageType = Card;
    SourceTable = MarkerCategory;
    Caption = 'Marker Category';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Marker Category No';
                }
                field("Marker Category"; "Marker Category")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        MarkerCategoryRec: Record MarkerCategory;
                    begin
                        MarkerCategoryRec.Reset();
                        MarkerCategoryRec.SetRange("Marker Category", "Marker Category");
                        if MarkerCategoryRec.FindSet() then
                            Error('Marker Category Name already exists.');
                    end;
                }
            }
        }
    }
}