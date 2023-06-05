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
                column(Factory; FactoryName)
                { }
                column(PO_No; PoNo)
                { }
                column(Order_Qty; PoQty)
                { }
                column(UnitPrice; UnitPrice)
                { }
                column(No_; InvNo)
                { }
                column(Posting_Date; PostingDate)
                { }

                column(Amount_Including_VAT; AMTIncVat)
                { }

                column(ShipQty; ShipQty)
                { }

                column(Shipment_Date; "Shipment Date")
                { }

                column(POBalance; POBalance)
                { }

                dataitem("Style Master"; "Style Master")
                {
                    DataItemLinkReference = "Contract/LCStyle";
                    DataItemLink = "No." = field("Style No.");

                    dataitem("Style Master PO"; "Style Master PO")
                    {
                        DataItemLinkReference = "Style Master";
                        DataItemLink = "Style No." = field("No.");



                        dataitem("Sales Invoice Header"; "Sales Invoice Header")
                        {
                            DataItemLinkReference = "Style Master PO";
                            DataItemLink = "Style No" = field("Style No."), "PO No" = field("PO No.");
                            DataItemTableView = where("No." = filter(<> ''));

                     
                            column(ShipQty; ShipQty)
                            { }

                            column(Shipment_Date; "Shipment Date")
                            { }

                            column(POBalance; POBalance)
                            { }


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

                    POLc: Code[20];
                    StyleNoLc: Code[20];
                begin

                    StyleMasterRec.Reset();
                    StyleMasterRec.SetRange("No.", "Style No.");
                    if StyleMasterRec.FindFirst() then begin
                        BuyerName := StyleMasterRec."Buyer Name";
                        FactoryName := StyleMasterRec."Factory Name";

                        StylePoRec.Reset();
                        StylePoRec.SetRange("Style No.", StyleMasterRec."No.");
                        if StylePoRec.FindSet() then begin
                            UnitPrice := StylePoRec."Unit Price";
                            PoQty := StylePoRec.Qty;
                            PoNo := StylePoRec."PO No.";

                            InvoiceRec.Reset();
                            InvoiceRec.SetRange("Style No", StylePoRec."Style No.");
                            InvoiceRec.SetRange("PO No", StylePoRec."PO No.");
                            if InvoiceRec.FindSet() then begin
                                InvNo := InvoiceRec."No.";
                                PostingDate := InvoiceRec."Posting Date";
                                AMTIncVat := InvoiceRec."Amount Including VAT";

                                ShipQty := 0;
                                SalesInvoiceLineRec.Reset();
                                SalesInvoiceLineRec.SetRange("Document No.", InvoiceRec."No.");
                                SalesInvoiceLineRec.SetRange(Type, SalesInvoiceLineRec.Type::Item);
                                if SalesInvoiceLineRec.FindFirst() then begin
                                    repeat
                                        ShipQty += SalesInvoiceLineRec.Quantity;
                                    until SalesInvoiceLineRec.Next() = 0;

                                    if InvoiceRec."PO No" = POLc then
                                        POBalance := POBalance + ShipQty
                                    else begin
                                        POBalance := 0;
                                        POBalance := POBalance + ShipQty
                                    end;

                                    POLc := InvoiceRec."PO No";
                                    StyleNoLc := InvoiceRec."Style No";

                                    InvoiceRec.CalcFields("Amount Including VAT");
                                end;
                            end;
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
        AMTIncVat: Decimal;
        PostingDate: Date;
        InvNo: Code[20];
        SalesInvoiceLineRec: Record "Sales Invoice Line";
        PoNo: Code[20];
        PoQty: BigInteger;
        StylePoRec: Record "Style Master PO";
        ShipMode: Option;
        Mode: Text[50];
        stDate: Date;
        endDate: Date;
        ShipQty: BigInteger;
        UnitPrice: Decimal;
        FilterDate: Date;
        comRec: Record "Company Information";
        InvoiceRec: Record "Sales Invoice Header";
        StyleMasterRec: Record "Style Master";
        FactoryName: text[50];
        BuyerName: Text[50];
        "Contract": code[20];
        "Buyer Code": Code[20];
        "Factory": Text[100];
        POBalance: BigInteger;


}