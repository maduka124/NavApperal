page 51047 "Main Category List part"
{
    PageType = ListPart;
    SourceTable = "Main Category";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Main Category No';
                }

                field("Main Category Name"; rec."Main Category Name")
                {
                    ApplicationArea = All;
                }

                field(Selected; rec.Selected)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        VendorNo: Code[20];


    trigger OnQueryClosePage(CloseAction: Action): Boolean;

    var
        MainCategoryVendorRec: Record "Main Category Vendor";
        MainCategoryRec: Record "Main Category";
        VendorRec: Record Vendor;
    begin

        VendorRec.Reset();
        VendorRec.SetRange("No.", VendorNo);
        VendorRec.FindSet();


        if CloseAction = Action::OK then begin
            MainCategoryVendorRec.SetRange("Vendor No.", VendorNo, VendorNo);
            MainCategoryVendorRec.DeleteAll();

            REPEAT
                if MainCategoryRec.Selected = true then begin
                    MainCategoryVendorRec.Init();
                    MainCategoryVendorRec."Vendor No." := VendorNo;
                    MainCategoryVendorRec."Vendor Name" := VendorRec.Name;
                    MainCategoryVendorRec."No." := MainCategoryRec."No.";
                    MainCategoryVendorRec."Main Category Name" := MainCategoryRec."Main Category Name";
                    MainCategoryVendorRec."Created User" := UserId;
                    MainCategoryVendorRec.Insert();
                end;
            UNTIL MainCategoryRec.NEXT <= 0;

        end;
    end;

    procedure PassParameters(VendorNoPara: Text);
    var

    begin
        VendorNo := VendorNoPara;

    end;

}