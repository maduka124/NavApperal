page 51324 OrderShippingList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Order Shipping Export Line";
    SourceTableView = where("Contract Lc No" = filter(<> ''));


    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Contract Lc No"; Rec."Contract Lc No")
                {
                    ApplicationArea = All;

                }
                field(Season; Rec.Season)
                {
                    ApplicationArea = All;

                }
                field("Buyer No"; Rec."Buyer No")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field(Buyer; Rec.Buyer)
                {
                    ApplicationArea = All;

                }
                field("Style Name"; Rec."Style Name")
                {
                    ApplicationArea = All;

                }
                field("Po No"; Rec."Po No")
                {
                    ApplicationArea = All;

                }
                field("Po Qty"; Rec."Po Qty")
                {
                    ApplicationArea = All;

                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;

                }
                field("Order value"; Rec."Po Qty" * Rec."Unit Price")
                {
                    ApplicationArea = All;

                }
                field("Ship Date"; Rec."Ship Date")
                {
                    ApplicationArea = All;

                }
                field("Ship Qty"; Rec."Ship Qty")
                {
                    ApplicationArea = All;

                }
                field("Ship value"; Rec."Ship Qty" * Rec."Unit Price")
                {
                    ApplicationArea = All;

                }
                field(Commission; Rec.Commission)
                {
                    ApplicationArea = All;

                }
                field(Discount; Rec.Discount)
                {
                    ApplicationArea = All;

                }
                field("Ex FTY Date"; Rec."Ex FTY Date")
                {
                    ApplicationArea = All;

                }
                field("Invoice No"; Rec."Invoice No")
                {
                    ApplicationArea = All;

                }
                field("Invoice Date"; Rec."Invoice Date")
                {
                    ApplicationArea = All;

                }
                field("No of CTN"; Rec."No of CTN")
                {
                    ApplicationArea = All;

                }
                field(CBM; Rec.CBM)
                {
                    ApplicationArea = All;

                }
                field(Mode; Rec.Mode)
                {
                    ApplicationArea = All;

                }
                field("BL No"; Rec."BL No")
                {
                    ApplicationArea = All;

                }
                field("BL Date"; Rec."BL Date")
                {
                    ApplicationArea = All;

                }
                field("Doc Sub Buyer Date"; Rec."Doc Sub Buyer Date")
                {
                    ApplicationArea = All;

                }
                field("Doc Sub Bank Date"; Rec."Doc Sub Bank Date")
                {
                    ApplicationArea = All;

                }
                field("Exp No"; Rec."Exp No")
                {
                    ApplicationArea = All;

                }
                field("Exp Date"; Rec."Exp Date")
                {
                    ApplicationArea = All;

                }
                field(Destination; Rec.Destination)
                {
                    ApplicationArea = All;

                }
                field("Bank Ref"; Rec."Bank Ref")
                {
                    ApplicationArea = All;

                }
                field("Bank Ref Date"; Rec."Bank Ref Date")
                {
                    ApplicationArea = All;

                }
                field("DHL No"; Rec."DHL No")
                {
                    ApplicationArea = All;

                }
                field("DHL Date"; Rec."DHL Date")
                {
                    ApplicationArea = All;

                }
                field("Maturity Date"; Rec."Maturity Date")
                {
                    ApplicationArea = All;

                }
                field("Realise Amount"; Rec."Realise Amount")
                {
                    ApplicationArea = All;

                }
                field("Realise Date"; Rec."Realise Date")
                {
                    ApplicationArea = All;

                }
                field("Exchange Rate"; Rec."Exchange Rate")
                {
                    ApplicationArea = All;

                }
                field("Sundry Acc"; Rec."Sundry Acc")
                {
                    ApplicationArea = All;

                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;

                }
                field("Margin Acc"; Rec."Margin Acc")
                {
                    ApplicationArea = All;

                }
                field("FC Acc"; Rec."FC Acc")
                {
                    ApplicationArea = All;

                }
                field("Currant Ac Amount"; Rec."Currant Ac Amount")
                {
                    ApplicationArea = All;

                }
                field("Excess/Short"; Rec."Excess/Short")
                {
                    ApplicationArea = All;

                }
                field(Diff; Rec.Diff)
                {
                    ApplicationArea = All;

                }
                field("No of Stlye"; Rec."No of Stlye")
                {
                    ApplicationArea = All;

                }
                field("Lc Fty"; Rec."Lc Fty")
                {
                    ApplicationArea = All;

                }

            }
        }
    }
    trigger OnOpenPage()
    var
        SalesInvoiceLineRec: Record "Sales Invoice Line";
        BankRefColRec: Record BankRefCollectionHeader;
        BankRefHRec: Record BankReferenceHeader;
        SalesInvRec: Record "Sales Invoice Header";
        BomEstimateRec: Record "BOM Estimate Cost";
        LcRec: Record "Contract/LCMaster";
        StyleRec: Record "Style Master";
        OrderSummaryRec: Record "Order Shipping Export Line";
        StylePoRec: Record "Style Master PO";
        ContractStyleRec: Record "Contract/LCStyle";
        LoginRec: Page "Login Card";
        LoginSessionsRec: Record LoginSessions;
        UserRec: Record "User Setup";
        MaxSeqNo: BigInteger;
        ShQty: Decimal;
    begin
        ShQty := 0;
        //Check whether user logged in or not
        LoginSessionsRec.Reset();
        LoginSessionsRec.SetRange(SessionID, SessionId());

        if not LoginSessionsRec.FindSet() then begin  //not logged in
            Clear(LoginRec);
            LoginRec.LookupMode(true);
            LoginRec.RunModal();
        end;

        // MaxSeqNo := 0;

        // // Delete Old Records
        // OrderSummaryRec.Reset();
        // // OrderSummaryRec.SetRange("Secondary UserID", LoginSessionsRec."Secondary UserID");
        // // OrderSummaryRec.SetRange(No, Rec."No.");
        // if OrderSummaryRec.FindSet() then begin
        //     OrderSummaryRec.DeleteAll();
        //     CurrPage.Update();
        // end;

        //Get Max Seq No
        OrderSummaryRec.Reset();
        if OrderSummaryRec.FindLast() then
            MaxSeqNo := OrderSummaryRec."SeqNo";

        StyleRec.Reset();
        // StyleRec.SetRange("Style No.", Rec."Style Name");
        StyleRec.SetRange(Status, StyleRec.Status::Confirmed);
        if StyleRec.FindSet() then begin
            repeat
                StylePoRec.Reset();
                StylePoRec.SetRange("Style No.", StyleRec."No.");
                if StylePoRec.FindSet() then begin
                    repeat
                        MaxSeqNo += 1;
                        OrderSummaryRec.Init();
                        OrderSummaryRec.SeqNo := MaxSeqNo;
                        OrderSummaryRec.No := StyleRec."No.";

                        LcRec.Reset();
                        LcRec.SetRange("No.", StyleRec.AssignedContractNo);
                        if LcRec.FindSet() then begin
                            OrderSummaryRec."Contract Lc No" := LcRec."Contract No";
                            OrderSummaryRec.Season := StyleRec."Season Name";
                            OrderSummaryRec."Buyer No" := StyleRec."Buyer No.";
                            OrderSummaryRec.Buyer := StyleRec."Buyer Name";
                            OrderSummaryRec."Style Name" := StyleRec."Style No.";
                            OrderSummaryRec."Po No" := StylePoRec."PO No.";
                            OrderSummaryRec."Po Qty" := StylePoRec.Qty;
                            OrderSummaryRec."Unit Price" := StylePoRec."Unit Price";
                            OrderSummaryRec."Ship Date" := StylePoRec."Ship Date";
                            OrderSummaryRec."Ship Qty" := StylePoRec."Shipped Qty";
                            OrderSummaryRec.Mode := StylePoRec.Mode;
                            OrderSummaryRec."Lc Fty" := LcRec."Factory No.";

                            BomEstimateRec.Reset();
                            BomEstimateRec.SetRange("Style No.", StyleRec."No.");
                            if BomEstimateRec.FindSet() then begin
                                OrderSummaryRec.Commission := BomEstimateRec."Commission %";
                            end;

                            SalesInvRec.Reset();
                            SalesInvRec.SetRange("Style Name", StyleRec."Style No.");
                            SalesInvRec.SetRange("Sell-to Customer No.", StyleRec."Buyer No.");
                            if SalesInvRec.FindSet() then begin
                                OrderSummaryRec."Invoice No" := SalesInvRec."Your Reference";
                                OrderSummaryRec."Invoice Date" := SalesInvRec."Shipment Date";
                                OrderSummaryRec."No of CTN" := SalesInvRec."No of Cartons";
                                OrderSummaryRec.CBM := SalesInvRec.CBM;
                                OrderSummaryRec."BL No" := SalesInvRec."BL No";
                                OrderSummaryRec."BL Date" := SalesInvRec."BL Date";
                                OrderSummaryRec."Exp No" := SalesInvRec."Exp No";
                                OrderSummaryRec."Exp Date" := SalesInvRec."Exp Date";
                                OrderSummaryRec.Destination := SalesInvRec."Location Code";

                                SalesInvoiceLineRec.Reset();
                                SalesInvoiceLineRec.SetRange("Document No.", SalesInvRec."No.");
                                SalesInvoiceLineRec.SetRange(Type, SalesInvoiceLineRec.Type::Item);
                                if SalesInvoiceLineRec.FindSet() then begin
                                    repeat
                                        ShQty += SalesInvoiceLineRec.Quantity;
                                    until SalesInvoiceLineRec.Next() = 0;
                                end;
                                OrderSummaryRec."Ship Qty" := ShQty;
                                OrderSummaryRec."Ship value" := ShQty * StylePoRec."Unit Price";


                                BankRefHRec.Reset();
                                // BankRefHRec.SetRange("Buyer No", Rec.Buyer);
                                BankRefHRec.SetRange("LC/Contract No.", SalesInvRec."Contract No");
                                // BankRefHRec.SetRange("No.", SalesInvRec.BankRefNo);
                                if BankRefHRec.FindSet() then begin
                                    OrderSummaryRec."Doc Sub Bank Date" := BankRefHRec."Reference Date";
                                    OrderSummaryRec."Doc Sub Buyer Date" := BankRefHRec."Reference Date";
                                    OrderSummaryRec."Bank Ref" := BankRefHRec."No.";
                                    OrderSummaryRec."Bank Ref Date" := BankRefHRec."Reference Date";
                                    OrderSummaryRec."Maturity Date" := BankRefHRec."Maturity Date";
                                    OrderSummaryRec.Remarks := BankRefHRec.Remarks;

                                    BankRefColRec.Reset();
                                    BankRefColRec.SetRange("BankRefNo.", BankRefHRec."BankRefNo.");
                                    if BankRefColRec.FindSet() then begin
                                        OrderSummaryRec."Realise Amount" := BankRefColRec."Release Amount";
                                        OrderSummaryRec."Realise Date" := BankRefColRec."Release Date";
                                        OrderSummaryRec."Exchange Rate" := BankRefColRec."Exchange Rate";
                                        OrderSummaryRec."Margin Acc" := BankRefColRec."Margin A/C Amount";
                                        OrderSummaryRec."FC Acc" := BankRefColRec."FC A/C Amount";
                                        OrderSummaryRec."Currant Ac Amount" := BankRefColRec."Current A/C Amount";
                                    end;
                                end;
                            end;
                        end;
                        OrderSummaryRec.Insert();
                    until StylePoRec.Next() = 0;
                end;
            until StyleRec.Next() = 0;
        end;
    end;

    // trigger OnOpenPage()
    // var
    //     BankRefColRec: Record BankRefCollectionHeader;
    //     BankRefHRec: Record BankReferenceHeader;
    //     SalesInvRec: Record "Sales Invoice Header";
    //     BomEstimateRec: Record "BOM Estimate Cost";
    //     LcRec: Record "Contract/LCMaster";
    //     StyleRec: Record "Style Master";
    //     OrderSummaryRec: Record "Order Shipping Export Line";
    //     StylePoRec: Record "Style Master PO";
    //     ContractStyleRec: Record "Contract/LCStyle";
    //     LoginRec: Page "Login Card";
    //     LoginSessionsRec: Record LoginSessions;
    //     UserRec: Record "User Setup";
    //     MaxSeqNo: BigInteger;
    // begin



    // //Check whether user logged in or not
    // LoginSessionsRec.Reset();
    // LoginSessionsRec.SetRange(SessionID, SessionId());

    // if not LoginSessionsRec.FindSet() then begin  //not logged in
    //     Clear(LoginRec);
    //     LoginRec.LookupMode(true);
    //     LoginRec.RunModal();
    // end;


    // // Delete Old Records
    // OrderSummaryRec.Reset();
    // OrderSummaryRec.SetRange("Secondary UserID", LoginSessionsRec."Secondary UserID");
    // if OrderSummaryRec.FindSet() then
    //     OrderSummaryRec.DeleteAll();

    // //Get Max Seq No
    // OrderSummaryRec.Reset();
    // if OrderSummaryRec.FindLast() then
    //     MaxSeqNo := OrderSummaryRec."SeqNo";

    // StyleRec.Reset();
    // StyleRec.SetRange(Status, StyleRec.Status::Confirmed);
    // if StylePoRec.FindSet() then begin
    //     repeat
    //         MaxSeqNo += 1;
    //         OrderSummaryRec.Init();
    //         OrderSummaryRec.SeqNo := MaxSeqNo;

    //         LcRec.Reset();
    //         LcRec.SetRange("No.", StyleRec.AssignedContractNo);
    //         if LcRec.FindSet() then begin
    //             OrderSummaryRec."Contract Lc No" := LcRec."Contract No";


    //             OrderSummaryRec.Season := StyleRec."Season Name";
    //             OrderSummaryRec."Buyer No" := StyleRec."Brand No.";
    //             OrderSummaryRec.Buyer := StyleRec."Buyer Name";
    //             OrderSummaryRec."Style Name" := StyleRec."Style No.";

    //             StylePoRec.Reset();
    //             StylePoRec.SetRange("Style No.", StyleRec."No.");
    //             if StyleRec.FindSet() then begin
    //                 OrderSummaryRec."Po No" := StylePoRec."PO No.";
    //                 OrderSummaryRec."Po Qty" := StylePoRec.Qty;
    //                 OrderSummaryRec."Unit Price" := StylePoRec."Unit Price";
    //                 OrderSummaryRec."Ship Date" := StylePoRec."Ship Date";
    //                 OrderSummaryRec."Ship Qty" := StylePoRec."Shipped Qty";
    //                 OrderSummaryRec.Mode := StylePoRec.Mode;

    //             end;

    //             BomEstimateRec.Reset();
    //             BomEstimateRec.SetRange("Style No.", StyleRec."No.");
    //             if BomEstimateRec.FindSet() then begin
    //                 OrderSummaryRec.Commission := BomEstimateRec."Commission %";

    //             end;

    //             SalesInvRec.Reset();
    //             SalesInvRec.SetRange("Style No", StyleRec."No.");
    //             SalesInvRec.SetRange("Contract No", LcRec."Contract No");
    //             if SalesInvRec.FindSet() then begin
    //                 OrderSummaryRec."Invoice No" := SalesInvRec."Your Reference";
    //                 OrderSummaryRec."Invoice Date" := SalesInvRec."Shipment Date";
    //                 OrderSummaryRec."No of CTN" := SalesInvRec."No of Cartons";
    //                 OrderSummaryRec.CBM := SalesInvRec.CBM;
    //                 OrderSummaryRec."BL No" := SalesInvRec."BL No";
    //                 OrderSummaryRec."BL Date" := SalesInvRec."BL Date";
    //                 OrderSummaryRec."Exp No" := SalesInvRec."Exp No";
    //                 OrderSummaryRec."Exp Date" := SalesInvRec."Exp Date";
    //                 OrderSummaryRec.Destination := SalesInvRec."Location Code";


    //                 BankRefHRec.Reset();
    //                 BankRefHRec.SetRange("Buyer No", LcRec."Buyer No.");
    //                 BankRefHRec.SetRange("LC/Contract No.", LcRec."Contract No");
    //                 BankRefHRec.SetRange("No.", SalesInvRec.BankRefNo);
    //                 if BankRefHRec.FindSet() then begin
    //                     OrderSummaryRec."Doc Sub Bank Date" := BankRefHRec."Reference Date";
    //                     OrderSummaryRec."Doc Sub Buyer Date" := BankRefHRec."Reference Date";
    //                     OrderSummaryRec."Bank Ref" := BankRefHRec."No.";
    //                     OrderSummaryRec."Bank Ref Date" := BankRefHRec."Reference Date";
    //                     OrderSummaryRec."Maturity Date" := BankRefHRec."Maturity Date";
    //                     OrderSummaryRec.Remarks := BankRefHRec.Remarks;

    //                     BankRefColRec.Reset();
    //                     BankRefColRec.SetRange("BankRefNo.", BankRefHRec."No.");
    //                     if BankRefColRec.FindSet() then begin
    //                         OrderSummaryRec."Realise Amount" := BankRefColRec."Release Amount";
    //                         OrderSummaryRec."Realise Date" := BankRefColRec."Release Date";
    //                         OrderSummaryRec."Exchange Rate" := BankRefColRec."Exchange Rate";
    //                         OrderSummaryRec."Margin Acc" := BankRefColRec."Margin A/C Amount";
    //                         OrderSummaryRec."FC Acc" := BankRefColRec."FC A/C Amount";
    //                         OrderSummaryRec."Currant Ac Amount" := BankRefColRec."Current A/C Amount";
    //                     end;

    //                 end;
    //             end;
    //         end;
    //         OrderSummaryRec.Insert();
    //     until StyleRec.Next() = 0;
    // end;
    // end;
}