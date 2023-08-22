page 51324 OrderShippingList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Order Shipping Export";
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
                    Editable = false;

                }
                field(Season; Rec.Season)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Buyer No"; Rec."Buyer No")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field(Buyer; Rec.Buyer)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Style Name"; Rec."Style Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Po No"; Rec."Po No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Order Qty"; Rec."Order Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Po Qty"; Rec."Po Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Order value"; Rec."Po Qty" * Rec."Unit Price")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Ship Date"; Rec."Ship Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Ship Qty"; Rec."Ship Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Ship value"; Rec."Ship Qty" * Rec."Unit Price")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Commission; Rec.Commission)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Discount; Rec.Discount)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Ex FTY Date"; Rec."Ex FTY Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Invoice No"; Rec."Invoice No")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'X-factory ';
                }
                field("Invoice Date"; Rec."Invoice Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Factory Invoice No"; Rec."Factory Invoice No")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Factory Inv. No';
                }
                field("No of CTN"; Rec."No of CTN1")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(CBM; Rec.CBM)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Mode; Rec.Mode)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("BL No"; Rec."BL No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("BL Date"; Rec."BL Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Doc Sub Buyer Date"; Rec."Doc Sub Buyer Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Doc Sub Bank Date"; Rec."Doc Sub Bank Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Exp No"; Rec."Exp No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Exp Date"; Rec."Exp Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Destination; Rec.Destination)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bank Ref"; Rec."Bank Ref")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bank Ref Date"; Rec."Bank Ref Date")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                    Editable = false;
                }
                field("Realise Amount"; Rec."Realise Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Realise Date"; Rec."Realise Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Exchange Rate"; Rec."Exchange Rate")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sundry Acc"; Rec."Sundry Acc")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Margin Acc"; Rec."Margin Acc")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("FC Acc"; Rec."FC Acc")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Currant Ac Amount"; Rec."Currant Ac Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Excess/Short"; Rec."Excess/Short")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Diff; Rec.Diff)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No of Stlye"; Rec."No of Stlye")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Lc Fty"; Rec."Lc Fty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

            }
        }
    }

    trigger OnOpenPage()
    var
        SalesInvRec2: Record "Sales Invoice Header";
        SalesLineRec: Record "Sales Invoice Line";
        ShipmentLineRec: Record "Sales Shipment Line";
        BankRefColRec: Record BankRefCollectionHeader;
        BankRefHRec: Record BankReferenceHeader;
        BankRefInvRec: Record BankReferenceInvoice;
        SalesInvRec: Record "Sales Invoice Header";
        BomEstimateRec: Record "BOM Estimate Cost";
        LcRec: Record "Contract/LCMaster";
        StyleRec: Record "Style Master";
        OrderSummaryRec: Record "Order Shipping Export";
        StylePoRec: Record "Style Master PO";
        ContractStyleRec: Record "Contract/LCStyle";
        LoginRec: Page "Login Card";
        LoginSessionsRec: Record LoginSessions;
        UserRec: Record "User Setup";
        MaxSeqNo: BigInteger;
        ShQty: Decimal;
    begin
        //Check whether user logged in or not
        LoginSessionsRec.Reset();
        LoginSessionsRec.SetRange(SessionID, SessionId());
        if not LoginSessionsRec.FindSet() then begin  //not logged in
            Clear(LoginRec);
            LoginRec.LookupMode(true);
            LoginRec.RunModal();
        end;

        // Delete Old Records
        OrderSummaryRec.Reset();
        if OrderSummaryRec.FindSet() then begin
            OrderSummaryRec.DeleteAll();
        end;

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
                            OrderSummaryRec."Order Qty" := StyleRec."Order Qty";
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
                            SalesInvRec.SetRange("PO No", StylePoRec."PO No.");
                            SalesInvRec.SetRange(Lot, StylePoRec."Lot No.");
                            if SalesInvRec.FindSet() then begin
                                OrderSummaryRec."Invoice No" := SalesInvRec."Your Reference";
                                OrderSummaryRec."Invoice Date" := SalesInvRec."Shipment Date";
                                OrderSummaryRec."No of CTN1" := SalesInvRec."No of Cartons";
                                OrderSummaryRec.CBM := SalesInvRec.CBM;
                                OrderSummaryRec."BL No" := SalesInvRec."BL No";
                                OrderSummaryRec."BL Date" := SalesInvRec."BL Date";
                                OrderSummaryRec."Exp No" := SalesInvRec."Exp No";
                                OrderSummaryRec."Exp Date" := SalesInvRec."Exp Date";
                                OrderSummaryRec.Destination := SalesInvRec."Location Code";

                                ShQty := 0;
                                SalesInvRec2.Reset();
                                SalesInvRec2.SetRange("Style Name", StyleRec."Style No.");
                                SalesInvRec2.SetRange("Sell-to Customer No.", StyleRec."Buyer No.");
                                SalesInvRec2.SetRange("PO No", StylePoRec."PO No.");
                                SalesInvRec2.SetRange(Lot, StylePoRec."Lot No.");
                                if SalesInvRec.FindSet() then begin
                                    repeat
                                        SalesLineRec.Reset();
                                        SalesLineRec.SetRange("Order No.", SalesInvRec2."Order No.");
                                        SalesLineRec.SetRange(Type, SalesLineRec.Type::Item);
                                        if SalesInvRec.FindSet() then begin
                                            repeat
                                                ShQty += SalesLineRec.Quantity;
                                            until SalesLineRec.Next() = 0;
                                        end;
                                    until SalesInvRec2.Next() = 0;
                                end;

                                OrderSummaryRec."Ship Qty" := ShQty;
                                OrderSummaryRec."Ship value" := ShQty * StylePoRec."Unit Price";

                                BankRefInvRec.Reset();
                                BankRefInvRec.SetRange("Factory Inv No", SalesInvRec."Your Reference");
                                if BankRefInvRec.FindSet() then begin

                                    BankRefHRec.Reset();
                                    BankRefHRec.SetRange("No.", BankRefInvRec."No.");
                                    if BankRefHRec.FindSet() then begin
                                        OrderSummaryRec."Doc Sub Bank Date" := BankRefHRec."Reference Date";
                                        OrderSummaryRec."Doc Sub Buyer Date" := BankRefHRec."Reference Date";
                                        OrderSummaryRec."Bank Ref" := BankRefHRec."BankRefNo.";
                                        OrderSummaryRec."Bank Ref Date" := BankRefHRec."Reference Date";
                                        OrderSummaryRec."Maturity Date" := BankRefHRec."Maturity Date";
                                        OrderSummaryRec.Remarks := BankRefHRec.Remarks;
                                        OrderSummaryRec."Factory Invoice No" := SalesInvRec."Your Reference";

                                        BankRefColRec.Reset();
                                        BankRefColRec.SetRange("BankRefNo.", BankRefHRec."BankRefNo.");
                                        if BankRefColRec.FindSet() then begin
                                            OrderSummaryRec."Realise Amount" := BankRefColRec."Release Amount";
                                            OrderSummaryRec."Realise Date" := BankRefColRec."Release Date";
                                            OrderSummaryRec."Exchange Rate" := BankRefColRec."Exchange Rate";
                                            OrderSummaryRec."Margin Acc New" := BankRefColRec."Margin A/C Amount";
                                            OrderSummaryRec."FC Acc New" := BankRefColRec."FC A/C Amount";
                                            OrderSummaryRec."Currant Ac Amount1" := BankRefColRec."Current A/C Amount";
                                        end;
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