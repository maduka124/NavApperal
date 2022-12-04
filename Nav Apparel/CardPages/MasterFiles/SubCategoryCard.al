page 71012650 "Sub Category Card"
{
    PageType = Card;
    SourceTable = "Sub Category";
    Caption = 'Sub Category';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No.";rec. "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Sub Category No';
                }

                field("Main Category No."; rec."Main Category No.")
                {
                    ApplicationArea = All;
                    TableRelation = "Main Category"."No." where("Main Category Name" = filter(<> 'ALL CATEGORIES'));
                    Caption = 'Main Category';

                    trigger OnValidate()
                    var
                        MainCategoryRec: Record "Main Category";
                    begin
                        MainCategoryRec.get(rec."Main Category No.");
                       rec. "Main Category Name" := MainCategoryRec."Main Category Name";
                    end;
                }

                field("Main Category Name"; rec."Main Category Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Sub Category Name"; rec."Sub Category Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        SubCategoryRec: Record "Sub Category";
                    begin
                        SubCategoryRec.Reset();
                        SubCategoryRec.SetRange("Sub Category Name", rec."Sub Category Name");

                        if SubCategoryRec.FindSet() then
                            Error('Sub Category Name already exists.');
                    end;
                }
            }
        }
    }
}