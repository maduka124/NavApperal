report 51246 LCReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = 'Report_Layouts/Commercial/LCReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Contract/LCMaster"; "Contract/LCMaster")
        {
            column(Factory_No_; "Factory No.")
            { }
            column(No_; "No.")
            { }
            column(Season_No_; "Season No.")
            { }
            column(Buyer_No_; "Buyer No.")
            { }

            // column()
            // { }
            // column()
            // { }
            // column()
            // { }
            // column()
            // { }
            // column()
            // { }
            // column()
            // { }
            // column()
            // { }
            dataitem("Contract/LCStyle"; "Contract/LCStyle")
            {
                DataItemLinkReference = "Contract/LCMaster";
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.", "Style No.");

                column(StyleDesc; StyleDesc)
                { }
                column(GarmentType; GarmentType)
                { }
                column(PoNo; PoNo)
                { }
                column(OrderQty; OrderQty)
                { }
                column(UnitPrice; UnitPrice)
                { }
                column(OrderValue; OrderQty * UnitPrice)
                { }
                column(ShipDate; ShipDate)
                { }
                column(ShipQty; ShipQty)
                { }
                column(ShipValue; UnitPrice * ShipQty)
                { }
                column(SHMode; SHMode)
                { }

                trigger OnAfterGetRecord()
                begin
                    StyleRec.Reset();
                    StyleRec.SetRange("No.", "Style No.");
                    if StyleRec.FindFirst() then begin
                        StyleDesc := StyleRec."Style No.";
                        GarmentType := StyleRec."Garment Type Name";
                        PoNo := StyleRec."PO No";
                        OrderQty := StyleRec."Order Qty";
                    end;

                    StylePORec.Reset();
                    StylePORec.SetRange("Style No.", "Style No.");
                    if StylePORec.FindFirst() then begin
                        UnitPrice := StylePORec."Unit Price";
                        ShipDate := StylePORec."Ship Date";
                        ShipQty := StylePORec."Shipped Qty";
                        SHMode := StylePORec.Mode;
                    end;
                end;
            }
            trigger OnPreDataItem()
            begin
                SetRange("Factory No.", FactoryFilter);
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
                    field(FactoryFilter; FactoryFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Factory';
                        TableRelation = Location.Code;
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
        SHMode: Option;
        ShipQty: BigInteger;
        ShipDate: Date;
        UnitPrice: Decimal;
        StylePORec: Record "Style Master PO";
        OrderQty: BigInteger;
        PoNo: Code[50];
        GarmentType: Text[50];
        StyleDesc: Text[50];
        StyleRec: Record "Style Master";
        FactoryFilter: Code[20];
}