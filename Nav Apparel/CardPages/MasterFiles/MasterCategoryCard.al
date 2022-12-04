page 50962 "Master Category Card"
{
    PageType = Card;
    SourceTable = "Master Category";
    Caption = 'Master Category';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Master Category No';
                }

                field("Master Category Name"; rec."Master Category Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        MasterCategoryRec: Record "Master Category";
                    begin
                        MasterCategoryRec.Reset();
                        MasterCategoryRec.SetRange("Master Category Name", rec."Master Category Name");
                        if MasterCategoryRec.FindSet() then
                            Error('Master Category Name already exists.');
                    end;
                }
            }
        }
    }
}