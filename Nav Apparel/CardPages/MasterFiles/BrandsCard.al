page 71012588 "Brand Card"
{
    PageType = Card;
    SourceTable = Brand;
    Caption = 'Brand';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Brand No';
                }

                field("Brand Name"; "Brand Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        BrandRec: Record Brand;
                    begin
                        BrandRec.Reset();
                        BrandRec.SetRange("Brand Name", "Brand Name");
                        if BrandRec.FindSet() then
                            Error('Brand name already exists.');
                    end;
                }
            }
        }
    }
}