page 50961 "Marker Category Card"
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
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Marker Category No';
                }
                field("Marker Category"; rec."Marker Category")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        MarkerCategoryRec: Record MarkerCategory;
                    begin
                        MarkerCategoryRec.Reset();
                        MarkerCategoryRec.SetRange("Marker Category", rec."Marker Category");
                        if MarkerCategoryRec.FindSet() then
                            Error('Marker Category Name already exists.');
                    end;
                }
            }
        }
    }
}