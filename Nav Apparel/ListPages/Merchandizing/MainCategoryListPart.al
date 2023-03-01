page 51047 "Main Category List part"
{
    PageType = Card;
    SourceTable = "Main Category";
    DeleteAllowed = false;
    InsertAllowed = false;

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
                    Editable = false;
                }

                field("Main Category Name"; rec."Main Category Name")
                {
                    ApplicationArea = All;
                    Editable = false;
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


    // trigger OnQueryClosePage(CloseAction: Action): Boolean;
    // var
    //     MainCategoryVendorRec: Record "Main Category Vendor";
    //     MainCategoryRec: Record "Main Category";
    //     VendorRec: Record Vendor;
    // begin

    //     VendorRec.Reset();
    //     VendorRec.SetRange("No.", VendorNo);
    //     VendorRec.FindSet();


    //     if CloseAction = Action::OK then begin

    //         MainCategoryVendorRec.Reset();
    //         MainCategoryVendorRec.SetRange("Vendor No.", VendorNo);
    //         if MainCategoryVendorRec.FindSet() then
    //             MainCategoryVendorRec.DeleteAll();

    //         REPEAT
    //             if MainCategoryRec.Selected = true then begin
    //                 MainCategoryVendorRec.Init();
    //                 MainCategoryVendorRec."Vendor No." := VendorNo;
    //                 MainCategoryVendorRec."Vendor Name" := VendorRec.Name;
    //                 MainCategoryVendorRec."No." := MainCategoryRec."No.";
    //                 MainCategoryVendorRec."Main Category Name" := MainCategoryRec."Main Category Name";
    //                 MainCategoryVendorRec."Created User" := UserId;
    //                 MainCategoryVendorRec.Insert();
    //             end;
    //         UNTIL MainCategoryRec.NEXT <= 0;

    //     end;
    // end;

    //Done By Sachith on 03/02/23
    trigger OnQueryClosePage(CloseAction: Action): Boolean

    var
        MainCategoryVendorRec: Record "Main Category Vendor";
        MainCategoryRec: Record "Main Category";
        MainCat2Rec: Record "Main Category";
        VendorRec: Record Vendor;
    begin

        VendorRec.Reset();
        VendorRec.SetRange("No.", VendorNo);
        VendorRec.FindSet();

        if CloseAction = Action::LookupOK then begin

            MainCategoryVendorRec.Reset();
            MainCategoryVendorRec.SetRange("Vendor No.", VendorNo);
            if MainCategoryVendorRec.FindSet() then
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

    procedure PassParameters(VendorNoPara: Code[20]);
    var
    begin
        VendorNo := VendorNoPara;

    end;

    trigger OnOpenPage()
    var
        MainCatRec: Record "Main Category";
        MainCatVendorRec: Record "Main Category Vendor";
        VendorRec: Record Vendor;
    begin

        //Clear Selected Data
        MainCatRec.Reset();
        if MainCatRec.FindSet() then begin
            repeat
                MainCatRec.Selected := false;
                MainCatRec.Modify();
            until MainCatRec.Next() = 0;
        end;

        MainCatVendorRec.Reset();
        MainCatVendorRec.SetRange("Vendor No.", VendorNo);

        if MainCatVendorRec.FindSet() then begin
            repeat

                MainCatRec.Reset();
                MainCatRec.SetRange("No.", MainCatVendorRec."No.");

                if MainCatRec.FindSet() then begin
                    MainCatRec.Selected := true;
                    MainCatRec.Modify();
                end;
            until MainCatVendorRec.Next() = 0;
        end;

    end;

}