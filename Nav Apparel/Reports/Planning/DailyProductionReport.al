report 50865 DailyProductionReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Daily Production Report';
    RDLCLayout = 'Report_Layouts/Planning/DailyProductionReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("NavApp Prod Plans Details"; "NavApp Prod Plans Details")
        {

            DataItemTableView = sorting("No.");
            column(ResourceName; ResourceName)
            { }
            // column(PO_No_; PoNo)
            // { }
            column(BuyerName; BuyerName)
            { }
            column(Style; Style)
            { }
            column(Factory; Factory)
            { }
            column(GarmentType; GarmentType)
            { }
            column(SMV; SMV)
            { }
            column(PlanTarget; PlanTarget)
            { }
            column(TodayTarget; Qty)
            { }
            // column(OrderQy; OrderQy)
            // { }
            column(PlanQty; PlanQty)
            { }
            // column(ShipDate; ShipDate)
            // { }
            column(PlanDt; InputDate)
            { }
            column(ActualPlanDt; ActualPlanDT)
            { }
            column(MC; MC)
            { }
            column(OutPutStartDate; OutPutStartDate)
            { }
            column(MerchandizerName; MerchandizerName)
            { }
            column(OutputComDate; OutputComDate)
            { }
            column(InputQtyToday; InputQtyToday)
            { }
            // column(Hour_1; "Hour 1")
            // { }
            // column(Hour_2; "Hour 2")
            // { }
            // column(Hour_3; "Hour 3")
            // { }
            // column(Hour_4; "Hour 4")
            // { }
            // column(Hour_5; "Hour 5")
            // { }
            // column(Hour_6; "Hour 6")
            // { }
            // column(Hour_7; "Hour 7")
            // { }
            // column(Hour_8; "Hour 8")
            // { }
            // column(Hour_9; "Hour 9")
            // { }
            // column(Hour_10; "Hour 10")
            // { }
            column(OutputQty; OutputQty)
            { }
            column(Line_No_; "Line No.")
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(PlanDate; PlanDate)
            { }
            column(TodayOutput; TodayOutput)
            { }
            column(variance; variance)
            { }
            column(HoursPerDay; HoursPerDay)
            { }
            column(FactoryName; FactoryName)
            { }
            column(Factory_No_; "Factory No.")
            { }
            // column(GarmentType; GarmentType)
            // { }
            dataitem("Style Master PO"; "Style Master PO")
            {
                DataItemLinkReference = "NavApp Prod Plans Details";
                DataItemLink = "Style No." = field("Style No.");
                DataItemTableView = sorting("Style No.", "Lot No.");

                column(PO_No_; "PO No.")
                { }
                column(ShipDate; "Ship Date")
                { }
                column(OrderQy; Qty)
                { }
                //hourly data
            }
            // // dataitem(ProductionOutHeader; ProductionOutHeader)
            // // {
            // //     DataItemLinkReference = "NavApp Prod Plans Details";
            // //     DataItemLink = "Style No."  = field("Style No.");

            // //     // DataItemTableView = sorting("Style No.", "Lot No.");
            // // }
            dataitem("Hourly Production Lines"; "Hourly Production Lines")
            {
                DataItemLinkReference = "NavApp Prod Plans Details";
                DataItemLink = "Factory No." = field("Factory No.");
                // , ,  "Prod Date" = field(PlanDate)"Style No." = field("Style No.")

                column(Hour_1; "Hour 1")
                { }
                column(Hour_2; "Hour 2")
                { }
                column(Hour_3; "Hour 3")
                { }
                column(Hour_4; "Hour 4")
                { }
                column(Hour_5; "Hour 5")
                { }
                column(Hour_6; "Hour 6")
                { }
                column(Hour_7; "Hour 7")
                { }
                column(Hour_8; "Hour 8")
                { }
                column(Hour_9; "Hour 9")
                { }
                column(Hour_10; "Hour 10")
                { }


                // column(Hour_1; "Hour 01")
                // { }
                // column(Hour_2; "Hour 02")
                // { }
                // column(Hour_3; "Hour 03")
                // { }
                // column(Hour_4; "Hour 04")
                // { }
                // column(Hour_5; "Hour 05")
                // { }
                // column(Hour_6; "Hour 06")
                // { }
                // column(Hour_7; "Hour 07")
                // { }
                // column(Hour_8; "Hour 08")
                // { }
                // column(Hour_9; "Hour 09")
                // { }
                // column(Hour_10; "Hour 10")
                // { }
                trigger OnAfterGetRecord()

                begin
                    "Hourly Production Lines".SetRange("Style No.", "NavApp Prod Plans Details"."Style No.");
                    "Hourly Production Lines".SetRange("Prod Date", "NavApp Prod Plans Details".PlanDate);
                    if "Hourly Production Lines".Type = "Hourly Production Lines".Type::Sewing then begin
                        if Item = 'PASS PCS' then begin
                            "Hour 1" := "Hourly Production Lines"."Hour 01";
                            "Hour 2" := "Hourly Production Lines"."Hour 02";
                            "Hour 3" := "Hourly Production Lines"."Hour 03";
                            "Hour 4" := "Hourly Production Lines"."Hour 04";
                            "Hour 5" := "Hourly Production Lines"."Hour 05";
                            "Hour 6" := "Hourly Production Lines"."Hour 06";
                            "Hour 7" := "Hourly Production Lines"."Hour 07";
                            "Hour 8" := "Hourly Production Lines"."Hour 08";
                            "Hour 9" := "Hourly Production Lines"."Hour 09";
                            "Hour 10" := "Hourly Production Lines"."Hour 10";
                        end;
                    end;



                end;

                // DataItemTableView = sorting("Style No.", "Lot No.");

                // trigger OnPreDataItem()

                // begin
                //     SetRange("Factory No.", FactortFilter);
                // end;
            }
            trigger OnPreDataItem()

            begin
                SetRange(PlanDate, FilterDate);
                SetRange("Factory No.", FactortFilter);
            end;

            trigger OnAfterGetRecord()

            begin
                variance := TodayOutput - Qty;
                comRec.Get;
                comRec.CalcFields(Picture);

                StyleRec.Reset();
                StyleRec.SetRange("No.", "Style No.");
                if StyleRec.FindFirst() then begin
                    BuyerName := StyleRec."Buyer Name";
                    Style := StyleRec."Style No.";
                    Factory := StyleRec."Factory Name";
                    GarmentType := StyleRec."Garment Type Name";
                    MerchandizerName := StyleRec."Merchandiser Name";
                end;

                WorkcenterRec.Reset();
                WorkcenterRec.SetRange("No.", "Resource No.");
                if WorkcenterRec.FindFirst() then begin
                    ResourceName := WorkcenterRec.Name;
                end;

                NavLinesRec.Reset();
                NavLinesRec.SetRange("Style No.", "Style No.");
                NavLinesRec.SetRange("PO No.", "PO No.");
                NavLinesRec.SetRange("Line No.", "Line No.");
                if NavLinesRec.FindFirst() then begin
                    PlanQty := NavLinesRec.Qty;
                    InputDate := NavLinesRec.StartDateTime;
                    OutputComDate := NavLinesRec.FinishDateTime;
                    PlanTarget := NavLinesRec.Target;
                    MC := NavLinesRec.Carder;
                end;

                StylePoRec.Reset();
                StylePoRec.SetRange("Style No.", "Style No.");
                StylePoRec.SetRange("Lot No.", "Lot No.");
                // StylePoRec.SetRange("PO No.", "PO No.");
                if StylePoRec.FindFirst() then begin
                    // TotalOuput := StylePoRec."Sawing Out Qty";
                    PoNo := StylePoRec."PO No.";
                    ShipDate := StylePoRec."Ship Date";
                    OrderQy := StylePoRec.Qty;
                end;

                ProductionHeaderRec.Reset();
                ProductionHeaderRec.SetRange("Style No.", "Style No.");
                ProductionHeaderRec.SetRange("PO No", "PO No.");
                ProductionHeaderRec.SetRange("Ref Line No.", "Line No.");
                if ProductionHeaderRec.FindFirst() then begin
                    ActualPlanDT := ProductionHeaderRec."Prod Date";
                    // OutPutStartDate := ProductionHeaderRec."Prod Date";
                    InputQtyToday := ProductionHeaderRec."Input Qty";
                    OutputQty := ProductionHeaderRec."Output Qty";
                    TodayOutput := ProductionHeaderRec."Output Qty";
                end;

                ProductionHeaderRec2.Reset();
                ProductionHeaderRec2.SetRange("Style No.", "Style No.");
                ProductionHeaderRec2.SetRange("PO No", "PO No.");
                ProductionHeaderRec2.SetRange("Ref Line No.", "Line No.");
                if ProductionHeaderRec2.FindLast() then begin
                    OutPutStartDate := ProductionHeaderRec."Prod Date";

                end;

                // HourlyProductionLineRec.Reset();
                // HourlyProductionLineRec.SetRange("Prod Date", PlanDate);
                // HourlyProductionLineRec.SetRange("Factory No.", "Factory No.");
                // HourlyProductionLineRec.SetRange("Style No.", "Style No.");
                // if HourlyProductionLineRec.Type = HourlyProductionLineRec.Type::Sewing then begin
                //     "Hour 1" := HourlyProductionLineRec."Hour 01";
                //     "Hour 2" := HourlyProductionLineRec."Hour 02";
                //     "Hour 3" := HourlyProductionLineRec."Hour 03";
                //     "Hour 4" := HourlyProductionLineRec."Hour 04";
                //     "Hour 5" := HourlyProductionLineRec."Hour 05";
                //     "Hour 6" := HourlyProductionLineRec."Hour 06";
                //     "Hour 7" := HourlyProductionLineRec."Hour 07";
                //     "Hour 8" := HourlyProductionLineRec."Hour 08";
                //     "Hour 9" := HourlyProductionLineRec."Hour 09";
                //     "Hour 10" := HourlyProductionLineRec."Hour 10";
                // end;
                // if HourlyProductionLineRec.FindFirst() then begin

                // end;

                LocationRec.SetRange(Code, "Factory No.");
                if LocationRec.FindFirst() then begin
                    FactoryName := LocationRec.Name;
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
                    field(FilterDate; FilterDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Production Date';

                    }
                    field(FactortFilter; FactortFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Factory';
                        TableRelation = Location.Code where("Sewing Unit" = filter(true));


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
        FactoryName: Text[100];
        LocationRec: Record Location;
        PoNo: Code[20];
        FactortFilter: Code[20];
        FilterDate: Date;
        ActualPlanDT: Date;
        variance: Decimal;
        TodayOutput: BigInteger;
        comRec: Record "Company Information";
        OutputQty: BigInteger;
        "Hour 1": Integer;
        "Hour 2": Integer;
        "Hour 3": Integer;
        "Hour 4": Integer;
        "Hour 5": Integer;
        "Hour 6": Integer;
        "Hour 7": Integer;
        "Hour 8": Integer;
        "Hour 9": Integer;
        "Hour 10": Integer;
        HourlyProductionLineRec: Record "Hourly Production Lines";
        InputQtyToday: BigInteger;
        MerchandizerName: Text[50];
        MC: Integer;
        OutPutStartDate: Date;
        ProductionHeaderRec: Record ProductionOutHeader;
        ProductionHeaderRec2: Record ProductionOutHeader;
        OrderQy: BigInteger;
        ShipDate: Date;
        StylePoRec: Record "Style Master PO";
        PlanTarget: BigInteger;
        OutputComDate: DateTime;
        InputDate: DateTime;
        PlanQty: BigInteger;
        NavLinesRec: Record "NavApp Planning Lines";
        GarmentType: Text[50];
        ResourceName: Text[100];
        WorkcenterRec: Record "Work Center";
        BuyerName: Text[50];
        StyleRec: Record "Style Master";
        Factory: Text[100];
        Style: Text[50];
}