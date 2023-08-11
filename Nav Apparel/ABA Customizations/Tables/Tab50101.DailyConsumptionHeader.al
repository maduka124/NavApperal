table 50101 "Daily Consumption Header"
{
    Caption = 'Daily Consumption Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }

        field(2; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
            DataClassification = ToBeClassified;
            // TableRelation = "Production Order"."No." where(Status = filter(Released), PO = field(PO), BuyerCode = field("Buyer Code"), "Style Name" = field("Style No."));
            TableRelation = "Production Order"."No." where(Status = filter(Released), PO = field(PO), BuyerCode = field("Buyer Code"), "Style Name" = field("Style Name"));

            trigger OnValidate()
            var
            // ProdOrderRec: Record "Production Order";
            // DailyConsumpLine: Record "Daily Consumption Line";
            // ProdOrderLine: Record "Prod. Order Line";
            // ProdOrderComp: Record "Prod. Order Component";
            // ItemLed: Record "Item Ledger Entry";
            // ItemJrnlLineRec: Record "Item Journal Line";
            // ItemJnalBatch: Record "Item Journal Batch";
            // DailyConsuHeaderRec: Record "Daily Consumption Header";
            // ItemRec: Record Item;
            // Inx: Integer;
            // Total: Decimal;
            // TotalLedger: Decimal;
            // DocNo: Text[20];
            begin
                ProductionOrderOldCal();

                // DailyConsumpLine.Reset();
                // DailyConsumpLine.SetRange("Document No.", "No.");
                // DailyConsumpLine.DeleteAll();

                // if "Prod. Order No." <> '' then begin
                //     ProdOrderRec.Get(ProdOrderRec.Status::Released, "Prod. Order No.");
                //     ItemJnalBatch.Get(Rec."Journal Template Name", Rec."Journal Batch Name");
                //     Rec.TestField("Colour No.");
                //     Description := ProdOrderRec.Description;
                //     "Source No." := ProdOrderRec."Source No.";
                //     "Due Date" := ProdOrderRec."Due Date";
                //     // "Journal Template Name" := GetTempCode;
                //     // "Journal Batch Name" := GetBatchCode;

                //     ProdOrderLine.Reset();
                //     ProdOrderLine.SetRange("Prod. Order No.", "Prod. Order No.");
                //     ProdOrderLine.SetRange(Status, ProdOrderLine.Status::Released);
                //     if ProdOrderLine.FindFirst() then begin
                //         repeat
                //             ItemRec.Get(ProdOrderLine."Item No.");
                //             if "Colour No." = ItemRec."Color No." then begin
                //                 ItemLed.Reset();
                //                 ItemLed.SetRange("Entry Type", ItemLed."Entry Type"::Consumption);
                //                 ItemLed.SetRange("Order No.", ProdOrderLine."Prod. Order No.");
                //                 ItemLed.SetRange("Order Line No.", ProdOrderLine."Line No.");
                //                 if ItemJnalBatch."Inventory Posting Group" <> '' then
                //                     ItemLed.SetRange("Invent. Posting Grp.", ItemJnalBatch."Inventory Posting Group");
                //                 //ItemLed.SetRange(MainCategoryName, "Main Category Name");
                //                 ItemLed.CalcSums("Posted Daily Output");

                //                 TotalLedger := 0;
                //                 DailyConsuHeaderRec.Reset();
                //                 DailyConsuHeaderRec.SetRange("No.", ItemLed."Daily Consumption Doc. No.");
                //                 if DailyConsuHeaderRec.FindSet() then begin
                //                     if DailyConsuHeaderRec.Status <> DailyConsuHeaderRec.Status::Open then
                //                         TotalLedger := ItemLed."Posted Daily Output";
                //                 end;

                //                 ProdOrderComp.Reset();
                //                 ProdOrderComp.SetRange("Prod. Order No.", ProdOrderLine."Prod. Order No.");
                //                 ProdOrderComp.SetRange("Prod. Order Line No.", ProdOrderLine."Line No.");
                //                 // ProdOrderComp.SetRange("Item Cat. Code", "Main Category");
                //                 ProdOrderComp.SetFilter("Remaining Quantity", '>%1', 0);
                //                 if ProdOrderComp.FindFirst() then begin

                //                     DocNo := '';
                //                     Total := 0;
                //                     ItemJrnlLineRec.Reset();
                //                     ItemJrnlLineRec.SetRange("Entry Type", ItemJrnlLineRec."Entry Type"::Consumption);
                //                     ItemJrnlLineRec.SetRange("Order No.", ProdOrderLine."Prod. Order No.");
                //                     ItemJrnlLineRec.SetRange("Order Line No.", ProdOrderLine."Line No.");
                //                     ItemJrnlLineRec.SetCurrentKey("Daily Consumption Doc. No.");
                //                     ItemJrnlLineRec.Ascending(true);
                //                     if ItemJnalBatch."Inventory Posting Group" <> '' then
                //                         ItemJrnlLineRec.SetRange("Inventory Posting Group", ItemJnalBatch."Inventory Posting Group");
                //                     if ItemJrnlLineRec.FindSet() then begin
                //                         repeat
                //                             if DocNo <> ItemJrnlLineRec."Daily Consumption Doc. No." then begin
                //                                 DailyConsuHeaderRec.Reset();
                //                                 DailyConsuHeaderRec.SetRange("No.", ItemJrnlLineRec."Daily Consumption Doc. No.");
                //                                 if DailyConsuHeaderRec.FindSet() then begin
                //                                     if DailyConsuHeaderRec.Status <> DailyConsuHeaderRec.Status::Open then
                //                                         Total += ItemJrnlLineRec."Posted Daily Output";
                //                                 end;
                //                             end;
                //                             DocNo := ItemJrnlLineRec."Daily Consumption Doc. No.";
                //                         until ItemJrnlLineRec.Next() = 0;
                //                     end;

                //                     Inx += 10000;
                //                     DailyConsumpLine.Init();
                //                     DailyConsumpLine."Document No." := "No.";
                //                     DailyConsumpLine."Line No." := Inx;
                //                     DailyConsumpLine."Item No." := ProdOrderLine."Item No.";
                //                     DailyConsumpLine.Description := ProdOrderLine.Description;
                //                     DailyConsumpLine."Order Quantity" := ProdOrderLine.Quantity;
                //                     DailyConsumpLine."Prod. Order No." := ProdOrderLine."Prod. Order No.";
                //                     DailyConsumpLine."prod. Order Line No." := ProdOrderLine."Line No.";
                //                     DailyConsumpLine."Issued Quantity" := TotalLedger + Total;
                //                     DailyConsumpLine."Balance Quantity" := ProdOrderLine.Quantity - (Total + TotalLedger);
                //                     // DailyConsumpLine."Issued Quantity" := Total;
                //                     // DailyConsumpLine."Balance Quantity" := ProdOrderLine.Quantity - Total;
                //                     // DailyConsumpLine."Main Category" := 
                //                     // DailyConsumpLine."Main Category Name" := 
                //                     DailyConsumpLine.Insert();
                //                 end;
                //             end;
                //         until ProdOrderLine.Next() = 0;
                //     end;
                // end;

            end;
        }

        field(3; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(4; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(5; "Due Date"; Date)
        {
            Caption = 'Due Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(6; Remarks; Text[50])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
            //Editable = false;
        }

        field(7; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(8; "Journal Template Name"; Code[10])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Journal Batch Name"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"));
        }

        //Mihiranga 2023/02/18
        field(10; Buyer; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer.Name;
            ValidateTableRelation = false;
            trigger OnValidate()
            var
                CustRec: Record Customer;
            begin

                CustRec.Reset();
                CustRec.SetRange(Name, Buyer);
                if CustRec.FindSet() then begin
                    "Buyer Code" := CustRec."No.";
                end;
            end;

        }

        field(11; PO; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Production Order".PO where(Status = filter(Released), BuyerCode = field("Buyer Code"), "Style Name" = field("Style Name"));
            //ValidateTableRelation = false;

            trigger OnLookup()
            var
                ProdOrder: Record "Production Order";
                UserSetupRec: Record "User Setup";
                NavAppProdPlanRec: Record "NavApp Prod Plans Details";
                PONO: code[20];
            begin
                ProdOrder.Reset();
                ProdOrder.SetRange(Status, ProdOrder.Status::Released);
                ProdOrder.SetRange(BuyerCode, "Buyer Code");
                ProdOrder.SetRange("Style Name", "Style Name");
                if ProdOrder.FindSet() then begin
                    repeat
                        UserSetupRec.Reset();
                        UserSetupRec.SetRange("User ID", UserId);
                        if UserSetupRec.FindSet() then begin

                            NavAppProdPlanRec.Reset();
                            NavAppProdPlanRec.SetRange("Style Name", "Style Name");
                            //NavAppProdPlanRec.SetRange("PO No.", ProdOrder.PO);
                            NavAppProdPlanRec.SetRange("Lot No.", ProdOrder."Lot No.");
                            if NavAppProdPlanRec.FindSet() then begin
                                repeat
                                    IF PONO <> NavAppProdPlanRec."PO No." THEN BEGIN
                                        if UserSetupRec."Factory Code" = NavAppProdPlanRec."Factory No." then begin
                                            PONO := NavAppProdPlanRec."PO No.";
                                            ProdOrder.MARK(TRUE);
                                        end;
                                    end;
                                until NavAppProdPlanRec.Next() = 0;
                            end
                            else
                                Error('Cannot find planned PO details.');
                        end
                        else
                            Error('Cannot find user details in user setup.');
                    until ProdOrder.Next() = 0;
                end;

                if Page.RunModal(51386, ProdOrder) = Action::LookupOK then begin
                    Validate("PO", ProdOrder."PO");
                    "Lot No." := ProdOrder."Lot No.";
                end;
            end;

            trigger OnValidate()
            var
                ProdOrder: Record "Production Order";
            begin
                ProdOrder.Reset();
                ProdOrder.SetRange(Status, ProdOrder.Status::Released);
                ProdOrder.SetRange(BuyerCode, "Buyer Code");
                ProdOrder.SetRange("Style Name", "Style Name");
                ProdOrder.SetRange(PO, PO);
                if not ProdOrder.FindFirst() then
                    Error('There is no Production order')
                else begin
                    if ProdOrder."No." <> '' then begin
                        "Prod. Order No." := ProdOrder."No.";
                    end;
                end;

                "Style Master No." := ProdOrder."Style No.";
            end;
        }

        field(12; "Buyer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
            ValidateTableRelation = false;
            // trigger OnValidate()
            // var
            //     CustRec: Record Customer;
            // begin
            //     Buyer := '';

            //     if "Buyer Code" <> '' then
            //         CustRec.get("Buyer Code");
            //     Buyer := CustRec.Name;
            // end;
        }

        field(13; "Style No."; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Style Name';
            TableRelation = "Style Master"."Style No." where("Buyer No." = field("Buyer Code"), Status = filter(Confirmed));
            ValidateTableRelation = false;
        }

        field(14; "Colour No."; Code[20])
        {
            DataClassification = ToBeClassified;
            // TableRelation = AssortmentDetails."Colour No" where("PO No." = field(PO), "Style No." = field("Style Master No."));
            //ValidateTableRelation = false;

            trigger OnValidate()
            var
                ColorRec: Record Colour;
                ProdOrder: Record "Production Order";
            begin
                if "Colour No." <> '' then
                    ColorRec.Get("Colour No.");
                "Colour Name" := ColorRec."Colour Name";

                ProdOrder.Reset();
                ProdOrder.SetRange(Status, ProdOrder.Status::Released);
                ProdOrder.SetRange(BuyerCode, "Buyer Code");
                // ProdOrder.SetRange("Style Name", "Style No.");
                ProdOrder.SetRange("Style Name", "Style Name");
                ProdOrder.SetRange(PO, PO);
                if not ProdOrder.FindFirst() then
                    Error('There is no Production order');

                Validate("Prod. Order No.", ProdOrder."No.");
            end;

            trigger OnLookup()
            var
                AssortDetails: Record AssortmentDetails;
            begin
                AssortDetails.Reset();
                AssortDetails.SetRange("PO No.", PO);
                AssortDetails.SetRange("Style No.", "Style Master No.");
                if Page.RunModal(50109, AssortDetails) = Action::LookupOK then
                    Validate("Colour No.", AssortDetails."Colour No");
            end;
        }

        field(15; "Colour Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            // Editable = false;
            trigger OnValidate()
            var
                ColorRec: Record Colour;
            begin
                ColorRec.Reset();
                ColorRec.SetRange("Colour Name", "Colour Name");
                if ColorRec.FindSet() then begin
                    "Colour No." := ColorRec."No.";
                    ProductionOrderOldCal();
                end
                else
                    Error('Cannot find Color in Color Master.');
            end;

            trigger OnLookup()
            var
                AssortDetails: Record AssortmentDetails;
            begin
                AssortDetails.Reset();
                AssortDetails.SetRange("Lot No.", "Lot No.");
                AssortDetails.SetRange("Style No.", "Style Master No.");
                if Page.RunModal(50109, AssortDetails) = Action::LookupOK then
                    Validate("Colour Name", AssortDetails."Colour Name");
            end;
        }

        field(16; "Style Master No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(17; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,"Pending Approval",Approved;
            OptionCaption = 'Open,Pending Approval,Approved';
        }

        field(18; "Created UserID"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(19; "Approved UserID"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(20; "Approved Date/Time"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(21; "Approver UserID"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(22; "Department Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Department."Department Name";
            ValidateTableRelation = false;
        }

        field(23; "Issued Date/Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }

        field(24; "Issued UserID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(25; "Main Category"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(26; "Main Category Name"; Text[50])
        {
            Caption = 'Main Category';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                MainCatRec: Record "Main Category";
            begin
                MainCatRec.Reset();
                MainCatRec.SetRange("Main Category Name", "Main Category Name");
                if MainCatRec.FindSet() then
                    "Main Category" := MainCatRec."No."
                else
                    Error('Invalid Main Category Name');
            end;


            trigger OnLookup()
            var
                ProdOrdComp: Record "Prod. Order Component";
                MainCatFilter: Record "Main Category Filter";
                ProdOrder: Record "Production Order";
                MainCat: Record "Main Category";
            begin
                MainCatFilter.Reset();
                MainCatFilter.DeleteAll();

                ProdOrder.Reset();
                ProdOrder.SetRange(Status, ProdOrder.Status::Released);
                ProdOrder.SetRange(BuyerCode, "Buyer Code");
                ProdOrder.SetRange("Style Name", "Style Name");
                ProdOrder.SetRange(PO, PO);
                if ProdOrder.FindFirst() then begin
                    ProdOrdComp.Reset();
                    ProdOrdComp.SetRange("Prod. Order No.", ProdOrder."No.");
                    ProdOrdComp.SetRange(Status, ProdOrder.Status);
                    if ProdOrdComp.FindFirst() then begin
                        repeat
                            if not MainCatFilter.Get(ProdOrdComp."Item Cat. Code") then begin
                                MainCatFilter.Init();
                                MainCatFilter.Code := ProdOrdComp."Item Cat. Code";
                                if MainCat.Get(MainCatFilter.Code) then
                                    MainCatFilter.Name := MainCat."Main Category Name";
                                MainCatFilter.Insert();
                            end;
                        until ProdOrdComp.Next() = 0;
                    end;
                end;
                Commit();
                if Page.RunModal(50118, MainCatFilter) = Action::LookupOK then begin
                    "Main Category" := MainCatFilter.Code;
                    "Main Category Name" := MainCatFilter.Name;
                    // Rec.Validate("Main Category", MainCatFilter.Code);
                end
            end;
        }

        field(27; "Style Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Style Name';
            TableRelation = "Style Master"."Style No." where("Buyer No." = field("Buyer Code"), Status = filter(Confirmed));
            ValidateTableRelation = false;
        }

        field(28; "Fully Issued"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(29; "All Main Categories"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(30; "Lot No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Style Name", po, "Prod. Order No.")
        {

        }
    }

    trigger OnInsert()
    var
        ManufacSetup: Record "Manufacturing Setup";
        NosMangmnet: Codeunit NoSeriesManagement;
        ItemJnaltempRec: Record "Item Journal Template";
    begin
        if "No." = '' then begin
            ManufacSetup.Get();
            ManufacSetup.TestField("Daily Consumption Nos.");
            "No." := NosMangmnet.GetNextNo(ManufacSetup."Daily Consumption Nos.", WorkDate(), true);
            "Document Date" := WorkDate();

            ItemJnaltempRec.Reset();
            ItemJnaltempRec.SetRange(Type, ItemJnaltempRec.Type::Consumption);
            ItemJnaltempRec.FindFirst();
            "Journal Template Name" := ItemJnaltempRec.Name;
            "Journal Batch Name" := 'DEFAULT';
            "Created UserID" := UserId;
        end;
    end;

    procedure AssistEdit(OldDailyConsumpHedd: Record "Daily Consumption Header"): Boolean
    var
        DailyConsumHedd2: Record "Daily Consumption Header";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ManuSetup: Record "Manufacturing Setup";
    begin
        COPY(Rec);
        ManuSetup.Get();
        ManuSetup.TestField("Daily Consumption Nos.");

        IF NoSeriesMgt.SelectSeries(ManuSetup."Daily Consumption Nos.", OldDailyConsumpHedd."No.", "No.") THEN BEGIN
            NoSeriesMgt.SetSeries("No.");
            IF DailyConsumHedd2.GET("No.") THEN
                EXIT(TRUE);
        END;
    end;


    //Done By Sachith on 04/08/23
    procedure ProductionOrderOldCal(): Boolean
    var
        ProdOrderRec: Record "Production Order";
        DailyConsumpLine: Record "Daily Consumption Line";
        ProdOrderLine: Record "Prod. Order Line";
        ProdOrderComp: Record "Prod. Order Component";
        ItemLed: Record "Item Ledger Entry";
        ItemJrnlLineRec: Record "Item Journal Line";
        ItemJnalBatch: Record "Item Journal Batch";
        DailyConsuHeaderRec: Record "Daily Consumption Header";
        ItemRec: Record Item;
        Inx: Integer;
        Total: Decimal;
        TotalLedger: Decimal;
        DocNo: Text[20];
    begin
        DailyConsumpLine.Reset();
        DailyConsumpLine.SetRange("Document No.", "No.");
        DailyConsumpLine.DeleteAll();

        if "Prod. Order No." <> '' then begin
            ProdOrderRec.Get(ProdOrderRec.Status::Released, "Prod. Order No.");
            ItemJnalBatch.Get(Rec."Journal Template Name", Rec."Journal Batch Name");
            Rec.TestField("Colour No.");
            Description := ProdOrderRec.Description;
            "Source No." := ProdOrderRec."Source No.";
            "Due Date" := ProdOrderRec."Due Date";
            // "Journal Template Name" := GetTempCode;
            // "Journal Batch Name" := GetBatchCode;

            ProdOrderLine.Reset();
            ProdOrderLine.SetRange("Prod. Order No.", "Prod. Order No.");
            ProdOrderLine.SetRange(Status, ProdOrderLine.Status::Released);
            if ProdOrderLine.FindFirst() then begin
                repeat
                    ItemRec.Get(ProdOrderLine."Item No.");
                    if "Colour No." = ItemRec."Color No." then begin

                        Total := 0;
                        ItemLed.Reset();
                        ItemLed.SetRange("Entry Type", ItemLed."Entry Type"::Consumption);
                        ItemLed.SetRange("Order No.", ProdOrderLine."Prod. Order No.");
                        ItemLed.SetRange("Order Line No.", ProdOrderLine."Line No.");
                        if ItemJnalBatch."Inventory Posting Group" <> '' then
                            ItemLed.SetRange("Invent. Posting Grp.", ItemJnalBatch."Inventory Posting Group");
                        //ItemLed.SetRange(MainCategoryName, "Main Category Name");
                        ItemLed.CalcSums("Posted Daily Output");

                        TotalLedger := 0;
                        DailyConsuHeaderRec.Reset();
                        DailyConsuHeaderRec.SetRange("No.", ItemLed."Daily Consumption Doc. No.");
                        if DailyConsuHeaderRec.FindSet() then begin
                            if DailyConsuHeaderRec.Status <> DailyConsuHeaderRec.Status::Open then
                                TotalLedger := ItemLed."Posted Daily Output";
                        end;

                        ProdOrderComp.Reset();
                        ProdOrderComp.SetRange("Prod. Order No.", ProdOrderLine."Prod. Order No.");
                        ProdOrderComp.SetRange("Prod. Order Line No.", ProdOrderLine."Line No.");
                        // ProdOrderComp.SetRange("Item Cat. Code", "Main Category");
                        ProdOrderComp.SetFilter("Remaining Quantity", '>%1', 0);
                        if ProdOrderComp.FindFirst() then begin

                            DocNo := '';
                            Total := 0;
                            ItemJrnlLineRec.Reset();
                            ItemJrnlLineRec.SetRange("Entry Type", ItemJrnlLineRec."Entry Type"::Consumption);
                            ItemJrnlLineRec.SetRange("Order No.", ProdOrderLine."Prod. Order No.");
                            ItemJrnlLineRec.SetRange("Order Line No.", ProdOrderLine."Line No.");
                            ItemJrnlLineRec.SetCurrentKey("Daily Consumption Doc. No.");
                            ItemJrnlLineRec.Ascending(true);
                            if ItemJnalBatch."Inventory Posting Group" <> '' then
                                ItemJrnlLineRec.SetRange("Inventory Posting Group", ItemJnalBatch."Inventory Posting Group");
                            if ItemJrnlLineRec.FindSet() then begin
                                repeat
                                    if DocNo <> ItemJrnlLineRec."Daily Consumption Doc. No." then begin
                                        DailyConsuHeaderRec.Reset();
                                        DailyConsuHeaderRec.SetRange("No.", ItemJrnlLineRec."Daily Consumption Doc. No.");
                                        if DailyConsuHeaderRec.FindSet() then begin
                                            if DailyConsuHeaderRec.Status <> DailyConsuHeaderRec.Status::Open then
                                                Total += ItemJrnlLineRec."Posted Daily Output";
                                        end;
                                    end;
                                    DocNo := ItemJrnlLineRec."Daily Consumption Doc. No.";
                                until ItemJrnlLineRec.Next() = 0;
                            end;

                            Inx += 10000;
                            DailyConsumpLine.Init();
                            DailyConsumpLine."Document No." := "No.";
                            DailyConsumpLine."Line No." := Inx;
                            DailyConsumpLine."Item No." := ProdOrderLine."Item No.";
                            DailyConsumpLine.Description := ProdOrderLine.Description;
                            DailyConsumpLine."Order Quantity" := ProdOrderLine.Quantity;
                            DailyConsumpLine."Prod. Order No." := ProdOrderLine."Prod. Order No.";
                            DailyConsumpLine."prod. Order Line No." := ProdOrderLine."Line No.";
                            DailyConsumpLine."Issued Quantity" := TotalLedger + Total;
                            DailyConsumpLine."Balance Quantity" := ProdOrderLine.Quantity - (Total + TotalLedger);
                            // DailyConsumpLine."Issued Quantity" := Total;
                            // DailyConsumpLine."Balance Quantity" := ProdOrderLine.Quantity - Total;
                            // DailyConsumpLine."Main Category" := 
                            // DailyConsumpLine."Main Category Name" := 
                            DailyConsumpLine.Insert();
                        end;
                    end;
                until ProdOrderLine.Next() = 0;
            end;
        end;
    end;


    // procedure GetVariables(TempCode: Code[10]; BatchCode: Code[10])
    // begin
    //     GetTempCode := TempCode;
    //     GetBatchCode := BatchCode;
    // end;

    var
        GetTempCode: Code[10];
        GetBatchCode: Code[10];
}
