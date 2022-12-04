page 50637 "Garment Type List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Garment Type";
    CardPageId = "Garment Type Card";
    SourceTableView = sorting("No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }

                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Caption = 'Garment Type Code';
                }

                field("Garment Type Description"; Rec."Garment Type Description")
                {
                    ApplicationArea = All;
                }

                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}