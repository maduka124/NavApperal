report 50629 ExportSummartReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Export Summary Report';
    RDLCLayout = 'Report_Layouts/Commercial/Export Summary Report.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = where("No." = filter(<> ''));

            column(Style_No_; "Style Name")
            { }
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
            column(LC_No; "LC No")
            { }
            column(ContractNo; "Contract No")
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(stDate; stDate)
            { }
            column(endDate; endDate)
            { }
            column(Factory; "Location Code")
            { }
            column(Buyer_Name; "Sell-to Customer Name")
            { }
            column(Mode; Mode)
            { }
            column(Brand_Name; "Brand Name")
            { }
            // dataitem("Contract/LCMaster"; "Contract/LCMaster")

            // {
            //     DataItemLinkReference = "Sales Invoice Header";
            //     DataItemLink = "Contract No" = field("Contract No");
            //     DataItemTableView = sorting("No.");



            //     trigger OnAfterGetRecord()
            //     var

            //     begin
            //         ShipMode := "Shipment Mode";
            //         Mode := '';
            //         if ShipMode = 0 then begin
            //             Mode := 'Sea';
            //         end
            //         else
            //             if ShipMode = 1 then begin
            //                 Mode := 'Air';
            //             end
            //             else
            //                 if ShipMode = 2 then begin
            //                     Mode := 'Sea-Air';
            //                 end
            //                 else
            //                     if ShipMode = 3 then begin
            //                         Mode := 'Air-Sea';
            //                     end
            //                     else
            //                         if ShipMode = 4 then begin
            //                             Mode := 'By-Road';
            //                         end;

            //     end;
            // }
            trigger OnAfterGetRecord()
            var
                SalesInvoiceLineRec: Record "Sales Invoice Line";
                POLc: Code[20];
                StyleNoLc: Code[20];
            begin

                ContractRec.Reset();
                ContractRec.SetRange("Contract No", "Contract No");
                if ContractRec.FindSet() then begin
                    ShipMode := ContractRec."Shipment Mode";
                end;

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

                POQty := 0;
                StylePoRec.Reset();
                StylePoRec.SetRange("Style No.", "Style No");
                StylePoRec.SetRange("PO No.", "PO No");
                if StylePoRec.FindSet() then begin
                    UnitPrice := StylePoRec."Unit Price";
                    POQty += StylePoRec.Qty;
                end;

                // ShipQty := 0;
                // SalesInvoiceLineRec.Reset();
                // SalesInvoiceLineRec.SetRange("Document No.", "No.");
                // SalesInvoiceLineRec.SetRange(Type, SalesInvoiceLineRec.Type::Item);
                // if SalesInvoiceLineRec.FindFirst() then begin
                //     repeat
                //         ShipQty += SalesInvoiceLineRec.Quantity;
                //     until SalesInvoiceLineRec.Next() = 0;
                // end;

                ShipQty := 0;
                SalesShipmentLineRec.Reset();
                SalesShipmentLineRec.SetRange("Order No.", "Order No.");
                SalesShipmentLineRec.SetRange(Type, SalesShipmentLineRec.Type::Item);
                if SalesShipmentLineRec.FindSet() then begin
                    repeat
                        ShipQty += SalesShipmentLineRec.Quantity;
                    until SalesShipmentLineRec.Next() = 0;
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

                if UDFilter <> '' then
                    SetRange("UD No", UDFilter);

                if FactoryInvFilter <> '' then
                    SetRange("Your Reference", FactoryInvFilter);

                if "Buyer Code" <> '' then
                    SetRange("Sell-to Customer No.", "Buyer Code");

                if Contract <> '' then
                    SetRange("Contract No", Contract);

                if FactoryFilter <> '' then
                    SetRange("Location Code", FactoryFilter);

                if BrandNameFilter <> '' then
                    SetRange("Brand Name", BrandNameFilter);
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
                        // ShowMandatory = true;
                        Caption = 'Buyer';
                        TableRelation = Customer."No.";
                    }
                    field(BrandNameFilter; BrandNameFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Brand Name';

                        trigger OnLookup(Var Text: Text): Boolean
                        var
                            StyleRec: Record "Style Master";
                            StyleRec1: Record "Style Master";
                        begin

                            StyleRec.Reset();
                            // StyleRec.SetFilter("Buyer No.", '<>%1', '');
                            StyleRec.SetRange(Status, StyleRec.Status::Confirmed);
                            StyleRec.SetRange("Buyer No.", "Buyer Code");
                            if StyleRec.FindSet() then begin
                                if page.RunModal(51067, StyleRec) = Action::LookupOK then begin
                                    BrandNameFilter := StyleRec."Brand Name";
                                end
                            end
                            else begin
                                StyleRec.Reset();
                                StyleRec.SetRange(Status, StyleRec.Status::Confirmed);
                                if StyleRec.FindSet() then begin
                                    if page.RunModal(51067, StyleRec) = Action::LookupOK then begin
                                        BrandNameFilter := StyleRec."Brand Name";
                                    end;
                                end;
                            end;
                        end;

                    }
                    //Done By Sachith On 15/03/23
                    field(Factory; FactoryFilter)
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
                                if page.RunModal(15, LocationRec) = Action::LookupOK then begin
                                    FactoryFilter := LocationRec.Code;
                                    LocationCode := LocationRec.Code;
                                end
                            end
                            else begin
                                if page.RunModal(15, LocationRec) = Action::LookupOK then begin
                                    FactoryFilter := LocationRec.Code;
                                    LocationCode := LocationRec.Code;
                                end;
                            end

                        end;
                    }

                    field(FactoryInvFilter; FactoryInvFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Factory Invoice No';

                        trigger OnLookup(Var Text: Text): Boolean
                        var
                            SalesInv: Record "Sales Invoice Header";
                        begin

                            SalesInv.Reset();
                            SalesInv.SetRange("Location Code", LocationCode);
                            if SalesInv.FindSet() then begin
                                if page.RunModal(143, SalesInv) = Action::LookupOK then begin
                                    FactoryInvFilter := SalesInv."Your Reference";
                                end
                            end
                            else begin
                                SalesInv.Reset();
                                if SalesInv.FindSet() then begin
                                    if page.RunModal(143, SalesInv) = Action::LookupOK then begin
                                        FactoryInvFilter := SalesInv."Your Reference";
                                    end;
                                end;
                            end

                        end;
                    }
                    field(UDFilter; UDFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'UD No';

                        trigger OnLookup(Var Text: Text): Boolean
                        var
                            SalesInv: Record "Sales Invoice Header";
                            SalesInv1: Record "Sales Invoice Header";
                        begin

                            SalesInv.Reset();
                            SalesInv.SetRange("Location Code", LocationCode);
                            SalesInv.SetRange("Your Reference", FactoryInvFilter);
                            if SalesInv.FindSet() then begin
                                if page.RunModal(143, SalesInv) = Action::LookupOK then begin
                                    UDFilter := SalesInv."UD No";
                                end
                            end
                            else begin
                                SalesInv.Reset();
                                if SalesInv.FindSet() then begin
                                    if page.RunModal(143, SalesInv1) = Action::LookupOK then begin
                                        UDFilter := SalesInv1."UD No";
                                    end;
                                end
                            end;
                        end;
                    }
                    field(Contract; Contract)
                    {
                        ApplicationArea = All;
                        Caption = 'Contract No';
                        // TableRelation = "Contract/LCMaster"."No.";
                        // ShowMandatory = true;

                        trigger OnLookup(Var Text: Text): Boolean
                        var
                            SalesInv: Record "Sales Invoice Header";
                            SalesInv1: Record "Sales Invoice Header";
                        begin

                            SalesInv.Reset();
                            SalesInv.SetRange("Location Code", LocationCode);
                            SalesInv.SetRange("Your Reference", FactoryInvFilter);
                            if SalesInv.FindSet() then begin
                                if page.RunModal(143, SalesInv) = Action::LookupOK then begin
                                    Contract := SalesInv."Contract No";
                                end
                            end
                            else begin
                                SalesInv.Reset();
                                if SalesInv.FindSet() then begin
                                    if page.RunModal(143, SalesInv) = Action::LookupOK then begin
                                        Contract := SalesInv."Contract No";
                                    end;
                                end
                            end;
                        end;
                    }
                    field(stDate; stDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                        // ShowMandatory = true;
                    }

                    field(endDate; endDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                        // ShowMandatory = true;
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
        SalesShipmentLineRec: Record "Sales Shipment Line";
        BrandNameFilter: Text[50];
        ContractRec: Record "Contract/LCMaster";
        FactoryInvFilter: Text[35];
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
        "Contract": Text[50];
        "Buyer Code": Code[20];
        FactoryFilter: Code[20];
        POBalance: BigInteger;


}