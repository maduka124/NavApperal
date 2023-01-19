pageextension 50805 "Consumption Jrnl List Ext" extends "Consumption Journal"
{
    layout
    {
        addafter("Document No.")
        {
            field("Cut No"; Rec."Cut No")
            {
                ApplicationArea = All;
            }
        }

        addafter(ShortcutDimCode8)
        {
            field("Style Transfer Doc. No."; rec."Style Transfer Doc. No.")
            {
                ApplicationArea = All;
            }
            field("Quantity Approved"; rec."Quantity Approved")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Line Approved"; rec."Line Approved")
            {
                ApplicationArea = All;
                Editable = false;
            }

        }
    }


    actions
    {
        modify("P&ost")
        {
            trigger OnBeforeAction()
            begin

            end;
        }

        addafter("P&ost")
        {
            action("Line Qty. Approved")
            {
                Image = Approve;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    ItemJnalLine: Record "Item Journal Line";
                    UserSetup: Record "User Setup";
                begin
                    UserSetup.Get(UserId);
                    if not UserSetup."Consump. Journal Qty. Approve" then
                        Error('You do not have permission to perform this action');
                    ItemJnalLine.Reset();
                    CurrPage.SETSELECTIONFILTER(ItemJnalLine);
                    ItemJnalLine.SetRange("Journal Template Name", rec."Journal Template Name");
                    ItemJnalLine.SetRange("Journal Batch Name", rec."Journal Batch Name");
                    ItemJnalLine.SetRange("Quantity Approved", false);
                    if ItemJnalLine.FINDSET then begin
                        REPEAT
                            ItemJnalLine."Quantity Approved" := true;
                            ItemJnalLine."Qty. Approved UserID" := UserId;
                            ItemJnalLine."Qty. Approved Date/Time" := CurrentDateTime;
                            ItemJnalLine.Modify();
                        UNTIL ItemJnalLine.NEXT = 0;
                    end
                    else
                        Message('Nothing to approve');
                end;
            }

            action("LineApproved")
            {
                Image = Approve;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Line Approved';
                trigger OnAction()
                var
                    ItemJnalLine: Record "Item Journal Line";
                    UserSetup: Record "User Setup";
                begin
                    UserSetup.Get(UserId);
                    if not UserSetup."Consumption Approve" then
                        Error('You do not have permission to perform this action');

                    ItemJnalLine.Reset();
                    CurrPage.SETSELECTIONFILTER(ItemJnalLine);
                    ItemJnalLine.SetRange("Journal Template Name", rec."Journal Template Name");
                    ItemJnalLine.SetRange("Journal Batch Name", rec."Journal Batch Name");
                    ItemJnalLine.SetRange("Line Approved", false);
                    if ItemJnalLine.FINDSET then begin
                        REPEAT
                            ItemJnalLine."Line Approved" := true;
                            ItemJnalLine."Line Approved UserID" := UserId;
                            ItemJnalLine."Line Approved DateTime" := CurrentDateTime;
                            ItemJnalLine.Modify();
                        UNTIL ItemJnalLine.NEXT = 0;
                        Message('Line approved');
                    end
                    else
                        Message('Nothing to approve');
                end;
            }
        }

        addafter("Pro&d. Order")
        {
            action("Mat. Req. Report")
            {
                Caption = 'Mat. &Requisition';
                Image = PrintCover;
                ApplicationArea = All;
                Visible = false;

                trigger OnAction();
                var
                    RPORec: Record "Production Order";
                // MaterialReport: Report MaterialRequition;
                begin
                    RPORec.Reset();
                    RPORec.SetRange("No.", Rec."Order No.");
                    RPORec.SetRange(Status, RPORec.Status::Released);
                    // RPORec.FindSet();
                    // ManuPrintReport.PrintProductionOrder(RPORec, 1);
                    // MaterialReport.Set_Value("Document No.");
                    // MaterialReport.Set_Batch("Journal Batch Name");
                    // MaterialReport.Run();




                end;
            }

            action("Print")
            {
                Caption = 'Mat. &Requisition';
                Image = PrintCover;
                ApplicationArea = All;

                trigger OnAction();
                var
                    // MaterialReport: Report MaterialRequition;
                    MaterialReport: Report MaterialIssueRequitionCard;
                begin

                    // RPORec.FindSet();
                    // ManuPrintReport.PrintProductionOrder(RPORec, 1);
                    MaterialReport.Set_Value(Rec."Document No.");
                    MaterialReport.Set_Batch(Rec."Journal Batch Name");
                    MaterialReport.Set_Doc(Rec."Daily Consumption Doc. No.");
                    MaterialReport.Run();

                end;
            }
        }

        modify("Calc. Co&nsumption")
        {
            Visible = false;
        }

        addafter("Calc. Co&nsumption")
        {
            action("Cal. Consumption")
            {
                ApplicationArea = Manufacturing;
                Caption = 'Calc. Co&nsumption';
                Image = CalculateConsumption;
                Promoted = true;
                PromotedCategory = Category5;
                Ellipsis = true;
                trigger OnAction()
                var
                    CalConsump: Report "Calc. Consumption";
                    ItemJnalBatch: Record "Item Journal Batch";
                begin
                    ItemJnalBatch.Get(rec."Journal Template Name", rec."Journal Batch Name");
                    //ItemJnalBatch.TestField("Inventory Posting Group");
                    CalConsump.SetTemplateAndBatchName(rec."Journal Template Name", rec."Journal Batch Name");
                    if ItemJnalBatch."Inventory Posting Group" <> '' then
                        CalConsump.SetItemCat(ItemJnalBatch."Inventory Posting Group");
                    CalConsump.RunModal();
                end;
            }

            action("Create Transfer Order")
            {
                Image = TransferOrder;
                Promoted = true;
                ApplicationArea = Manufacturing;
                PromotedCategory = Category5;
                trigger OnAction()
                var
                    CustMangemnt: Codeunit "Customization Management";
                    ItemJnal: Record "Item Journal Line";
                begin
                    if not Confirm('Do you want to create the Transfer order?', false) then
                        exit;
                    CreateTransOrder();
                end;
            }

            // action("Calculate Daily Consumption")
            // {
            //     Image = CalculateInventory;
            //     Promoted = true;
            //     ApplicationArea = Manufacturing;
            //     PromotedCategory = Category5;
            //     Visible = false;
            //     trigger OnAction()
            //     var
            //         DailyConsumpHedd: Record "Daily Consumption Header";
            //         DailyConsumpCard: Page "Daily Consumption Card";
            //         CheckItemJurnalLine: Record "Item Journal Line";
            //     begin
            //         CheckItemJurnalLine.Reset();
            //         CheckItemJurnalLine.SetRange("Journal Template Name", rec."Journal Template Name");
            //         CheckItemJurnalLine.SetRange("Journal Batch Name", rec."Journal Batch Name");
            //         if not CheckItemJurnalLine.IsEmpty then
            //             Error('Please post the pending lines first');
            //         //DailyConsumpHedd.GetVariables(rec."Journal Template Name", rec."Journal Batch Name");
            //         DailyConsumpHedd.Init();
            //         DailyConsumpHedd."Journal Template Name" := rec."Journal Template Name";
            //         DailyConsumpHedd."Journal Batch Name" := rec."Journal Batch Name";
            //         DailyConsumpHedd.Insert(true);
            //         //Message('%1 - %2 / %3', DailyConsumpHedd."No.", rec."Journal Template Name", rec."Journal Batch Name");
            //         Commit();
            //         Page.RunModal(50102, DailyConsumpHedd);
            //         //DailyConsumpCard.Run(DailyConsumpHedd);
            //     end;
            // }
        }


    }


    procedure CreateTransOrder()
    var
        TransHedd: Record "Transfer Header";
        TransLine: Record "Transfer Line";
        ProdOrdComp: Record "Prod. Order Component";
        InvSetup: Record "Inventory Setup";
        PassItemJnalRec: Record "Item Journal Line";
        LocRec: Record Location;
        ProcessPass: Boolean;
        Inx: Integer;
        MsgShow: Boolean;
        Window: Dialog;
        GrpItemNo: Code[20];
        CheckTransLine: Record "Transfer Line";
        LoginSessionsRec: Record LoginSessions;
        LoginRec: Page "Login Card";
        TotQty: Decimal;
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


        Window.Open('Transfer Order ###1###');
        InvSetup.Get();
        InvSetup.TestField("Transfer Order Nos.");

        TotQty := 0;
        MsgShow := false;
        ProcessPass := false;
        PassItemJnalRec.Reset();
        //CurrPage.SETSELECTIONFILTER(PassItemJnalRec);
        PassItemJnalRec.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
        PassItemJnalRec.SetRange("Journal Template Name", rec."Journal Template Name");
        PassItemJnalRec.SetRange("Journal Batch Name", rec."Journal Batch Name");
        PassItemJnalRec.FindFirst();
        LocRec.Get(PassItemJnalRec."Location Code");
        LocRec.TestField("Transfer-from Location");

        repeat
            if not ProcessPass then begin
                if not ProdOrdComp.Get(ProdOrdComp.Status::Released, PassItemJnalRec."Order No.", PassItemJnalRec."Order Line No.", PassItemJnalRec."Prod. Order Comp. Line No.") then
                    Error('Prod. Order Component Line not found');

                if not ProdOrdComp."Transfer Order Created" then
                    ProcessPass := true;
            end;
        until PassItemJnalRec.Next() = 0;

        if not ProcessPass then
            Error('Transfer order already created');

        if ProcessPass then begin
            PassItemJnalRec.Reset();
            //CurrPage.SETSELECTIONFILTER(PassItemJnalRec);
            PassItemJnalRec.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
            PassItemJnalRec.SetRange("Journal Template Name", rec."Journal Template Name");
            PassItemJnalRec.SetRange("Journal Batch Name", rec."Journal Batch Name");
            PassItemJnalRec.FindFirst();
            TransHedd.Init();
            //TransHedd."No." := Nosmangemnt.GetNextNo(InvSetup."Transfer Order Nos.", WorkDate(), true);

            TransHedd.Validate("Transfer-from Code", LocRec."Transfer-from Location");
            TransHedd.Validate("Transfer-to Code", PassItemJnalRec."Location Code");
            TransHedd.TestField("In-Transit Code");
            TransHedd.PO := PassItemJnalRec.PO;
            TransHedd."Style No." := PassItemJnalRec."Style No.";
            TransHedd."Style Name" := PassItemJnalRec."Style Name";
            TransHedd."Style No." := PassItemJnalRec."Style No.";
            TransHedd."Secondary UserID" := LoginSessionsRec."Secondary UserID";
            TransHedd.Insert(true);
            Window.Update(1, TransHedd."No.");

            repeat
                ProdOrdComp.Get(ProdOrdComp.Status::Released, PassItemJnalRec."Order No.", PassItemJnalRec."Order Line No.", PassItemJnalRec."Prod. Order Comp. Line No.");
                if not ProdOrdComp."Transfer Order Created" then begin
                    CheckTransLine.Reset();
                    CheckTransLine.SetRange("Document No.", TransHedd."No.");
                    CheckTransLine.SetRange("Item No.", PassItemJnalRec."Item No.");
                    if CheckTransLine.FindFirst() then begin
                        //TotQty += TransLine.Quantity;
                        CheckTransLine.Quantity += PassItemJnalRec.Quantity;
                        CheckTransLine.Validate(Quantity);
                        CheckTransLine.Modify();
                    end
                    else begin
                        Inx += 10000;
                        TransLine.Init();
                        TransLine."Document No." := TransHedd."No.";
                        TransLine."Line No." := Inx;
                        TransLine.Validate("Item No.", PassItemJnalRec."Item No.");
                        TransLine.Quantity := PassItemJnalRec.Quantity;
                        TransLine.Validate(Quantity);
                        TransLine.Insert(true);
                    end;
                    ProdOrdComp."Transfer Order Created" := true;
                    ProdOrdComp.Modify();
                    MsgShow := true;
                end;
            until PassItemJnalRec.Next() = 0;
        end;
        Window.Close();
        if MsgShow then
            Message('Transfer order %1 created', TransHedd."No.")
        else
            Message('There is nothing to create');
    end;

    var
        ManuPrintReport: Codeunit "Manu. Print Report";

    trigger OnOpenPage()
    var
        LoginRec: Page "Login Card";
        LoginSessionsRec: Record LoginSessions;
    begin

        //Check whether user logged in or not
        LoginSessionsRec.Reset();
        LoginSessionsRec.SetRange(SessionID, SessionId());

        if not LoginSessionsRec.FindSet() then begin  //not logged in
            Clear(LoginRec);
            LoginRec.LookupMode(true);
            LoginRec.RunModal();

            // LoginSessionsRec.Reset();
            // LoginSessionsRec.SetRange(SessionID, SessionId());
            // if LoginSessionsRec.FindSet() then
            //     rec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
        end
        else begin   //logged in
            //rec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
        end;

    end;
}