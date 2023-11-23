report 51480 SalesContractReport2
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Sales Contract Report old';
    RDLCLayout = 'Report_Layouts/Commercial/SalesContractReport.rdl';
    DefaultLayout = RDLC;


    dataset
    {
        dataitem("Contract/LCMaster"; "Contract/LCMaster")
        {
            RequestFilterFields = "No.";
            column(No_; "Contract No")
            { }
            column(Buyer; Buyer)
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(BBLC; BBLC)
            { }
            column(Freight_Value; "Freight Value")
            { }
            column(Total_Commission; "Total Commission")
            { }
            column(Amend_Date; "Amend Date")
            { }
            column(Expiry_Date; "Expiry Date")
            { }
            column(Factory; Factory)
            { }
            column(OrderQty; OrderQty)
            { }
            column(Contract_Value; "Contract Value")
            { }
            column(Quantity__Pcs_; "Quantity (Pcs)")
            { }
            column(BBLCOPENED; BBLCOPENED)
            { }
            column(UDNo; UDNo)
            { }
            column(UDQty; UDQty)
            { }
            column(UDValue; UDValue)
            { }
            column(UDBalance; UDBalance)
            { }
            column(UDBalanceValue; UDBalanceValue)
            { }

            dataitem("Contract/LCStyle"; "Contract/LCStyle")
            {
                DataItemLinkReference = "Contract/LCMaster";
                DataItemLink = "No." = field("No.");
                //DataItemTableView = sorting("No.", "Style No.");

                column(PoQtySum; Qty)
                { }

                dataitem("Style Master PO"; "Style Master PO")
                {
                    DataItemLinkReference = "Contract/LCStyle";
                    DataItemLink = "Style No." = field("Style No.");
                    //DataItemTableView = sorting("Style No.", "Lot No.");

                    column(Style_Name; StyleName)
                    { }
                    column(Qty; QTYG)
                    { }
                    column(GarmentType; GarmentType)
                    { }
                    column(UnitPrice; UnitPrice)
                    { }
                    column(PoQty; Qty)
                    { }
                    column(ShippedQty; ShipQty)
                    { }
                    column(Diff; ShipQty - Qty)
                    { }
                    column(PoNo; "Style Master PO"."PO No.")
                    { }
                    column(ShipDate; ShipDate)
                    { }
                    column(Color; Color)
                    { }
                    column(ShValue; ShValue)
                    { }
                    column(TotalPO; UnitPrice * Qty)
                    { }
                    column(AMT; AMT)
                    { }



                    trigger OnAfterGetRecord()
                    begin
                        StylePoRec.Reset();
                        StylePoRec.SetRange("Style No.", "Style No.");
                        StylePoRec.SetRange("PO No.", "PO No.");
                        StylePoRec.SetRange("Lot No.", "Lot No.");
                        if StylePoRec.FindSet() then begin
                            UnitPrice := StylePoRec."Unit Price";
                            ShipDate := StylePoRec."Ship Date";
                        end;

                        PoQty := 0;
                        StylePoRec.Reset();
                        StylePoRec.SetRange("Style No.", "Style No.");
                        StylePoRec.SetRange("PO No.", "PO No.");
                        StylePoRec.SetRange("Lot No.", "Lot No.");
                        if StylePoRec.FindSet() then begin
                            repeat
                                PoQty += StylePoRec.Qty;
                            until StylePoRec.Next() = 0;
                        end;

                        StyleRec.Reset();
                        StyleRec.SetRange("No.", "Style No.");
                        if StyleRec.FindFirst() then begin
                            GarmentType := StyleRec."Garment Type Name";
                            StyleName := StyleRec."Style No.";
                        end;

                        // OrderQty := 0;
                        AssormentDetailRec.Reset();
                        AssormentDetailRec.SetRange("Style No.", "Style No.");
                        AssormentDetailRec.SetRange("PO No.", "PO No.");
                        if AssormentDetailRec.FindSet() then begin
                            Color := AssormentDetailRec."Colour Name";
                        end;

                        ShipQty := 0;
                        ShValue := 0;

                        // if "PO No." = '53848-55 C-761' then begin
                        //     st := "Style Master"."Style No.";
                        //     po := "Style Master PO"."PO No."
                        // end;


                        SalesInvoiceHRec.Reset();
                        SalesInvoiceHRec.SetRange("Style No", "Style No.");
                        SalesInvoiceHRec.SetRange("PO No", "Style Master PO"."PO No.");
                        SalesInvoiceHRec.SetRange("Contract No", "Contract/LCMaster"."Contract No");
                        SalesInvoiceHRec.SetRange(Closed, false);
                        if SalesInvoiceHRec.FindSet() then begin
                            repeat
                                ShipDate := SalesInvoiceHRec."Shipment Date";

                                SalesInVLineRec.Reset();
                                SalesInVLineRec.SetRange("Document No.", SalesInvoiceHRec."No.");
                                SalesInVLineRec.SetRange(Type, SalesInVLineRec.Type::Item);
                                if SalesInVLineRec.FindSet() then begin
                                    repeat
                                        ShipQty += SalesInVLineRec.Quantity;
                                        ShValue += SalesInVLineRec.Quantity * SalesInVLineRec."Unit Price";
                                    until SalesInVLineRec.Next() = 0;
                                    // ShValue += ShipQty * "Unit Price";
                                end;
                            until SalesInvoiceHRec.Next() = 0;
                        end;
                    end;
                }

            }


            trigger OnAfterGetRecord()
            var
                UDRec: Record UDHeader;
            begin
                comRec.Get;
                comRec.CalcFields(Picture);

                ContracStyleRec.Reset();
                ContracStyleRec.SetRange("No.", ContracStyleRec."No.");
                if ContracStyleRec.FindSet() then begin
                    repeat
                        QTYG += ContracStyleRec.Qty;
                    until ContracStyleRec.Next() = 0;
                end;

                BBLCOPENED := 0;
                B2BRec.Reset();
                B2BRec.SetRange("LC/Contract No.", "Contract No");
                if B2BRec.FindSet() then begin
                    repeat
                        BBLCOPENED += B2BRec."B2B LC Value";
                    until B2BRec.Next() = 0;
                end;

                Amount := "Contract Value";
                "BBLC AMOUNT" := ("Contract Value" * BBLC) / 100;

                BBLCOPENED := 0;
                B2BRec.Reset();
                B2BRec.SetRange("LC/Contract No.", "Contract No");
                if B2BRec.FindSet() then begin
                    repeat
                        BBLCOPENED += B2BRec."B2B LC Value";
                    until B2BRec.Next() = 0;
                end;

                "BBLC BALANCE" := "BBLC AMOUNT" - BBLCOPENED;

                //UD Values
                UDRec.Reset();
                UDRec.SetRange("LC/Contract No.", "Contract No");
                if UDRec.FindSet() then begin
                    UDQty := UDRec.UDQty;
                    UDValue := UDRec.Value;
                    UDBalance := UDRec.UDBalance;
                    UDBalanceValue := UDRec.UDBalanceValue;
                    UDNo := UDRec."No.";
                end;

            end;
        }
    }

    var
        AMT: Decimal;
        StyleName: Text[200];
        ShValue: Decimal;
        "BBLC BALANCE": Decimal;
        "BBLC Opened": Decimal;
        Amount: Decimal;
        BalanceBBLC: Decimal;
        "BBLC AMOUNT": Decimal;
        Style1: Code[20];
        PONo1: Code[20];
        SalesInvoiceHRec: Record "Sales Invoice Header";
        BBLCOPENED: Decimal;
        B2BRec: Record B2BLCMaster;
        PoQtySum: BigInteger;
        ShipmentLineRec: Record "Sales Shipment Line";
        ShipDate: Date;
        PoQty: BigInteger;
        SalesInVLineRec: Record "Sales Invoice Line";
        ContracStyleRec: Record "Contract/LCStyle";
        StylePoRec: Record "Style Master PO";
        QTYG: BigInteger;
        OrderQty: BigInteger;
        AssormentDetailRec: Record AssortmentDetails;
        AssormentQty: Integer;
        AssorColorRationRec: Record AssorColorSizeRatio;
        comRec: Record "Company Information";
        Color: Text[50];
        GarmentType: text[50];
        StyleRec: Record "Style Master";
        ShipQty: BigInteger;
        UnitPrice: Decimal;
        UDQty: BigInteger;
        UDValue: Decimal;
        UDBalance: BigInteger;
        UDBalanceValue: Decimal;
        UDNo: Code[20];
}