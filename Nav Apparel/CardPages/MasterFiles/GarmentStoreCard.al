page 71012607 "Garment Store Card"
{
    PageType = Card;
    SourceTable = "Garment Store";
    Caption = 'Garment Store';

    layout
    {

        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Store No';
                }

                field("Store Name"; "Store Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        GarmentStoreRec: Record "Garment Store";
                    begin
                        GarmentStoreRec.Reset();
                        GarmentStoreRec.SetRange("Store Name", "Store Name");
                        GarmentStoreRec.SetRange("Country No_", "Country No_");
                        if GarmentStoreRec.FindSet() then
                            Error('Store name already exists for the country %1', Country);
                    end;

                }

                field("Country No_"; "Country No_")
                {
                    ApplicationArea = All;
                    TableRelation = "Country/Region".Code;
                    Caption = 'Country';

                    trigger OnValidate()
                    var
                        countryrec: Record "Country/Region";
                        GarmentStoreRec: Record "Garment Store";
                    begin
                        countryrec.get("Country No_");
                        Name := countryrec.Name;
                        Country := Name;

                        GarmentStoreRec.Reset();
                        GarmentStoreRec.SetRange("Store Name", "Store Name");
                        GarmentStoreRec.SetRange("Country No_", "Country No_");
                        if GarmentStoreRec.FindSet() then
                            Error('Store name already exists for the country %1', Country);
                    end;
                }

                field(Country; Country)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    var
        Name: Text[20];

}