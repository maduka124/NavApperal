report 50724 ContractExportStatus
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Contract Export Status Report';
    RDLCLayout = 'Report_Layouts/Commercial/ContractExportStatusReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = where("No." = filter(<> ''));

            column(Style_Name; "Style Name")
            { }
            column(Buyer; "Sell-to Customer Name")
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(LcNo; "Contract No")
            { }
            column(PO_No_; "PO No")
            { }
            column(Qty; POQty)
            { }
            column(RoundUnitPrice; RoundUnitPrice)
            { }
            column(RoundOrderValue; RoundOrderValue)
            { }
            column(Ship_Date; ShipDate)
            { }
            column(Shipped_Qty; ShipQty)
            { }
            column(RoundShip; RoundShip)
            { }

            trigger OnPreDataItem()

            begin
                if FilterBuyer <> '' then
                    SetRange("Sell-to Customer No.", FilterBuyer);

                if LcNo <> '' then
                    SetRange("Contract No", LcNo);
            end;

            trigger OnAfterGetRecord()

            begin
                comRec.Get;
                comRec.CalcFields(Picture);

                StyleRec.Reset();
                StyleRec.SetRange("Style No.", "Style Name");
                if StyleRec.FindSet() then begin
                    StylePoRec.Reset();
                    StylePoRec.SetRange("Style No.", StyleRec."No.");
                    if StylePoRec.FindSet() then begin
                        RoundUnitPrice := Round(StylePoRec."Unit Price", 0.01, '=');
                    end;

                    StylePoRec.Reset();
                    StylePoRec.SetRange("Style No.", StyleRec."No.");
                    if StylePoRec.FindSet() then begin
                        repeat
                            POQty += StylePoRec.Qty;
                        until StylePoRec.Next() = 0;
                    end;
                end;

                ShipQty := 0;
                SalesInvoiceLineRec.Reset();
                SalesInvoiceLineRec.SetRange("Document No.", "No.");
                SalesInvoiceLineRec.SetRange(Type, SalesInvoiceLineRec.Type::Item);
                if SalesInvoiceLineRec.FindSet() then begin
                    repeat
                        ShipQty += SalesInvoiceLineRec.Quantity;
                    until SalesInvoiceLineRec.Next() = 0;
                end;

                RoundOrderValue := POQty * RoundUnitPrice;
                RoundShip := ShipQty * RoundUnitPrice;

                SalesInvoiceLineRec.Reset();
                SalesInvoiceLineRec.SetRange("Document No.", "No.");
                SalesInvoiceLineRec.SetRange(Type, SalesInvoiceLineRec.Type::Item);
                SalesInvoiceLineRec.SetCurrentKey("Shipment Date");
                SalesInvoiceLineRec.Ascending(true);
                if SalesInvoiceLineRec.FindFirst() then begin
                    ShipDate := SalesInvoiceLineRec."Shipment Date";
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
                group(GroupName)
                {
                    Caption = 'Filter By';
                    field(FilterBuyer; FilterBuyer)
                    {
                        ApplicationArea = All;
                        Caption = 'Buyer No';
                        TableRelation = Customer."No.";
                    }
                    field(LcNo; LcNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Contract No';

                        trigger OnLookup(Var Text: Text): Boolean
                        var
                            SalesInv: Record "Sales Invoice Header";
                            SalesInv1: Record "Sales Invoice Header";
                        begin

                            SalesInv.Reset();
                            SalesInv.SetRange("Sell-to Customer No.", FilterBuyer);
                            if SalesInv.FindSet() then begin
                                if page.RunModal(143, SalesInv) = Action::LookupOK then begin
                                    LcNo := SalesInv."Contract No";
                                end
                            end
                            else begin
                                SalesInv.Reset();
                                if SalesInv.FindSet() then begin
                                    if page.RunModal(143, SalesInv) = Action::LookupOK then begin
                                        LcNo := SalesInv."Contract No";
                                    end;
                                end
                            end;
                        end;
                    }
                }
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
        ShipQty: BigInteger;
        SalesInvoiceLineRec: Record "Sales Invoice Line";
        POQty: BigInteger;
        StyleRec: Record "Style Master";
        StylePoRec: Record "Style Master PO";
        LcNo: Text[50];
        FilterBuyer: Code[20];
        RoundOrderValue: Decimal;
        RoundUnitPrice: Decimal;
        RoundShip: Decimal;
        comRec: Record "Company Information";

}