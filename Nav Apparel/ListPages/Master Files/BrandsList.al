page 71012587 Brand
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Brand;
    CardPageId = "Brand Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Brand No';
                }

                field("Brand Name"; "Brand Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}