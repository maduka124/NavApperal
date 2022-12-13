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
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Req. No';
                    Enabled = false;
                }

                field(Type; rec.Type)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }

                field(Buyer; rec.Buyer)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }

                field("Buyer No"; rec."Buyer No")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                    Enabled = false;
                }

                field("Color Name"; rec."Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'Color';
                    Enabled = false;
                }

                field("Req Qty BW QC Pass"; rec."Req Qty BW QC Pass")
                {
                    ApplicationArea = All;
                    Enabled = false;
                    Caption = 'Req. Qty (BW QC Pass)';
                }

                field("Gament Type"; rec."Gament Type")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }

                field(SampleType; rec.SampleType)
                {
                    ApplicationArea = All;
                    Caption = 'Sample Type';
                    Enabled = false;
                }

                field("Wash Type"; rec."Wash Type")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }

                field(Size; rec.Size)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }

                field("Req Date"; rec."Req Date")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }

                field("BW QC Date"; rec."BW QC Date")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }

                field("Split Status"; rec."Split Status")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }

                field(RemarkLine; rec.RemarkLine)
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

            field("Total Split Qty"; rec."Total Split Qty")
            {
                ApplicationArea = All;
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
                    SalesHeaderRec: Record "Sales Header";
                    Window: Dialog;
                    TextCon1: TextConst ENU = 'Creating Production Order ####1';
                    ProOrderNo: Code[20];
                    CodeUnitNavApp: Codeunit NavAppCodeUnit;
                begin

                    if rec."Split Status" = rec."Split Status"::Yes then
                        Error('This job creation already posted.');

                    Quantity := 0;
                    JobcreationRec.Reset();
                    JobcreationRec.SetRange(No, rec."No.");
                    JobcreationRec.SetRange("Line No", rec."Line no.");

                    if JobcreationRec.FindSet() then begin

                        repeat
                            Quantity += JobcreationRec.QTY;
                        until JobcreationRec.Next() = 0;

                        if Quantity <> JobcreationRec."Order Qty" then
                            error('Total split quantity must Be equal to requested quantity.');

                        if rec."Split Status" = rec."Split Status"::No then begin
                            rec."Split Status" := rec."Split Status"::Yes;

                            //Create Sample Items
                            Generate_Sample_Items();

                            //Create Sales Orders
                            Generate_SO();

                            //Create Purchase Order (For GRN of received items)
                            Generate_PO(rec."Style No.", rec."Style Name");

                            //Create Prod orders                       
                            SalesHeaderRec.Reset();
                            SalesHeaderRec."Document Type" := SalesHeaderRec."Document Type"::Order;
                            SalesHeaderRec.SetRange("Style No", rec."Style No.");
                            SalesHeaderRec.SetRange(EntryType, SalesHeaderRec.EntryType::Washing);

                            if SalesHeaderRec.FindSet() then begin

                                repeat

                                    ProOrderNo := CodeUnitNavApp.CreateProdOrder(SalesHeaderRec."No.", 'Washing');

                                    //get split no of the So
                                    inTermeDiateTable.Reset();
                                    inTermeDiateTable.SetRange(No, rec."No.");
                                    inTermeDiateTable.SetRange("Line No", rec."Line no.");
                                    inTermeDiateTable.SetRange("SO No", SalesHeaderRec."No.");

                                    if inTermeDiateTable.FindSet() then begin

                                        JobcreationRec.Reset();
                                        JobcreationRec.SetRange(No, rec."No.");
                                        JobcreationRec.SetRange("Line No", rec."Line no.");
                                        JobcreationRec.SetRange("Split No", inTermeDiateTable."Split No");

                                        if JobcreationRec.FindSet() then begin
                                            JobcreationRec."Job Card (Prod Order)" := ProOrderNo;
                                            JobcreationRec.Modify();
                                        end;
                                    end;

                                until SalesHeaderRec.Next() = 0;

                            end;

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
        IntermediateTableRec.SetRange(No, rec."No.");
        IntermediateTableRec.SetRange("Line No", rec."Line no.");

        if IntermediateTableRec.FindSet() then begin
            repeat
                Description := 'Sample_Item' + '/' + rec."Style Name" + '/' + rec."Color Name" + '/' + rec.Size + '/' + IntermediateTableRec."Wash Type";
                itemNo := CreateItem(Description, rec."Color Code", rec."Unite Price");
                IntermediateTableRec."FG No" := itemNo;
                IntermediateTableRec."FG Item Name" := Description;

                IntermediateTableRec.Modify();
            until IntermediateTableRec.Next() = 0;
            rec."FG Status" := rec."FG Status"::Yes;
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
        StyleMasterPo: Record "Style Master PO";
        LoginSessionsRec: Record LoginSessions;
        LoginRec: Page "Login Card";
        HeaderRenaretor: Integer;
        "SO No": Code[20];
        LineNo: Integer;
        LotNo: Code[20];
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
        end;

        StyleMasterPo.Reset();
        StyleMasterPo.SetRange("Style No.", rec."Style No.");
        StyleMasterPo.SetRange("PO No.", rec."Style_PO No");

        if StyleMasterPo.FindSet() then
            LotNo := StyleMasterPo."Lot No.";


        IntermediateTableRec.Reset();
        IntermediateTableRec.SetRange(No, rec."No.");
        IntermediateTableRec.SetRange("Line No", rec."Line no.");

        if IntermediateTableRec.FindSet() then begin
            //HeaderRenaretor := 0;
            //LineNo := 0;
            NavAppSetupRec.Reset();
            NavAppSetupRec.FindSet();

            repeat
                //LineNo += 1;
                //if HeaderRenaretor = 0 then begin
                "SO No" := NoSeriesManagementCode.GetNextNo(NavAppSetupRec."Wash SO Nos.", Today(), true);
                // Sales Header 
                SalesHeaderRec.Init();
                SalesHeaderRec."Document Type" := SalesHeaderRec."Document Type"::Order;
                SalesHeaderRec."No." := "SO No";
                SalesHeaderRec.Validate("Sell-to Customer No.", rec."Buyer No");
                SalesHeaderRec."Document Date" := WorkDate();
                SalesHeaderRec."Posting Date" := WorkDate();
                SalesHeaderRec."Order Date" := WorkDate();
                SalesHeaderRec."Shipping No. Series" := 'S-SHPT';
                SalesHeaderRec."Posting No. Series" := 'S-INV+';
                SalesHeaderRec."Style No" := rec."Style No.";
                SalesHeaderRec."Style Name" := rec."Style Name";
                SalesHeaderRec."PO No" := rec."Style_PO No";
                SalesHeaderRec.Lot := LotNo;
                SalesHeaderRec.EntryType := SalesHeaderRec.EntryType::Washing;
                SalesHeaderRec.Status := SalesHeaderRec.Status::Open;
                SalesHeaderRec."Requested Delivery Date" := rec."Req Date";
                SalesHeaderRec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                SalesHeaderRec.INSERT();
                //HeaderRenaretor := 1;
                //end;

                // Sales Line
                SalesLineRec.Init();
                SalesLineRec."Document Type" := SalesLineRec."Document Type"::Order;
                SalesLineRec."Document No." := "SO No";
                SalesLineRec."Line No." := 1;
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
            rec."SO Satatus" := rec."SO Satatus"::Yes;
        end;
    end;

    procedure Generate_PO(StyleNo: code[20]; StyleName: Text[50])
    var
        PoNo: Code[20];
        IntermediateTableRec: Record IntermediateTable;
        NoSeriesManagementCode: Codeunit NoSeriesManagement;
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        NavAppSetupRec: Record "NavApp Setup";
        HeaderGenerated: Integer;
        LineNo: Integer;
        PurchaseHeader2: Record "Purchase Header";
        PurchPostCodeunit: Codeunit "Purch.-Post";
        NavappRec: Record "NavApp Setup";
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
        end;

        IntermediateTableRec.Reset();
        IntermediateTableRec.SetRange(No, rec."No.");
        IntermediateTableRec.SetRange("Line No", rec."Line no.");

        if IntermediateTableRec.FindSet() then begin
            HeaderGenerated := 0;
            LineNo := 0;
            NavAppSetupRec.Reset();
            NavAppSetupRec.FindSet();

            repeat
                LineNo += 1;
                begin
                    // Insert Purchase Header 
                    if HeaderGenerated = 0 then begin
                        PoNo := NoSeriesManagementCode.GetNextNo(NavAppSetupRec."Wash Purchase Nos.", Today(), true);
                        PurchaseHeader.Init();
                        PurchaseHeader."No." := PoNo;
                        PurchaseHeader."Buy-from Vendor No." := NavAppSetupRec."Wash PO Vendor";
                        PurchaseHeader.Validate("Buy-from Vendor No.");
                        //PurchaseHeader.Validate("Buy-from Address", PurchaseHeader."Buy-from Address");
                        //PurchaseHeader."Buy-from Vendor Name" := 'CoolWood Technologies';
                        PurchaseHeader."Order Date" := rec."Req Date";
                        PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Order;
                        PurchaseHeader."Document Date" := rec."Req Date";
                        PurchaseHeader."Posting Date" := WorkDate();
                        PurchaseHeader.receive := true;
                        HeaderGenerated := 1;
                        PurchaseHeader."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        PurchaseHeader.Insert();
                    end;

                    //Insert Purchse Line quantity
                    PurchaseLine.Init();
                    PurchaseLine."Document Type" := PurchaseHeader."Document Type"::Order;
                    PurchaseLine."Document No." := PoNo;
                    PurchaseLine.StyleNo := StyleNo;
                    PurchaseLine.StyleName := StyleName;
                    PurchaseLine.Type := PurchaseLine.Type::Item;
                    PurchaseLine."VAT Bus. Posting Group" := 'ZERO';
                    PurchaseLine."VAT Prod. Posting Group" := 'ZERO';
                    PurchaseLine.Validate("No.", IntermediateTableRec."FG No");
                    PurchaseLine."Line No." := LineNo;
                    PurchaseLine."Buy-from Vendor No." := NavAppSetupRec."Wash PO Vendor";
                    PurchaseLine.Validate("Buy-from Vendor No.");
                    PurchaseLine.Validate(Quantity, IntermediateTableRec."Split Qty");
                    purchaseline.Validate("Location Code", rec."Location Code");
                    // PurchaseLine."Quantity Received" := "Req Qty BW QC Pass";
                    // PurchaseLine."Qty. to Invoice" := "Req Qty BW QC Pass";
                    PurchaseLine.Insert();

                    IntermediateTableRec."Po No" := PoNo;
                    IntermediateTableRec.Modify();

                end;
            until IntermediateTableRec.Next() = 0;

            //Post Purchase Order
            PurchaseHeader.Reset();
            PurchaseHeader.SetRange("No.", PoNo);
            PurchaseHeader.SetRange("Document Type", PurchaseHeader."Document Type"::Order);

            if PurchaseHeader.FindSet() then begin
                PurchPostCodeunit.Run(PurchaseHeader);
            end;

            rec."PO Satatus" := rec."PO Satatus"::Yes;
        end;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        JobcreationRec: Record JobCreationLine;
        Inter1Rec: Record IntermediateTable;
    begin
        if rec."Split Status" = rec."Split Status"::Yes then
            Error('This job creation already posted. Cannot delete.');

        JobcreationRec.Reset();
        JobcreationRec.SetRange(No, rec."No.");
        JobcreationRec.SetRange("Line No", rec."Line no.");

        if JobcreationRec.FindSet() then
            JobcreationRec.DeleteAll();

        if JobcreationRec.FindSet() then begin
            JobcreationRec.Delete();
            rec."Total Split Qty" := rec."Total Split Qty" - JobcreationRec.QTY;
        end;

        Inter1Rec.Reset();
        Inter1Rec.SetRange(No, rec."No.");
        Inter1Rec.SetRange("Line No", rec."Line no.");

        if Inter1Rec.FindSet() then
            Inter1Rec.DeleteAll();
    end;

    trigger OnOpenPage()
    var
        jobcreationLine: Record JobCreationLine;
    begin
        jobcreationLine.Reset();
        jobcreationLine.SetRange(No, rec."No.");
        jobcreationLine.SetRange("Line No", rec."Line no.");

        if jobcreationLine.FindSet() then
            repeat
                jobcreationLine.Select := false;
                jobcreationLine.Modify();
            until jobcreationLine.Next() = 0;

        CurrPage.Update();

    end;
}

