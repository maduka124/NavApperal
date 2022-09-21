page 71012604 "Dimension Width Card"
{
    PageType = Card;
    SourceTable = DimensionWidth;
    Caption = 'Dimension Width';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Dimension Width No';
                }

                field("Main Category No."; "Main Category No.")
                {
                    ApplicationArea = All;
                    TableRelation = "Main Category"."No." where("Main Category Name" = filter(<> 'ALL CATEGORIES'));
                    Caption = 'Main Category';

                    trigger OnValidate()
                    var
                        MainCategoryRec: Record "Main Category";
                    begin
                        MainCategoryRec.get("Main Category No.");
                        "Main Category Name" := MainCategoryRec."Main Category Name";
                    end;
                }

                field("Main Category Name"; "Main Category Name")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Dimension Width"; "Dimension Width")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        DimensionWidthRec: Record DimensionWidth;
                    begin
                        DimensionWidthRec.Reset();
                        DimensionWidthRec.SetRange("Main Category No.", "Main Category No.");
                        DimensionWidthRec.SetRange("Dimension Width", "Dimension Width");
                        if DimensionWidthRec.FindSet() then
                            Error('Dimension Width already exists for the Main Category %1.', "Main Category Name");
                    end;
                }

                field(Length; Length)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}