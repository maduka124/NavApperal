page 50721 "Job Creation Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Job Creation';
    SourceTable = "Washing Sample Requsition Line";
    layout
    {
        area(Content)
        {
            group(Request)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Req. No';
                    Enabled = false;
                }

                field(Type; Type)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }

                field(Buyer; Buyer)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }

                field("Buyer No"; "Buyer No")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                    Enabled = false;
                }

                field("Color Name"; "Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'Color';
                    Enabled = false;
                }

                field("Req Qty BW QC Pass"; "Req Qty BW QC Pass")
                {
                    ApplicationArea = All;
                    Enabled = false;
                    Caption = 'Req. Qty (BW QC Pass)';
                }

                field("Gament Type"; "Gament Type")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }

                field(SampleType; SampleType)
                {
                    ApplicationArea = All;
                    Caption = 'Sample Type';
                    Enabled = false;
                }

                field("Wash Type"; "Wash Type")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }

                field(Size; Size)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }

                field("Req Date"; "Req Date")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }

                field("BW QC Date"; "BW QC Date")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }

                field("Split Status"; "Split Status")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }

                field(RemarkLine; RemarkLine)
                {
                    ApplicationArea = All;
                    Caption = 'Remarks';
                    Enabled = false;
                }
            }

            group(" ")
            {
                part(JobcreationPageListPart; JobcreationPageListPart)
                {
                    ApplicationArea = All;
                    Caption = 'Request - Splits';
                    SubPageLink = No = field("No."), "Line No" = field("Line no.");
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Post)
            {
                ApplicationArea = All;
                Image = Post;

                trigger OnAction()
                var
                    JobcreationRec: Record JobCreationLine;
                    WashSampleReqDataRec: Record "Washing Sample Requsition Line";
                    Quantity: Integer;
                    inTermeDiateTable: Record IntermediateTable;

                //jobcreationTable: Record JobCreationLine;
                begin

                    if "Split Status" = "Split Status"::Yes then
                        Error('This job creation already posted.');

                    Quantity := 0;
                    JobcreationRec.Reset();
                    JobcreationRec.SetRange(No, "No.");
                    JobcreationRec.SetRange("Line No", "Line no.");

                    if JobcreationRec.FindSet() then begin

                        repeat
                            Quantity += JobcreationRec.QTY;
                        until JobcreationRec.Next() = 0;

                        if Quantity <> JobcreationRec."Order Qty" then
                            error('Total split quantity must Be equal to requested quantity.');

                        if "Split Status" = "Split Status"::No then begin
                            "Split Status" := "Split Status"::Yes;

                            //Create Sample Items
                            Generate_Sample_Items();

                            //Create Sales Order
                            Generate_SO();

                            //Create Purchase Order
                            Generate_PO();

                            CurrPage.Editable(false);
                            CurrPage.Update();
                            Message('Posting completed.');
                        end
                        else
                            Error('This job creation already posted.');
                    end
                    else
                        Error('No splits for posting.');
                end;
            }
        }
    }


    procedure Generate_Sample_Items()
    var
        Description: Text[500];
        IntermediateTableRec: Record IntermediateTable;
        itemNo: Code[20];
    begin
        IntermediateTableRec.Reset();
        IntermediateTableRec.SetRange(No, "No.");
        IntermediateTableRec.SetRange("Line No", "Line no.");

        if IntermediateTableRec.FindSet() then begin
            repeat
                Description := 'Sample_Item' + '/' + "Style Name" + '/' + "Color Name" + '/' + Size + '/' + IntermediateTableRec."Wash Type";
                itemNo := CreateItem(Description, "Color Code", "Unite Price");
                IntermediateTableRec."FG No" := itemNo;
                IntermediateTableRec."FG Item Name" := Description;

                IntermediateTableRec.Modify();
            until IntermediateTableRec.Next() = 0;
            "FG Status" := "FG Status"::Yes;
        end;
    end;


    procedure CreateItem(ItemDesc: Text[500]; color: code[50]; "Unit Price": Decimal): code[20]
    var
        NoSeriesManagementCode: Codeunit NoSeriesManagement;
        NavAppSetupRec: Record "NavApp Setup";
        ItemMasterRec: Record Item;
        ItemUinitRec: Record "Item Unit of Measure";
        ItemRec: Record Item;
        NextItemNo: Code[20];
    begin

        //Get Worksheet line no
        NavAppSetupRec.Reset();
        NavAppSetupRec.FindSet();

        //Check for item existance
        ItemMasterRec.Reset();
        ItemMasterRec.SetRange(Description, ItemDesc);

        //If new item
        if not ItemMasterRec.FindSet() then begin
            //Get next Item no
            NextItemNo := NoSeriesManagementCode.GetNextNo(NavAppSetupRec."WS SMItem Nos.", Today(), true);

            //Create new item
            ItemUinitRec.Reset();
            ItemUinitRec.SetRange("Item No.", NextItemNo);
            ItemUinitRec.SetRange(Code, 'PCS');

            if not ItemUinitRec.FindSet() then begin
                ItemUinitRec.Init();
                ItemUinitRec."Item No." := NextItemNo;
                ItemUinitRec.Code := 'PCS';
                ItemUinitRec."Qty. per Unit of Measure" := 1;
                ItemUinitRec.Insert();
            end;

            ItemRec.Init();
            ItemRec."No." := NextItemNo;
            ItemRec.Description := ItemDesc;
            ItemRec.Type := ItemRec.Type::Inventory;
            ItemRec."Gen. Prod. Posting Group" := NavAppSetupRec."Gen Posting Group-WashSample";
            ItemRec."Inventory Posting Group" := NavAppSetupRec."InventoryPostingGroupWashSampl";
            ItemRec.Validate("Color No.", Color);
            ItemRec.Validate("Base Unit of Measure", 'PCS');
            ItemRec."VAT Prod. Posting Group" := 'ZERO';
            ItemRec."VAT Bus. Posting Gr. (Price)" := 'ZERO';
            ItemRec.Validate("Replenishment System", 1);
            ItemRec.Validate("Manufacturing Policy", 1);
            ItemRec."Routing No." := NavAppSetupRec.Routing;
            ItemRec."Unit Price" := "Unit Price";
            ItemRec.Insert(true);

            exit(NextItemNo);
            Message('Item No', ItemRec."No.");
        end
        else
            exit(ItemMasterRec."No.");
    end;

    procedure Generate_SO()
    var
        SalesHeaderRec: Record "Sales Header";
        SalesLineRec: Record "Sales Line";
        NavAppSetupRec: Record "NavApp Setup";
        NoSeriesManagementCode: Codeunit NoSeriesManagement;
        IntermediateTableRec: Record IntermediateTable;
        HeaderRenaretor: Integer;
        "SO No": Code[20];
        LineNo: Integer;
    begin

        IntermediateTableRec.Reset();
        IntermediateTableRec.SetRange(No, "No.");
        IntermediateTableRec.SetRange("Line No", "Line no.");

        if IntermediateTableRec.FindSet() then begin
            //HeaderRenaretor := 0;
            LineNo := 0;
            NavAppSetupRec.Reset();
            NavAppSetupRec.FindSet();

            repeat
                LineNo += 1;
                //if HeaderRenaretor = 0 then begin
                "SO No" := NoSeriesManagementCode.GetNextNo(NavAppSetupRec."Wash SO Nos.", Today(), true);
                // Sales Header 
                SalesHeaderRec.Init();
                SalesHeaderRec."Document Type" := SalesHeaderRec."Document Type"::Order;
                SalesHeaderRec."No." := "SO No";
                SalesHeaderRec.Validate("Sell-to Customer No.", "Buyer No");
                SalesHeaderRec."Document Date" := WorkDate();
                SalesHeaderRec."Posting Date" := WorkDate();
                SalesHeaderRec."Order Date" := WorkDate();
                SalesHeaderRec."Shipping No. Series" := 'S-SHPT';
                SalesHeaderRec."Posting No. Series" := 'S-INV+';
                SalesHeaderRec."Style Name" := "Style Name";
                SalesHeaderRec.Status := SalesHeaderRec.Status::Open;
                SalesHeaderRec."Requested Delivery Date" := "Req Date";
                SalesHeaderRec.INSERT();
                //HeaderRenaretor := 1;
                //end;

                // Sales Line
                SalesLineRec.Init();
                SalesLineRec."Document Type" := SalesLineRec."Document Type"::Order;
                SalesLineRec."Document No." := "SO No";
                SalesLineRec."Line No." := LineNo;
                SalesLineRec.Type := SalesLineRec.Type::Item;
                SalesLineRec."VAT Bus. Posting Group" := 'ZERO';
                SalesLineRec."VAT Prod. Posting Group" := 'ZERO';
                SalesLineRec.Validate("No.", IntermediateTableRec."FG No");
                SalesLineRec.Validate(Quantity, IntermediateTableRec."Split Qty");
                SalesLineRec."Gen. Prod. Posting Group" := 'RETAIL';
                SalesLineRec."Gen. Bus. Posting Group" := 'EU';
                SalesLineRec."Tax Group Code" := NavAppSetupRec.TaxGroupCode;
                SalesLineRec."Shipment Date" := WorkDate();
                SalesLineRec.Insert();

                IntermediateTableRec."SO No" := "SO No";
                IntermediateTableRec.Modify();

            until IntermediateTableRec.Next() = 0;

            //update SO status in request line
            "SO Satatus" := "SO Satatus"::Yes;
        end;
    end;

    procedure Generate_PO()
    var
        PoNo: Code[20];
        IntermediateTableRec: Record IntermediateTable;
        NoSeriesManagementCode: Codeunit NoSeriesManagement;
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        NavAppSetupRec: Record "NavApp Setup";
        HeaderRenaretor: Integer;
        LineNo: Integer;
        PurchaseHeader2: Record "Purchase Header";
        PurchPostCodeunit: Codeunit "Purch.-Post";
        NavappRec: Record "NavApp Setup";
    begin

        IntermediateTableRec.Reset();
        IntermediateTableRec.SetRange(No, "No.");
        IntermediateTableRec.SetRange("Line No", "Line no.");

        if IntermediateTableRec.FindSet() then begin
            HeaderRenaretor := 0;
            LineNo := 0;
            NavAppSetupRec.Reset();
            NavAppSetupRec.FindSet();

            repeat
                LineNo += 1;
                begin
                    // Insert Purchase Header 
                    if HeaderRenaretor = 0 then begin
                        PoNo := NoSeriesManagementCode.GetNextNo(NavAppSetupRec."Wash Purchase Nos.", Today(), true);
                        PurchaseHeader.Init();
                        PurchaseHeader."No." := PoNo;
                        PurchaseHeader."Buy-from Vendor No." := NavAppSetupRec."Wash PO Vendor";
                        PurchaseHeader.Validate("Buy-from Vendor No.");
                        //PurchaseHeader.Validate("Buy-from Address", PurchaseHeader."Buy-from Address");
                        //PurchaseHeader."Buy-from Vendor Name" := 'CoolWood Technologies';
                        PurchaseHeader."Order Date" := "Req Date";
                        PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Order;
                        PurchaseHeader."Document Date" := "Req Date";
                        PurchaseHeader."Posting Date" := WorkDate();
                        PurchaseHeader.receive := true;
                        HeaderRenaretor := 1;
                        PurchaseHeader.Insert();
                    end;

                    //Insert Purchse Line quantity
                    PurchaseLine.Init();
                    PurchaseLine."Document Type" := PurchaseHeader."Document Type"::Order;
                    PurchaseLine."Document No." := PoNo;
                    PurchaseLine.Type := PurchaseLine.Type::Item;
                    PurchaseLine."VAT Bus. Posting Group" := 'ZERO';
                    PurchaseLine."VAT Prod. Posting Group" := 'ZERO';
                    PurchaseLine.Validate("No.", IntermediateTableRec."FG No");
                    PurchaseLine."Line No." := LineNo;
                    PurchaseLine."Buy-from Vendor No." := NavAppSetupRec."Wash PO Vendor";
                    PurchaseLine.Validate("Buy-from Vendor No.");
                    PurchaseLine.Validate(Quantity, IntermediateTableRec."Split Qty");
                    purchaseline.Validate("Location Code", "Location Code");
                    // PurchaseLine."Quantity Received" := "Req Qty BW QC Pass";
                    // PurchaseLine."Qty. to Invoice" := "Req Qty BW QC Pass";
                    PurchaseLine.Insert();

                    IntermediateTableRec."Po No" := PoNo;
                    IntermediateTableRec.Modify();

                    //Post Purchase Order
                    PurchaseHeader.Reset();
                    PurchaseHeader.SetRange("No.", PoNo);
                    PurchaseHeader.SetRange("Document Type", PurchaseHeader."Document Type");

                    if PurchaseHeader.FindSet() then begin
                        PurchPostCodeunit.Run(PurchaseHeader);
                    end;

                end;
            until IntermediateTableRec.Next() = 0;

            "PO Satatus" := "PO Satatus"::Yes;
        end;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        JobcreationRec: Record JobCreationLine;
        Inter1Rec: Record IntermediateTable;
    begin
        if "Split Status" = "Split Status"::Yes then
            Error('This job creation already posted. Cannot delete.');

        JobcreationRec.Reset();
        JobcreationRec.SetRange(No, "No.");
        JobcreationRec.SetRange("Line No", "Line no.");

        if JobcreationRec.FindSet() then
            JobcreationRec.DeleteAll();

        Inter1Rec.Reset();
        Inter1Rec.SetRange(No, "No.");
        Inter1Rec.SetRange("Line No", "Line no.");

        if Inter1Rec.FindSet() then
            Inter1Rec.DeleteAll();
    end;

    trigger OnOpenPage()
    var
        jobcreationLine: Record JobCreationLine;
    begin
        jobcreationLine.Reset();
        jobcreationLine.SetRange(No, "No.");
        jobcreationLine.SetRange("Line No", "Line no.");

        if jobcreationLine.FindSet() then
            repeat
                jobcreationLine.Select := false;
                jobcreationLine.Modify();
            until jobcreationLine.Next() = 0;

        CurrPage.Update();

    end;
}

