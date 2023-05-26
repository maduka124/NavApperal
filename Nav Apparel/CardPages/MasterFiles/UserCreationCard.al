page 50978 "Create User Card"
{
    PageType = Card;
    SourceTable = LoginDetails;
    Caption = 'User Creation';
    //AutoSplitKey = true;
    // Permissions = tabledata "Purch. Rcpt. Line" = rmID;
    Permissions = tabledata "Purch. Rcpt. Line" = rmID;
    // Permissions = tabledata "Purchase Line" = rmID;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Type1; Type1)
                {
                    ApplicationArea = All;
                }

                field(In_Out; In_Out)
                {
                    ApplicationArea = All;
                }

                field(contractNo; contractNo)
                {
                    ApplicationArea = All;
                }

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
                    Caption = 'Export Ref No';
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


            action("remove value Export Reference")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    SalesInvRec: Record "Sales Invoice Header";
                begin
                    SalesInvRec.Reset();
                    SalesInvRec.SetRange("No.", ExportRefNo);
                    if SalesInvRec.FindSet() then begin
                        // SalesInvRec."Export Ref No." := '';
                        SalesInvRec.ModifyAll("Export Ref No.", '');
                        Message('Export Ref No Removed');
                    end;
                end;
            }
            action("Remove minus Planned Qty")
            {
                ApplicationArea = All;
                Image = AddAction;

                trigger OnAction()
                var
                    Sty: Record "Style Master PO";
                begin
                    Sty.Reset();
                    Sty.SetFilter(PlannedQty, '<%1', 0);
                    Sty.FindSet();
                    Sty.ModifyAll(PlannedQty, 0);
                    Message('Completed');
                end;
            }







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

            // action("remove navapp plan/Prod")
            // {
            //     ApplicationArea = All;
            //     Image = AddAction;

            //     trigger OnAction()
            //     var
            //         NavApp: Record "NavApp Planning Lines";
            //         NavAppprod: Record "NavApp Prod Plans Details";
            //     begin
            //         NavApp.Reset();
            //         NavApp.SetRange("Style No.", '02367');
            //         if NavApp.FindSet() then
            //             NavApp.Delete();

            //         NavAppprod.Reset();
            //         NavAppprod.SetRange("Style No.", '02367');
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


            // action("delete daily sewing")
            // {
            //     ApplicationArea = All;
            //     Image = AddAction;

            //     trigger OnAction()
            //     var
            //         ProductionOutHeader: Record ProductionOutHeader;
            //     begin
            //         ProductionOutHeader.Reset();
            //         ProductionOutHeader.SetFilter(Type, '=%1', ProductionOutHeader.Type::Saw);
            //         ProductionOutHeader.SetRange("No.", 139);
            //         if ProductionOutHeader.FindSet() then
            //             ProductionOutHeader.DeleteAll();

            //         Message('Completed');
            //     end;
            // }


            // action("Update Prod Status")
            // {
            //     ApplicationArea = All;
            //     Image = AddAction;

            //     trigger OnAction()
            //     var
            //         ProductionOutHeader: Record ProductionOutHeader;
            //     begin
            //         ProductionOutHeader.Reset();
            //         ProductionOutHeader.SetRange("No.", 175);
            //         if ProductionOutHeader.FindSet() then
            //             ProductionOutHeader.ModifyAll("Prod Updated", 1);

            //         Message('Completed');
            //     end;
            // }

            // actions


            // action("remove Export Reference No")
            // {
            //     ApplicationArea = All;
            //     Image = RemoveLine;


            //     trigger OnAction()
            //     var
            //         SalesInvRec: Record "Sales Invoice Header";
            //     begin
            //         SalesInvRec.Reset();
            //         SalesInvRec.FindSet();
            //         repeat
            //             SalesInvRec."Export Ref No." := '';
            //             SalesInvRec.Modify();
            //         until SalesInvRec.Next() = 0;
            //         Message('Completed');
            //     end;
            // }

            //Done By Sachith 20/04/23
            // action("Update Colors")
            // {
            //     ApplicationArea = all;

            //     trigger OnAction()
            //     var
            //         PurchRcptLine: Record "Purch. Rcpt. Line";
            //         ItemRec: Record Item;
            //     begin

            //         PurchRcptLine.Reset();
            //         if PurchRcptLine.FindSet() then begin
            //             repeat
            //                 if PurchRcptLine."Color No." = '' then begin

            //                     // ItemRec.Reset();
            //                     // if ItemRec.FindSet() then begin
            //                     //     repeat
            //                     //         if PurchRcptLine."No." = ItemRec."No." then begin
            //                     //             PurchRcptLine."Color No." := ItemRec."Color No.";
            //                     //             PurchRcptLine."Color Name" := ItemRec."Color Name";
            //                     //             PurchRcptLine.Modify()
            //                     //         end;
            //                     //     until ItemRec.Next() = 0;
            //                     // end;


            //                     ItemRec.Reset();
            //                     ItemRec.SetRange("No.", PurchRcptLine."No.");
            //                     if ItemRec.FindFirst() then begin
            //                         PurchRcptLine."Color No." := ItemRec."Color No.";
            //                         PurchRcptLine."Color Name" := ItemRec."Color Name";
            //                         PurchRcptLine.Modify()
            //                     end;

            //                 end;
            //             until PurchRcptLine.Next() = 0;
            //             Message('Colors updated');
            //         end;
            //     end;
            // }

            //Done By Sachith on 21/04/23
            // action("PO Line vendor Add")
            // {
            //     ApplicationArea = All;

            //     trigger OnAction()
            //     var
            //         VendorRec: Record Vendor;
            //         PolineRec: Record "Purchase Line";
            //     begin

            //         PolineRec.Reset();
            //         PolineRec.SetFilter("Document Type", '=%1', PolineRec."Document Type"::Order);
            //         if PolineRec.FindSet() then begin
            //             repeat
            //                 if PolineRec."Buy-from Vendor No." <> '' then begin
            //                     VendorRec.Reset();
            //                     VendorRec.SetRange("No.", PolineRec."Buy-from Vendor No.");

            //                     if VendorRec.FindSet() then begin
            //                         if PolineRec."Buy From Vendor Name" = '' then begin
            //                             PolineRec."Buy From Vendor Name" := VendorRec.Name;
            //                             PolineRec.Modify();
            //                         end;
            //                     end;
            //                 end;
            //             until PolineRec.Next() = 0;
            //         end;
            //     end;
            // }


            // action("Update Main Category Mater Categeory Name")
            // {
            //     ApplicationArea = All;
            //     Image = RemoveLine;


            //     trigger OnAction()
            //     var
            //         // MasterCatRec: Record "Master Category";
            //         MainCat: Record "Main Category";
            //     begin

            //         MainCat.Reset();
            //         MainCat.FindSet();

            //         repeat
            //             if MainCat."Master Category Name" = 'SEWING TRIM' then begin

            //                 MainCat."Master Category Name" := 'SEWING TRIMS';
            //                 MainCat.Modify();

            //             end;
            //         until MainCat.Next() = 0;

            //         Message('Completed');
            //     end;
            // }

            //Done By Sachith on 03/05/23
            // action("Update Fabric PO In GRN")
            // {
            //     ApplicationArea = All;

            //     trigger OnAction()
            //     var
            //         GRNHeaderRec: Record "Purch. Rcpt. Header";
            //         GRNLineRec: Record "Purch. Rcpt. Line";
            //         ItemRec: Record Item;
            //     begin

            //         GRNHeaderRec.Reset();
            //         if GRNHeaderRec.FindSet() then begin
            //             repeat

            //                 GRNLineRec.Reset();
            //                 GRNLineRec.SetRange("Document No.", GRNHeaderRec."No.");

            //                 if GRNLineRec.FindSet() then begin
            //                     repeat

            //                         ItemRec.Reset();
            //                         ItemRec.SetRange("No.", GRNLineRec."No.");

            //                         if ItemRec.FindSet() then begin
            //                             if ItemRec."Main Category Name" = 'FABRIC' then begin
            //                                 GRNHeaderRec.FabricPO := true;
            //                                 GRNHeaderRec.Modify();
            //                             end
            //                         end;

            //                     until GRNLineRec.Next() = 0;
            //                 end;

            //             until GRNHeaderRec.Next() = 0;
            //         end;
            //     end;
            // }

            // Done By sachith on 15/05/23
            action("UpDate Sample Req Line Group HD")
            {
                ApplicationArea = All;
                Caption = 'Update Group Head';

                trigger OnAction()
                var
                    SampleReqHeaderRec: Record "Sample Requsition Header";
                    SampleReqLinRec: REcord "Sample Requsition Line";
                begin

                    SampleReqHeaderRec.Reset();

                    if SampleReqHeaderRec.FindFirst() then begin
                        repeat

                            SampleReqLinRec.Reset();
                            SampleReqLinRec.SetRange("No.", SampleReqHeaderRec."No.");

                            if SampleReqLinRec.FindFirst() then begin
                                SampleReqLinRec."Group Head" := SampleReqHeaderRec."Group HD";
                                SampleReqLinRec.Modify();
                            end;

                        until SampleReqHeaderRec.Next() = 0;
                    end;
                end;
            }
        }
    }


    procedure Update_Sty_Master_PO()
    var
        StyleMasterRec: Record "Style Master";
        StyleMasterPORec: Record "Style Master PO";
        StyleMasterPO1Rec: Record "Style Master PO";
        ProductionOutLine: Record ProductionOutLine;
        LineTotal: BigInteger;
    begin

        if (In_Out <> 'IN') and (In_Out <> 'OUT') then
            Error('Invalid In Out Type');

        StyleMasterRec.Reset();
        if StyleMasterRec.FindSet() then begin
            repeat
                StyleMasterPORec.Reset();
                StyleMasterPORec.SetRange("Style No.", StyleMasterRec."No.");
                if StyleMasterPORec.FindSet() then begin
                    repeat
                        LineTotal := 0;
                        //Get out Total
                        ProductionOutLine.Reset();
                        ProductionOutLine.SetRange("Style No.", StyleMasterRec."No.");
                        ProductionOutLine.SetRange("Lot No.", StyleMasterPORec."Lot No.");
                        ProductionOutLine.SetRange(Type, Type1);
                        ProductionOutLine.SetRange(In_Out, In_Out);

                        if ProductionOutLine.FindSet() then begin
                            repeat
                                if ProductionOutLine."Colour No" <> '*' then
                                    LineTotal += ProductionOutLine.Total;
                            until ProductionOutLine.Next() = 0;
                        end;

                        StyleMasterPO1Rec.Reset();
                        StyleMasterPO1Rec.SetRange("Style No.", StyleMasterRec."No.");
                        StyleMasterPO1Rec.SetRange("Lot No.", StyleMasterPORec."Lot No.");
                        if StyleMasterPO1Rec.FindSet() then begin

                            if Type1 = Type1::Saw then BEGIN
                                if In_Out = 'IN' then
                                    StyleMasterPO1Rec.ModifyAll("Sawing In Qty", LineTotal)
                                else
                                    if In_Out = 'OUT' then
                                        StyleMasterPO1Rec.ModifyAll("Sawing Out Qty", LineTotal);
                            END;


                            if Type1 = Type1::Wash then begin
                                if In_Out = 'IN' then
                                    StyleMasterPO1Rec.ModifyAll("Wash In Qty", LineTotal)
                                else
                                    if In_Out = 'OUT' then
                                        StyleMasterPO1Rec.ModifyAll("Wash Out Qty", LineTotal);
                            end;


                            if Type1 = Type1::Cut then begin
                                StyleMasterPO1Rec.ModifyAll("Cut Out Qty", LineTotal);
                            end;


                            if Type1 = Type1::Emb then begin
                                if In_Out = 'IN' then
                                    StyleMasterPO1Rec.ModifyAll("Emb In Qty", LineTotal)
                                else
                                    if In_Out = 'OUT' then
                                        StyleMasterPO1Rec.ModifyAll("Emb Out Qty", LineTotal);
                            end;


                            if Type1 = Type1::Print then begin
                                if In_Out = 'IN' then
                                    StyleMasterPO1Rec.ModifyAll("Print In Qty", LineTotal)
                                else
                                    if In_Out = 'OUT' then
                                        StyleMasterPO1Rec.ModifyAll("print Out Qty", LineTotal);
                            end;


                            if Type1 = Type1::Fin then begin
                                StyleMasterPO1Rec.ModifyAll("Finish Qty", LineTotal);
                            end;


                            if Type1 = Type1::Ship then BEGIN
                                begin
                                    StyleMasterPO1Rec.ModifyAll("Shipped Qty", LineTotal);
                                end;
                            END;

                        end;

                    until StyleMasterPORec.Next() = 0;
                end;
            until StyleMasterRec.Next() = 0;
        end;
    end;


    var
        ExportRefNo: Code[50];
        Password: Text[50];
        contractNo: Text[50];
        Type1: Option Saw,Cut,Wash,Emb,Print,Fin,Ship;
        In_Out: code[10];

}