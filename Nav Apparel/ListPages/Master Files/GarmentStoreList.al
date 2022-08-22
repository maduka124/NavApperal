page 71012606 "Garment Store"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Garment Store";
    CardPageId = "Garment Store Card";

    layout
    {
        area(Content)
        {
            repeater(general)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Store No';
                }

                field("Store Name"; "Store Name")
                {
                    ApplicationArea = All;
                }

                field("Country"; Country)
                {
                    ApplicationArea = All;
                }
            }
        }
    }   
}