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

            dataitem("Contract/LCStyle"; "Contract/LCStyle")
            {
                DataItemLinkReference = "Contract/LCMaster";
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.");

                column(Style_No_; "Style Name")
                { }
                column(Order_Qty; OrderQt)
                { }
                column(PO_No; PoNo)
                { }
                column(Mode; Mode)
                { }
                column(stDate; stDate)
                { }
                column(endDate; endDate)
                { }
                column(ShipQty; ShipQty)
                { }
                column(Balance; OrderQt - ShipQty)
                { }
                column(ShipValue; UnitPrice * ShipQty)
                { }
                column(UnitPrice; UnitPrice)
                { }
                column(InvoiceNO; InvoiceNO)
                { }
                column(InvoiceDate; InvoiceDate)
                { }
                column(Factory; FactoryName)
                { }
                column(Buyer_Name; BuyerName)
                { }

                trigger OnAfterGetRecord()
                var
                    SaledInvoiceHeaderRec: Record "Sales Invoice Header";
                    SalesInvoiceLineRec: Record "Sales Invoice Line";
                begin




                    StylePoRec.SetRange("Style No.", "Style No.");
                    if StylePoRec.FindFirst() then begin
                        ShipQty := StylePoRec."Shipped Qty";
                        UnitPrice := StylePoRec."Unit Price";
                    end;

                    InvoiceRec.SetRange("Style No", "Style No.");
                    if InvoiceRec.FindFirst() then begin
                        InvoiceNO := InvoiceRec."No.";
                        InvoiceDate := InvoiceRec."Document Date";
                    end;
                    StyleRec.SetRange("No.", "Style No.");
                    if StyleRec.FindFirst() then begin
                        OrderQt := StyleRec."Order Qty";
                        PoNo := StyleRec."PO No";
                        BuyerName := StyleRec."Buyer Name";
                    end;
                    LCRec.SetRange("No.", "No.");
                    if LCRec.FindFirst() then begin
                        FactoryName := LCRec.Factory;
                    end;


                    SaledInvoiceHeaderRec.Reset();
                    SaledInvoiceHeaderRec.SetRange("Style No", "Style No.");
                    SaledInvoiceHeaderRec.SetRange("PO No", PoNo);
                    if SaledInvoiceHeaderRec.FindSet() then begin
                        SalesInvoiceLineRec.Reset();
                        SalesInvoiceLineRec.SetRange("Order No.", SaledInvoiceHeaderRec."Order No.");
                        if SalesInvoiceLineRec.FindSet() then begin
                            repeat
                                ShipQty := SalesInvoiceLineRec.Quantity;
                            // Rec.ShipValue := SalesInvoiceLineRec."Line Amount";
                            until SalesInvoiceLineRec.Next() = 0;
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

        InvoiceNO: Code[50];
        InvoiceDate: Date;
        ShipMode: Option;
        Mode: Text[50];
        stDate: Date;
        endDate: Date;
        OrderQt: BigInteger;
        PoNo: Code[20];
        StylePoRec: Record "Style Master PO";
        ShipQty: BigInteger;
        UnitPrice: Decimal;
        FilterDate: Date;
        comRec: Record "Company Information";
        InvoiceRec: Record "Sales Invoice Header";
        StyleRec: Record "Style Master";
        LCRec: Record "Contract/LCMaster";
        FactoryName: text[50];
        BuyerName: Text[50];
        "Contract": code[20];
        "LC No": Code[20];
        "Buyer Code": Code[20];
        "Factory Code": Code[20];


}