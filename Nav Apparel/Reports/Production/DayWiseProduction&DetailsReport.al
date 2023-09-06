report 50622 DayWiseProductionReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Day Wise Production & Details Report';
    RDLCLayout = 'Report_Layouts/Production/DayWiseProductionReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(ProductionOutHeader; ProductionOutHeader)
        {
            DataItemTableView = sorting("No.");
            column(Created_Date; "Prod Date")
            { }
            column(Style_Name; "Style Name")
            { }
            column(BuyerName; BuyerName)
            { }
            column(SMV; SMV)
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(stDate; stDate)
            { }
            column(endDate; endDate)
            { }
            column(cutting; CutQty)
            { }
            column(Sewing; SewingoutQty)
            { }
            column(Finishing; FinishQty)
            { }
            column(PO_No_; "PO No")
            { }
            column(ShipQty; ShipQty)
            { }
            column(WashQty; WashQty)
            { }
            column(Factory_Name; "Factory Name")
            { }

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                if (stDate <> 0D) and (endDate <> 0D) then
                    SetRange("Prod Date", stDate, endDate);

                if FactoryFilter <> '' then
                    SetRange("Factory Code", FactoryFilter);
            end;

            trigger OnAfterGetRecord()
            begin
                comRec.Get;
                comRec.CalcFields(Picture);

                StyleRec.Reset();
                StyleRec.SetRange("No.", "Style No.");
                if StyleRec.FindSet() then begin
                    SMV := StyleRec.SMV;
                    BuyerName := StyleRec."Buyer Name";
                end;

                ShipQty := 0;
                SalesInVRec.Reset();
                SalesInVRec.SetRange("Style No", "Style No.");
                SalesInVRec.SetRange("PO No", "PO No");
                if SalesInVRec.FindSet() then begin
                    SalesLineRec.Reset();
                    SalesLineRec.SetRange("Document No.", SalesInVRec."No.");
                    SalesLineRec.SetFilter("Shipment Date", '%1..%2', stDate, endDate);
                    SalesLineRec.SetRange(Type, SalesLineRec.Type::Item);
                    if SalesLineRec.FindSet() then begin
                        repeat
                            ShipQty += SalesLineRec.Quantity;
                        until SalesLineRec.Next() = 0;
                    end;
                end;

                CutQty := 0;
                ProdOutRec.Reset();
                ProdOutRec.SetRange("No.", "No.");
                ProdOutRec.SetRange("Style No.", "Style No.");
                ProdOutRec.SetRange("PO No", "PO No");
                ProdOutRec.SetFilter("Prod Date", '%1..%2', stDate, endDate);
                ProdOutRec.SetRange(Type, ProdOutRec.Type::Cut);
                if ProdOutRec.FindSet() then begin
                    repeat
                        CutQty += ProdOutRec."Output Qty"
                    until ProdOutRec.Next() = 0;
                end;


                SewingoutQty := 0;
                ProdOutRec.Reset();
                ProdOutRec.SetRange("No.", "No.");
                ProdOutRec.SetRange("Style No.", "Style No.");
                ProdOutRec.SetRange("PO No", "PO No");
                ProdOutRec.SetFilter("Prod Date", '%1..%2', stDate, endDate);
                ProdOutRec.SetRange(Type, ProdOutRec.Type::Saw);
                if ProdOutRec.FindSet() then begin
                    repeat
                        SewingoutQty += ProdOutRec."Output Qty"
                    until ProdOutRec.Next() = 0;
                end;

                FinishQty := 0;
                ProdOutRec.Reset();
                ProdOutRec.SetRange("No.", "No.");
                ProdOutRec.SetRange("Style No.", "Style No.");
                ProdOutRec.SetRange("PO No", "PO No");
                ProdOutRec.SetFilter("Prod Date", '%1..%2', stDate, endDate);
                ProdOutRec.SetRange(Type, ProdOutRec.Type::Fin);
                if ProdOutRec.FindSet() then begin
                    repeat
                        FinishQty += ProdOutRec."Output Qty"
                    until ProdOutRec.Next() = 0;
                end;

                WashQty := 0;
                ProdOutRec.Reset();
                ProdOutRec.SetRange("No.", "No.");
                ProdOutRec.SetRange("Style No.", "Style No.");
                ProdOutRec.SetRange("PO No", "PO No");
                ProdOutRec.SetFilter("Prod Date", '%1..%2', stDate, endDate);
                ProdOutRec.SetRange(Type, ProdOutRec.Type::Wash);
                if ProdOutRec.FindSet() then begin
                    repeat
                        WashQty += ProdOutRec."Output Qty"
                    until ProdOutRec.Next() = 0;
                end;


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
                    Caption = 'Filter By';

                    field(FactoryFilter; FactoryFilter)
                    {
                        ApplicationArea = all;
                        Caption = 'Factory';
                        TableRelation = Location.Code;
                    }
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
    }

    var
        BuyerName: Text[50];
        SMV: Decimal;
        StyleRec: Record "Style Master";
        StylePoRec: Record "Style Master PO";
        FactoryFilter: Code[20];
        WashQty: BigInteger;
        ShipQty: Decimal;
        SalesLineRec: Record "Sales Invoice Line";
        SalesInVRec: Record "Sales Invoice Header";
        FinishQty: BigInteger;
        SewingoutQty: BigInteger;
        CutQty: BigInteger;
        ProdOutRec: Record ProductionOutHeader;
        stDate: Date;
        endDate: Date;
        comRec: Record "Company Information";
}