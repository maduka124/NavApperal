report 51244 ShipementSummaryReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Shipment Summary As Per SC/UD';
    RDLCLayout = 'Report_Layouts/Commercial/ShipementSummaryReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(UDHeader; UDHeader)
        {
            DataItemTableView = sorting("No.");
            column(UD_No; "No.")
            { }
            column(UdQuanty; Qantity)
            { }
            column(UdValue; Value)
            { }
            column(Buyer; Buyer)
            { }
            column(Contract_No; "LC/Contract No.")
            { }
            column(Factory; Factory)
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(Contract_Value; ContractValue)
            { }

            dataitem(UDStylePOinformation; UDStylePOinformation)
            {
                DataItemLinkReference = UDHeader;
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.");
                column(ShDate; "Ship Date")
                { }
                column(ShipValue; "Ship Values")
                { }
                column(ShipQty; "Ship Qty")
                { }
                column(OrderQty; OrderQty)
                { }

                trigger OnAfterGetRecord()
                begin
                    StyleRec.Reset();
                    StyleRec.SetRange("No.", "Style No");
                    if StyleRec.FindFirst() then begin
                        OrderQty := StyleRec."Order Qty";
                    end;

                    StylePoRec.Reset();
                    StylePoRec.SetRange("Style No.", "Style No");
                    if StylePoRec.FindFirst() then begin
                        ShDate := StylePoRec."Ship Date";
                    end;
                end;

            }
            trigger OnAfterGetRecord()
            begin
                // UdStyleRec.Reset();
                // UdStyleRec.SetRange("No.", "No.");
                // if UdStyleRec.FindFirst() then begin
                //     ShDate := UdStyleRec."Ship Date";
                //     ShipValue := UdStyleRec."Ship Values";
                //     ShipQty := UdStyleRec."Ship Qty";

                LcMasterRec.Reset();
                LcMasterRec.SetRange("No.", "LC/Contract No.");
                LcMasterRec.SetRange("Buyer No.", "Buyer No.");
                if LcMasterRec.FindFirst() then begin
                    ContractValue := LcMasterRec."Contract Value";
                end;

                comRec.Get;
                comRec.CalcFields(Picture);
            end;

            trigger OnPreDataItem()
            begin
                if BuyerFilter <> '' then
                    SetRange("Buyer No.", BuyerFilter);
                if ContractFilter <> '' then
                    SetRange("LC/Contract No.", ContractFilter);
                if UdFilter <> '' then
                    SetRange("No.", UdFilter);
                if (Stdate <> 0D) and (EndDate <> 0D) then
                    SetRange("Created Date", Stdate, EndDate);
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
                    field(UdFilter; UdFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'UD No';
                        TableRelation = UDHeader."No.";
                    }
                    field(BuyerFilter; BuyerFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Buyer';
                        TableRelation = Customer."No.";
                    }
                    field(ContractFilter; ContractFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Contract No';
                        TableRelation = "Contract/LCMaster"."No.";
                    }
                    field(Stdate; Stdate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';

                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';

                    }
                }
            }
        }
    }


    var
        Stdate: Date;
        EndDate: Date;
        UdFilter: Code[20];
        ContractFilter: Text[50];
        ContractValue: Decimal;
        LcMasterRec: Record "Contract/LCMaster";
        BuyerFilter: Code[20];
        ShipQty: BigInteger;
        // ShipValue: Decimal;
        comRec: Record "Company Information";
        // UdValue: Decimal;
        // UdNo: Code[20];
        // UdQuanty: BigInteger;
        // UdStyleRec: Record UDStylePOinformation;
        ShDate: Date;
        StylePoRec: Record "Style Master PO";
        OrderQty: BigInteger;
        StyleRec: Record "Style Master";
}