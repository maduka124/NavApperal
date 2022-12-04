page 71012772 "Sample Request Card"
{
    PageType = Card;
    SourceTable = "Sample Requsition Header";
    Caption = 'Sample Requisition';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Request No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Buyer Name"; rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        BuyerRec: Record Customer;
                    begin
                        BuyerRec.Reset();
                        BuyerRec.SetRange("Name", rec."Buyer Name");
                        if BuyerRec.FindSet() then begin
                            rec."Buyer No." := BuyerRec."No.";
                            // CurrPage.Update();
                        end;
                    end;
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        StyleMasRec: Record "Style Master";
                    begin

                        StyleMasRec.Reset();
                        StyleMasRec.SetRange("Style No.", rec."Style Name");
                        if StyleMasRec.FindSet() then begin
                            rec."Style No." := StyleMasRec."No.";
                            rec."Garment Type No" := StyleMasRec."Garment Type No.";
                            rec."Garment Type Name" := StyleMasRec."Garment Type Name";
                        end;
                    end;
                }

                field("Garment Type Name"; rec."Garment Type Name")
                {
                    Caption = 'Garment Type';
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Wash Type Name"; rec."Wash Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Wash Type';

                    trigger OnValidate()
                    var
                        WashTypeRec: Record "Wash Type";
                    begin
                        WashTypeRec.Reset();
                        WashTypeRec.SetRange("Wash Type Name", rec."Wash Type Name");
                        if WashTypeRec.FindSet() then
                            rec."Wash Type No." := WashTypeRec."No.";
                    end;
                }

                field("Wash Plant Name"; rec."Wash Plant Name")
                {
                    ApplicationArea = All;
                    Caption = 'Wash Plant';

                    trigger OnValidate()
                    var
                        LocationRec: Record Location;
                    begin
                        LocationRec.Reset();
                        LocationRec.SetRange(Name, rec."Wash Plant Name");
                        if LocationRec.FindSet() then
                            rec."Wash Plant No." := LocationRec."code";
                    end;
                }

                field("Sample Room Name"; rec."Sample Room Name")
                {
                    ApplicationArea = All;
                    Caption = 'Sample Room';

                    trigger OnValidate()
                    var
                        SampleRoomRec: Record "Sample Room";
                    begin
                        SampleRoomRec.Reset();
                        SampleRoomRec.SetRange("Sample Room Name", rec."Sample Room Name");
                        if SampleRoomRec.FindSet() then begin
                            rec."Sample Room No." := SampleRoomRec."Sample Room No.";
                            rec.Validate("Global Dimension Code", SampleRoomRec."Global Dimension Code");
                        end;
                    end;
                }

                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = All;
                }

                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                //Done By Sachith -22/10/20
                field("Global Dimension Code"; rec."Global Dimension Code")
                {
                    ApplicationArea = All;
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
            action("Write To MRP")
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
                    SalesHeaderRec: Record "Sales Header";
                    Window: Dialog;
                    TextCon1: TextConst ENU = 'Creating Production Order ####1';
                    ProOrderNo: Code[20];
                    CodeUnitNavApp: Codeunit NavAppCodeUnit;
                    ItemLedgerRec: Record "Item Ledger Entry";
                    NavAppSetupRec: Record "NavApp Setup";
                    RequLineRec: Record "Requisition Line";
                    QtyInStock: Decimal;
                    ItemNotemp: Code[50];
                begin
                    SampleRec.Reset();
                    SampleRec.SetRange("No.", rec."No.");
                    if SampleRec.FindSet() then begin
                        repeat
                            if SampleRec."SalesOrder No." = '' then begin
                                Description := 'SAMPLE' + '/' + rec."Style Name" + '/' + SampleRec."Fabrication Name" + '/' + SampleRec."Sample Name" + '/' + SampleRec."Color Name" + '/' + SampleRec.Size;
                                Create_FGItem_SO(Description, SampleRec.Qty, SampleRec."Color No", SampleRec.Size, rec."No.", SampleRec."Line No.");

                                //Create Prod orders                       
                                SalesHeaderRec.Reset();
                                SalesHeaderRec.SetRange("Style No", rec."Style No.");
                                SalesHeaderRec."Document Type" := SalesHeaderRec."Document Type"::Order;
                                SalesHeaderRec.SetRange(EntryType, SalesHeaderRec.EntryType::Sample);

                                if SalesHeaderRec.FindSet() then begin
                                    //Window.Open(TextCon1);
                                    repeat
                                        ProOrderNo := CodeUnitNavApp.CreateProdOrder(SalesHeaderRec."No.", 'Samples');
                                    //Window.Update(1, ProOrderNo);
                                    //Sleep(100);
                                    until SalesHeaderRec.Next() = 0;
                                    //Window.Close();
                                end;


                                // NavAppSetupRec.Reset();
                                // NavAppSetupRec.FindSet();

                                // //Adjust planning worksheet order qty based on in hand stock
                                // //Get planning worksheet recods  
                                // RequLineRec.Reset();
                                // RequLineRec.SetCurrentKey("Worksheet Template Name", "Journal Batch Name", "No.");
                                // RequLineRec.SetRange("Worksheet Template Name", NavAppSetupRec."Worksheet Template Name");
                                // RequLineRec.SetRange("Journal Batch Name", NavAppSetupRec."Journal Batch Name");
                                // RequLineRec.SetRange(StyleNo, "Style No.");

                                // if RequLineRec.FindSet() then begin
                                //     repeat

                                //         if ItemNotemp <> RequLineRec."No." then begin
                                //             //Get qty in stock for first time only
                                //             QtyInStock := 0;
                                //             ItemLedgerRec.Reset();
                                //             ItemLedgerRec.SetRange("Item No.", RequLineRec."No.");

                                //             if ItemLedgerRec.FindSet() then begin
                                //                 repeat
                                //                     QtyInStock += ItemLedgerRec."Remaining Quantity";
                                //                 until ItemLedgerRec.Next() = 0;
                                //             end;

                                //             //Validate qty
                                //             if RequLineRec.Quantity > QtyInStock then begin   //order balance qty
                                //                 RequLineRec.Quantity := RequLineRec.Quantity - QtyInStock;
                                //                 RequLineRec.Modify();
                                //                 QtyInStock := 0;
                                //             end
                                //             else begin
                                //                 if RequLineRec.Quantity <= QtyInStock then begin  //No need to order.make zero qty                                            
                                //                     QtyInStock := QtyInStock - RequLineRec.Quantity;
                                //                     RequLineRec.Quantity := 0;
                                //                     RequLineRec.Modify();
                                //                 end;
                                //             end;

                                //             ItemNotemp := RequLineRec."No.";
                                //         end
                                //         else begin

                                //             //Validate qty
                                //             if RequLineRec.Quantity > QtyInStock then begin   //order balance qty
                                //                 RequLineRec.Quantity := RequLineRec.Quantity - QtyInStock;
                                //                 RequLineRec.Modify();
                                //                 QtyInStock := 0;
                                //             end
                                //             else begin
                                //                 if RequLineRec.Quantity <= QtyInStock then begin  //No need to order.make zero qty                                           
                                //                     QtyInStock := QtyInStock - RequLineRec.Quantity;
                                //                     RequLineRec.Quantity := 0;
                                //                     RequLineRec.Modify();
                                //                 end;
                                //             end;

                                //             ItemNotemp := RequLineRec."No.";
                                //         end;

                                //     until RequLineRec.Next() = 0;

                                // end;


                                // //Delete zero qty records
                                // RequLineRec.Reset();
                                // RequLineRec.SetCurrentKey("Worksheet Template Name", "Journal Batch Name", "No.");
                                // RequLineRec.SetRange("Worksheet Template Name", NavAppSetupRec."Worksheet Template Name");
                                // RequLineRec.SetRange("Journal Batch Name", NavAppSetupRec."Journal Batch Name");
                                // RequLineRec.SetRange(StyleNo, "Style No.");
                                // RequLineRec.SetFilter(Quantity, '=%1', 0);

                                // if RequLineRec.FindSet() then begin
                                //     RequLineRec.DeleteAll();
                                // end;


                                rec.WriteToMRPStatus := 1;
                                CurrPage.SaveRecord();
                                CurrPage.Update();
                                Message('Completed');
                            end
                            else
                                Error('Sample  request already posted.');
                        until SampleRec.Next() = 0;
                    end;
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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."SAMPLE Nos.", xRec."No.", rec."No.") THEN BEGIN
            NoSeriesMngment.SetSeries(rec."No.");
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        SampleReqLineRec: Record "Sample Requsition Line";
        SampleReqAcceRec: Record "Sample Requsition Acce";
        SampleReqDocRec: Record "Sample Requsition Doc";
    begin

        if rec.WriteToMRPStatus = 1 then
            Error('Sample request has been posted already. You cannot delete.');

        SampleReqLineRec.Reset();
        SampleReqLineRec.SetRange("No.", rec."No.");
        SampleReqLineRec.DeleteAll();

        SampleReqAcceRec.Reset();
        SampleReqAcceRec.SetRange("No.", rec."No.");
        SampleReqAcceRec.DeleteAll();

        SampleReqDocRec.Reset();
        SampleReqDocRec.SetRange("No.", rec."No.");
        SampleReqDocRec.DeleteAll();

    end;

    procedure Create_FGItem_SO(ItemDesc: Text[500]; Qty: Integer; Color: Code[20]; Size: Code[20]; No: code[20]; Lineno: Integer)
    var
        FOBPcsPrice: Decimal;
        SampleReqLineRec: Record "Sample Requsition line";
        NavAppSetupRec: Record "NavApp Setup";
        NoSeriesManagementCode: Codeunit NoSeriesManagement;
        ItemMasterRec: Record Item;
        ItemUinitRec: Record "Item Unit of Measure";
        BOMEstimateRec: Record "BOM Estimate Cost";
        RouterRec: Record "Routing Header";
        ColorRec: Record Colour;
        ItemRec: Record Item;
        NextItemNo: Code[20];
        SalesDocNo: Code[20];
        ProdBOM: Code[20];
        Routing: Code[20];
    begin

        //Get FOB Pcs price
        FOBPcsPrice := 0;
        BOMEstimateRec.Reset();
        BOMEstimateRec.SetRange("Style No.", rec."Style No.");
        if BOMEstimateRec.FindSet() then
            FOBPcsPrice := BOMEstimateRec."FOB Pcs";

        //Get Worksheet line no
        NavAppSetupRec.Reset();
        NavAppSetupRec.FindSet();


        //Get Sample Router Name
        RouterRec.Reset();
        RouterRec.SetFilter("Sample Router", '=%1', true);

        if RouterRec.FindSet() then
            Routing := RouterRec."No.";


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
            ItemRec."Color No." := Color;

            ColorRec.Reset();
            ColorRec.SetRange("No.", Color);
            ColorRec.FindSet();
            ItemRec."Color Name" := ColorRec."Colour Name";

            ItemRec."Size Range No." := Size;
            ItemRec."Rounding Precision" := 0.00001;

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

            //if "Wash Type Name" = '' then begin
            ItemRec."Routing No." := Routing;
            //Routing := NavAppSetupRec."Sample Non Wash Route Nos.";
            //end
            //else begin
            //    ItemRec."Routing No." := NavAppSetupRec."Sample Wash Route Nos.";
            //    Routing := NavAppSetupRec."Sample Wash Route Nos.";
            //end;

            ItemRec.Insert(true);

            //Create new sales order
            CreateSalesOrder(NextItemNo, Qty, FOBPcsPrice, No, Lineno);

            //Create new Prod BOM
            CreateProdBOM(rec."No.", ItemDesc, NextItemNo);

        end
        else begin   //If old FG item 
            NextItemNo := ItemMasterRec."No.";
            Routing := ItemMasterRec."Routing No.";
            //ProdBOM := ItemMasterRec."Production BOM No.";

            //Create new sales order
            CreateSalesOrder(NextItemNo, Qty, FOBPcsPrice, No, Lineno);

            //Create new Prod BOM
            CreateProdBOM(rec."No.", ItemDesc, NextItemNo);
        end;


        //update router line
        SampleReqLineRec.Reset();
        SampleReqLineRec.SetRange("No.", rec."No.");
        SampleReqLineRec.FindSet();
        SampleReqLineRec."Routing Code" := Routing;
        SampleReqLineRec."FG Code" := NextItemNo;
        SampleReqLineRec.Modify();


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
        StyMasterRec.SetRange("No.", rec."Style No.");
        StyMasterRec.FindSet();

        //Insert Header
        NextOrderNo := NoSeriesManagementCode.GetNextNo(NavAppSetupRec."Sample SO Nos.", Today(), true);
        SalesHeaderRec.Init();
        SalesHeaderRec."Document Type" := SalesHeaderRec."Document Type"::Order;
        SalesHeaderRec."No." := NextOrderNo;
        SalesHeaderRec."Posting Date" := WorkDate();
        SalesHeaderRec."Order Date" := WorkDate();
        SalesHeaderRec.Validate("Sell-to Customer No.", rec."Buyer No.");
        //SalesHeaderRec.Validate("Bill-to Customer No.", "Buyer No.");
        SalesHeaderRec."Document Date" := WORKDATE;
        SalesHeaderRec."Shipping No. Series" := 'S-SHPT';
        SalesHeaderRec."Posting No. Series" := 'S-INV+';
        SalesHeaderRec."Style No" := rec."Style No.";
        SalesHeaderRec."Style Name" := rec."Style Name";
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
        SalesLineRec.Validate("Location Code", StyMasterRec."Factory Code");
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
        UOMRec: Record "Unit of Measure";
        ConvFactor: Decimal;
        ConsumptionTot: Decimal;
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
        ProdBOMHeaderRec."BOM Type" := ProdBOMHeaderRec."BOM Type"::Samples;
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

                    if MainCateRec."Prod. Posting Group Code" = '' then
                        Error('Product Posting Group is not setup for the Main Category : %1. Cannot proceed.', SampleReqAcceRec."Main Category Name");
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

                    ItemMasterRec.validate("Gen. Prod. Posting Group", MainCateRec."Prod. Posting Group Code");
                    ItemMasterRec.validate("Inventory Posting Group", MainCateRec."Inv. Posting Group Code");
                    ItemMasterRec.Modify();
                end
                else begin

                    NextItemNo := NoSeriesManagementCode.GetNextNo(NavAppSetupRec."Sample RM Nos.", Today(), true);

                    ItemMasterRec.Init();
                    ItemMasterRec."No." := NextItemNo;
                    ItemMasterRec.Description := Description;
                    ItemMasterRec."Main Category No." := SampleReqAcceRec."Main Category No.";
                    ItemMasterRec."Main Category Name" := SampleReqAcceRec."Main Category Name";
                    ItemMasterRec."Rounding Precision" := 0.00001;

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
                    ItemMasterRec."Article" := SampleReqAcceRec."Article Name.";
                    ItemMasterRec."Dimension Width No." := SampleReqAcceRec."Dimension No.";
                    ItemMasterRec."Dimension Width" := SampleReqAcceRec."Dimension Name.";
                    ItemMasterRec.Type := ItemMasterRec.Type::Inventory;
                    ItemMasterRec."Unit Cost" := SampleReqAcceRec.Rate;
                    ItemMasterRec."Unit Price" := SampleReqAcceRec.Rate;
                    ItemMasterRec."Last Direct Cost" := SampleReqAcceRec.Rate;
                    ItemMasterRec.validate("Gen. Prod. Posting Group", MainCateRec."Prod. Posting Group Code");
                    ItemMasterRec.validate("Inventory Posting Group", MainCateRec."Inv. Posting Group Code");
                    // ItemMasterRec."Inventory Posting Group" := NavAppSetupRec."Inventory Post Group-RM Sample";
                    ItemMasterRec."VAT Prod. Posting Group" := 'ZERO';
                    //ItemMasterRec."VAT Bus. Posting Gr. (Price)" := 'ZERO';


                    if MainCateRec.LOTTracking then begin
                        ItemMasterRec.Validate("Item Tracking Code", NavAppSetupRec."LOT Tracking Code");
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
                //ProdBOMLineRec.Validate("Main Category Name", SampleReqAcceRec."Main Category Name");
                ProdBOMLineRec.Validate("Main Category Code", SampleReqAcceRec."Main Category No.");
                ProdBOMLineRec.Validate("No.", NextItemNo);
                ProdBOMLineRec.Description := Description;
                ProdBOMLineRec.Validate("Unit of Measure Code", SampleReqAcceRec."Unit N0.");

                UOMRec.Reset();
                UOMRec.SetRange(Code, SampleReqAcceRec."Unit N0.");
                UOMRec.FindSet();
                ConvFactor := UOMRec."Converion Parameter";

                if ConvFactor = 0 then
                    ConvFactor := 1;

                if SampleReqAcceRec.Type = SampleReqAcceRec.Type::Pcs then
                    ConsumptionTot := SampleReqAcceRec.Consumption + (SampleReqAcceRec.Consumption * SampleReqAcceRec.WST) / 100;

                if ConvFactor <> 0 then
                    ConsumptionTot := ConsumptionTot / ConvFactor;

                if ConsumptionTot = 0 then
                    ConsumptionTot := 1;

                ProdBOMLineRec.Quantity := ConsumptionTot;
                ProdBOMLineRec."Quantity per" := ConsumptionTot;
                ProdBOMLineRec.Insert(true);

                // ProdBOMLineRec."Quantity per" := SampleReqAcceRec.Consumption / ConvFactor;
                // ProdBOMLineRec.Insert(true);

                //Create Worksheet Entry
                CreateWorksheetEntry(NextItemNo, SampleReqAcceRec."Supplier No.", SampleReqAcceRec.Requirment, SampleReqAcceRec.Rate, SampleReqAcceRec."Main Category Name");

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

    procedure CreateWorksheetEntry(Item: code[20]; Supplier: Code[20]; Qty: Decimal; Rate: Decimal; MainCat: Code[50])
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
        StyMasterRec.SetRange("No.", rec."Style No.");
        StyMasterRec.FindSet();

        // if StyMasterRec."Factory Code" = '' then
        //     Error('Factory is not assigned for the Style : %1', StyMasterRec."Style No.");

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
        RequLineRec.SetRange(StyleNo, rec."Style No.");
        // RequLineRec.SetRange(Lot, Lot);
        RequLineRec.SetRange("No.", Item);

        if not RequLineRec.FindSet() then begin    //Not existing items

            ReqLineNo += 1000;
            RequLineRec1.Init();
            RequLineRec1."Worksheet Template Name" := NavAppSetupRec."Worksheet Template Name";
            RequLineRec1."Journal Batch Name" := NavAppSetupRec."Journal Batch Name";
            RequLineRec1."Line No." := ReqLineNo;
            RequLineRec1.Type := RequLineRec.Type::Item;
            RequLineRec1."Main Category" := MainCat;
            RequLineRec1.Validate("No.", Item);
            RequLineRec1.Validate("Vendor No.", Supplier);
            RequLineRec1."Action Message" := RequLineRec."Action Message"::New;
            RequLineRec1."Accept Action Message" := true;
            RequLineRec1."Ending Date" := Today + 7;
            RequLineRec1.Quantity := Qty;
            RequLineRec1."Direct Unit Cost" := Rate;
            RequLineRec1."Unit Cost" := Rate;
            RequLineRec1.StyleNo := rec."Style No.";
            RequLineRec1.StyleName := rec."Style Name";
            // RequLineRec1.PONo := PONo;
            // RequLineRec1.Lot := Lot;
            RequLineRec1.Validate("Location Code", StyMasterRec."Factory Code");
            RequLineRec1.Validate("Shortcut Dimension 1 Code", StyMasterRec."Global Dimension Code");
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


    trigger OnOpenPage()
    var
    begin
        if rec.WriteToMRPStatus = 1 then
            CurrPage.Editable(false)
        else
            CurrPage.Editable(true);

    end;


    trigger OnAfterGetRecord()
    var
    begin
        if rec.WriteToMRPStatus = 1 then
            CurrPage.Editable(false)
        else
            CurrPage.Editable(true);


    end;
}