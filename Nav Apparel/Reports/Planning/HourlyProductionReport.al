report 50865 HourlyProductionReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Hourly Production Report';
    RDLCLayout = 'Report_Layouts/Planning/HourlyProductionReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("NavApp Prod Plans Details"; "NavApp Prod Plans Details")
        {
            DataItemTableView = sorting("No.");
            column(PlanDate; PlanDate)
            { }
            column(Qty; Qty)
            { }
            column(Style_Name; "Style Name")
            { }
            column(ResourceName; ResourceName)
            { }
            column("ResourceNo"; "Resource No.")
            { }
            column(EffProdPlan; Eff)
            { }
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
            column(TodayTarget; Target)
            { }
            column(PlanQty; PlanQty)
            { }
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
            column(OutputQty; OutputQty)
            { }
            column(Line_No_; "Line No.")
            { }
            column(CompLogo; comRec.Picture)
            { }
            // column(PlanDate; PlanDate)
            // { }
            column(TodayOutput; TodayOutput)
            { }
            column(variance; variance)
            { }
            column(HoursPerDay; HoursPerDay)
            { }
            column(Factory_No_; "Factory No.")
            { }
            column(BrandName; BrandName)
            { }
            column(PlanInput; PlanInput)
            { }
            column(Planfinish; Planfinish)
            { }
            column(ActualInputDate; ActualInputDate)
            { }
            column(ActualFinishDate; ActualFinishDate)
            { }
            column(EffProdOut; Eff)
            { }
            column(InputQtyTotal; InputQtyTotal)
            { }
            column(OutputQtyTotal; OutputQtyTotal)
            { }

            dataitem("Hourly Production Lines"; "Hourly Production Lines")
            {
                DataItemLinkReference = "NavApp Prod Plans Details";
                DataItemLink = "Factory No." = field("Factory No."), "Work Center No." = field("Resource No."), "Prod Date" = field(PlanDate), "Style No." = field("Style No.");
                DataItemTableView = where(Type = filter('Sewing'));
                column(FactoryName; FactoryName)
                { }
                column(Hour_1; "Hour 01")
                { }
                column(Hour_2; "Hour 02")
                { }
                column(Hour_3; "Hour 03")
                { }
                column(Hour_4; "Hour 04")
                { }
                column(Hour_5; "Hour 05")
                { }
                column(Hour_6; "Hour 06")
                { }
                column(Hour_7; "Hour 07")
                { }
                column(Hour_8; "Hour 08")
                { }
                column(Hour_9; "Hour 09")
                { }
                column(Hour_10; "Hour 10")
                { }
                column(Line_No_1; "Work Center Name")
                { }
                column(Item; Item)
                { }
                column(Factory_No_1; "Factory No.")
                { }
            }

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
                    BrandName := StyleRec."Brand Name";
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


                InputQtyToday := 0;
                OutputQty := 0;
                //Input/Output Today
                ProductionHeaderRec.Reset();
                ProductionHeaderRec.SetRange("Style No.", "Style No.");
                ProductionHeaderRec.SetRange("PO No", "PO No.");
                ProductionHeaderRec.SetRange("Resource No.", "Resource No.");
                ProductionHeaderRec.SetRange("Prod Date", PlanDate);
                ProductionHeaderRec.SetFilter(Type, '=%1', ProductionHeaderRec.Type::Saw);
                // ProductionHeaderRec.SetRange("Ref Line No.", "Line No.");

                if ProductionHeaderRec.Findset() then begin
                    InputQtyToday := ProductionHeaderRec."Input Qty";
                    OutputQty := ProductionHeaderRec."Output Qty";
                end;


                InputQtyTotal := 0;
                OutputQtyTotal := 0;
                //Input/Ouput Total (up to date)
                ProductionHeaderRec.Reset();
                ProductionHeaderRec.SetRange("Style No.", "Style No.");
                ProductionHeaderRec.SetRange("PO No", "PO No.");
                ProductionHeaderRec.SetRange("Resource No.", "Resource No.");
                ProductionHeaderRec.SetFilter("Prod Date", '<=%1', PlanDate);
                ProductionHeaderRec.SetFilter(Type, '=%1', ProductionHeaderRec.Type::Saw);

                if ProductionHeaderRec.Findset() then begin
                    repeat
                        InputQtyTotal += ProductionHeaderRec."Input Qty";
                        OutputQtyTotal += ProductionHeaderRec."Output Qty";
                    until ProductionHeaderRec.Next() = 0;
                end;

                //ActualPlanDT := ProductionHeaderRec."Prod Date";
                // OutputQty := ProductionHeaderRec."Output Qty";
                //TodayOutput := ProductionHeaderRec."Output Qty";



                OutPutStartDate := 0D;
                ProductionHeaderRec2.Reset();
                ProductionHeaderRec2.SetRange("Ref Line No.", "Line No.");
                ProductionHeaderRec2.SetFilter("Output Qty", '<>%1', 0);
                ProductionHeaderRec2.SetFilter(Type, '=%1', ProductionHeaderRec3.Type::Saw);
                ProductionHeaderRec2.SetCurrentKey("Prod Date");
                ProductionHeaderRec2.Ascending(true);

                if ProductionHeaderRec2.FindFirst() then
                    OutPutStartDate := ProductionHeaderRec2."Prod Date";


                ActualInputDate := 0D;
                ProductionHeaderRec3.Reset();
                ProductionHeaderRec3.SetRange("Ref Line No.", "Line No.");
                ProductionHeaderRec3.SetFilter("Input Qty", '<>%1', 0);
                ProductionHeaderRec3.SetFilter(Type, '=%1', ProductionHeaderRec3.Type::Saw);
                ProductionHeaderRec3.SetCurrentKey("Prod Date");
                ProductionHeaderRec3.Ascending(true);

                if ProductionHeaderRec3.FindFirst() then
                    ActualInputDate := ProductionHeaderRec3."Prod Date";


                ActualFinishDate := 0D;
                ProductionHeaderRec4.Reset();
                ProductionHeaderRec4.SetRange("Ref Line No.", "Line No.");
                ProductionHeaderRec4.SetFilter("Output Qty", '<>%1', 0);
                ProductionHeaderRec4.SetFilter(Type, '=%1', ProductionHeaderRec3.Type::Saw);
                ProductionHeaderRec4.SetCurrentKey("Prod Date");
                ProductionHeaderRec4.Ascending(true);

                if ProductionHeaderRec4.FindLast() then
                    ActualFinishDate := ProductionHeaderRec4."Prod Date";


                PlanInput := 0D;
                NavAppProdRec.Reset();
                NavAppProdRec.SetRange("Style No.", "Style No.");
                NavAppProdRec.SetRange("Resource No.", "Resource No.");
                NavAppProdRec.SetCurrentKey(PlanDate);
                NavAppProdRec.Ascending(true);
                if NavAppProdRec.FindFirst() then begin
                    PlanInput := NavAppProdRec.PlanDate;
                end;


                Planfinish := 0D;
                NavAppProdRec.Reset();
                NavAppProdRec.SetRange("Style No.", "Style No.");
                NavAppProdRec.SetRange("Resource No.", "Resource No.");
                NavAppProdRec.SetCurrentKey(PlanDate);
                NavAppProdRec.Ascending(true);
                if NavAppProdRec.FindLast() then begin
                    Planfinish := NavAppProdRec.PlanDate;
                end;


                LocationRec.SetRange(Code, FactortFilter);
                if LocationRec.FindFirst() then begin
                    FactoryName := LocationRec.Name;
                end;
            end;

            trigger OnPreDataItem()
            begin
                SetRange(PlanDate, FilterDate);
                SetRange("Factory No.", FactortFilter);
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

                    field(FactortFilter; FactortFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Factory';
                        TableRelation = Location.Code where("Sewing Unit" = filter(true));
                    }

                    field(FilterDate; FilterDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Production Date';
                    }
                }
            }
        }
    }

    var
        ActualFinishDate: Date;
        ProductionHeaderRec4: Record ProductionOutHeader;
        ProductionHeaderRec3: Record ProductionOutHeader;
        ActualInputDate: Date;
        Planfinish: Date;
        NavAppProdRec2: Record "NavApp Prod Plans Details";
        PlanInput: Date;
        NavAppProdRec: Record "NavApp Prod Plans Details";
        BrandName: Text[50];
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
        InputQtyToday: BigInteger;
        InputQtyTotal: BigInteger;
        OutputQtyTotal: BigInteger;
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