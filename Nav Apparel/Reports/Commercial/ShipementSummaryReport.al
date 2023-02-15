report 51244 ShipementSummaryReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Shipment Summary As Per SC/UD';
    RDLCLayout = 'Report_Layouts/Commercial/ShipementSummaryReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Contract/LCMaster"; "Contract/LCMaster")
        {
            DataItemTableView = sorting("No.");
            column(Buyer; Buyer)
            { }
            column(Contract_No; "Contract No")
            { }
            column(Factory; Factory)
            { }
            column(UdNo; UdNo)
            { }
            column(Contract_Value; "Contract Value")
            { }
            column(CompLogo; comRec.Picture)
            { }

            dataitem("Contract/LCStyle"; "Contract/LCStyle")
            {
                DataItemLinkReference = "Contract/LCMaster";
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.");

                column(OrderQty; OrderQty)
                { }

                trigger OnAfterGetRecord()
                begin
                    StyleRec.Reset();
                    StyleRec.SetRange("No.", "Style No.");
                    if StyleRec.FindFirst() then begin
                        OrderQty := StyleRec."Order Qty";
                    end;

                    StylePoRec.Reset();
                    StylePoRec.SetRange("Style No.", "Style No.");
                    if StylePoRec.FindFirst() then begin
                        ShDate := StylePoRec."Ship Date";
                    end;
                end;
            }

            dataitem(UDHeader; UDHeader)
            {
                DataItemLinkReference = "Contract/LCMaster";
                DataItemLink = "LC/Contract No." = field("Contract No");
                DataItemTableView = sorting("No.");

                column(UD_No; "No.")
                { }
                column(UdQuanty; Qantity)
                { }
                column(UdValue; Value)
                { }
                column(ShDate; ShDate)
                { }
                column(ShipValue; ShipValue)
                { }
                column(ShipQty; ShipQty)
                { }
            }

            trigger OnAfterGetRecord()
            begin
                UdStyleRec.Reset();
                UdStyleRec.SetRange("No.", "No.");
                if UdStyleRec.FindFirst() then begin
                    ShDate := UdStyleRec."Ship Date";
                    ShipValue := UdStyleRec."Ship Values";
                    ShipQty := UdStyleRec."Ship Qty";
                end;

                comRec.Get;
                comRec.CalcFields(Picture);
            end;


            trigger OnPreDataItem()
            begin
                SetRange("Buyer No.", BuyerFilter);
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
                    field(BuyerFilter; BuyerFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Buyer';
                        TableRelation = Customer."No.";
                    }
                }
            }
        }
    }


    var
        BuyerFilter: Code[20];
        ShipQty: BigInteger;
        ShipValue: Decimal;
        comRec: Record "Company Information";
        UdValue: Decimal;
        UdNo: Code[20];
        UdQuanty: BigInteger;
        UdStyleRec: Record UDStylePOinformation;
        ShDate: Date;
        StylePoRec: Record "Style Master PO";
        OrderQty: BigInteger;
        StyleRec: Record "Style Master";
}