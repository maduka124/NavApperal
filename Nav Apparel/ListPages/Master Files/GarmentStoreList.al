page 50636 "Garment Store"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Garment Store";
    CardPageId = "Garment Store Card";
    SourceTableView = sorting("No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(general)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Store No';
                }

                field("Store Name"; Rec."Store Name")
                {
                    ApplicationArea = All;
                }

                field("Country"; Rec.Country)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}