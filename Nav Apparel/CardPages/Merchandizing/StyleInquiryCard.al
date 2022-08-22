page 71012723 "Style Inquiry Card"
{
    PageType = Card;
    SourceTable = "Style Master";
    Caption = 'Style Inquiry';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Style No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Style No."; "Style No.")
                {
                    ApplicationArea = All;
                    Caption = 'Style Name';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        StyleMasRec: Record "Style Master";
                    begin

                        CurrPage.Update();
                        StyleMasRec.Reset();
                        StyleMasRec.SetRange("Style No.", "Style No.");
                        StyleMasRec.SetFilter("No.", '<>%1', "No.");

                        if StyleMasRec.FindSet() then
                            Error('Style No : %1 already exists', "Style No.");

                    end;
                }

                field("Store Name"; "Store Name")
                {
                    ApplicationArea = All;
                    Caption = 'Store';

                    trigger OnValidate()
                    var
                        GarmentStoreRec: Record "Garment Store";
                    begin
                        GarmentStoreRec.Reset();
                        GarmentStoreRec.SetRange("Store Name", "Store Name");
                        if GarmentStoreRec.FindSet() then
                            "Store No." := GarmentStoreRec."No.";

                        CurrPage.Update();
                    end;
                }

                field("Season Name"; "Season Name")
                {
                    ApplicationArea = All;
                    Caption = 'Season';

                    trigger OnValidate()
                    var
                        SeasonsRec: Record "Seasons";
                    begin
                        SeasonsRec.Reset();
                        SeasonsRec.SetRange("Season Name", "Season Name");
                        if SeasonsRec.FindSet() then
                            "Season No." := SeasonsRec."No.";

                        CurrPage.Update();
                    end;
                }

                field("Brand Name"; "Brand Name")
                {
                    ApplicationArea = All;
                    Caption = 'Brand';

                    trigger OnValidate()
                    var
                        BrandRec: Record "Brand";
                    begin
                        BrandRec.Reset();
                        BrandRec.SetRange("Brand Name", "Brand Name");
                        if BrandRec.FindSet() then
                            "Brand No." := BrandRec."No.";

                        CurrPage.Update();
                    end;
                }

                field("Department Name"; "Department Name")
                {
                    ApplicationArea = All;
                    Caption = 'Department';

                    trigger OnValidate()
                    var
                        DepartmentRec: Record "Department Style";
                    begin
                        DepartmentRec.Reset();
                        DepartmentRec.SetRange("Department Name", "Department Name");
                        if DepartmentRec.FindSet() then
                            "Department No." := DepartmentRec."No.";

                        CurrPage.Update();
                    end;
                }

                field("Buyer Name"; "Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';

                    trigger OnValidate()
                    var
                        BuyerRec: Record Customer;
                    begin
                        BuyerRec.Reset();
                        BuyerRec.SetRange("Name", "Buyer Name");
                        if BuyerRec.FindSet() then
                            "Buyer No." := BuyerRec."No.";

                        CurrPage.Update();
                    end;
                }

                field("Garment Type Name"; "Garment Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Garment Type';

                    trigger OnValidate()
                    var
                        GarmentTypeRec: Record "Garment Type";
                    begin
                        GarmentTypeRec.Reset();
                        GarmentTypeRec.SetRange("Garment Type Description", "Garment Type Name");
                        if GarmentTypeRec.FindSet() then
                            "Garment Type No." := GarmentTypeRec."No.";

                        CurrPage.Update();
                    end;
                }

                field("Size Range Name"; "Size Range Name")
                {
                    ApplicationArea = All;
                    Caption = 'Size Range';

                    trigger OnValidate()
                    var
                        SizeRangeRec: Record SizeRange;
                    begin
                        SizeRangeRec.Reset();
                        SizeRangeRec.SetRange("Size Range", "Size Range Name");
                        if SizeRangeRec.FindSet() then
                            "Size Range No." := SizeRangeRec."No.";

                        CurrPage.Update();
                    end;
                }

                field("Order Qty"; "Order Qty")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field("Lead Time"; "Lead Time")
                {
                    ApplicationArea = All;
                }

                field("Ship Date"; "Ship Date")
                {
                    ApplicationArea = All;
                }

                field(Front; Front)
                {
                    ApplicationArea = All;
                }

                field(Back; Back)
                {
                    ApplicationArea = All;
                }

                field(Status; Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                // field("Item No"; "Item No")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Finished Good Item';
                //     Editable = false;
                // }
            }

            group(" ")
            {
                part("SpecialOperationStyle Listpart"; "SpecialOperationStyle Listpart")
                {
                    ApplicationArea = All;
                    Caption = 'Special Operations';
                    SubPageLink = "Style No." = FIELD("No.");
                    Editable = false;
                }
            }
        }

        area(FactBoxes)
        {
            part(MyFactBox; "Style Picture FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Add Special Operations")
            {
                Caption = 'Add Special Operations';
                Image = SpecialOrder;
                ApplicationArea = All;

                trigger OnAction();
                var
                    SpecialOperationList: Page "Special Operation List part";
                begin
                    // HyperLink('https://www.microsoft.com');

                    Clear(SpecialOperationList);
                    SpecialOperationList.LookupMode(true);
                    SpecialOperationList.PassParameters("No.");
                    SpecialOperationList.RunModal();
                    CurrPage.Update();
                end;
            }

            action(Confirm)
            {
                Image = Confirm;
                ApplicationArea = All;

                trigger OnAction()
                var

                begin
                    if Status = Status::Confirmed then begin
                        Message('This Style is already confirmed');
                    end
                    else begin
                        Status := Status::Confirmed;
                        CurrPage.Update();
                        Message('Style confirmed');
                    end;
                end;
            }

            action(Reject)
            {
                Image = Reject;
                ApplicationArea = All;

                trigger OnAction()
                var
                begin
                    if Status = Status::Confirmed then
                        Message('This Style already confirmed')
                    else
                        if Status = Status::Rejected then
                            Message('This Style already rejected')
                        else begin
                            Status := Status::Rejected;
                            CurrPage.Update();
                            Message('Style rejected');
                        end;

                end;
            }

            action(ImportPictureFrontURL)
            {
                ApplicationArea = All;
                Caption = 'Import Front/Back Picture URL';
                Image = Import;
                ToolTip = 'Import Front/Back Picture URL';

                trigger OnAction()
                var
                    PictureURLDialog: Page "Picture URL Dialog";
                begin
                    PictureURLDialog.SetItemInfo("No.");
                    if PictureURLDialog.RunModal() = Action::OK then
                        PictureURLDialog.ImportItemPictureFromURL();

                end;
            }

            // action(ImportPictureBackURL)
            // {
            //     ApplicationArea = All;
            //     Caption = 'Import Back Picture URL';
            //     Image = Import;
            //     ToolTip = 'Import Back Picture URL';

            //     trigger OnAction()
            //     var
            //         PictureURLDialog: Page "Picture URL Dialog";
            //     begin
            //         PictureURLDialog.SetItemInfo("No.");
            //         if PictureURLDialog.RunModal() = Action::OK then
            //             PictureURLDialog.ImportItemPictureFromURL();
            //     end;
            // }

            // action("Create FG Item")
            // {
            //     Image = NewItem;

            //     trigger OnAction()
            //     var
            //         ItemRec: Record Item;
            //         NoSeriesManagementCode: Codeunit NoSeriesManagement;
            //         NextNo: Code[20];
            //     begin

            //         if ("Item No" = '') and ("Style No." <> '') then begin

            //             //Get next Item no
            //             NextNo := NoSeriesManagementCode.GetNextNo('Item1', Today(), true);

            //             //Create new item
            //             ItemRec.Init();
            //             ItemRec."No." := NextNo;
            //             ItemRec.Description := "Style No." + ' - ' + "Garment Type Name";
            //             ItemRec.Type := 0;
            //             ItemRec."Base Unit of Measure" := 'PCS';
            //             ItemRec.Insert();

            //             //Update Item No in the Style Inquiry
            //             "Item No" := NextNo;
            //             CurrPage.SaveRecord();
            //             CurrPage.Update();

            //             Message('New FG item created');
            //         end;

            //     end;
            // }
        }
    }

    trigger OnOpenPage()
    var
    begin
        if Status = Status::Confirmed then
            CurrPage.Editable := false;
    end;


    trigger OnClosePage()
    var
        ItemRec: Record Item;
        NoSeriesManagementCode: Codeunit NoSeriesManagement;
        NextNo: Code[20];
        StyleRec: Record "Style Master";

        Client: HttpClient;
        Content: HttpContent;
        ResponseFront: HttpResponseMessage;
        ResponseBack: HttpResponseMessage;
        InStrFront: InStream;
        InStrBack: InStream;
    begin

        // StyleRec.SetRange("No.", "No.");
        // if StyleRec.FindSet() then begin

        //     if ("Item No" = '') and ("Style No." <> '') then begin

        //         //Get next Item no
        //         NextNo := NoSeriesManagementCode.GetNextNo('Item1', Today(), true);

        //         //Create new item
        //         ItemRec.Init();
        //         ItemRec."No." := NextNo;
        //         ItemRec.Description := "Style No." + ' - ' + "Garment Type Name";
        //         ItemRec.Type := ItemRec.Type::Inventory;
        //         ItemRec."Base Unit of Measure" := 'PCS';
        //         ItemRec.Insert();

        //         //Update Item No in the Style Inquiry
        //         "Item No" := NextNo;
        //         CurrPage.SaveRecord();
        //         CurrPage.Update();

        //     end;
        // end;

        StyleRec.Reset();
        StyleRec.SetRange("No.", "No.");

        if StyleRec.FindSet() then begin

            Clear(StyleRec.PictureFront);
            Clear(StyleRec.PictureBack);
            StyleRec.Modify(true);

        end;

    end;


    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."Style Nos.", xRec."No.", "No.") THEN BEGIN
            NoSeriesMngment.SetSeries("No.");
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        //StyleRec: Record "Style Master";
        StylePORec: Record "Style Master PO";
        SpecialOpRec: Record "Special Operation Style";
    begin
        if Status = status::Confirmed then
            Error('Style already confirmed. Cannot delete.')
        else begin

            // StyleRec.SetRange("No.", "No.");
            // if StyleRec.FindSet() then
            //     StyleRec.DeleteAll();

            SpecialOpRec.SetRange("Style No.", "No.");
            if SpecialOpRec.FindSet() then
                SpecialOpRec.DeleteAll();

            StylePORec.SetRange("Style No.", "No.");
            if StylePORec.FindSet() then
                StylePORec.DeleteAll();


        end;
    end;

}