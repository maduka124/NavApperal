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
            column(Factory; Factory)
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

                dataitem("Sales Invoice Header"; "Sales Invoice Header")
                {
                    DataItemLinkReference = "Contract/LCStyle";
                    DataItemLink = "Style No" = field("Style No."), "Sell-to Customer No." = field("Buyer No.");
                    DataItemTableView = where("No." = filter(<> ''));

                    column(No_; "Your Reference")
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
                    column(PO_No; "PO No")
                    { }
                    column(Order_Qty; POQty)
                    { }
                    column(UnitPrice; UnitPrice)
                    { }
                    column(UD_No; "UD No")
                    { }
                    column(Exp_No; "Exp No")
                    { }
                    column(Exp_Date; "Exp Date")
                    { }
                    column(No_of_Cartons; "No of Cartons")
                    { }
                    column(BL_Date; "BL Date")
                    { }
                    column(BL_No; "BL No")
                    { }
                    // column()


                    trigger OnAfterGetRecord()
                    var
                        SalesInvoiceLineRec: Record "Sales Invoice Line";
                        POLc: Code[20];
                        StyleNoLc: Code[20];
                    begin
                        StylePoRec.Reset();
                        StylePoRec.SetRange("Style No.", "Style No");
                        StylePoRec.SetRange("PO No.", "PO No");
                        if StylePoRec.FindSet() then begin
                            UnitPrice := StylePoRec."Unit Price";
                            POQty := StylePoRec.Qty;
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

                        // if UDFilter <> '' then
                        //     SetRange("UD No", UDFilter);
                    end;
                }

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

            begin
                if "Buyer Code" <> '' then
                    SetRange("Buyer No.", "Buyer Code");

                if Contract <> '' then
                    SetRange("No.", Contract);

                if Factory <> '' then
                    SetRange(Factory, FactoryFilter);

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
                    field("Buyer Code"; "Buyer Code")
                    {
                        ApplicationArea = All;
                        ShowMandatory = true;
                        Caption = 'Buyer';
                        TableRelation = Customer."No.";
                    }

                    //Done By Sachith On 15/03/23
                    field(Factory; FactoryFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Factory';
                        ShowMandatory = true;

                        trigger OnLookup(Var Text: Text): Boolean
                        var
                            LocationRec: Record Location;
                        begin

                            LocationRec.Reset();
                            LocationRec.SetFilter("Sewing Unit", '=%1', true);

                            if LocationRec.FindSet() then begin
                                if page.RunModal(15, LocationRec) = Action::LookupOK then begin
                                    FactoryFilter := LocationRec.Name;
                                    LocationCode := LocationRec.Code;
                                end;
                            end;

                        end;
                    }
                    field(Contract; Contract)
                    {
                        ApplicationArea = All;
                        Caption = 'Contract No';
                        // TableRelation = "Contract/LCMaster"."No.";
                        ShowMandatory = true;

                        trigger OnLookup(Var Text: Text): Boolean
                        var
                            contractRec: Record "Contract/LCMaster";
                        begin

                            contractRec.Reset();
                            contractRec.SetRange(Factory, FactoryFilter);
                            contractRec.SetRange("Buyer No.", "Buyer Code");
                            if contractRec.FindSet() then begin
                                if page.RunModal(50503, contractRec) = Action::LookupOK then begin
                                    Contract := contractRec."No."
                                end

                                else begin
                                    if page.RunModal(50503, contractRec) = Action::LookupOK then
                                        Contract := contractRec."No."
                                end;
                            end;
                        end;

                    }

                    // field(UDFilter; UDFilter)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'UD No';
                    //     ShowMandatory = true;

                    //     trigger OnLookup(Var Text: Text): Boolean
                    //     var
                    //         SalesInv: Record "Sales Invoice Header";
                    //     begin

                    //         SalesInv.Reset();
                    //         SalesInv.SetRange("Location Code", LocationCode);
                    //         if SalesInv.FindSet() then begin
                    //             if page.RunModal(143, SalesInv) = Action::LookupOK then begin
                    //                 UDFilter := SalesInv."UD No";
                    //             end
                    //             else begin
                    //                 if page.RunModal(143, SalesInv) = Action::LookupOK then begin
                    //                     UDFilter := SalesInv."UD No";
                    //                 end;
                    //             end;
                    //         end;
                    //     end;
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
        POQty: BigInteger;
        StylePoRec: Record "Style Master PO";
        UDFilter: Text[50];
        LocationCode: Code[20];
        ShipMode: Option;
        Mode: Text[50];
        stDate: Date;
        endDate: Date;
        ShipQty: BigInteger;
        UnitPrice: Decimal;
        comRec: Record "Company Information";
        StyleMasterRec: Record "Style Master";
        BuyerName: Text[50];
        "Contract": Code[20];
        "Buyer Code": Code[20];
        FactoryFilter: Text[100];
        POBalance: BigInteger;


}