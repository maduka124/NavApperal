report 50629 ExportSummartReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Export Summary Report';
    RDLCLayout = 'Report_Layouts/Commercial/Export Summary Report.rdl';
    DefaultLayout = RDLC;
    dataset
    {
        dataitem("Contract/LCMaster"; "Contract/LCMaster")
        {
            DataItemTableView = sorting("No.");
            column(ContractNo; "Contract No")
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(stDate; stDate)
            { }
            column(endDate; endDate)
            { }

            dataitem("Contract/LCStyle"; "Contract/LCStyle")
            {
                DataItemLinkReference = "Contract/LCMaster";
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.");

                column(Style_No_; "Style Name")
                { }

                // column(Order_Qty; OrderQt)
                // { }

                // column(PO_No; PoNo)
                // { }

                column(Mode; Mode)
                { }

                // column(ShipQty; ShipQty)
                // { }

                // column(Balance; OrderQt - ShipQty)
                // { }

                // column(ShipValue; UnitPrice * ShipQty)
                // { }

                // column(UnitPrice; UnitPrice)
                // { }

                // column(InvoiceDate; InvoiceDate)
                // { }

                column(Factory; FactoryName)
                { }

                column(Buyer_Name; BuyerName)
                { }

                dataitem("Style Master PO"; "Style Master PO")
                {
                    DataItemLinkReference = "Contract/LCStyle";
                    DataItemLink = "Style No." = field("Style No.");


                    column(PO_No; "PO No.")
                    { }

                    column(Order_Qty; Qty)
                    { }

                    column(UnitPrice; "Unit Price")
                    { }

                    dataitem("Sales Invoice Header"; "Sales Invoice Header")
                    {
                        DataItemLinkReference = "Style Master PO";
                        DataItemLink = "Style No" = field("Style No.");

                        column(No_; "No.")
                        { }

                        column(Posting_Date; "Posting Date")
                        { }

                        column(Amount_Including_VAT; "Amount Including VAT")
                        { }

                        column(ShipQty; ShipQty)
                        { }

                        trigger OnAfterGetRecord()
                        var
                            SalesInvoiceLineRec: Record "Sales Invoice Line";
                        // StyleMasterPoRec: Record "Style Master PO";
                        begin

                            // StyleMasterPoRec.Reset();
                            // StyleMasterPoRec.SetRange("Style No.", "Style No");
                            // if StyleMasterPoRec.FindSet() then begin

                            //     OrderQt := StyleMasterPoRec.Qty;
                            //     PoNo := StyleMasterPoRec."PO No.";
                            //     UnitPrice := StyleMasterPoRec."Unit Price";
                            // end;

                            ShipQty := 0;

                            // SalesInvoiceLineRec.Reset();
                            // SalesInvoiceLineRec.SetRange("Document No.", "No.");
                            // SalesInvoiceLineRec.SetFilter(Type, '=%1', SalesInvoiceLineRec.Type::Item);

                            // if SalesInvoiceLineRec.FindSet() then begin
                            //     repeat
                            //         ShipQty += SalesInvoiceLineRec.Quantity;
                            //     until SalesInvoiceLineRec.Next() = 0;
                            // end;

                            SalesInvoiceLineRec.Reset();
                            SalesInvoiceLineRec.SetRange("Document No.", "No.");
                            SalesInvoiceLineRec.SetRange(Type, SalesInvoiceLineRec.Type::Item);
                            if SalesInvoiceLineRec.FindFirst() then begin
                                repeat
                                    ShipQty += SalesInvoiceLineRec.Quantity;
                                until SalesInvoiceLineRec.Next() = 0;
                            end;

                            CalcFields("Amount Including VAT");

                        end;
                    }
                }

                trigger OnAfterGetRecord()
                var
                    SalesInvoiceLineRec: Record "Sales Invoice Line";
                begin

                    // StylePoRec.SetRange("Style No.", "Style No.");
                    // if StylePoRec.FindFirst() then begin
                    //     UnitPrice := StylePoRec."Unit Price";
                    // end;

                    // InvoiceRec.SetRange("Style No", "Style No.");
                    // if InvoiceRec.FindFirst() then begin
                    //     InvoiceNO := InvoiceRec."No.";
                    //     InvoiceDate := InvoiceRec."Document Date";
                    // end;
                    // StyleMasterPoRec.Reset();
                    // StyleMasterPoRec.SetRange("Style No.", "Style No.");
                    // if StyleMasterPoRec.FindSet() then begin
                    //     repeat
                    //         OrderQt := StyleMasterPoRec.Qty;
                    //         // PoNo := StyleMasterPoRec."PO No.";
                    //         UnitPrice := StyleMasterPoRec."Unit Price";
                    //     // BuyerName := StyleRec.;
                    //     until StyleMasterPoRec.Next() = 0;
                    // end;

                    StyleMasterRec.Reset();
                    StyleMasterRec.SetRange("No.", "Style No.");

                    if StyleMasterRec.FindSet() then
                        BuyerName := StyleMasterRec."Buyer Name";

                    LCRec.SetRange("No.", "No.");
                    if LCRec.FindFirst() then begin
                        FactoryName := LCRec.Factory;
                    end;

                end;
            }
            trigger OnAfterGetRecord()
            var

            begin
                ShipMode := "Shipment Mode";
                Mode := '';
                if ShipMode = 0 then begin
                    Mode := 'Sea';
                end
                else
                    if ShipMode = 1 then begin
                        Mode := 'Air';
                    end
                    else
                        if ShipMode = 2 then begin
                            Mode := 'Sea-Air';
                        end
                        else
                            if ShipMode = 3 then begin
                                Mode := 'Air-Sea';
                            end
                            else
                                if ShipMode = 4 then begin
                                    Mode := 'By-Road';
                                end;
                comRec.Get;
                comRec.CalcFields(Picture);

            end;

            trigger OnPreDataItem()
            begin

                //Done By Sachith On 15/03/23
                if stDate <> 0D then
                    SetRange("Created Date", stDate, endDate);

                if "Buyer Code" <> '' then
                    SetRange("Buyer No.", "Buyer Code");

                if "Factory Code" <> '' then
                    SetRange("Factory No.", "Factory Code");

                if Contract <> '' then
                    SetRange("No.", Contract);
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
                    //Done By Sachith On 15/03/23
                    field("Buyer Code"; "Buyer Code")
                    {
                        ApplicationArea = All;
                        // ShowMandatory = true;
                        Caption = 'Buyer';
                        TableRelation = Customer."No.";
                    }

                    //Done By Sachith On 15/03/23
                    field("Factory Code"; "Factory Code")
                    {
                        ApplicationArea = All;
                        Caption = 'Factory';
                        // ShowMandatory = true;
                        TableRelation = Location.Code where("Sewing Unit" = filter(true));
                    }

                    //Done By Sachith On 15/03/23
                    field(Contract; Contract)
                    {
                        ApplicationArea = All;
                        Caption = 'Contract No';
                        TableRelation = "Contract/LCMaster"."No.";
                        // ShowMandatory = true;
                    }

                    //Done By Sachith On 15/03/23
                    // field("LC No"; "LC No")
                    // {
                    //     ShowMandatory = true;
                    //     ApplicationArea = All;
                    //     Caption = 'Contract LC No';
                    //     TableRelation = "Contract/LCMaster"."No.";
                    // }

                    field(stDate; stDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                        ShowMandatory = true;
                    }

                    field(endDate; endDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                        ShowMandatory = true;
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

        // InvoiceNO: Code[50];
        InvoiceDate: Date;
        ShipMode: Option;
        Mode: Text[50];
        stDate: Date;
        endDate: Date;
        OrderQt: BigInteger;
        PoNo: Code[20];
        // StylePoRec: Record "Style Master PO";
        ShipQty: BigInteger;
        UnitPrice: Decimal;
        FilterDate: Date;
        comRec: Record "Company Information";
        // InvoiceRec: Record "Sales Invoice Header";
        StyleMasterRec: Record "Style Master";
        LCRec: Record "Contract/LCMaster";
        FactoryName: text[50];
        BuyerName: Text[50];
        "Contract": code[20];
        "LC No": Code[20];
        "Buyer Code": Code[20];
        "Factory Code": Code[20];


}