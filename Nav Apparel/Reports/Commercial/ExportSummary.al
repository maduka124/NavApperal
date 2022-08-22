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
            column(Factory; Factory)
            { }
            column(CompLogo; comRec.Picture)
            { }
            // column()
            //     { }
            // column()
            //     { }
            //     column()
            // {}
            dataitem("Style Master"; "Style Master")
            {
                DataItemLinkReference = "Contract/LCMaster";
                DataItemLink = "Buyer No." = field("Buyer No.");
                DataItemTableView = sorting("No.");
                column(Buyer_Name; "Buyer Name")
                { }
                column(Style_No_; "Style No.")
                { }
                column(Order_Qty; "Order Qty")
                { }
                column(PO_No; "PO No")
                { }
                column(Mode; Mode)
                { }
                column(stDate; stDate)
                { }
                column(endDate; endDate)
                { }
                column(ShipQty; ShipQty)
                { }
                column(Balance; "Order Qty" - ShipQty)
                { }
                column(ShipValue; UnitPrice * ShipQty)
                { }
                column(UnitPrice; UnitPrice)
                { }

                //     column()
                // {}
                //     column()
                // {}

                trigger OnAfterGetRecord()
                begin

                    StylePoRec.SetRange("Style No.", "Style Master"."No.");
                    if StylePoRec.FindFirst() then begin
                        ShipQty := StylePoRec."Shipped Qty";
                        UnitPrice := StylePoRec."Unit Price";
                    end;
                    // ContractLcMasterRec.SetRange("Buyer No.", "Style Master"."Buyer No.");
                    // if ContractLcMasterRec.FindFirst() then begin
                    //     // Factory := ContractLcMasterRec.Factory;
                    //     // ContractNo := ContractLcMasterRec."Contract No";
                    //     // ShipMode := ContractLcMasterRec."Shipment Mode";
                    // end;

                    // PiDetailsHeaderRec.SetRange("Style No.", "Style Master"."No.");
                    // if PiDetailsHeaderRec.FindFirst() then begin
                    //     InvoiceDate := PiDetailsHeaderRec."PI Date";
                    //     InvoiceNO := PiDetailsHeaderRec."No.";
                    // end;
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
                SetRange("Created Date", stDate, endDate);
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
                    field(stDate; stDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';

                    }
                    field(endDate; endDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';

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
        PiDetailsHeaderRec: Record "PI Details Header";
        InvoiceNO: Code[50];
        InvoiceDate: Date;
        ContractLcMasterRec: Record "Contract/LCMaster";
        ShipMode: Option;
        // Air: Option;
        // SeaAir: Option;
        // AirSea: Option;
        // ByRoad: Option;
        Mode: Text[50];
        stDate: Date;
        endDate: Date;
        // Factory: Text[20];
        // ContractNo: Text[20];
        StylePoRec: Record "Style Master PO";
        ShipQty: BigInteger;
        UnitPrice: Decimal;
        FilterDate: Date;
        comRec: Record "Company Information";
}