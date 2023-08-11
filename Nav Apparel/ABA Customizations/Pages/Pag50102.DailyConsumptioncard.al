page 50102 "Daily Consumption Card"
{
    Caption = 'Raw Material Requisition Card';
    PageType = Card;
    SourceTable = "Daily Consumption Header";
    Permissions = tabledata "Item Ledger Entry" = rm;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = EditableGB;

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }

                field("Department Name"; rec."Department Name")
                {
                    ApplicationArea = All;
                }

                //Mihiranga 2023/02/18
                field(Buyer; Rec.Buyer)
                {
                    ApplicationArea = All;
                }

                field("Style Name"; Rec."Style Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        rec."Style No." := rec."Style Name";
                    end;
                }

                field(PO; Rec.PO)
                {
                    ApplicationArea = All;
                }

                // field("Main Category Name"; Rec."Main Category Name")
                // {
                //     ApplicationArea = All;
                // }

                field("All Main Categories"; rec."All Main Categories")
                {
                    ApplicationArea = All;
                }

                //Mihiranga 2023/02/18
                field("Colour Name"; rec."Colour Name")
                {
                    ApplicationArea = All;
                }

                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ApplicationArea = All;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }

                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            part(Lines; "Daily Consumption Subform")
            {
                ApplicationArea = All;
                Editable = EditableGB;
                Enabled = rec."Prod. Order No." <> '';
                UpdatePropagation = Both;
                SubPageLink = "Document No." = field("No.");
            }

            part("Daily Requirement"; "Daily Requirement")
            {
                ApplicationArea = All;
                Visible = true;
                Enabled = true;
                //Enabled = rec."Journal Batch Name" <> '';
                UpdatePropagation = Both;
                SubPageLink = "Journal Template Name" = field("Journal Template Name"), "Journal Batch Name" = field("Journal Batch Name"), "Daily Consumption Doc. No." = field("No.");
            }

            part("Posted Daily Requirement"; "Posted Consumptions")
            {
                ApplicationArea = All;
                Visible = Vis2;
                //Enabled = rec."Journal Batch Name" <> '';
                UpdatePropagation = Both;
                SubPageLink = "Daily Consumption Doc. No." = field("No."), "Entry Type" = filter(Consumption);
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(SendApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Image = SendApprovalRequest;
                Caption = 'Send Approval Request';
                Promoted = true;
                PromotedCategory = Process;
                Visible = BooVis1;

                trigger OnAction()
                var
                    ItemJnalLine: Record "Item Journal Line";
                    UserSetup: Record "User Setup";
                begin
                    Rec.TestField(Status, rec.Status::Open);
                    ItemJnalLine.Reset();
                    ItemJnalLine.SetRange("Journal Template Name", rec."Journal Template Name");
                    ItemJnalLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    ItemJnalLine.SetRange("Daily Consumption Doc. No.", Rec."No.");
                    if not ItemJnalLine.FindFirst() then
                        Error('There is nothing to send');

                    UserSetup.Get(UserId);

                    Sleep(500);
                    Rec.Status := Rec.Status::"Pending Approval";
                    if UserSetup."Daily Requirement Approver" = '' then
                        Error('Approval user not found');

                    Rec."Approver UserID" := UserSetup."Daily Requirement Approver";
                    Rec.Modify();

                    Message('Sent for approval.');
                end;
            }

            action(CancelApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Image = CancelApprovalRequest;
                Caption = 'Cancel Approval Request';
                Promoted = true;
                PromotedCategory = Process;
                Visible = BooVis1;

                trigger OnAction()
                var
                    ItemJnalLine: Record "Item Journal Line";
                begin
                    Rec.TestField(Status, rec.Status::"Pending Approval");
                    Sleep(500);
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify();
                    Message('Cancelled approval.');
                end;
            }

            action(Approve)
            {
                Image = Approve;
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Approve';
                Visible = BooVis2;

                trigger OnAction()
                var
                    ItemJnalLine: Record "Item Journal Line";
                    UserSetup: Record "User Setup";
                    AppOK: Boolean;
                begin
                    AppOK := false;
                    UserSetup.Get(UserId);
                    if not UserSetup."Consumption Approve" then
                        Error('You do not have permission to perform this action');

                    Rec.TestField(Status, Rec.Status::"Pending Approval");
                    Sleep(500);

                    ItemJnalLine.Reset();
                    ItemJnalLine.SetRange("Journal Template Name", rec."Journal Template Name");
                    ItemJnalLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    ItemJnalLine.SetRange("Daily Consumption Doc. No.", Rec."No.");
                    if ItemJnalLine.FindFirst() then
                        repeat
                            ItemJnalLine.validate("Line Approved", true);
                            ItemJnalLine.Modify();
                            AppOK := true;
                        until ItemJnalLine.Next() = 0;
                    Commit();
                    if AppOK then begin
                        Rec.Status := Rec.Status::Approved;
                        Rec."Approved UserID" := UserId;
                        Rec."Approved Date/Time" := CurrentDateTime;
                        Rec.Modify();
                        Message('Approved.');
                    end;
                end;
            }

            action(Reject)
            {
                Image = Reject;
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Reject';
                Visible = BooVis2;

                trigger OnAction()
                var
                    UserSetup: Record "User Setup";
                begin
                    UserSetup.Get(UserId);
                    if not UserSetup."Consumption Approve" then
                        Error('You do not have permission to perform this action');

                    Rec.TestField(Status, Rec.Status::"Pending Approval");
                    Sleep(500);
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify();

                    Message('Request rejected. .');
                end;
            }

            action("Calculate Consumption")
            {
                Image = CalculateConsumption;
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Calculate Requirement';
                Visible = BooVis1;

                trigger OnAction()
                var
                    CalConsump: Report "Calc. Consumption";
                    ItemJnalRec: Record "Item Journal Line";
                    ProdOrdComp: Record "Prod. Order Component";
                    DailyConsumpLine: Record "Daily Consumption Line";
                    DailyConsumpLine2: Record "Daily Consumption Line2";
                    ProdOrderLine: Record "Prod. Order Line";
                    ProdOrderRec: Record "Production Order";
                    ItemLedEntry: Record "Item Ledger Entry";
                    ReserveEntryLast: Record "Reservation Entry";
                    ReserveEntry: Record "Reservation Entry";
                    ItemJnalBatch: Record "Item Journal Batch";
                    NoserMangemnt: Codeunit NoSeriesManagement;
                    ManufacSetup: Record "Manufacturing Setup";
                    ItemJrnlLineTempRec: Record ItemJournalLinetemp;
                    DeptRec: Record Department;
                    //BOMRec: Record BOM;
                    ItemRec: Record Item;
                    BOMLineEstRec: Record "BOM Line Estimate";
                    MainCategoryRec: Record "Main Category";
                    MainCategoryNo: Code[20];
                    MainCategoryName: Text[200];
                    PostNo: Code[20];
                    Window: Dialog;
                    Inx1: Integer;
                    LastLNo: Integer;
                    QtyToLot: Decimal;
                    TotRecervQty: Decimal;
                    LineCompleted: Boolean;
                    Include: Boolean;
                    MasterCateName: Text[200];
                    Text000: Label 'Calculating consumption...\\';
                    Text001: Label 'Prod. Order No.   #1##########\';
                    Text002: Label 'Item No.          #2##########\';
                    Text003: Label 'Quantity          #3##########';
                    Lineno: BigInteger;
                    Lineno2: BigInteger;
                begin
                    if (Rec.Status = Rec.Status::"Pending Approval") then
                        Error('Request already sent for approval. Cannot calculate Consumption.');

                    if rec."Department Name" = '' then
                        Error('Invalid Department.');

                    Inx1 := 0;
                    PostNo := '';
                    Window.Open(Text000 + Text001 + Text002 + Text003);

                    ManufacSetup.Get();
                    ManufacSetup.TestField("Posted Daily Consumption Nos.");
                    PostNo := NoserMangemnt.GetNextNo(ManufacSetup."Posted Daily Consumption Nos.", Today, true);
                    ProdOrderRec.Get(ProdOrderRec.Status::Released, rec."Prod. Order No.");
                    ItemJnalBatch.Get(rec."Journal Template Name", rec."Journal Batch Name");

                    //Delete existing records //Done by Maduka on 20/02/2023
                    ItemJnalRec.Reset();
                    ItemJnalRec.SetRange("Journal Template Name", Rec."Journal Template Name");
                    ItemJnalRec.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    ItemJnalRec.SetFilter("Entry Type", '=%1', ItemJnalRec."Entry Type"::Consumption);
                    ItemJnalRec.SetRange("Daily Consumption Doc. No.", rec."No.");
                    if ItemJnalRec.Findset() then
                        ItemJnalRec.DeleteAll();

                    ItemJnalRec.Reset();
                    ItemJnalRec.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
                    ItemJnalRec.SetRange("Journal Template Name", Rec."Journal Template Name");
                    ItemJnalRec.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    if ItemJnalRec.FindLast() then
                        LastLNo := ItemJnalRec."Line No.";

                    // BOMRec.Reset();
                    // BOMRec.SetRange("Style Name", rec."Style Name");
                    // if not BOMRec.Findset() then
                    //     Error('Cannot find BOM for the Style : %1', rec."Style Name");

                    if not rec."All Main Categories" then begin
                        DeptRec.Reset();
                        DeptRec.SetRange("Department Name", rec."Department Name");
                        if DeptRec.Findset() then begin
                            if DeptRec."Master Cat. Name" <> '' then
                                MasterCateName := DeptRec."Master Cat. Name"
                            else
                                MasterCateName := '';
                        end
                        else
                            MasterCateName := '';
                    end
                    else
                        MasterCateName := '';

                    Window.Update(1, rec."Prod. Order No.");
                    DailyConsumpLine.Reset();
                    DailyConsumpLine.SetRange("Document No.", rec."No.");
                    DailyConsumpLine.SetFilter("Daily Consumption", '>%1', 0);
                    if DailyConsumpLine.FindFirst() then begin

                        repeat
                            ProdOrderLine.Get(ProdOrderLine.Status::Released, DailyConsumpLine."Prod. Order No.", DailyConsumpLine."Prod. Order Line No.");
                            ProdOrdComp.Reset();
                            ProdOrdComp.SetRange("Prod. Order No.", Rec."Prod. Order No.");
                            ProdOrdComp.SetRange("Prod. Order Line No.", DailyConsumpLine."prod. Order Line No.");
                            ProdOrdComp.SetFilter("Remaining Quantity", '<>%1', 0);
                            ProdOrdComp.SETFILTER("Flushing Method", '<>%1&<>%2', "Flushing Method"::Backward, "Flushing Method"::"Pick + Backward");
                            //ProdOrdComp.SetRange("Item Cat. Code", Rec."Main Category");
                            if ItemJnalBatch."Inventory Posting Group" <> '' then
                                ProdOrdComp.SetRange("Invent. Posting Group", ItemJnalBatch."Inventory Posting Group");
                            if ProdOrdComp.FindFirst() then
                                repeat
                                    Include := false;
                                    // BOMLineEstRec.Reset();
                                    // BOMLineEstRec.SetRange("No.", BOMRec.No);
                                    // BOMLineEstRec.SetRange("Item No.", ProdOrdComp."Item No.");
                                    // if BOMLineEstRec.Findset() then
                                    //     Error('Cannot find BOM Estimate Item in BOM : %1 , Item : %2', BOMRec.No, ProdOrdComp."Item No.");

                                    if MasterCateName <> '' then begin
                                        ItemRec.Reset();
                                        ItemRec.SetRange("No.", ProdOrdComp."Item No.");
                                        if ItemRec.Findset() then begin
                                            MainCategoryRec.Reset();
                                            MainCategoryRec.SetRange("No.", ItemRec."Main Category No.");
                                            if MainCategoryRec.Findset() then begin
                                                if MainCategoryRec."Master Category Name" = MasterCateName then
                                                    Include := true
                                                else
                                                    Include := false;
                                            end;
                                        end;
                                    end
                                    else
                                        Include := true;

                                    if Include = true then begin
                                        LineCompleted := false;
                                        QtyToLot := 0;
                                        TotRecervQty := 0;
                                        if LastLNo <> 0 then
                                            Inx1 := LastLNo;

                                        ItemLedEntry.Reset();
                                        ItemLedEntry.SetCurrentKey("Location Code", "Item No.");
                                        ItemLedEntry.SetRange("Item No.", ProdOrdComp."Item No.");
                                        ItemLedEntry.SetRange("Location Code", ProdOrdComp."Location Code");
                                        ItemLedEntry.CalcSums("Remaining Quantity");

                                        Window.Update(2, ProdOrdComp."Item No.");

                                        //get Main category
                                        ItemRec.Reset();
                                        ItemRec.SetRange("No.", ProdOrdComp."Item No.");
                                        if ItemRec.Findset() then begin
                                            MainCategoryRec.Reset();
                                            MainCategoryRec.SetRange("No.", ItemRec."Main Category No.");
                                            if MainCategoryRec.Findset() then begin
                                                MainCategoryNo := MainCategoryRec."No.";
                                                MainCategoryName := MainCategoryRec."Main Category Name";
                                            end
                                            else begin
                                                MainCategoryNo := '';
                                                MainCategoryName := '';
                                            end;
                                        end
                                        else begin
                                            MainCategoryNo := '';
                                            MainCategoryName := '';
                                        end;

                                        //if BOMLineEstRec."Size Sensitive" = true then begin
                                        //Add new line
                                        ItemJnalRec.Init();
                                        ItemJnalRec."Journal Template Name" := rec."Journal Template Name";
                                        ItemJnalRec."Journal Batch Name" := rec."Journal Batch Name";
                                        ItemJnalRec."Line No." := Inx1 + 10000;
                                        ItemJnalRec.Insert(true);

                                        Sleep(200);
                                        ItemJnalRec.Validate("Entry Type", ItemJnalRec."Entry Type"::Consumption);
                                        ItemJnalRec.Validate("Order Type", ItemJnalRec."Order Type"::Production);
                                        ItemJnalRec.Validate("Order No.", rec."Prod. Order No.");
                                        ItemJnalRec.Validate("Source No.", DailyConsumpLine."Item No.");  //FG
                                        ItemJnalRec.Validate("Posting Date", rec."Document Date");
                                        ItemJnalRec."Daily Consumption Doc. No." := DailyConsumpLine."Document No.";
                                        ItemJnalRec."Posted Daily Consump. Doc. No." := PostNo;
                                        ItemJnalRec."Posted Daily Output" := DailyConsumpLine."Daily Consumption";  //FG Qty
                                        ItemJnalRec.Validate("Order Line No.", DailyConsumpLine."prod. Order Line No.");
                                        ItemJnalRec.PO := ProdOrderRec.PO;
                                        ItemJnalRec."Style No." := ProdOrderRec."Style No.";
                                        ItemJnalRec."Style Name" := ProdOrderRec."Style Name";
                                        ItemJnalRec.MainCategory := MainCategoryNo;
                                        ItemJnalRec.MainCategoryName := MainCategoryName;
                                        ItemJnalRec.Validate("Item No.", ProdOrdComp."Item No.");   //RM Item

                                        if (ProdOrdComp."Quantity per" * DailyConsumpLine."Daily Consumption") > ProdOrdComp."Remaining Quantity" then
                                            ItemJnalRec.Validate(Quantity, ProdOrdComp."Remaining Quantity")
                                        else
                                            ItemJnalRec.Validate(Quantity, (ProdOrdComp."Quantity per" * DailyConsumpLine."Daily Consumption"));

                                        Window.Update(3, ItemJnalRec.Quantity);
                                        ItemJnalRec."Original Daily Requirement" := ItemJnalRec.Quantity;
                                        ItemJnalRec."Request Qty" := ItemJnalRec.Quantity;
                                        ItemJnalRec.Validate("Variant Code", ProdOrdComp."Variant Code");
                                        ItemJnalRec.Validate("Location Code", ProdOrdComp."Location Code");
                                        ItemJnalRec.Description := ProdOrdComp.Description;
                                        ItemJnalRec.Validate("Unit of Measure Code", ProdOrdComp."Unit of Measure Code");
                                        ItemJnalRec.Validate("Prod. Order Comp. Line No.", ProdOrdComp."Line No.");
                                        ItemJnalRec."Stock After Issue" := ItemLedEntry."Remaining Quantity" - ItemJnalRec.Quantity;
                                        //ProdOrdComp.Get(ProdOrdComp.Status::Released, rec."Transaction Doc. No.", rec."Transaction Line No.", BarcodeLine."Componant Line No.");
                                        // ItemJnalRec.MainCategory := rec."Main Category";
                                        // ItemJnalRec.MainCategoryName := rec."Main Category Name";
                                        ItemJnalRec.Modify();

                                        Inx1 := ItemJnalRec."Line No.";
                                        LastLNo := 0;
                                        //end
                                        //else begin
                                        //update existing lines
                                        // ItemJnalRec.Reset();
                                        // ItemJnalRec.SetRange("Journal Template Name", Rec."Journal Template Name");
                                        // ItemJnalRec.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                                        // ItemJnalRec.SetFilter("Entry Type", '=%1', ItemJnalRec."Entry Type"::Consumption);
                                        // ItemJnalRec.Validate("Order Type", ItemJnalRec."Order Type"::Production);
                                        // ItemJnalRec.SetRange("Daily Consumption Doc. No.", rec."No.");
                                        // ItemJnalRec.SetRange("Item No.", ProdOrdComp."Item No.");
                                        // if ItemJnalRec.Findset() then begin
                                        //     if (ProdOrdComp."Quantity per" * DailyConsumpLine."Daily Consumption") > ProdOrdComp."Remaining Quantity" then
                                        //         ItemJnalRec.Validate(Quantity, ItemJnalRec.Quantity + ProdOrdComp."Remaining Quantity")
                                        //     else
                                        //         ItemJnalRec.Validate(Quantity, (ItemJnalRec.Quantity + (ProdOrdComp."Quantity per" * DailyConsumpLine."Daily Consumption")));

                                        //     Window.Update(3, ItemJnalRec.Quantity);
                                        //     ItemJnalRec."Original Daily Requirement" := ItemJnalRec.Quantity;
                                        //     ItemJnalRec."Request Qty" := ItemJnalRec.Quantity;
                                        //     ItemJnalRec."Stock After Issue" := ItemLedEntry."Remaining Quantity" - ItemJnalRec.Quantity;
                                        //     ItemJnalRec.Modify();
                                        // end
                                        // else begin
                                        // //Add new line
                                        // ItemJnalRec.Init();
                                        // ItemJnalRec."Journal Template Name" := rec."Journal Template Name";
                                        // ItemJnalRec."Journal Batch Name" := rec."Journal Batch Name";
                                        // ItemJnalRec."Line No." := Inx1 + 10000;
                                        // ItemJnalRec.Insert(true);

                                        // Sleep(200);
                                        // ItemJnalRec.Validate("Entry Type", ItemJnalRec."Entry Type"::Consumption);
                                        // ItemJnalRec.Validate("Order Type", ItemJnalRec."Order Type"::Production);
                                        // ItemJnalRec.Validate("Order No.", rec."Prod. Order No.");
                                        // ItemJnalRec.Validate("Source No.", DailyConsumpLine."Item No.");  //FG
                                        // ItemJnalRec.Validate("Posting Date", rec."Document Date");
                                        // ItemJnalRec."Daily Consumption Doc. No." := DailyConsumpLine."Document No.";
                                        // ItemJnalRec."Posted Daily Consump. Doc. No." := PostNo;
                                        // ItemJnalRec."Posted Daily Output" := DailyConsumpLine."Daily Consumption";  //FG Qty
                                        // ItemJnalRec.Validate("Order Line No.", DailyConsumpLine."prod. Order Line No.");
                                        // ItemJnalRec.PO := ProdOrderRec.PO;
                                        // ItemJnalRec."Style No." := ProdOrderRec."Style No.";
                                        // ItemJnalRec."Style Name" := ProdOrderRec."Style Name";
                                        // ItemJnalRec.MainCategory := MainCategoryNo;
                                        // ItemJnalRec.MainCategoryName := MainCategoryName;
                                        // ItemJnalRec.Validate("Item No.", ProdOrdComp."Item No.");   //RM Item

                                        // if (ProdOrdComp."Quantity per" * DailyConsumpLine."Daily Consumption") > ProdOrdComp."Remaining Quantity" then
                                        //     ItemJnalRec.Validate(Quantity, ProdOrdComp."Remaining Quantity")
                                        // else
                                        //     ItemJnalRec.Validate(Quantity, (ProdOrdComp."Quantity per" * DailyConsumpLine."Daily Consumption"));

                                        // Window.Update(3, ItemJnalRec.Quantity);
                                        // ItemJnalRec."Original Daily Requirement" := ItemJnalRec.Quantity;
                                        // ItemJnalRec."Request Qty" := ItemJnalRec.Quantity;
                                        // ItemJnalRec.Validate("Variant Code", ProdOrdComp."Variant Code");
                                        // ItemJnalRec.Validate("Location Code", ProdOrdComp."Location Code");
                                        // ItemJnalRec.Description := ProdOrdComp.Description;
                                        // ItemJnalRec.Validate("Unit of Measure Code", ProdOrdComp."Unit of Measure Code");
                                        // ItemJnalRec.Validate("Prod. Order Comp. Line No.", ProdOrdComp."Line No.");
                                        // ItemJnalRec."Stock After Issue" := ItemLedEntry."Remaining Quantity" - ItemJnalRec.Quantity;
                                        // //ProdOrdComp.Get(ProdOrdComp.Status::Released, rec."Transaction Doc. No.", rec."Transaction Line No.", BarcodeLine."Componant Line No.");
                                        // // ItemJnalRec.MainCategory := rec."Main Category";
                                        // // ItemJnalRec.MainCategoryName := rec."Main Category Name";
                                        // ItemJnalRec.Modify();

                                        // Inx1 := ItemJnalRec."Line No.";
                                        // LastLNo := 0;
                                        //end;
                                        //end;

                                        ItemLedEntry.Reset();
                                        ItemLedEntry.SetCurrentKey("Item No.", Open, "Variant Code", "Location Code", "Item Tracking", "Lot No.", "Serial No.");
                                        ItemLedEntry.SetRange("Item No.", ProdOrdComp."Item No.");
                                        ItemLedEntry.SetRange("Variant Code", ProdOrdComp."Variant Code");
                                        ItemLedEntry.SetRange(Open, true);
                                        ItemLedEntry.SetRange("Location Code", ProdOrdComp."Location Code");
                                        ItemLedEntry.SetFilter("Lot No.", '<>%1', '');

                                        if ItemLedEntry.FindFirst() then begin
                                            REPEAT
                                                if not LineCompleted then begin
                                                    //Check Same lot availability
                                                    ReserveEntry.RESET;
                                                    ReserveEntry.SETCURRENTKEY("Entry No.");
                                                    ReserveEntry.SetRange("Item No.", ProdOrdComp."Item No.");
                                                    ReserveEntry.SetRange("Lot No.", ItemLedEntry."Lot No.");
                                                    // ReserveEntry.SetRange("Source ID", rec."Journal Template Name");
                                                    // ReserveEntry.SetRange("Source Batch Name", Rec."Journal Batch Name");
                                                    // ReserveEntry.SetRange("Source Ref. No.", ItemJnalRec."Line No.");
                                                    ReserveEntry.CalcSums(Quantity);

                                                    ReserveEntryLast.RESET;
                                                    ReserveEntryLast.SETCURRENTKEY("Entry No.");
                                                    ReserveEntryLast.SetRange("Item No.", ProdOrdComp."Item No.");
                                                    ReserveEntryLast.SetRange("Source ID", rec."Journal Template Name");
                                                    ReserveEntryLast.SetRange("Source Batch Name", Rec."Journal Batch Name");
                                                    ReserveEntryLast.SetRange("Source Ref. No.", ItemJnalRec."Line No.");
                                                    ReserveEntryLast.CalcSums(Quantity);
                                                    TotRecervQty := ABS(ReserveEntryLast.Quantity);

                                                    IF (ItemJnalRec.Quantity > TotRecervQty) and (ItemLedEntry."Remaining Quantity" - Abs(ReserveEntry.Quantity) > 0) then begin
                                                        if (ItemLedEntry."Remaining Quantity" - Abs(ReserveEntry.Quantity)) <= (ItemJnalRec.Quantity - TotRecervQty) then
                                                            QtyToLot := ItemLedEntry."Remaining Quantity" - Abs(ReserveEntry.Quantity)
                                                        else
                                                            QtyToLot := ItemJnalRec.Quantity - TotRecervQty;

                                                        InsertResvEntry(ItemJnalRec."Item No.", ItemJnalRec."Location Code", 83, 5, -QtyToLot, ItemLedEntry."Lot No.",
                                                                false, ItemJnalRec."Posting Date", rec."Journal Template Name", Rec."Journal Batch Name", ItemJnalRec."Line No.", 'C', LineCompleted,
                                                                 ItemLedEntry.Shade, ItemLedEntry."Shade No", ItemLedEntry."Width Act", ItemLedEntry."Width Tag", ItemLedEntry."Length Act", ItemLedEntry."Length Tag"
                                                                    , ItemLedEntry."Supplier Batch No.", ItemLedEntry.InvoiceNo, ItemLedEntry.Color, ItemLedEntry."Color No");
                                                    end;
                                                end;
                                            until ItemLedEntry.Next() = 0;
                                        end;

                                        //Delete old records from TEMP table
                                        ItemJrnlLineTempRec.Reset();
                                        ItemJrnlLineTempRec.SetRange("Journal Template Name", Rec."Journal Template Name");
                                        ItemJrnlLineTempRec.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                                        ItemJrnlLineTempRec.SetRange("Source No.", DailyConsumpLine."Item No.");
                                        ItemJrnlLineTempRec.SetRange("Daily Consumption Doc. No.", DailyConsumpLine."Document No.");
                                        ItemJrnlLineTempRec.SetRange("Item No.", ProdOrdComp."Item No.");
                                        if ItemJrnlLineTempRec.Findset() then
                                            ItemJrnlLineTempRec.DeleteAll();

                                        //Get max line;
                                        Lineno := 0;
                                        ItemJrnlLineTempRec.Reset();
                                        ItemJrnlLineTempRec.SetCurrentKey("Line No.");
                                        ItemJrnlLineTempRec.Ascending(true);
                                        if ItemJrnlLineTempRec.FindLast() then
                                            Lineno := ItemJrnlLineTempRec."Line No.";

                                        //Insert to the temp table
                                        ItemJrnlLineTempRec.Init();
                                        ItemJrnlLineTempRec."Journal Batch Name" := Rec."Journal Batch Name";
                                        ItemJrnlLineTempRec."Journal Template Name" := Rec."Journal Template Name";
                                        ItemJrnlLineTempRec."Daily Consumption Doc. No." := DailyConsumpLine."Document No.";
                                        ItemJrnlLineTempRec."Prod. Order No." := DailyConsumpLine."Prod. Order No.";
                                        ItemJrnlLineTempRec."Prod. Order Line No." := DailyConsumpLine."Prod. Order Line No.";
                                        ItemJrnlLineTempRec."Source No." := DailyConsumpLine."Item No.";
                                        ItemJrnlLineTempRec."Item No." := ProdOrdComp."Item No.";
                                        ItemJrnlLineTempRec."Daily Consumption" := DailyConsumpLine."Daily Consumption";
                                        ItemJrnlLineTempRec."Line No." := Lineno + 1;
                                        ItemJrnlLineTempRec."Original Requirement" := ItemJnalRec.Quantity;
                                        ItemJrnlLineTempRec."Posted requirement" := 0;
                                        ItemJrnlLineTempRec.Insert();


                                        //Delete old records from PERMANENT table
                                        DailyConsumpLine2.Reset();
                                        DailyConsumpLine2.SetRange("Journal Template Name", Rec."Journal Template Name");
                                        DailyConsumpLine2.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                                        DailyConsumpLine2.SetRange("Source No.", DailyConsumpLine."Item No.");
                                        DailyConsumpLine2.SetRange("Daily Consumption Doc. No.", DailyConsumpLine."Document No.");
                                        DailyConsumpLine2.SetRange("Item No.", ProdOrdComp."Item No.");
                                        if DailyConsumpLine2.Findset() then
                                            DailyConsumpLine2.DeleteAll();

                                        //Get max line;
                                        Lineno2 := 0;
                                        DailyConsumpLine2.Reset();
                                        DailyConsumpLine2.SetRange("Daily Consumption Doc. No.", DailyConsumpLine."Document No.");
                                        DailyConsumpLine2.SetCurrentKey("Line No.");
                                        DailyConsumpLine2.Ascending(true);
                                        if DailyConsumpLine2.FindLast() then
                                            Lineno2 := DailyConsumpLine2."Line No.";

                                        //Insert to the temp table
                                        DailyConsumpLine2.Init();
                                        DailyConsumpLine2."Journal Batch Name" := Rec."Journal Batch Name";
                                        DailyConsumpLine2."Journal Template Name" := Rec."Journal Template Name";
                                        DailyConsumpLine2."Daily Consumption Doc. No." := DailyConsumpLine."Document No.";
                                        DailyConsumpLine2."Prod. Order No." := DailyConsumpLine."Prod. Order No.";
                                        DailyConsumpLine2."Prod. Order Line No." := DailyConsumpLine."Prod. Order Line No.";
                                        DailyConsumpLine2."Source No." := DailyConsumpLine."Item No.";
                                        DailyConsumpLine2."Item No." := ProdOrdComp."Item No.";
                                        DailyConsumpLine2."Daily Consumption" := DailyConsumpLine."Daily Consumption"; //FG qty
                                        DailyConsumpLine2."Line No." := Lineno2 + 1;
                                        DailyConsumpLine2."Original Requirement" := ItemJnalRec.Quantity;
                                        DailyConsumpLine2."Posted requirement" := 0;
                                        DailyConsumpLine2.Insert();

                                    end;
                                until ProdOrdComp.Next() = 0;
                        until DailyConsumpLine.Next() = 0;
                    end
                    else
                        Message('There is nothing to process.');

                    Window.Close();
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
        ItemJnalRec: Record "Item Journal Line";
        ItemLedRec: Record "Item Ledger Entry";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."Consumption Approve" then begin
            BooVis1 := true;
            BooVis2 := false;
            EditableGB := true;
        end
        else begin
            BooVis1 := false;
            BooVis2 := true;
            EditableGB := true;
        end;

        if UserSetup.UserRole = 'STORE USER' then begin
            BooVis1 := false;
            BooVis2 := false;
            EditableGB := false;
        end;
    end;


    trigger OnAfterGetCurrRecord()
    var
        ItemLedRec: Record "Item Ledger Entry";
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."Consumption Approve" then begin
            BooVis1 := true;
            BooVis2 := false;
            EditableGB := true;
        end
        else begin
            BooVis1 := false;
            BooVis2 := true;
            EditableGB := true;
        end;
        //Mihiranga 2023/4/18
        // if UserSetup.UserRole = 'STORE USER' then begin
        //     BooVis1 := false;
        //     BooVis2 := false;
        //     EditableGB := false;
        // end;

        Vis2 := false;
        ItemLedRec.Reset();
        ItemLedRec.SetRange("Entry Type", ItemLedRec."Entry Type"::Consumption);
        ItemLedRec.SetRange("Daily Consumption Doc. No.", rec."No.");
        if ItemLedRec.FindFirst() then
            Vis2 := true;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        DailyConsumptionLine: Record "Daily Consumption Line";
        ItemJournalLine: Record "Item Journal Line";
        ItemJrnlLineTempRec: Record ItemJournalLinetemp;
    begin
        if rec.Status = rec.Status::Approved then
            Error('Request already approved. Cannot delete.');

        if rec.Status = rec.Status::"Pending Approval" then
            Error('Request already sent for approval. Cannot delete.');

        if rec.Status = rec.Status::Open then begin
            DailyConsumptionLine.Reset();
            DailyConsumptionLine.SetRange("Document No.", rec."No.");
            if DailyConsumptionLine.FindSet() then
                DailyConsumptionLine.DeleteAll();

            ItemJournalLine.SetRange("Journal Template Name", Rec."Journal Template Name");
            ItemJournalLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
            ItemJournalLine.SetFilter("Entry Type", '=%1', ItemJournalLine."Entry Type"::Consumption);
            ItemJournalLine.SetRange("Daily Consumption Doc. No.", rec."No.");
            if ItemJournalLine.FindSet() then
                ItemJournalLine.DeleteAll();

            ItemJrnlLineTempRec.SetRange("Journal Template Name", Rec."Journal Template Name");
            ItemJrnlLineTempRec.SetRange("Journal Batch Name", Rec."Journal Batch Name");
            ItemJrnlLineTempRec.SetRange("Daily Consumption Doc. No.", rec."No.");
            if ItemJrnlLineTempRec.FindSet() then
                ItemJrnlLineTempRec.DeleteAll();
        end;

    end;

    local procedure InsertResvEntry(PassItemNo: Code[20]; PassLocation: Code[20]; PassSourceType: Integer; PassSubType: Integer; PassQty: Decimal; PassLotNo: Code[50];
               PassPos: Boolean; PassDate: Date; PassSourceID: Text[20]; PassBatch: Text[20]; PassRefNo: Integer; DocT: Code[1]; var Completed: Boolean;
                PassShade: text[20]; PassShadeNo: code[20]; PassWidthAct: Decimal; PassWidthTag: Decimal; PassLengthAct: Decimal; PassLengthTag: Decimal;
             PassSupplierBatchNo: code[50]; PassInvoiceNo: Code[20]; PassColor: code[20]; PassColorNo: code[20])
    var
        ResvEntry: Record "Reservation Entry";
        ItemJnal: Record "Item Journal Line";
        ReserveEntry: Record "Reservation Entry";
        ItemRec: Record Item;
        LastEntryNo: Integer;
    begin
        Completed := false;

        ResvEntry.SetCurrentKey("Entry No.");
        if ResvEntry.FindLast() then
            LastEntryNo := ResvEntry."Entry No." + 1
        else
            LastEntryNo := 1;

        ResvEntry.LockTable();

        Clear(ResvEntry);
        ResvEntry.Init();
        ResvEntry."Entry No." := LastEntryNo;
        ResvEntry."Item No." := PassItemNo;
        ItemRec.Get(PassItemNo);
        ResvEntry.Description := ItemRec.Description;
        ResvEntry."Location Code" := PassLocation;
        ResvEntry."Source Type" := PassSourceType;
        ResvEntry."Source Subtype" := PassSubType;
        ResvEntry.Validate("Quantity (Base)", PassQty);
        ResvEntry."Lot No." := PassLotNo;
        ResvEntry.Positive := PassPos;
        if DocT = 'O' then
            ResvEntry."Expected Receipt Date" := PassDate;
        if DocT = 'C' then
            ResvEntry."Shipment Date" := PassDate;
        ResvEntry."Source ID" := PassSourceID;
        ResvEntry."Source Batch Name" := PassBatch;
        ResvEntry."Source Ref. No." := PassRefNo;
        ResvEntry."Creation Date" := Today;
        ResvEntry."Created By" := UserId;
        ResvEntry."Item Tracking" := ResvEntry."Item Tracking"::"Lot No.";
        ResvEntry.validate("Qty. per Unit of Measure", 1);
        ResvEntry."Reservation Status" := ResvEntry."Reservation Status"::Prospect;
        ResvEntry.Shade := PassShade;
        ResvEntry."Shade No" := PassShadeNo;
        ResvEntry."Width Act" := PassWidthAct;
        ResvEntry."Width Tag" := PassWidthTag;
        ResvEntry."Length Act" := PassLengthAct;
        ResvEntry."Length Tag" := PassLengthTag;
        ResvEntry."Supplier Batch No." := PassSupplierBatchNo;
        ResvEntry.InvoiceNo := PassInvoiceNo;
        ResvEntry.Color := PassColor;
        ResvEntry."Color No" := PassColorNo;
        ResvEntry.Insert(true);

        ReserveEntry.RESET;
        ReserveEntry.SETCURRENTKEY("Entry No.");
        ReserveEntry.SetRange("Item No.", ResvEntry."Item No.");
        ReserveEntry.SetRange("Source ID", ResvEntry."Source ID");
        ReserveEntry.SetRange("Source Batch Name", ResvEntry."Source Batch Name");
        ReserveEntry.SetRange("Source Ref. No.", ResvEntry."Source Ref. No.");
        ReserveEntry.CalcSums(Quantity);

        ItemJnal.Get(ResvEntry."Source ID", ResvEntry."Source Batch Name", ResvEntry."Source Ref. No.");
        if Abs(ReserveEntry.Quantity) = ItemJnal.Quantity then
            Completed := true;
    end;

    var
        BooVis1: Boolean;
        BooVis2: Boolean;
        Vis2: Boolean;
        EditableGB: Boolean;
}
