report 50724 ContractExportStatus
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Contract Export Status Report';
    RDLCLayout = 'Report_Layouts/Commercial/ContractExportStatusReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Contract/LCMaster"; "Contract/LCMaster")
        {
            DataItemTableView = where("No." = filter(<> ''));

            column(Buyer; Buyer)
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(LcNo; "Contract No")
            { }
            column(RoundUnitPrice; RoundUnitPrice)
            { }
            column(RoundOrderValue; RoundOrderValue)
            { }
            column(RoundShip; RoundShip)
            { }

            dataitem("Contract/LCStyle"; "Contract/LCStyle")
            {
                DataItemLinkReference = "Contract/LCMaster";
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.", "Style No.");

                column(Style_Name; "Style Name")
                { }

                dataitem("Style Master PO"; "Style Master PO")
                {
                    DataItemLinkReference = "Contract/LCStyle";
                    DataItemLink = "Style No." = field("Style No.");
                    DataItemTableView = sorting("Style No.", "Lot No.");

                    column(Qty; Qty)
                    { }
                    column(Shipped_Qty; ShipQty)
                    { }
                    column(PO_No_; "PO No.")
                    { }
                    column(ShipDate; ShipDate)
                    { }
                    column(Ship_Date; ShipDate)
                    { }
                    column(Shipment_Date; ShDate)
                    { }

                    trigger OnAfterGetRecord()
                    var
                        myInt: Integer;
                    begin
                        StyleRec.Reset();
                        StyleRec.SetRange("No.", "Style No.");
                        if StyleRec.FindSet() then begin
                            StylePoRec.Reset();
                            StylePoRec.SetRange("Style No.", StyleRec."No.");
                            if StylePoRec.FindSet() then begin
                                RoundUnitPrice := Round(StylePoRec."Unit Price", 0.01, '=');
                            end;

                            POQty := 0;
                            StylePoRec.Reset();
                            StylePoRec.SetRange("Style No.", "Style No.");
                            StylePoRec.SetRange("PO No.", "PO No.");
                            if StylePoRec.FindSet() then begin
                                repeat
                                    POQty += StylePoRec.Qty;
                                until StylePoRec.Next() = 0;
                            end;
                        end;


                        // ShipmentLineRec.Reset();
                        // ShipmentLineRec.SetRange("Order No.", "PO No.");
                        // ShipmentLineRec.SetRange(Type, ShipmentLineRec.Type::Item);
                        // if ShipmentLineRec.FindSet() then begin
                        //     repeat
                        //         ShipQty += ShipmentLineRec.Quantity;
                        //     until ShipmentLineRec.Next() = 0;
                        // end;

                        SalesInvHRec.Reset();
                        SalesInvHRec.SetRange("Style No", "Style No.");
                        SalesInvHRec.SetRange("PO No", "PO No.");
                        SalesInvHRec.SetRange(EntryType, SalesInvHRec.EntryType::FG);
                        SalesInvHRec.SetRange("Bal. Account Type", SalesInvHRec."Bal. Account Type"::"G/L Account");
                        if SalesInvHRec.FindSet() then begin

                            ShipQty := 0;
                            SalesInvoiceLineRec.Reset();
                            SalesInvoiceLineRec.SetRange("Document No.", SalesInvHRec."No.");
                            SalesInvoiceLineRec.SetRange(Type, SalesInvoiceLineRec.Type::Item);
                            if SalesInvoiceLineRec.FindSet() then begin
                                repeat
                                    ShipQty += SalesInvoiceLineRec.Quantity;
                                until SalesInvoiceLineRec.Next() = 0;
                            end;
                        end;


                        RoundOrderValue := POQty * RoundUnitPrice;
                        RoundShip := ShipQty * RoundUnitPrice;

                        // SalesInvoiceLineRec.Reset();
                        // SalesInvoiceLineRec.SetRange("Document No.", "No.");
                        // SalesInvoiceLineRec.SetRange(Type, SalesInvoiceLineRec.Type::Item);
                        // SalesInvoiceLineRec.SetCurrentKey("Shipment Date");
                        // SalesInvoiceLineRec.Ascending(true);
                        // if SalesInvoiceLineRec.FindLast() then begin
                        //     ShipDate := SalesInvoiceLineRec."Shipment Date";
                        // end;

                        SalesInvHRec.Reset();
                        SalesInvHRec.SetRange("Style No", "Style No.");
                        SalesInvHRec.SetRange("PO No", "PO No.");
                        SalesInvHRec.SetRange(EntryType, SalesInvHRec.EntryType::FG);
                        SalesInvHRec.SetRange("Bal. Account Type", SalesInvHRec."Bal. Account Type"::"G/L Account");
                        SalesInvHRec.SetCurrentKey("Shipment Date");
                        SalesInvHRec.Ascending(true);
                        if SalesInvHRec.FindFirst() then begin
                            ShDate := SalesInvHRec."Shipment Date";
                        end;

                        SalesInvHRec.Reset();
                        SalesInvHRec.SetRange("Style No", "Style No.");
                        SalesInvHRec.SetRange("PO No", "PO No.");
                        SalesInvHRec.SetRange(EntryType, SalesInvHRec.EntryType::FG);
                        SalesInvHRec.SetRange("Bal. Account Type", SalesInvHRec."Bal. Account Type"::"G/L Account");
                        SalesInvHRec.SetCurrentKey("Shipment Date");
                        SalesInvHRec.Ascending(true);
                        if SalesInvHRec.FindLast() then begin
                            ShipDate := SalesInvHRec."Shipment Date";
                        end;

                    end;
                }
            }

            trigger OnPreDataItem()

            begin
                if FilterBuyer <> '' then
                    SetRange("Buyer No.", FilterBuyer);

                if LcNo <> '' then
                    SetRange("Contract No", LcNo);
            end;

            trigger OnAfterGetRecord()

            begin
                comRec.Get;
                comRec.CalcFields(Picture);

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
        SalesInvHRec: Record "Sales Invoice Header";
        ShDate: Date;
        ShipmentLineRec: Record "Sales Shipment Line";
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