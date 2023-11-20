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
            column(Contract_Value; "Contract Value")
            { }
            column(Quantity__Pcs_; "Quantity (Pcs)")
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
            // column(OrderQty; OrderQty)
            // { }
            column(BBLCOPENED; BBLCOPENED)
            { }

            // column(PoQty; POQty)
            // { }

            dataitem("Sales Invoice Header"; "Sales Invoice Header")
            {
                DataItemLinkReference = "Contract/LCMaster";
                DataItemLink = "Contract No" = field("Contract No"), "Bill-to Customer No." = field("Buyer No.");
                DataItemTableView = where(Closed = filter(false));

                column(Style_Name; "Style Name")
                { }
                column(GarmentType; GarmentType)
                { }
                column(UnitPrice; "Unit Price")
                { }
                column(ShipDate; "Shipment Date")
                { }
                column(PoNo; "PO No")
                { }
                column(Color; Color)
                { }
                column(PoQty; POQty)
                { }
                column(TotalPO; "Unit Price" * "PO QTY")
                { }
                column(ShippedQty; ShipQty)
                { }
                column(ShValue; Amount)
                { }
                column(Diff; ShipQty - POQty)
                { }
                column(AMT; AMT)
                { }
                column(Remaining_Amount; "Remaining Amount")
                { }

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    AMT := 0;
                    SalesInvRec.Reset();
                    // SalesInvRec.SetRange("No.", "No.");
                    SalesInvRec.SetRange("Contract No", "Contract No");
                    SalesInvRec.SetRange(Closed, false);
                    if SalesInvRec.FindSet() then begin
                        SalesInvRec.CalcFields("Remaining Amount");
                        repeat
                            AMT += SalesInvRec."Remaining Amount";
                        until SalesInVLineRec.Next() = 0;
                    end;
                    StyleRec.Reset();
                    StyleRec.SetRange("No.", "Style No");
                    if StyleRec.FindFirst() then begin
                        GarmentType := StyleRec."Garment Type Name";
                        // StyleName := StyleRec."Style No.";
                    end;
                    POQty := 0;
                    StylePoRec.Reset();
                    StylePoRec.SetRange("Style No.", "Style No");
                    StylePoRec.SetRange("Lot No.", Lot);
                    StylePoRec.SetRange("PO No.", "PO No");
                    if StylePoRec.FindSet() then begin
                        POQty += StylePoRec.Qty;
                    end;


                    // OrderQty := 0;
                    AssormentDetailRec.Reset();
                    AssormentDetailRec.SetRange("Style No.", "Style No");
                    AssormentDetailRec.SetRange("PO No.", "PO No");
                    if AssormentDetailRec.FindSet() then begin
                        Color := AssormentDetailRec."Colour Name";
                    end;

                    ShipQty := 0;
                    ShValue := 0;
                    SalesInVLineRec.Reset();
                    SalesInVLineRec.SetRange("Document No.", "No.");
                    SalesInVLineRec.SetRange(Type, SalesInVLineRec.Type::Item);
                    if SalesInVLineRec.FindSet() then begin
                        repeat
                            ShipQty += SalesInVLineRec.Quantity;
                            ShValue += SalesInVLineRec.Quantity * SalesInVLineRec."Unit Price";
                        until SalesInVLineRec.Next() = 0;

                    end;
                end;
            }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                comRec.Get;
                comRec.CalcFields(Picture);


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

                BBLCOPENED := 0;
                B2BRec.Reset();
                B2BRec.SetRange("LC/Contract No.", "Contract No");
                if B2BRec.FindSet() then begin
                    repeat
                        BBLCOPENED += B2BRec."B2B LC Value";
                    until B2BRec.Next() = 0;
                end;

                ContractSLcRec.Reset();
                ContractSLcRec.SetRange("No.", "No.");
                if ContractSLcRec.FindSet() then begin


                end;


            end;
        }
    }

    // requestpage
    // {
    //     layout
    //     {
    //         area(Content)
    //         {
    //             group(GroupName)
    //             {
    //                 // field(Name; SourceExpression)
    //                 // {
    //                 //     ApplicationArea = All;

    //                 // }
    //             }
    //         }
    //     }
    // }



    var
        AMT: Decimal;
        SalesInvRec: Record "Sales Invoice Header";
        ContractSLcRec: Record "Contract/LCStyle";
        StylePoRec: Record "Style Master PO";
        POQty: Integer;
        ShValue: Decimal;
        ShipQty: Decimal;
        SalesInVLineRec: Record "Sales Invoice Line";
        AssormentDetailRec: Record AssortmentDetails;
        Color: Text[50];
        GarmentType: text[50];
        StyleRec: Record "Style Master";
        BBLCOPENED: Decimal;
        B2BRec: Record B2BLCMaster;
        UDQty: BigInteger;
        UDValue: Decimal;
        UDBalance: BigInteger;
        UDBalanceValue: Decimal;
        UDNo: Code[20];
        UDRec: Record UDHeader;
        comRec: Record "Company Information";
}