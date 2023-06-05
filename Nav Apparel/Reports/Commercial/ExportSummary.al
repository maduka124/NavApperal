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

                column(Mode; Mode)
                { }

                column(Buyer_Name; BuyerName)
                { }

                dataitem("Style Master"; "Style Master")
                {
                    DataItemLinkReference = "Contract/LCStyle";
                    DataItemLink = "No." = field("Style No.");

                    column(Factory; "Factory Name")
                    { }

                    dataitem("Style Master PO"; "Style Master PO")
                    {
                        DataItemLinkReference = "Style Master";
                        DataItemLink = "Style No." = field("No.");

                        column(PO_No; "PO No.")
                        { }

                        column(Order_Qty; Qty)
                        { }

                        column(UnitPrice; "Unit Price")
                        { }

                        dataitem("Sales Invoice Header"; "Sales Invoice Header")
                        {
                            DataItemLinkReference = "Style Master PO";
                            DataItemLink = "Style No" = field("Style No."), "PO No" = field("PO No.");
                            DataItemTableView = where("No." = filter(<> ''));

                            column(No_; "No.")
                            { }

                            column(Posting_Date; "Posting Date")
                            { }

                            column(Amount_Including_VAT; "Amount Including VAT")
                            { }

                            column(ShipQty; ShipQty)
                            { }

                            column(Shipment_Date; "Shipment Date")
                            { }

                            column(POBalance; POBalance)
                            { }

                            trigger OnAfterGetRecord()
                            var
                                SalesInvoiceLineRec: Record "Sales Invoice Line";
                                POLc: Code[20];
                                StyleNoLc: Code[20];
                            begin


                                ShipQty := 0;

                                SalesInvoiceLineRec.Reset();
                                SalesInvoiceLineRec.SetRange("Document No.", "No.");
                                SalesInvoiceLineRec.SetRange(Type, SalesInvoiceLineRec.Type::Item);
                                if SalesInvoiceLineRec.FindFirst() then begin
                                    repeat
                                        ShipQty += SalesInvoiceLineRec.Quantity;
                                    until SalesInvoiceLineRec.Next() = 0;

                                end;

                                if "PO No" = POLc then
                                    POBalance := POBalance + ShipQty
                                else begin
                                    POBalance := 0;
                                    POBalance := POBalance + ShipQty
                                end;

                                POLc := "PO No";
                                StyleNoLc := "Style No";

                                "Sales Invoice Header".CalcFields("Amount Including VAT");

                            end;

                            trigger OnPreDataItem()
                            begin
                                if stDate <> 0D then
                                    SetRange("Shipment Date", stDate, endDate);
                            end;
                        }
                    }

                    trigger OnPreDataItem()
                    begin
                        if Factory <> '' then
                            SetRange("Factory Name", Factory)
                    end;
                }

                trigger OnPreDataItem()
                begin
                    if "Buyer Code" <> '' then
                        SetRange("Buyer No.", "Buyer Code");
                end;

                trigger OnAfterGetRecord()
                var
                    SalesInvoiceLineRec: Record "Sales Invoice Line";
                begin

                    StyleMasterRec.Reset();
                    StyleMasterRec.SetRange("No.", "Style No.");

                    if StyleMasterRec.FindSet() then
                        BuyerName := StyleMasterRec."Buyer Name";
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
            var
                InvoiceRec: Record "Sales Invoice Header";
                LocationRec: Record Location;
            begin

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
                    field(Factory; Factory)
                    {
                        ApplicationArea = All;
                        Caption = 'Factory';
                        // ShowMandatory = true;

                        trigger OnLookup(Var Text: Text): Boolean
                        var
                            LocationRec: Record Location;
                        begin

                            LocationRec.Reset();
                            LocationRec.SetFilter("Sewing Unit", '=%1', true);

                            if LocationRec.FindSet() then begin
                                if page.RunModal(15, LocationRec) = Action::LookupOK then
                                    Factory := LocationRec.Name

                            end;

                        end;
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
        "Factory": Text[100];
        "Factory Code": Code[20];
        POQty: BigInteger;
        POBalance: BigInteger;


}