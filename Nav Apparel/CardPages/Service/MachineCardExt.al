pageextension 50736 MachineCardExt extends "Machine Center Card"
{
    layout
    {
        addafter("Last Date Modified")
        {
            field("ASSERT NO"; rec."ASSERT NO")
            {
                ApplicationArea = All;
                Caption = 'Assert No';
            }

            field("BRAND Desc"; rec."BRAND Desc")
            {
                ApplicationArea = All;
                Caption = 'Brand';

                trigger OnValidate()
                var
                    BrandRec: Record Brand;
                begin
                    BrandRec.Reset();
                    BrandRec.SetRange("Brand Name", rec."BRAND Desc");
                    if BrandRec.FindSet() then
                        rec."BRAND Code" := BrandRec."No.";
                end;
            }

            field(MODEL; rec.MODEL)
            {
                ApplicationArea = All;
                Caption = 'Model';
            }

            field("MACHINE CATEGORY"; rec."MACHINE CATEGORY")
            {
                ApplicationArea = All;
                Caption = 'Machine Category';
            }

            field("Head /Serial No"; rec."Head /Serial No")
            {
                ApplicationArea = All;
            }

            field("MOTOR NO"; rec."MOTOR NO")
            {
                ApplicationArea = All;
                Caption = 'Motor No';
            }

            field("PURCHASE YEAR"; rec."PURCHASE YEAR")
            {
                ApplicationArea = All;
                Caption = 'Purchased Year';
            }

            field(SUPPLIER; rec.SUPPLIER)
            {
                ApplicationArea = All;
                Caption = 'Supplier';

                trigger OnValidate()
                var
                    VendorRec: Record Vendor;
                begin
                    VendorRec.Reset();
                    VendorRec.SetRange(Name, rec.SUPPLIER);
                    if VendorRec.FindSet() then
                        rec."SUPPLIER CODE" := VendorRec."No.";
                end;
            }

            field("SERVICE PERIOD"; rec."SERVICE PERIOD")
            {
                ApplicationArea = All;
                Caption = 'Service Period';
            }

            field("OWNER SHIP"; rec."OWNER SHIP")
            {
                ApplicationArea = All;
                Caption = 'Ownnership';
            }
        }


        modify(Name)
        {
            trigger OnAfterValidate()
            var
                LoginSessionsRec: Record LoginSessions;
                LoginRec: Page "Login Card";
            begin
                //Check whether user logged in or not
                LoginSessionsRec.Reset();
                LoginSessionsRec.SetRange(SessionID, SessionId());

                if not LoginSessionsRec.FindSet() then begin  //not logged in
                    Clear(LoginRec);
                    LoginRec.LookupMode(true);
                    LoginRec.RunModal();

                    LoginSessionsRec.Reset();
                    LoginSessionsRec.SetRange(SessionID, SessionId());
                    LoginSessionsRec.FindSet();
                    rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                end
                else begin   //logged in
                    rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                end;
            end;
        }

    }
}