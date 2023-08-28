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
            column(BBLCOPENED; BBLCOPENED)
            { }
            dataitem("Sales Invoice Header"; "Sales Invoice Header")
            {
                DataItemLinkReference = "Contract/LCMaster";
                DataItemLink = "Contract No" = field("Contract No");
                DataItemTableView = sorting("No.");

                column(Style_Name; "Style Name")
                { }
                column(Qty; QTYG)
                { }
                column(GarmentType; GarmentType)
                { }
                column(UnitPrice; UnitPrice)
                { }
                column(PoQty; PoQty)
                { }
                column(ShippedQty; ShipQty)
                { }
                column(PoNo; "PO No")
                { }
                column(ShipDate; ShipDate)
                { }
                column(Color; Color)
                { }
                column(PoQtySum; PoQtySum)
                { }
                trigger OnAfterGetRecord()
                begin

                    PoQty := 0;
                    StylePoRec.Reset();
                    StylePoRec.SetRange("Style No.", "Style No");
                    StylePoRec.SetRange("PO No.", "PO No");
                    if StylePoRec.FindSet() then begin
                        UnitPrice := StylePoRec."Unit Price";
                        ShipDate := StylePoRec."Ship Date";
                        repeat
                            PoQty += StylePoRec.Qty;
                        until StylePoRec.Next() = 0;
                    end;

                    // PoQtySum := 0;
                    StylePoRec.Reset();
                    StylePoRec.SetRange("Style No.", "Style No");
                    if StylePoRec.FindSet() then begin
                        StylePoRec.CalcSums(Qty);
                        PoQtySum := StylePoRec.Qty;
                    end;

                    StyleRec.Reset();
                    StyleRec.SetRange("No.", "Style No");
                    if StyleRec.FindFirst() then begin
                        GarmentType := StyleRec."Garment Type Name";
                    end;

                    // OrderQty := 0;
                    StyleRec.Reset();
                    StyleRec.SetRange("No.", "Style No");
                    if StyleRec.FindFirst() then begin
                        repeat
                            OrderQty += StyleRec."Order Qty";
                        until StyleRec.Next() = 0;
                    end;


                    AssormentDetailRec.Reset();
                    AssormentDetailRec.SetRange("Style No.", "Style No");
                    AssormentDetailRec.SetRange("PO No.", "PO No");
                    if AssormentDetailRec.FindFirst() then begin
                        Color := AssormentDetailRec."Colour Name";
                    end;

      
                    // ShipmentLineRec.Reset();
                    // ShipmentLineRec.SetRange("Order No.", "Order No.");
                    // ShipmentLineRec.SetRange(Type, ShipmentLineRec.Type::Item);
                    // if ShipmentLineRec.FindSet() then begin
                    //     repeat
                    //         ShipQty += ShipmentLineRec.Quantity;
                    //     until ShipmentLineRec.Next() = 0;
                    // end;
                    
                    ShipQty := 0;
                    SalesInVLineRec.Reset();
                    SalesInVLineRec.SetRange("Document No.", "No.");
                    SalesInVLineRec.SetRange(Type, SalesInVLineRec.Type::Item);
                    if SalesInVLineRec.FindSet() then begin
                        repeat
                            ShipQty += SalesInVLineRec.Quantity;
                        until SalesInVLineRec.Next() = 0;
                    end;
                end;

            }
            trigger OnAfterGetRecord()

            begin
                comRec.Get;
                comRec.CalcFields(Picture);

                ContracStyleRec.Reset();
                ContracStyleRec.SetRange("No.", ContracStyleRec."No.");
                if ContracStyleRec.FindFirst() then begin
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