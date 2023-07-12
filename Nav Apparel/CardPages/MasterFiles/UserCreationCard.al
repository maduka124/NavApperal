page 50978 "Create User Card"
{
    PageType = Card;
    SourceTable = LoginDetails;
    Caption = 'User Creation';
    //AutoSplitKey = true;
    // Permissions = tabledata "Purch. Rcpt. Line" = rmID;
    // Permissions = tabledata "Purch. Rcpt. Line" = rmID;
    // Permissions = tabledata "Purchase Line" = rmID;
    // Permissions = tabledata "Sales Invoice Header" = rmID;
    Permissions = tabledata "Purchase Header" = RIMD;

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
            }
        }
    }

    actions
    {


        area(Processing)
        {
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

            action("Remove Assigned PI No")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    PurchaseHeaderRec: Record "Purchase Header";
                begin

                    PurchaseHeaderRec.Reset();
                    PurchaseHeaderRec.SetRange("No.", PONo);
                    if PurchaseHeaderRec.FindSet() then begin
                        repeat
                            PurchaseHeaderRec."Assigned PI No." := '';
                            PurchaseHeaderRec.Modify();
                        until PurchaseHeaderRec.Next() = 0;
                        Message('Purchase Header Record Updated');
                    end;
                end;
            }
            action("Brand Name Update In Sales Invoice Header")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    SalesInvRec: Record "Sales Invoice Header";
                    StyleRec: Record "Style Master";
                begin

                    StyleRec.Reset();
                    if StyleRec.FindSet() then begin
                        repeat
                            SalesInvRec.Reset();
                            SalesInvRec.SetRange("Style Name", StyleRec."Style No.");
                            if SalesInvRec.FindSet() then begin
                                repeat
                                    SalesInvRec."Brand Name" := StyleRec."Brand Name";
                                    SalesInvRec.Modify();
                                until SalesInvRec.Next() = 0;
                            end;
                        until StyleRec.Next() = 0;
                        Message('Brand Name Updated');
                    end;


                end;
            }
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
            action("remove value Export Reference")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    SalesInvRec: Record "Sales Invoice Header";
                begin
                    SalesInvRec.Reset();
                    SalesInvRec.SetRange("No.", ExportRefNo);
                    SalesInvRec.FindSet();
                    SalesInvRec.ModifyAll("Export Ref No.", '');
                    Message('Export Ref No Removed');

                end;
            }

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
            // action("Remove minus Planned Qty")
            // {
            //     ApplicationArea = All;
            //     Image = AddAction;

            //     trigger OnAction()
            //     var
            //         Sty: Record "Style Master PO";
            //     begin
            //         Sty.Reset();
            //         Sty.SetFilter(PlannedQty, '<%1', 0);
            //         Sty.FindSet();
            //         Sty.ModifyAll(PlannedQty, 0);
            //         Message('Completed');
            //     end;
            // }


            // action("update prod update status")
            // {
            //     ApplicationArea = All;
            //     Image = AddAction;

            //     trigger OnAction()
            //     var
            //         Prodout: Record ProductionOutHeader;
            //         dtStart: Date;
            //     begin
            //         dtStart := DMY2DATE(2, 5, 2023);
            //         Prodout.Reset();
            //         Prodout.SetRange("Prod Date", dtStart);
            //         Prodout.FindSet();
            //         Prodout.ModifyAll("Prod Updated", 0);


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
        PONo: Code[20];
        PurchaseNo: Code[20];
        ExportRefNo: Code[50];
        Password: Text[50];
        contractNo: Text[50];

}