page 51266 GarmentPartList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = BundleCardGMTType;
    CardPageId = Garmentpart;
    Caption = 'Garment Parts List';



    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Garment Part Code"; Rec."Garment Part Code")
                {
                    ApplicationArea = All;
                    Caption = 'Fabric Requsition No';
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

            }
        }
    }


}