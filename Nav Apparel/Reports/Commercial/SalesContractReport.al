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
                trigger OnAfterGetRecord()
                begin

                    StylePoRec.Reset();
                    StylePoRec.SetRange("Style No.", "Style No");
                    if StylePoRec.FindSet() then begin
                        UnitPrice := StylePoRec."Unit Price";
                        PoQty := StylePoRec.Qty;
                        ShipDate := StylePoRec."Ship Date";
                    end;
                    StyleRec.Reset();
                    StyleRec.SetRange("No.", "Style No");
                    if StyleRec.FindFirst() then begin
                        GarmentType := StyleRec."Garment Type Name";
                    end;

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

                    ShipQty := 0;
                    SalesInvoiceLineRec.Reset();
                    SalesInvoiceLineRec.SetRange("Document No.", "No.");
                    SalesInvoiceLineRec.SetRange(Type, SalesInvoiceLineRec.Type::Item);
                    if SalesInvoiceLineRec.FindFirst() then begin
                        repeat
                            ShipQty += SalesInvoiceLineRec.Quantity;
                        until SalesInvoiceLineRec.Next() = 0;

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
        ShipDate: Date;
        PoQty: BigInteger;
        SalesInvoiceLineRec: Record "Sales Invoice Line";
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