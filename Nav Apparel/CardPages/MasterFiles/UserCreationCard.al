page 50978 "Create User Card"
{
    PageType = Card;
    SourceTable = LoginDetails;
    Caption = 'User Creation';
    //AutoSplitKey = true;
    // Permissions = tabledata "Purch. Rcpt. Line" = rmID;
    // Permissions = tabledata "Purch. Rcpt. Line" = rmID;
    // Permissions = tabledata "Purchase Line" = rmID;
    Permissions = tabledata "Sales Invoice Header" = rmID;
    // Permissions = tabledata "Purchase Header" = RIMD;
    // Permissions = tabledata "Approval Entry" = RIMD;

    layout
    {
        area(Content)
        {
            group(General)
            {
                // field(contractNo; contractNo)
                // {
                //     ApplicationArea = All;
                // }             

                field("Secondary UserID"; rec."UserID Secondary")
                {
                    ApplicationArea = All;
                    Caption = 'Secondary User ID';

                    trigger OnValidate()
                    var
                        LoginDetailsRec: Record LoginDetails;
                    begin
                        LoginDetailsRec.Reset();
                        LoginDetailsRec.SetRange("UserID Secondary", rec."UserID Secondary");

                        if LoginDetailsRec.FindSet() then
                            Error('Secondary User ID already exists.');
                    end;
                }

                field("User Name"; rec."User Name")
                {
                    ApplicationArea = All;
                    Caption = 'Full Name';
                }

                field(Pw; rec.Pw)
                {
                    ApplicationArea = All;
                    Caption = 'Password';
                }

                field(Password; Password)
                {
                    ApplicationArea = All;
                    ExtendedDatatype = Masked;
                    Caption = 'Re Enter Password';

                    trigger OnValidate()
                    var
                    begin
                        if rec.pw <> Password then
                            Error('Password mismatch.');
                    end;
                }

                field(Active; rec.Active)
                {
                    ApplicationArea = All;
                    Caption = 'Active Status';
                }

                field(ExportRefNo; ExportRefNo)
                {
                    ApplicationArea = All;
                    Caption = 'Posted Sales Invoice No';
                }
                // field(PurchaseNo; PurchaseNo)
                // {
                //     ApplicationArea = All;
                //     Caption = 'Purchase Order No';
                // }
                field(PONo; PONo)
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Order No';
                }
                field(ApprovalNo; ApprovalNo)
                {
                    ApplicationArea = All;
                    Caption = 'Request Approval PO No';
                }
            }
        }
    }

    actions
    {


        area(Processing)
        {
            // action("Assign Lot No to the Prod order and Daily Consu. Header")
            // {
            //     ApplicationArea = All;
            //     Image = AddAction;

            //     trigger OnAction()
            //     var
            //         ProdOrder: Record "Production Order";
            //         StyPo: Record "Style Master PO";
            //         DailyConsuHeader: Record "Daily Consumption Header";
            //     begin
            //         ProdOrder.Reset();
            //         ProdOrder.FindSet();
            //         repeat
            //             StyPo.Reset();
            //             StyPo.SetRange("Style No.", ProdOrder."Style No.");
            //             StyPo.SetRange("Po No.", ProdOrder.po);
            //             if StyPo.FindSet() then begin
            //                 ProdOrder."Lot No." := StyPo."Lot No.";
            //                 ProdOrder.Modify()
            //             end;
            //         until ProdOrder.Next() = 0;

            //         DailyConsuHeader.Reset();
            //         DailyConsuHeader.FindSet();
            //         repeat
            //             StyPo.Reset();
            //             StyPo.SetRange("Style No.", DailyConsuHeader."Style Master No.");
            //             StyPo.SetRange("Po No.", DailyConsuHeader.po);
            //             if StyPo.FindSet() then begin
            //                 DailyConsuHeader."Lot No." := StyPo."Lot No.";
            //                 DailyConsuHeader.Modify()
            //             end;
            //         until DailyConsuHeader.Next() = 0;

            //         Message('Completed');
            //     end;
            // }

            // action("Update sample req status")
            // {
            //     ApplicationArea = All;
            //     Image = AddAction;

            //     trigger OnAction()
            //     var
            //         samprec: Record "Sample Requsition Line";
            //         dtStart: Date;
            //     begin
            //         dtStart := DMY2DATE(24, 7, 2023);
            //         samprec.Reset();
            //         samprec.SetFilter("Created Date", '<%1', dtStart);
            //         samprec.FindSet();
            //         samprec.ModifyAll(Status, samprec.Status::Yes);
            //         Message('Completed');
            //     end;
            // }

            // action("Update WIP Qty")
            // {
            //     ApplicationArea = All;
            //     Image = AddAction;

            //     trigger OnAction()
            //     var

            //     begin
            //         Update_Sty_Master_PO();
            //         Message('Completed');
            //     end;
            // }


            // action("Remove Export Bank Ref Available Invoices")
            // {
            //     ApplicationArea = All;

            //     trigger OnAction()
            //     var
            //         ContractPostedRec: Record ContractPostedInvoices;
            //     begin
            //         ContractPostedRec.Reset();
            //         if ContractPostedRec.FindSet() then begin
            //             ContractPostedRec.DeleteAll();
            //             Message('Export Bank Ref Available Invoices Removed');
            //         end;

            //     end;
            // }
            // action("Reomove Request Approval")
            // {
            //     ApplicationArea = All;

            //     trigger OnAction()
            //     var
            //         ApprovalRec: Record "Approval Entry";
            //     begin
            //         ApprovalRec.Reset();
            //         ApprovalRec.SetRange("Document No.", ApprovalNo);
            //         ApprovalRec.SetRange(Status, ApprovalRec.Status::Open);
            //         ApprovalRec.SetRange("Document Type", ApprovalRec."Document Type"::Order);
            //         if ApprovalRec.FindSet() then begin
            //             ApprovalRec.DeleteAll();
            //             Message('Request Deleted');
            //         end;
            //     end;
            // }


            // action("Remove Assigned PI No")
            // {
            //     ApplicationArea = All;

            //     trigger OnAction()
            //     var
            //         PurchaseHeaderRec: Record "Purchase Header";
            //     begin

            //         PurchaseHeaderRec.Reset();
            //         PurchaseHeaderRec.SetRange("No.", PONo);
            //         if PurchaseHeaderRec.FindSet() then begin
            //             repeat
            //                 PurchaseHeaderRec."Assigned PI No." := '';
            //                 PurchaseHeaderRec.Modify();
            //             until PurchaseHeaderRec.Next() = 0;
            //             Message('Purchase Header Record Updated');
            //         end;
            //     end;
            // }

            // action("Brand Name Update In Sales Invoice Header")
            // {
            //     ApplicationArea = All;

            //     trigger OnAction()
            //     var
            //         SalesInvRec: Record "Sales Invoice Header";
            //         StyleRec: Record "Style Master";
            //     begin

            //         StyleRec.Reset();
            //         if StyleRec.FindSet() then begin
            //             repeat
            //                 SalesInvRec.Reset();
            //                 SalesInvRec.SetRange("Style Name", StyleRec."Style No.");
            //                 if SalesInvRec.FindSet() then begin
            //                     repeat
            //                         SalesInvRec."Brand Name" := StyleRec."Brand Name";
            //                         SalesInvRec.Modify();
            //                     until SalesInvRec.Next() = 0;
            //                 end;
            //             until StyleRec.Next() = 0;
            //             Message('Brand Name Updated');
            //         end;


            //     end;
            // }
            // action("Update Contract No ")
            // {
            //     ApplicationArea = All;

            //     trigger OnAction()
            //     var
            //         SaleIncRec: Record "Sales Invoice Header";
            //         LcRec: Record "Contract/LCMaster";
            //     begin
            //         SaleIncRec.Reset();
            //         LcRec.Reset();
            //         if LcRec.FindSet() then begin
            //             repeat
            //                 SaleIncRec.SetRange("Export Ref No.", LcRec."Contract No");
            //                 if SaleIncRec.FindSet() then begin
            //                     repeat
            //                         SaleIncRec."Contract No" := SaleIncRec."Export Ref No.";
            //                         SaleIncRec.Modify();
            //                     until SaleIncRec.Next() = 0;
            //                 end;
            //             until LcRec.Next() = 0;
            //         end;

            //         SaleIncRec.Reset();
            //         LcRec.Reset();
            //         if LcRec.FindSet() then begin
            //             repeat
            //                 SaleIncRec.SetRange("Export Ref No.", LcRec."Contract No");
            //                 if SaleIncRec.FindSet() then begin
            //                     repeat
            //                         SaleIncRec."Export Ref No." := '';
            //                         SaleIncRec.Modify();
            //                     until SaleIncRec.Next() = 0;
            //                 end;
            //             until LcRec.Next() = 0;
            //         end;

            //         Message('Contract No Updated');
            //     end;
            // }

            // action("remove value Export Reference")
            // {
            //     ApplicationArea = All;

            //     trigger OnAction()
            //     var
            //         SalesInvRec: Record "Sales Invoice Header";
            //     begin
            //         SalesInvRec.Reset();
            //         SalesInvRec.SetRange("No.", ExportRefNo);
            //         SalesInvRec.FindSet();
            //         SalesInvRec.ModifyAll("Export Ref No.", '');
            //         Message('Export Ref No Removed');

            //     end;
            // }

            // action("Remove Export Ref No. From Sales Invoice")
            // {
            //     ApplicationArea = All;

            //     trigger OnAction()
            //     var
            //         ExportReferenceHeaderRec: Record ExportReferenceHeader;
            //         SalesInvRec: Record "Sales Invoice Header";
            //     begin

            //         SalesInvRec.Reset();
            //         if SalesInvRec.FindSet() then begin
            //             repeat
            //                 ExportReferenceHeaderRec.Reset();
            //                 ExportReferenceHeaderRec.SetRange("Invoice No", SalesInvRec."No.");
            //                 if not ExportReferenceHeaderRec.FindSet() then begin
            //                     SalesInvRec."Export Ref No." := '';
            //                     SalesInvRec.Modify();
            //                 end;
            //             until SalesInvRec.Next() = 0;
            //         end;
            //     end;
            // }


            // action("Remove value from Purchase Header")
            // {
            //     ApplicationArea = All;
            //     Image = Add;
            //     trigger OnAction()
            //     var
            //         PurchaseRec: Record "Purchase Header";
            //     begin
            //         PurchaseRec.Reset();
            //         PurchaseRec.SetRange("No.", PurchaseNo);
            //         if PurchaseRec.FindSet() then begin
            //             PurchaseRec.ModifyAll("Assigned PI No.", '');
            //             PurchaseRec.ModifyAll(Status, PurchaseRec.Status::Released);
            //             Message('Purchase Header Record Updated');
            //         end;
            //     end;
            // }
            // action("Remove Contract Style Contract No")
            // {
            //     ApplicationArea = All;

            //     trigger OnAction()
            //     var
            //         ContractStyleRec: Record "Contract/LCStyle";
            //     begin
            //         ContractStyleRec.Reset();
            //         ContractStyleRec.SetRange("No.", '00392');
            //         if ContractStyleRec.FindSet() then begin
            //             ContractStyleRec.DeleteAll();
            //             Message('00392 Record deleted');
            //         end;

            //     end;

            // }

            // action("Order Qty Update NB")
            // {
            //     ApplicationArea = All;

            //     trigger OnAction()
            //     var
            //         NewBreackDownTec: Record "New Breakdown";
            //         NewBreackDown2Tec: Record "New Breakdown";
            //         StyleMsterRec: Record "Style Master";
            //     begin

            //         NewBreackDown2Tec.Reset();
            //         NewBreackDownTec.Reset();

            //         if NewBreackDownTec.FindFirst() then begin
            //             repeat

            //                 NewBreackDown2Tec.SetRange("Style No.", NewBreackDownTec."Style No.");

            //                 if NewBreackDown2Tec.FindSet() then begin
            //                     StyleMsterRec.Reset();
            //                     StyleMsterRec.SetRange("Style No.", NewBreackDown2Tec."Style Name");
            //                     if StyleMsterRec.FindSet() then begin
            //                         NewBreackDown2Tec."Order Qty" := StyleMsterRec."Order Qty";
            //                         NewBreackDown2Tec.Modify(true);
            //                     end;
            //                 end;
            //             until NewBreackDownTec.Next() = 0;
            //         end;
            //     end;
            // }
            action("Remove Reservation Entry Records")
            {
                ApplicationArea = All;
                Image = RemoveLine;

                trigger OnAction()
                var
                    ReseveRec: Record "Reservation Entry";
                begin

                    ReseveRec.Reset();
                    ReseveRec.SetRange("Source ID", 'AFL-PO-02209');
                    if ReseveRec.FindSet() then begin
                        ReseveRec.DeleteAll();
                        Message('AFL-PO-02209 Record deleted');
                    end;
                end;

            }
            action("Remove minus Planned Qty in wip")
            {
                ApplicationArea = All;
                Image = AddAction;

                trigger OnAction()
                var
                    Sty: Record "Style Master PO";
                begin
                    Sty.Reset();
                    Sty.SetFilter(PlannedQty, '<%1', 0);
                    if Sty.FindSet() then
                        Sty.ModifyAll(PlannedQty, 0);

                    Message('Completed');
                end;
            }

            action("Remove minus Target qty in planned detail")
            {
                ApplicationArea = All;
                Image = AddAction;

                trigger OnAction()
                var
                    NavApp: Record "NavApp Prod Plans Details";
                begin
                    NavApp.Reset();
                    NavApp.SetFilter(Qty, '<%1', 0);
                    NavApp.SetFilter(ProdUpd, '=%1', 0);
                    if NavApp.FindSet() then
                        NavApp.DeleteAll();

                    Message('Completed');
                end;
            }

            action("PO Allocation Remove(Washing)")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    PendingAllocationWashRec: Record PendingAllocationWash;
                    WashingMasterRec: Record WashingMaster;
                begin

                    WashingMasterRec.Reset();
                    if WashingMasterRec.FindSet() then
                        WashingMasterRec.DeleteAll(true);

                    PendingAllocationWashRec.Reset();
                    if PendingAllocationWashRec.FindSet() then
                        PendingAllocationWashRec.DeleteAll(true);

                end;
            }

            // action("Update BundleGuideNo in Laysheet")
            // {
            //     ApplicationArea = All;

            //     trigger OnAction()
            //     var
            //         Bundle: Record BundleGuideHeader;
            //         LaySheetHeader: Record LaySheetHeader;
            //     begin
            //         Bundle.Reset();
            //         if Bundle.FindSet() then begin
            //             repeat
            //                 if Bundle."LaySheetNo." <> '' then begin
            //                     LaySheetHeader.Reset();
            //                     LaySheetHeader.SetRange("LaySheetNo.", Bundle."LaySheetNo.");
            //                     if LaySheetHeader.FindSet() then begin
            //                         repeat
            //                             LaySheetHeader."BundleGuideNo." := Bundle."BundleGuideNo.";
            //                             LaySheetHeader.Modify();
            //                         until LaySheetHeader.Next() = 0;
            //                     end;
            //                 end;
            //             until Bundle.Next() = 0;
            //             Message('completed');
            //         end;
            //     end;
            // }

            // action("Style no update in Sales Invoice Header")
            // {
            //     ApplicationArea = All;

            //     trigger OnAction()
            //     var
            //         SalesInvRec: Record "Sales Invoice Header";
            //         StyleRec: Record "Style Master";
            //     begin
            //         SalesInvRec.Reset();
            //         SalesInvRec.SetFilter("Style No", '=%1', '');
            //         if SalesInvRec.FindSet() then begin
            //             repeat
            //                 Stylerec.Reset();
            //                 Stylerec.SetRange("Style No.", SalesInvRec."Style Name");
            //                 if Stylerec.FindSet() then begin
            //                     SalesInvRec."Style No" := Stylerec."No.";
            //                     SalesInvRec.Modify();
            //                 end
            //             until SalesInvRec.Next() = 0;
            //         end;
            //         Message('Completed');
            //     end;
            // }

            // action("update contract sys no in b2b master")
            // {
            //     ApplicationArea = All;
            //     Image = AddAction;

            //     trigger OnAction()
            //     var
            //         B2BLCMaster: Record B2BLCMaster;
            //         "ContLCMasRec": Record "Contract/LCMaster";
            //     begin
            //         B2BLCMaster.Reset();
            //         if B2BLCMaster.FindSet() then begin
            //             repeat
            //                 ContLCMasRec.Reset();
            //                 ContLCMasRec.SetRange("Contract No", B2BLCMaster."LC/Contract No.");
            //                 if ContLCMasRec.FindSet() then begin
            //                     B2BLCMaster."Contract Sys No." := ContLCMasRec."No.";
            //                     B2BLCMaster.Modify();
            //                 end;
            //             until B2BLCMaster.Next() = 0;
            //         end;

            //         Message('Completed');
            //     end;
            // }

            // action("update GIT LC balance value")
            // {
            //     ApplicationArea = All;
            //     Image = AddAction;

            //     trigger OnAction()
            //     var
            //         GITBaseonLCRec: Record GITBaseonLC;
            //         GITRec: Record GITBaseonLC;
            //         Tot: Decimal;
            //     begin
            //         GITBaseonLCRec.Reset();
            //         if GITBaseonLCRec.FindSet() then
            //             repeat
            //                 GITRec.Reset();
            //                 GITRec.SetRange("B2B LC No.", GITBaseonLCRec."B2B LC No.");
            //                 if GITRec.FindSet() then begin
            //                     repeat
            //                         tot += GITRec."Invoice Value";
            //                     until GITRec.Next() = 0;
            //                 end;
            //                 GITBaseonLCRec."B2B LC Balance" := GITBaseonLCRec."B2B LC Value" - Tot;
            //                 GITBaseonLCRec.Modify();
            //             until GITBaseonLCRec.Next() = 0;
            //     end;
            // }

            // action("Remove navapp plan/Prod from board")
            // {
            //     ApplicationArea = All;
            //     Image = AddAction;

            //     trigger OnAction()
            //     var
            //         NavApp: Record "NavApp Planning Lines";
            //         NavAppprod: Record "NavApp Prod Plans Details";
            //     begin
            //         NavApp.Reset();
            //         NavApp.SetRange("Line No.", 3162);
            //         if NavApp.FindSet() then
            //             NavApp.Delete();

            //         NavAppprod.Reset();
            //         NavAppprod.SetRange("Line No.", 3162);
            //         if NavAppprod.FindSet() then
            //             NavAppprod.DeleteAll();

            //         Message('Completed');
            //     end;
            // }

            // action("remove contarct/style")
            // {
            //     ApplicationArea = All;
            //     Image = AddAction;

            //     trigger OnAction()
            //     var
            //         ContractLCStyle: Record "Contract/LCStyle";
            //     begin
            //         ContractLCStyle.Reset();
            //         ContractLCStyle.SetRange("No.", contractNo);
            //         if ContractLCStyle.FindSet() then
            //             ContractLCStyle.DeleteAll();

            //         Message('Completed');
            //     end;
            // }  

            // action("Update AC Shipped Qty")
            // {
            //     ApplicationArea = All;
            //     Image = AddAction;

            //     trigger OnAction()
            //     var
            //         SalesInvoiceheader: Record "Sales Invoice Header";
            //         SalesInvoiceLineRec: Record "Sales Invoice Line";
            //         SatylemsterPORec: Record "Style Master PO";
            //         ShippedQty: BigInteger;
            //     begin

            //         SalesInvoiceheader.Reset();
            //         if SalesInvoiceheader.FindSet() then begin
            //             repeat


            //                 SalesInvoiceLineRec.SetRange("Document No.", SalesInvoiceheader."No.");

            //                 if SalesInvoiceLineRec.FindSet() then begin
            //                     ShippedQty := 0;
            //                     repeat

            //                         ShippedQty += SalesInvoiceLineRec.Quantity;

            //                     until SalesInvoiceLineRec.Next() = 0;

            //                     SatylemsterPORec.Reset();
            //                     SatylemsterPORec.SetRange("Style No.", SalesInvoiceheader."Style No");
            //                     SatylemsterPORec.SetRange("PO No.", SalesInvoiceheader."PO No");
            //                     SatylemsterPORec.SetRange("Lot No.", SalesInvoiceheader.Lot);

            //                     if SatylemsterPORec.FindSet() then begin
            //                         SatylemsterPORec."Actual Shipment Qty" := SatylemsterPORec."Actual Shipment Qty" + ShippedQty;
            //                         SatylemsterPORec.Modify();
            //                     end;
            //                 end;

            //             until SalesInvoiceheader.Next() = 0;
            //         end;

            //         Message('Completed');
            //     end;
            // }
        }
    }


    // procedure Update_Sty_Master_PO()
    // var
    //     StyleMasterRec: Record "Style Master";
    //     StyleMasterPORec: Record "Style Master PO";
    //     StyleMasterPO1Rec: Record "Style Master PO";
    //     ProductionOutLine: Record ProductionOutLine;
    //     LineTotal: BigInteger;
    // begin

    //     if (In_Out <> 'IN') and (In_Out <> 'OUT') then
    //         Error('Invalid In Out Type');

    //     StyleMasterRec.Reset();
    //     if StyleMasterRec.FindSet() then begin
    //         repeat
    //             StyleMasterPORec.Reset();
    //             StyleMasterPORec.SetRange("Style No.", StyleMasterRec."No.");
    //             if StyleMasterPORec.FindSet() then begin
    //                 repeat
    //                     LineTotal := 0;
    //                     //Get out Total
    //                     ProductionOutLine.Reset();
    //                     ProductionOutLine.SetRange("Style No.", StyleMasterRec."No.");
    //                     ProductionOutLine.SetRange("Lot No.", StyleMasterPORec."Lot No.");
    //                     ProductionOutLine.SetRange(Type, Type1);
    //                     ProductionOutLine.SetRange(In_Out, In_Out);

    //                     if ProductionOutLine.FindSet() then begin
    //                         repeat
    //                             if ProductionOutLine."Colour No" <> '*' then
    //                                 LineTotal += ProductionOutLine.Total;
    //                         until ProductionOutLine.Next() = 0;
    //                     end;

    //                     StyleMasterPO1Rec.Reset();
    //                     StyleMasterPO1Rec.SetRange("Style No.", StyleMasterRec."No.");
    //                     StyleMasterPO1Rec.SetRange("Lot No.", StyleMasterPORec."Lot No.");
    //                     if StyleMasterPO1Rec.FindSet() then begin

    //                         if Type1 = Type1::Saw then BEGIN
    //                             if In_Out = 'IN' then
    //                                 StyleMasterPO1Rec.ModifyAll("Sawing In Qty", LineTotal)
    //                             else
    //                                 if In_Out = 'OUT' then
    //                                     StyleMasterPO1Rec.ModifyAll("Sawing Out Qty", LineTotal);
    //                         END;


    //                         if Type1 = Type1::Wash then begin
    //                             if In_Out = 'IN' then
    //                                 StyleMasterPO1Rec.ModifyAll("Wash In Qty", LineTotal)
    //                             else
    //                                 if In_Out = 'OUT' then
    //                                     StyleMasterPO1Rec.ModifyAll("Wash Out Qty", LineTotal);
    //                         end;


    //                         if Type1 = Type1::Cut then begin
    //                             StyleMasterPO1Rec.ModifyAll("Cut Out Qty", LineTotal);
    //                         end;


    //                         if Type1 = Type1::Emb then begin
    //                             if In_Out = 'IN' then
    //                                 StyleMasterPO1Rec.ModifyAll("Emb In Qty", LineTotal)
    //                             else
    //                                 if In_Out = 'OUT' then
    //                                     StyleMasterPO1Rec.ModifyAll("Emb Out Qty", LineTotal);
    //                         end;


    //                         if Type1 = Type1::Print then begin
    //                             if In_Out = 'IN' then
    //                                 StyleMasterPO1Rec.ModifyAll("Print In Qty", LineTotal)
    //                             else
    //                                 if In_Out = 'OUT' then
    //                                     StyleMasterPO1Rec.ModifyAll("print Out Qty", LineTotal);
    //                         end;


    //                         if Type1 = Type1::Fin then begin
    //                             StyleMasterPO1Rec.ModifyAll("Finish Qty", LineTotal);
    //                         end;


    //                         if Type1 = Type1::Ship then BEGIN
    //                             begin
    //                                 StyleMasterPO1Rec.ModifyAll("Shipped Qty", LineTotal);
    //                             end;
    //                         END;

    //                     end;

    //                 until StyleMasterPORec.Next() = 0;
    //             end;
    //         until StyleMasterRec.Next() = 0;
    //     end;
    // end;


    var

        ApprovalNo: Code[20];
        PONo: Code[20];
        PurchaseNo: Code[20];
        ExportRefNo: Code[50];
        Password: Text[50];
        contractNo: Text[50];

}