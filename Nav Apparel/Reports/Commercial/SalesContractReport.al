report 51245 SalesContractReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Sales Contract Report';
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
            column(BBLCOPENED; "BBLC BALANCE")
            { }
            dataitem("Contract/LCStyle"; "Contract/LCStyle")
            {
                DataItemLinkReference = "Contract/LCMaster";
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.", "Style No.");
                column(Style_Name; "Style Name")
                { }
                column(PoQtySum; Qty)
                { }
                dataitem("Style Master PO"; "Style Master PO")
                {
                    DataItemLinkReference = "Contract/LCStyle";
                    DataItemLink = "Style No." = field("Style No.");
                    DataItemTableView = sorting("Style No.", "Lot No.");

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
                    column(PoNo; "PO No.")
                    { }
                    column(ShipDate; ShipDate)
                    { }
                    column(Color; Color)
                    { }
                    column(ShValue; ShValue)
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
                        end;

                        // OrderQty := 0;


                        AssormentDetailRec.Reset();
                        AssormentDetailRec.SetRange("Style No.", "Style No.");
                        AssormentDetailRec.SetRange("PO No.", "PO No.");
                        if AssormentDetailRec.FindSet() then begin
                            Color := AssormentDetailRec."Colour Name";
                        end;

                        SalesInvoiceHRec.Reset();
                        SalesInvoiceHRec.SetRange("Style No", "Style No.");
                        SalesInvoiceHRec.SetRange("PO No", "PO No.");
                        SalesInvoiceHRec.SetRange(EntryType, SalesInvoiceHRec.EntryType::FG);
                        SalesInvoiceHRec.SetRange("Bal. Account Type", SalesInvoiceHRec."Bal. Account Type"::"G/L Account");
                        if SalesInvoiceHRec.FindSet() then begin
                            ShipDate := SalesInvoiceHRec."Shipment Date";

                            ShipQty := 0;
                            SalesInVLineRec.Reset();
                            SalesInVLineRec.SetRange("Document No.", SalesInvoiceHRec."No.");
                            SalesInVLineRec.SetRange(Type, SalesInVLineRec.Type::Item);
                            if SalesInVLineRec.FindSet() then begin
                                repeat
                                    ShipQty += SalesInVLineRec.Quantity;
                                until SalesInVLineRec.Next() = 0;
                                ShValue += ShipQty * "Unit Price";
                            end;
                        end;


                    end;
                }
            }

            trigger OnAfterGetRecord()

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

            end;
        }

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                // group(GroupName)
                // {
                //     // field(Name; SourceExpression)
                //     // {
                //     //     ApplicationArea = All;

                //     // }
                // }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }


    var
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
}