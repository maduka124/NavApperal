report 50852 SewingProductionDetails
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Sewing Production Details';
    RDLCLayout = 'Report_Layouts/Planning/SewingProductionDetails.rdl';
    DefaultLayout = RDLC;


    dataset
    {
        dataitem(ProductionOutHeader; ProductionOutHeader)
        {
            DataItemTableView = where(Type = filter('Saw'), "Output Qty" = filter(<> 0));

            column(TodayOutput; "Output Qty")
            { }
            column(OutPutStartDate; "Prod Date")
            { }
            column(Resource_No_; "Resource Name")
            { }
            column(PO_No_; "PO No")
            { }
            column(TodayTarget; Quantity)
            { }
            column(BuyerName; BuyerName)
            { }
            column(PlanQty; PlanQty)
            { }
            column(InputDate; InputDate)
            { }
            column(TotalOuput; TotalOuput)
            { }
            column(OutputComDate; OutputComDate)
            { }
            column(ShipDate; ShipDate)
            { }
            column(stDate; stDate)
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(Style; "Out Style Name")
            { }
            column(Factory; Factory)
            { }
            column(OrderQy; OrderQy)
            { }
            column(Style_No_; "Out Style No.")
            { }

            trigger OnPreDataItem()
            begin
                SetRange("Prod Date", stDate);
            end;

            trigger OnAfterGetRecord()
            begin

                NavAppProdRec.Reset();
                NavAppProdRec.SetRange("Style No.", "Out Style No.");
                NavAppProdRec.SetRange(PlanDate, "Prod Date");
                if NavAppProdRec.FindFirst() then begin
                    Quantity := NavAppProdRec.Qty;
                end;

                // TotalOuput := 0;
                // StylePoRec.Reset();
                // StylePoRec.SetRange("Style No.", "Out Style No.");
                // StylePoRec.SetRange("PO No.", "OUT PO No");
                // StylePoRec.SetRange("Lot No.", "Out Lot No.");
                // if StylePoRec.FindSet() then begin
                //     repeat
                //         TotalOuput += StylePoRec."Sawing Out Qty";
                //     until StylePoRec.Next() = 0;
                // end;

                TotalOuput := 0;
                ProductionHeaderRec.Reset();
                ProductionHeaderRec.SetFilter(Type, '=%1', ProductionHeaderRec.Type::Saw);
                ProductionHeaderRec.SetFilter("Prod Date", '<=%1', stDate);
                ProductionHeaderRec.SetRange("Resource No.", "Resource No.");
                ProductionHeaderRec.SetRange("out Style No.", "Out Style No.");
                ProductionHeaderRec.SetRange("OUT PO No", "OUT PO No");
                ProductionHeaderRec.SetRange("out Lot No.", "Out Lot No.");
                if ProductionHeaderRec.FindSet() then begin
                    repeat
                        TotalOuput += ProductionHeaderRec."Output Qty";
                    until ProductionHeaderRec.Next() = 0;
                end;

                //Input date first date
                ProductionHeaderRec.Reset();
                ProductionHeaderRec.SetRange("No.", "No.");
                ProductionHeaderRec.SetFilter(Type, '=%1', ProductionHeaderRec.Type::Saw);
                ProductionHeaderRec.SetRange("Prod Date", "Prod Date");
                ProductionHeaderRec.SetCurrentKey("Prod Date");
                ProductionHeaderRec.Ascending(true);
                if ProductionHeaderRec.FindFirst() then begin
                    InputDate := ProductionHeaderRec."Prod Date";
                end;

                //OutPut Complete Date
                ProductionHeaderRec.Reset();
                ProductionHeaderRec.SetRange("No.", "No.");
                ProductionHeaderRec.SetFilter(Type, '=%1', ProductionHeaderRec.Type::Saw);
                ProductionHeaderRec.SetRange("Prod Date", "Prod Date");
                ProductionHeaderRec.SetCurrentKey("Prod Date");
                ProductionHeaderRec.Ascending(true);
                if ProductionHeaderRec.FindLast() then begin
                    OutputComDate := ProductionHeaderRec."Prod Date";
                end;

                StylePoRec.Reset();
                StylePoRec.SetRange("Style No.", "Out Style No.");
                StylePoRec.SetRange("PO No.", "out PO No");
                StylePoRec.SetRange("Lot No.", "Out Lot No.");
                if StylePoRec.FindSet() then begin
                    repeat
                        OrderQy += StylePoRec.Qty;
                    until StylePoRec.Next() = 0;
                end;


                StylePoRec.Reset();
                StylePoRec.SetRange("Style No.", "Out Style No.");
                StylePoRec.SetRange("PO No.", "out PO No");
                StylePoRec.SetRange("Lot No.", "Out Lot No.");
                if StylePoRec.FindFirst() then begin
                    ShipDate := StylePoRec."Ship Date";
                end;


                StyleRec.Reset();
                StyleRec.SetRange("No.", "Out Style No.");
                if StyleRec.FindFirst() then begin
                    BuyerName := StyleRec."Buyer Name";
                    Style := StyleRec."Style No.";
                    Factory := StyleRec."Factory Name";
                end;

                comRec.Get;
                comRec.CalcFields(Picture);

                NavLinesRec.Reset();
                NavLinesRec.SetRange("Style No.", "Out Style No.");
                // NavLinesRec.SetRange("Resource No.", "Resource No.");
                // NavLinesRec.SetRange("PO No.", "PO No");
                // NavLinesRec.SetRange("Line No.", "Line No.");
                if NavLinesRec.FindFirst() then begin
                    PlanQty := NavLinesRec.Qty;


                    ResourceName := NavLinesRec."Resource Name";
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
                    field(stDate; stDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Date';
                    }
                }
            }
        }
    }


    var
        Quantity: Decimal;
        NavAppProdRec: Record "NavApp Prod Plans Details";
        ResourceName: Text[100];
        WorkcenterRec: Record "Work Center";
        OrderQy: BigInteger;
        Factory: Text[100];
        Style: Text[50];
        comRec: Record "Company Information";
        TodayOutput: BigInteger;
        ShipDate: Date;
        OutputComDate: Date;
        OutPutStartDate: Date;
        ProductionHeaderRec: Record ProductionOutHeader;
        TotalOuput: BigInteger;
        StylePoRec: Record "Style Master PO";
        InputDate: Date;
        PlanQty: BigInteger;
        NavLinesRec: Record "NavApp Planning Lines";
        BuyerName: Text[50];
        StyleRec: Record "Style Master";
        stDate: Date;

}