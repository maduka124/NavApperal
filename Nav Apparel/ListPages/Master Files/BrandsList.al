page 50630 Brand
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Brand;
    CardPageId = "Brand Card";
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
                    Caption = 'Brand No';
                }

                field("Brand Name"; Rec."Brand Name")
                {
                    ApplicationArea = All;
                }

                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}