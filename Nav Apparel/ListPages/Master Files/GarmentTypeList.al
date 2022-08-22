page 71012609 "Garment Type List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Garment Type";
    CardPageId = "Garment Type Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Type; Type)
                {
                    ApplicationArea = All;
                }

                field("No."; "No.")
                {
                    ApplicationArea = All;
                }

                field(Code; Code)
                {
                    ApplicationArea = All;
                    Caption = 'Garment Type Code';
                }

                field("Garment Type Description"; "Garment Type Description")
                {
                    ApplicationArea = All;
                }

                field(Category; Category)
                {
                    ApplicationArea = All;
                }
            }
        }
    }   
}