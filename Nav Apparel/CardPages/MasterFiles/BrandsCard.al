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
                field("No.";rec. "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Brand No';
                }

                field("Brand Name"; rec."Brand Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        BrandRec: Record Brand;
                    begin
                        BrandRec.Reset();
                        BrandRec.SetRange("Brand Name", rec."Brand Name");
                        if BrandRec.FindSet() then
                            Error('Brand name already exists.');
                    end;
                }

                field(Type; rec.Type)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}