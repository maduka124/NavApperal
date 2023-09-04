page 51328 OMSList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = OMS;
    SourceTableView = where("Lc Contract No" = filter(<> ''));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Lc Contract No"; Rec."Lc Contract No")
                {
                    ApplicationArea = All;
                }

                field(Store; Rec.Store)
                {
                    ApplicationArea = All;
                }

                field(Season; Rec.Season)
                {
                    ApplicationArea = All;
                }

                field(Brand; Rec.Brand)
                {
                    ApplicationArea = All;
                }

                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }

                field(Buyer; Rec.Buyer)
                {
                    ApplicationArea = All;
                }

                field("Merchandizer Group Head"; Rec."Merchandizer Group Head")
                {
                    ApplicationArea = All;
                }

                field("Style No"; Rec."Style No")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Style Des"; Rec."Style Des")
                {
                    ApplicationArea = All;
                }

                field(Factory; Rec.Factory)
                {
                    ApplicationArea = All;
                }

                field("Order Qty"; Rec."Order Qty")
                {
                    ApplicationArea = All;
                }

                field(Lot; Rec.Lot)
                {
                    ApplicationArea = All;
                }

                field("PO No"; Rec."PO No")
                {
                    ApplicationArea = All;
                }

                field(Mode; Rec.Mode)
                {
                    ApplicationArea = All;
                }

                field("Po Qty"; Rec."Po Qty")
                {
                    ApplicationArea = All;
                }

                field("Cut Qty"; Rec."Cut Qty")
                {
                    ApplicationArea = All;
                }

                field("EMB OUT"; Rec."EMB OUT")
                {
                    ApplicationArea = All;
                }

                field("EMB IN"; Rec."EMB IN")
                {
                    ApplicationArea = All;
                }

                field("Print OUT"; Rec."Print OUT")
                {
                    ApplicationArea = All;
                }

                field("Print IN"; Rec."Print IN")
                {
                    ApplicationArea = All;
                }

                field("Line IN"; Rec."Line IN")
                {
                    ApplicationArea = All;
                }

                field("Line OUT"; Rec."Line OUT")
                {
                    ApplicationArea = All;                    
                }

                field("Wash OUT"; Rec."Wash OUT")
                {
                    ApplicationArea = All;
                }

                field("Wash IN"; Rec."Wash IN")
                {
                    ApplicationArea = All;
                }

                field("Poly OUT"; Rec."Poly OUT")
                {
                    ApplicationArea = All;                    
                }

                field("Ship Qty"; Rec."Ship Qty")
                {
                    ApplicationArea = All;                    
                }

                field("Ship Date"; Rec."Ship Date")
                {
                    ApplicationArea = All;
                }

                field(FOB; Rec.FOB)
                {
                    ApplicationArea = All;
                }

                field("EXP QTY"; Rec."EXP QTY")
                {
                    ApplicationArea = All;
                }

                field("EX Date"; Rec."EX Date")
                {
                    ApplicationArea = All;
                }

                field("EX Short"; Rec."EX Short")
                {
                    ApplicationArea = All;
                }

                field("Ship Value"; Rec."Ship Value")
                {
                    ApplicationArea = All;
                }

                field("Comm Cash"; Rec."Comm Cash")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Comm Lc"; Rec."Comm Lc")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }


    trigger OnOpenPage()
    var
        ProdRec: Record ProductionOutHeader;
        StylePoRec1: Record "Style Master PO";
        OMSRec: Record OMS;
        CustomerRec: Record Customer;
        MerchantRec: Record MerchandizingGroupTable;
        SalesInvoiceLineRec: Record "Sales Invoice Line";
        BankRefColRec: Record BankRefCollectionHeader;
        BankRefHRec: Record BankReferenceHeader;
        SalesInvRec: Record "Sales Invoice Header";
        BomEstimateRec: Record "BOM Estimate Cost";
        LcRec: Record "Contract/LCMaster";
        StyleRec: Record "Style Master";
        StylePoRec: Record "Style Master PO";
        ContractStyleRec: Record "Contract/LCStyle";
        LoginRec: Page "Login Card";
        //LoginSessionsRec: Record LoginSessions;
        UserRec: Record "User Setup";
        MaxSeqNo: BigInteger;
        ShQty: Decimal;
        POQtyTot: BigInteger;
    begin
        ShQty := 0;
        POQtyTot := 0;       

        OMSRec.Reset();
        if OMSRec.FindSet() then begin
            OMSRec.DeleteAll();
        end;

        //Get Max Seq No
        OMSRec.Reset();
        if OMSRec.FindLast() then
            MaxSeqNo := OMSRec."Seq No";

        StyleRec.Reset();
        StyleRec.SetRange(Status, StyleRec.Status::Confirmed);
        if StyleRec.FindSet() then begin
            repeat
                StylePoRec.Reset();
                StylePoRec.SetRange("Style No.", StyleRec."No.");
                if StylePoRec.FindSet() then begin
                    repeat
                        MaxSeqNo += 1;
                        OMSRec.Init();
                        OMSRec."Seq No" := MaxSeqNo;

                        LcRec.Reset();
                        LcRec.SetRange("No.", StyleRec.AssignedContractNo);
                        if LcRec.FindSet() then begin
                            OMSRec."Lc Contract No" := LcRec."Contract No";
                            OMSRec.Season := StyleRec."Season Name";
                            OMSRec.Store := StyleRec."Store Name";
                            OMSRec.Buyer := StyleRec."Buyer Name";
                            OMSRec."Style No" := StyleRec."No.";
                            OMSRec."Style Des" := StyleRec."Style No.";
                            OMSRec."Order Qty" := StyleRec."Order Qty";
                            OMSRec.Brand := StyleRec."Brand Name";

                            CustomerRec.Reset();
                            CustomerRec.SetRange(Name, StyleRec."Buyer Name");

                            if CustomerRec.FindSet() then begin

                                MerchantRec.Reset();
                                MerchantRec.SetRange("Group Id", CustomerRec."Group Id");

                                if MerchantRec.FindSet() then begin
                                    OMSRec."Merchandizer Group Head" := MerchantRec."Group Head";
                                end;

                            end;

                            OMSRec.Department := StyleRec."Department Name";
                            OMSRec."Po No" := StylePoRec."PO No.";
                            OMSRec."Po Qty" := StylePoRec.Qty;
                            OMSRec."Unit Price" := StylePoRec."Unit Price";
                            OMSRec."Ship Date" := StylePoRec."Ship Date";
                            OMSRec.Mode := StylePoRec.Mode;
                            OMSRec.Factory := StyleRec."Factory Code";
                            OMSRec."EMB IN" := StylePoRec."Emb In Qty";
                            OMSRec."EMB OUT" := StylePoRec."Emb Out Qty";
                            OMSRec."Print IN" := StylePoRec."Print In Qty";
                            OMSRec."Print OUT" := StylePoRec."Print Out Qty";
                            OMSRec.Lot := StylePoRec."Lot No.";
                            OMSRec."Wash IN" := StylePoRec."Wash In Qty";
                            OMSRec."Wash OUT" := StylePoRec."Wash Out Qty";
                            OMSRec."Poly OUT" := StylePoRec."Poly Bag";
                            OMSRec."Line IN" := StylePoRec."Sawing In Qty";
                            OMSRec."Line OUT" := StylePoRec."Sawing Out Qty";
                            OMSRec."Cut Qty" := StylePoRec."Cut In Qty";
                            OMSRec.FOB := StylePoRec."Unit Price";
                            OMSRec."EX Date" := StylePoRec."Ship Date";
                            OMSRec."Poly OUT" := StylePoRec."Finish Qty";

                            POQtyTot := 0;
                            StylePoRec1.Reset();
                            StylePoRec1.SetRange("Style No.", StyleRec."No.");
                            if StylePoRec1.FindSet() then begin
                                // repeat
                                POQtyTot := StylePoRec1.Qty;
                                // until StylePoRec1.Next() = 0;
                            end;
                            ShQty := 0;
                            SalesInvRec.Reset();
                            SalesInvRec.SetRange(Lot, StylePoRec."Lot No.");
                            SalesInvRec.SetRange("Style Name", StyleRec."Style No.");
                            SalesInvRec.SetRange("PO No", StylePoRec."PO No.");
                            //SalesInvRec.SetRange("Sell-to Customer No.", StyleRec."Buyer No.");
                            if SalesInvRec.FindSet() then begin
                                repeat
                                    SalesInvoiceLineRec.Reset();
                                    SalesInvoiceLineRec.SetRange("Document No.", SalesInvRec."No.");
                                    SalesInvoiceLineRec.SetRange(Type, SalesInvoiceLineRec.Type::Item);
                                    if SalesInvoiceLineRec.FindSet() then begin
                                        repeat
                                            ShQty += SalesInvoiceLineRec.Quantity;
                                            OMSRec."Ship value" += (SalesInvoiceLineRec.Quantity * SalesInvoiceLineRec."Unit Price");
                                        until SalesInvoiceLineRec.Next() = 0;
                                    end;
                                until SalesInvRec.Next() = 0;
                                OMSRec."Ship Qty" := ShQty;
                                // OMSRec."Ship value" := ShQty * StylePoRec."Unit Price";
                                OMSRec."EXP QTY" := ShQty;

                                // OMSRec."EX Short" := ShQty - StylePoRec.Qty;

                            end;
                            OMSRec."EX Short" := ShQty - StylePoRec.Qty;
                        end
                        else begin
                            OMSRec."Lc Contract No" := LcRec."Contract No";
                            OMSRec.Season := StyleRec."Season Name";
                            OMSRec.Store := StyleRec."Store Name";
                            OMSRec.Buyer := StyleRec."Buyer Name";
                            OMSRec."Style No" := StyleRec."No.";
                            OMSRec."Style Des" := StyleRec."Style No.";
                            OMSRec."Order Qty" := StyleRec."Order Qty";
                            OMSRec.Brand := StyleRec."Brand Name";
                            OMSRec.Department := StyleRec."Department Name";
                            OMSRec."Po No" := StylePoRec."PO No.";
                            OMSRec."Po Qty" := StylePoRec.Qty;
                            OMSRec."Unit Price" := StylePoRec."Unit Price";
                            OMSRec."Ship Date" := StylePoRec."Ship Date";
                            OMSRec.Mode := StylePoRec.Mode;
                            OMSRec.Factory := StyleRec."Factory Code";
                            OMSRec."EMB IN" := StylePoRec."Emb In Qty";
                            OMSRec."EMB OUT" := StylePoRec."Emb Out Qty";
                            OMSRec."Print IN" := StylePoRec."Print In Qty";
                            OMSRec."Print OUT" := StylePoRec."Print Out Qty";
                            OMSRec.Lot := StylePoRec."Lot No.";
                            OMSRec."Wash IN" := StylePoRec."Wash In Qty";
                            OMSRec."Wash OUT" := StylePoRec."Wash Out Qty";
                            OMSRec."Poly OUT" := StylePoRec."Poly Bag";
                            OMSRec."Line IN" := StylePoRec."Sawing In Qty";
                            OMSRec."Line OUT" := StylePoRec."Sawing Out Qty";
                            OMSRec."Cut Qty" := StylePoRec."Cut In Qty";
                            OMSRec.FOB := StylePoRec."Unit Price";
                            OMSRec."EX Date" := StylePoRec."Ship Date";
                            OMSRec."Poly OUT" := StylePoRec."Finish Qty";

                            POQtyTot := 0;
                            StylePoRec1.Reset();
                            StylePoRec1.SetRange("Style No.", StyleRec."No.");
                            if StylePoRec1.FindSet() then begin
                                // repeat
                                POQtyTot := StylePoRec1.Qty;
                                // until StylePoRec1.Next() = 0;
                            end;

                            ShQty := 0;
                            SalesInvRec.Reset();
                            SalesInvRec.SetRange(Lot, StylePoRec."Lot No.");
                            SalesInvRec.SetRange("PO No", StylePoRec."PO No.");
                            SalesInvRec.SetRange("Style Name", StyleRec."Style No.");
                            SalesInvRec.SetRange("Sell-to Customer No.", StyleRec."Buyer No.");
                            if SalesInvRec.FindSet() then begin
                                repeat
                                    SalesInvoiceLineRec.Reset();
                                    SalesInvoiceLineRec.SetRange("Document No.", SalesInvRec."No.");
                                    SalesInvoiceLineRec.SetRange(Type, SalesInvoiceLineRec.Type::Item);
                                    if SalesInvoiceLineRec.FindSet() then begin
                                        repeat
                                            ShQty += SalesInvoiceLineRec.Quantity;
                                        until SalesInvoiceLineRec.Next() = 0;
                                    end;
                                until SalesInvRec.Next() = 0;
                                OMSRec."Ship Qty" := ShQty;
                                OMSRec."Ship value" := ShQty * StylePoRec."Unit Price";
                                OMSRec."EXP QTY" := ShQty;

                                // OMSRec."EX Short" := ShQty - StylePoRec.Qty;

                            end;
                            OMSRec."EX Short" := ShQty - StylePoRec.Qty;
                        end;
                        OMSRec.Insert();
                        CurrPage.Update();
                    until StylePoRec.Next() = 0;
                end;
            until StyleRec.Next() = 0;
        end;
    end;
}

