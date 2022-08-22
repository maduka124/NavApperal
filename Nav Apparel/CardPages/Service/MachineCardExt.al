pageextension 50736 MachineCardExt extends "Machine Center Card"
{
    layout
    {
        addafter("Last Date Modified")
        {
            field("ASSERT NO"; "ASSERT NO")
            {
                ApplicationArea = All;
                Caption = 'Assert No';
            }

            field("BRAND Desc"; "BRAND Desc")
            {
                ApplicationArea = All;
                Caption = 'Brand';

                trigger OnValidate()
                var
                    BrandRec: Record Brand;
                begin
                    BrandRec.Reset();
                    BrandRec.SetRange("Brand Name", "BRAND Desc");
                    if BrandRec.FindSet() then
                        "BRAND Code" := BrandRec."No.";
                end;
            }

            field(MODEL; MODEL)
            {
                ApplicationArea = All;
                Caption = 'Model';
            }

            field("MACHINE CATEGORY"; "MACHINE CATEGORY")
            {
                ApplicationArea = All;
                Caption = 'Machine Category';
            }

            field("Head /Serial No"; "Head /Serial No")
            {
                ApplicationArea = All;
            }

            field("MOTOR NO"; "MOTOR NO")
            {
                ApplicationArea = All;
                Caption = 'Motor No';
            }

            field("PURCHASE YEAR"; "PURCHASE YEAR")
            {
                ApplicationArea = All;
                Caption = 'Purchased Year';
            }

            field(SUPPLIER; SUPPLIER)
            {
                ApplicationArea = All;
                Caption = 'Supplier';

                trigger OnValidate()
                var
                    VendorRec: Record Vendor;
                begin
                    VendorRec.Reset();
                    VendorRec.SetRange(Name, SUPPLIER);
                    if VendorRec.FindSet() then
                        "SUPPLIER CODE" := VendorRec."No.";
                end;
            }

            field("SERVICE PERIOD"; "SERVICE PERIOD")
            {
                ApplicationArea = All;
                Caption = 'Service Period';
            }

            field("OWNER SHIP"; "OWNER SHIP")
            {
                ApplicationArea = All;
                Caption = 'Ownnership';
            }
        }
    }
}