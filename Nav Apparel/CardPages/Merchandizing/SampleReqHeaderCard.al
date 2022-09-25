page 71012772 "Sample Request Card"
{
    PageType = Card;
    SourceTable = "Sample Requsition Header";
    Caption = 'Sample Request';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Request No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Buyer Name"; "Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        BuyerRec: Record Customer;
                    begin
                        BuyerRec.Reset();
                        BuyerRec.SetRange("Name", "Buyer Name");
                        if BuyerRec.FindSet() then begin
                            "Buyer No." := BuyerRec."No.";
                            CurrPage.Update();
                        end;
                    end;
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        StyleMasRec: Record "Style Master";
                    begin

                        StyleMasRec.Reset();
                        StyleMasRec.SetRange("Style No.", "Style Name");
                        if StyleMasRec.FindSet() then begin
                            "Style No." := StyleMasRec."No.";
                        end;
                    end;
                }

                field("Wash Type Name"; "Wash Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Wash Type';

                    trigger OnValidate()
                    var
                        WashTypeRec: Record "Wash Type";
                    begin
                        WashTypeRec.Reset();
                        WashTypeRec.SetRange("Wash Type Name", "Wash Type Name");
                        if WashTypeRec.FindSet() then
                            "Wash Type No." := WashTypeRec."No.";
                    end;
                }

                field("Wash Plant Name"; "Wash Plant Name")
                {
                    ApplicationArea = All;
                    Caption = 'Wash Plant';

                    trigger OnValidate()
                    var
                        LocationRec: Record Location;
                    begin
                        LocationRec.Reset();
                        LocationRec.SetRange(Name, "Wash Plant Name");
                        if LocationRec.FindSet() then
                            "Wash Plant No." := LocationRec."code";
                    end;
                }

                field("Sample Room Name"; "Sample Room Name")
                {
                    ApplicationArea = All;
                    Caption = 'Sample Room';

                    trigger OnValidate()
                    var
                        SampleRoomRec: Record "Sample Room";
                    begin
                        SampleRoomRec.Reset();
                        SampleRoomRec.SetRange("Sample Room Name", "Sample Room Name");
                        if SampleRoomRec.FindSet() then
                            "Sample Room No." := SampleRoomRec."Sample Room No.";
                    end;
                }

                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
                }

                field(Status; Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group("Sample Details")
            {
                part("SampleReqLineListPart"; SampleReqLineListPart)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "No." = FIELD("No."), "Buyer No." = field("Buyer No.");
                }
            }

            group("Related Documents")
            {
                part(SampleReqDocListPart; SampleReqDocListPart)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "No." = FIELD("No.");
                }
            }

            group("Accessories/BOM")
            {
                part(SampleReqAccListPart; SampleReqAccListPart)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "No." = FIELD("No.");
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Post")
            {
                ApplicationArea = All;
                Image = AddAction;
                ToolTip = 'Auto Generate FG/Sales Order/Production BOM/Routing';

                trigger OnAction()
                var
                    Description: Text[500];
                    NextBomNo: Text;
                    NextItemNo: Text;
                    SampleRec: Record "Sample Requsition Line";
                begin
                    SampleRec.Reset();
                    SampleRec.SetRange("No.", "No.");
                    if SampleRec.FindSet() then begin
                        repeat
                            if SampleRec."SalesOrder No." = '' then begin
                                Description := 'SAMPLE' + '/' + "Style Name" + '/' + SampleRec."Fabrication Name" + '/' + SampleRec."Sample Name" + '/' + SampleRec."Color Name" + '/' + SampleRec.Size;
                                Create_FGItem_SO(Description, SampleRec.Qty, SampleRec."Color No", SampleRec.Size, "No.", SampleRec."Line No.");
                                Message('Completed');
                            end
                            else
                                Error('Sample  request already posted.');
                        until SampleRec.Next() = 0;
                    end;

                    Status := Status::Posted;
                    CurrPage.SaveRecord();
                    CurrPage.Update();

                end;
            }
        }
    }


    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."SAMPLE Nos.", xRec."No.", "No.") THEN BEGIN
            NoSeriesMngment.SetSeries("No.");
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        SampleReqLineRec: Record "Sample Requsition Line";
        SampleReqAcceRec: Record "Sample Requsition Acce";
        SampleReqDocRec: Record "Sample Requsition Doc";
    begin

        SampleReqLineRec.Reset();
        SampleReqLineRec.SetRange("No.", "No.");
        SampleReqLineRec.DeleteAll();

        SampleReqAcceRec.Reset();
        SampleReqAcceRec.SetRange("No.", "No.");
        SampleReqAcceRec.DeleteAll();

        SampleReqDocRec.Reset();
        SampleReqDocRec.SetRange("No.", "No.");
        SampleReqDocRec.DeleteAll();

    end;

    procedure Create_FGItem_SO(ItemDesc: Text[500]; Qty: Integer; Color: Code[20]; Size: Code[20]; No: code[20]; Lineno: Integer)
    var
        FOBPcsPrice: Decimal;
        NavAppSetupRec: Record "NavApp Setup";
        NoSeriesManagementCode: Codeunit NoSeriesManagement;
        ItemMasterRec: Record Item;
        ItemUinitRec: Record "Item Unit of Measure";
        BOMEstimateRec: Record "BOM Estimate Cost";
        ItemRec: Record Item;
        NextItemNo: Code[20];
        ItemNo: Code[20];
        SalesDocNo: Code[20];
        ProdBOM: Code[20];
    begin

        //Get FOB Pcs price
        FOBPcsPrice := 0;
        BOMEstimateRec.Reset();
        BOMEstimateRec.SetRange("Style No.", "Style No.");
        if BOMEstimateRec.FindSet() then
            FOBPcsPrice := BOMEstimateRec."FOB Pcs";

        //Get Worksheet line no
        NavAppSetupRec.Reset();
        NavAppSetupRec.FindSet();

        //Check for item existance
        ItemMasterRec.Reset();
        ItemMasterRec.SetRange(Description, ItemDesc);

        if not ItemMasterRec.FindSet() then begin   //If new FG item

            //Get next Item no
            NextItemNo := NoSeriesManagementCode.GetNextNo(NavAppSetupRec."Sample Item Nos.", Today(), true);

            //Create new item
            ItemRec.Init();
            ItemRec."No." := NextItemNo;
            ItemRec.Description := ItemDesc;
            ItemRec.Type := ItemRec.Type::Inventory;
            ItemRec."Gen. Prod. Posting Group" := NavAppSetupRec."Gen Posting Group-SM";
            ItemRec."Inventory Posting Group" := NavAppSetupRec."Inventory Posting Group-SM";
            ItemRec.Validate("Color No.", Color);

            //Insert into Item unit of measure
            ItemUinitRec.Init();
            ItemUinitRec."Item No." := NextItemNo;
            ItemUinitRec.Code := 'PCS';
            ItemUinitRec."Qty. per Unit of Measure" := 1;
            ItemUinitRec.Insert();

            ItemRec.Validate("Base Unit of Measure", 'PCS');
            ItemRec.Validate("Replenishment System", 1);
            ItemRec.Validate("Manufacturing Policy", 1);
            ItemRec."Production BOM No." := '';
            ItemRec."Unit Price" := FOBPcsPrice;

            if "Wash Type Name" = '' then
                ItemRec."Routing No." := NavAppSetupRec."Sample Non Wash Route Nos."
            else
                ItemRec."Routing No." := NavAppSetupRec."Sample Non Wash Route Nos.";

            ItemRec.Insert(true);

            //Create new sales order
            CreateSalesOrder(NextItemNo, Qty, FOBPcsPrice, No, Lineno);

            //Create new Prod BOM
            CreateProdBOM("No.", ItemDesc, NextItemNo);

        end
        else begin   //If old FG item 

            ItemNo := ItemMasterRec."No.";
            //ProdBOM := ItemMasterRec."Production BOM No.";

            //Create new sales order
            CreateSalesOrder(ItemNo, Qty, FOBPcsPrice, No, Lineno);

            //Create new Prod BOM
            CreateProdBOM("No.", ItemDesc, ItemNo);
        end;

    end;

    procedure CreateSalesOrder(Item: code[20]; Qty: Integer; Price: Decimal; No: code[20]; Lineno: Integer)
    var
        SalesHeaderRec: Record "Sales Header";
        SalesLineRec: Record "Sales Line";
        NavAppSetupRec: Record "NavApp Setup";
        NoSeriesManagementCode: Codeunit NoSeriesManagement;
        StyMasterRec: Record "Style Master";
        SampleRec: Record "Sample Requsition Line";
        NextOrderNo: Code[20];
    begin

        //Get Worksheet line no
        NavAppSetupRec.Reset();
        NavAppSetupRec.FindSet();

        //Get location for the style
        StyMasterRec.Reset();
        StyMasterRec.SetRange("No.", "Style No.");
        StyMasterRec.FindSet();

        //Insert Header
        NextOrderNo := NoSeriesManagementCode.GetNextNo(NavAppSetupRec."Sample SO Nos.", Today(), true);
        SalesHeaderRec.Init();
        SalesHeaderRec."Document Type" := SalesHeaderRec."Document Type"::Order;
        SalesHeaderRec."No." := NextOrderNo;
        SalesHeaderRec."Posting Date" := WorkDate();
        SalesHeaderRec."Order Date" := WorkDate();
        SalesHeaderRec.Validate("Sell-to Customer No.", "Buyer No.");
        //SalesHeaderRec.Validate("Bill-to Customer No.", "Buyer No.");
        SalesHeaderRec."Document Date" := WORKDATE;
        SalesHeaderRec."Shipping No. Series" := 'S-SHPT';
        SalesHeaderRec."Posting No. Series" := 'S-INV+';
        SalesHeaderRec."Style No" := "Style No.";
        SalesHeaderRec."Style Name" := "Style Name";
        SalesHeaderRec.Validate("Location Code", StyMasterRec."Factory Code");
        SalesHeaderRec.EntryType := SalesHeaderRec.EntryType::Sample;
        SalesHeaderRec.INSERT();

        //Insert Line
        SalesLineRec.Init();
        SalesLineRec."Document Type" := SalesLineRec."Document Type"::Order;
        SalesLineRec."Document No." := NextOrderNo;
        SalesLineRec."Line No." := 1000;
        SalesLineRec.Type := SalesLineRec.Type::Item;
        SalesLineRec.validate("No.", Item);
        SalesLineRec.validate(Quantity, Qty);
        SalesLineRec."Gen. Prod. Posting Group" := 'RETAIL';
        SalesLineRec."Gen. Bus. Posting Group" := 'EU';
        SalesLineRec.validate("Unit Price", Price);
        SalesLineRec."Unit of Measure Code" := 'PCS';
        SalesLineRec."Tax Group Code" := NavAppSetupRec.TaxGroupCode;
        SalesLineRec.INSERT();

        //update with new sales order no
        SampleRec.Reset();
        SampleRec.SetRange("No.", No);
        SampleRec.SetRange("Line No.", Lineno);
        if SampleRec.FindSet() then
            SampleRec.ModifyAll("SalesOrder No.", NextOrderNo);

    end;

    procedure CreateProdBOM(No: Code[20]; ItemDesc: Text[500]; FGItem: code[20])
    var
        NavAppSetupRec: Record "NavApp Setup";
        ItemCategoryRec: Record "Item Category";
        NextBOMNo: Code[20];
        NoSeriesManagementCode: Codeunit NoSeriesManagement;
        ProdBOMHeaderRec: Record "Production BOM Header";
        ProdBOMLineRec: Record "Production BOM Line";
        ItemMasterRec: Record item;
        SampleReqAcceRec: Record "Sample Requsition Acce";
        LineNo: Integer;
        MainCateRec: Record "Main Category";
        Description: Text[500];
        NextItemNo: Code[20];
        ItemUinitRec: Record "Item Unit of Measure";
    begin

        //Get Worksheet line no
        NavAppSetupRec.Reset();
        NavAppSetupRec.FindSet();

        //Generate Production BOM Header                                            
        NextBomNo := NoSeriesManagementCode.GetNextNo(NavAppSetupRec."Sample ProdBOM Nos.", Today(), true);
        ProdBOMHeaderRec.Init();
        ProdBOMHeaderRec."No." := NextBomNo;
        ProdBOMHeaderRec.Description := ItemDesc;
        ProdBOMHeaderRec.Validate("Unit of Measure Code", 'PCS');
        ProdBOMHeaderRec.Validate("Low-Level Code", 0);
        ProdBOMHeaderRec.Validate(Status, 0);
        ProdBOMHeaderRec."Creation Date" := WorkDate();
        ProdBOMHeaderRec."Last Date Modified" := WorkDate();
        ProdBOMHeaderRec."No. Series" := 'SMPRODBOM';
        ProdBOMHeaderRec.EntryType := ProdBOMHeaderRec.EntryType::Sample;
        ProdBOMHeaderRec.Insert(true);

        //Update Prod BOm No in item master
        ItemMasterRec.Reset();
        ItemMasterRec.SetRange("No.", FGItem);

        if ItemMasterRec.FindSet() then
            ItemMasterRec.ModifyAll("Production BOM No.", NextBomNo);

        SampleReqAcceRec.Reset();
        SampleReqAcceRec.SetCurrentKey("Line No.");
        SampleReqAcceRec.SetRange("No.", "No");

        if SampleReqAcceRec.FindSet() then begin
            repeat

                //Get Dimenion only status
                MainCateRec.Reset();
                MainCateRec.SetRange("No.", SampleReqAcceRec."Main Category No.");
                if MainCateRec.FindSet() then begin
                    if MainCateRec."Inv. Posting Group Code" = '' then
                        Error('Inventory Posting Group is not setup for the Main Category : %1. Cannot proceed.', SampleReqAcceRec."Main Category Name");
                end
                else
                    Error('Cannot find Main Category details.');

                //Generate description
                Description := SampleReqAcceRec."Item Name";

                if SampleReqAcceRec."Item Color Name" <> '' then
                    Description := Description + ' / ' + SampleReqAcceRec."Item Color Name";

                if SampleReqAcceRec."Article Name." <> '' then
                    Description := Description + ' / ' + SampleReqAcceRec."Article Name.";

                if MainCateRec.DimensionOnly then begin
                    if SampleReqAcceRec."Dimension Name." <> '' then
                        Description := Description + ' / ' + SampleReqAcceRec."Dimension Name.";
                end
                else begin
                    if SampleReqAcceRec."GMT Size Name" <> '' then
                        Description := Description + ' / ' + SampleReqAcceRec."GMT Size Name";
                end;


                //Check whether item exists
                ItemMasterRec.Reset();
                ItemMasterRec.SetRange(Description, Description);

                if ItemMasterRec.FindSet() then begin
                    NextItemNo := ItemMasterRec."No.";

                    ItemUinitRec.Reset();
                    ItemUinitRec.SetRange("Item No.", NextItemNo);
                    ItemUinitRec.SetRange(Code, SampleReqAcceRec."Unit N0.");

                    if not ItemUinitRec.FindSet() then begin
                        //Insert into Item unit of measure
                        ItemUinitRec.Init();
                        ItemUinitRec."Item No." := NextItemNo;
                        ItemUinitRec.Code := SampleReqAcceRec."Unit N0.";
                        ItemUinitRec."Qty. per Unit of Measure" := 1;
                        ItemUinitRec.Insert();
                    end;
                end
                else begin

                    NextItemNo := NoSeriesManagementCode.GetNextNo(NavAppSetupRec."Sample RM Nos.", Today(), true);

                    ItemMasterRec.Init();
                    ItemMasterRec."No." := NextItemNo;
                    ItemMasterRec.Description := Description;
                    ItemMasterRec."Main Category No." := SampleReqAcceRec."Main Category No.";
                    ItemMasterRec."Main Category Name" := SampleReqAcceRec."Main Category Name";

                    //Check for Item category
                    ItemCategoryRec.Reset();
                    ItemCategoryRec.SetRange(Code, SampleReqAcceRec."Main Category No.");
                    if not ItemCategoryRec.FindSet() then begin
                        ItemCategoryRec.Init();
                        ItemCategoryRec.Code := SampleReqAcceRec."Main Category No.";
                        ItemCategoryRec.Description := SampleReqAcceRec."Main Category Name";
                        ItemCategoryRec.Insert();
                    end;

                    ItemMasterRec."Item Category Code" := SampleReqAcceRec."Main Category No.";


                    ItemMasterRec."Sub Category No." := SampleReqAcceRec."Sub Category No.";
                    ItemMasterRec."Sub Category Name" := SampleReqAcceRec."Sub Category Name";
                    ItemMasterRec."Color No." := SampleReqAcceRec."Item Color No.";
                    ItemMasterRec."Color Name" := SampleReqAcceRec."Item Color Name";

                    if MainCateRec.DimensionOnly then
                        ItemMasterRec."Size Range No." := SampleReqAcceRec."Dimension Name."
                    else
                        ItemMasterRec."Size Range No." := SampleReqAcceRec."GMT Size Name";

                    ItemMasterRec."Article No." := SampleReqAcceRec."Article No.";
                    ItemMasterRec."Dimension Width No." := SampleReqAcceRec."Dimension No.";
                    ItemMasterRec.Type := ItemMasterRec.Type::Inventory;
                    ItemMasterRec."Unit Cost" := SampleReqAcceRec.Rate;
                    ItemMasterRec."Unit Price" := SampleReqAcceRec.Rate;
                    ItemMasterRec."Last Direct Cost" := SampleReqAcceRec.Rate;
                    ItemMasterRec."Gen. Prod. Posting Group" := NavAppSetupRec."Gen Post Group-RM Sample";
                    ItemMasterRec."Inventory Posting Group" := MainCateRec."Inv. Posting Group Code";
                    // ItemMasterRec."Inventory Posting Group" := NavAppSetupRec."Inventory Post Group-RM Sample";
                    ItemMasterRec."VAT Prod. Posting Group" := 'ZERO';
                    //ItemMasterRec."VAT Bus. Posting Gr. (Price)" := 'ZERO';


                    if SampleReqAcceRec."Main Category Name" = 'FABRIC' then begin
                        ItemMasterRec."Item Tracking Code" := 'LOTALL';
                        ItemMasterRec."Lot Nos." := NavAppSetupRec."LOTTracking Nos.";
                    end;

                    //Insert into Item unit of measure
                    ItemUinitRec.Init();
                    ItemUinitRec."Item No." := NextItemNo;
                    ItemUinitRec.Code := SampleReqAcceRec."Unit N0.";
                    ItemUinitRec."Qty. per Unit of Measure" := 1;
                    ItemUinitRec.Insert();

                    ItemMasterRec.Validate("Base Unit of Measure", SampleReqAcceRec."Unit N0.");
                    ItemMasterRec.Validate("Replenishment System", 0);
                    ItemMasterRec.Validate("Manufacturing Policy", 1);
                    //ItemMasterRec."Location Filter" Validate();
                    ItemMasterRec.Insert(true);

                end;

                //Insert BOM Line
                LineNo += 1000;
                ProdBOMLineRec.Init();
                ProdBOMLineRec."Production BOM No." := NextBomNo;
                ProdBOMLineRec."Line No." := LineNo;
                ProdBOMLineRec.Type := ProdBOMLineRec.Type::Item;
                ProdBOMLineRec.Validate("No.", NextItemNo);
                ProdBOMLineRec.Description := Description;
                ProdBOMLineRec.Validate("Unit of Measure Code", SampleReqAcceRec."Unit N0.");
                ProdBOMLineRec."Quantity per" := SampleReqAcceRec.Consumption;
                ProdBOMLineRec.Insert(true);

                //Create Worksheet Entry
                CreateWorksheetEntry(NextItemNo, SampleReqAcceRec."Supplier No.", SampleReqAcceRec.Requirment, SampleReqAcceRec.Rate);

                //Update Auto generate                
                SampleReqAcceRec."Production BOM No." := NextBomNo;
                //SampleReqAcceRec."New Item No." := NextItemNo;
                SampleReqAcceRec.Modify();

                //Update Prod BOm No in item master
                ItemMasterRec.Reset();
                ItemMasterRec.SetRange("No.", FGItem);

                if ItemMasterRec.FindSet() then
                    ItemMasterRec.ModifyAll("Production BOM No.", NextBomNo);

            until SampleReqAcceRec.Next() = 0;

            //Update Status of the BOM to released
            ProdBOMHeaderRec.Reset();
            ProdBOMHeaderRec.SetRange("No.", NextBOMNo);
            if ProdBOMHeaderRec.FindSet() then begin
                ProdBOMHeaderRec.Validate(Status, 1);
                ProdBOMHeaderRec.Modify();
            end;

        end;

    end;

    procedure CreateWorksheetEntry(Item: code[20]; Supplier: Code[20]; Qty: Decimal; Rate: Decimal)
    var
        NoSeriesManagementCode: Codeunit NoSeriesManagement;
        NavAppSetupRec: Record "NavApp Setup";
        RequLineRec: Record "Requisition Line";
        RequLineRec1: Record "Requisition Line";
        StyMasterRec: Record "Style Master";
        ReqLineNo: Integer;
        ItemRec: Record Item;
        NextLotNo: Code[20];
    begin

        //Get Worksheet line no
        NavAppSetupRec.Reset();
        NavAppSetupRec.FindSet();

        //Get location for the style
        StyMasterRec.Reset();
        StyMasterRec.SetRange("No.", "Style No.");
        StyMasterRec.FindSet();

        if StyMasterRec."Factory Code" = '' then
            Error('Factory is not assigned for the Style : %1', StyMasterRec."Style No.");

        //Get max line no
        RequLineRec.Reset();
        RequLineRec.SetRange("Worksheet Template Name", NavAppSetupRec."Worksheet Template Name");
        RequLineRec.SetRange("Journal Batch Name", NavAppSetupRec."Journal Batch Name");

        if RequLineRec.FindLast() then
            ReqLineNo := RequLineRec."Line No.";


        RequLineRec.Reset();
        RequLineRec.SetCurrentKey("Worksheet Template Name", "Journal Batch Name", "No.");
        RequLineRec.SetRange("Worksheet Template Name", NavAppSetupRec."Worksheet Template Name");
        RequLineRec.SetRange("Journal Batch Name", NavAppSetupRec."Journal Batch Name");
        RequLineRec.SetRange("Vendor No.", Supplier);
        RequLineRec.SetRange(StyleNo, "Style No.");
        // RequLineRec.SetRange(Lot, Lot);
        RequLineRec.SetRange("No.", Item);

        if not RequLineRec.FindSet() then begin    //Not existing items

            ReqLineNo += 1000;
            RequLineRec1.Init();
            RequLineRec1."Worksheet Template Name" := NavAppSetupRec."Worksheet Template Name";
            RequLineRec1."Journal Batch Name" := NavAppSetupRec."Journal Batch Name";
            RequLineRec1."Line No." := ReqLineNo;
            RequLineRec1.Type := RequLineRec.Type::Item;
            RequLineRec1.Validate("No.", Item);
            RequLineRec1.Validate("Vendor No.", Supplier);
            RequLineRec1."Action Message" := RequLineRec."Action Message"::New;
            RequLineRec1."Accept Action Message" := true;
            RequLineRec1."Ending Date" := Today + 7;
            RequLineRec1.Quantity := Qty;
            RequLineRec1."Direct Unit Cost" := Rate;
            RequLineRec1."Unit Cost" := Rate;
            RequLineRec1.StyleNo := "Style No.";
            RequLineRec1.StyleName := "Style Name";
            // RequLineRec1.PONo := PONo;
            // RequLineRec1.Lot := Lot;
            RequLineRec1.Validate("Location Code", StyMasterRec."Factory Code");
            RequLineRec1.EntryType := RequLineRec1.EntryType::Sample;
            RequLineRec1.Insert();


            //Update Rates
            RequLineRec1.Reset();
            RequLineRec1.SetRange("Worksheet Template Name", NavAppSetupRec."Worksheet Template Name");
            RequLineRec1.SetRange("Journal Batch Name", NavAppSetupRec."Journal Batch Name");
            RequLineRec1.SetRange("No.", Item);
            RequLineRec1.SetRange("Line No.", ReqLineNo);
            if RequLineRec1.FindSet() then begin
                RequLineRec1."Direct Unit Cost" := Rate;
                RequLineRec1."Unit Cost" := Rate;
                RequLineRec1.Modify();
            end

        end
        else begin  // Update existing item

            RequLineRec."Quantity" := RequLineRec."Quantity" + Qty;
            RequLineRec.Modify();

        end;

        // //Get No series for LOT
        // ItemRec.Reset();
        // ItemRec.SetRange("No.", Item);
        // ItemRec.FindSet();

        // NextLotNo := NoSeriesManagementCode.GetNextNo(ItemRec."Lot Nos.", Today(), true);

        // //Insert to the reservaton entry table
        // InsertResvEntry(true, Item, StyMasterRec."Factory Code", Qty, 246, 0, NavAppSetupRec."Worksheet Template Name",
        // NavAppSetupRec."Journal Batch Name", 1000, Today, NextLotNo);

    end;
}