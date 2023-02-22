report 50865 HourlyProductionReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Hourly Production Report';
    RDLCLayout = 'Report_Layouts/Planning/HourlyProductionReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Hourly Production Master"; "Hourly Production Master")
        {
            column(FactoryName; FactoryName)
            { }
            dataitem("Hourly Production Lines"; "Hourly Production Lines")
            {
                DataItemLinkReference = "Hourly Production Master";
                DataItemLink = "No." = field("No."), "Factory No." = field("Factory No."), "Prod Date" = field("Prod Date");
                DataItemTableView = sorting("No.");
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
                dataitem("NavApp Prod Plans Details"; "NavApp Prod Plans Details")
                {
                    DataItemLinkReference = "Hourly Production Lines";
                    DataItemLink = PlanDate = field("Prod Date"), "Factory No." = field("Factory No.");
                    DataItemTableView = sorting("No.");

                    column(Qty; Qty)
                    { }
                    column(Style_Name; "Style Name")
                    { }
                    column(ResourceName; ResourceName)
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
                    column(PlanDate; PlanDate)
                    { }
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

                        ProductionHeaderRec.Reset();
                        ProductionHeaderRec.SetRange("Style No.", "Style No.");
                        ProductionHeaderRec.SetRange("PO No", "PO No.");
                        ProductionHeaderRec.SetRange("Ref Line No.", "Line No.");
                        if ProductionHeaderRec.FindFirst() then begin
                            if ProductionHeaderRec.Type = ProductionHeaderRec.Type::Saw then
                                ActualPlanDT := ProductionHeaderRec."Prod Date";
                            InputQtyToday := ProductionHeaderRec."Input Qty";
                            OutputQty := ProductionHeaderRec."Output Qty";
                            TodayOutput := ProductionHeaderRec."Output Qty";
                        end;

                        ProductionHeaderRec2.Reset();
                        ProductionHeaderRec2.SetRange("Style No.", "Style No.");
                        ProductionHeaderRec2.SetRange("PO No", "PO No.");
                        ProductionHeaderRec2.SetRange("Ref Line No.", "Line No.");
                        if ProductionHeaderRec2.FindLast() then begin
                            if ProductionHeaderRec2.Type = ProductionHeaderRec2.Type::Saw then
                                OutPutStartDate := ProductionHeaderRec."Prod Date";
                        end;

                        ProductionHeaderRec3.Reset();
                        ProductionHeaderRec3.SetRange("Style No.", "Style No.");
                        ProductionHeaderRec3.SetRange("PO No", "PO No.");
                        ProductionHeaderRec3.SetRange("Ref Line No.", "Line No.");
                        ProductionHeaderRec3.SetCurrentKey("Prod Date");
                        ProductionHeaderRec3.Ascending(true);
                        if ProductionHeaderRec3.FindFirst() then begin
                            if ProductionHeaderRec3.Type = ProductionHeaderRec3.Type::Saw then
                                if ProductionHeaderRec."Input Qty" = 0 then
                                    ActualInputDate := ProductionHeaderRec."Prod Date"
                                else
                                    ActualInputDate := ProductionHeaderRec."Prod Date";
                        end;
                        ProductionHeaderRec4.Reset();
                        ProductionHeaderRec4.SetRange("Style No.", "Style No.");
                        ProductionHeaderRec4.SetRange("PO No", "PO No.");
                        ProductionHeaderRec4.SetRange("Ref Line No.", "Line No.");
                        ProductionHeaderRec4.SetCurrentKey("Prod Date");
                        ProductionHeaderRec4.Ascending(false);
                        if ProductionHeaderRec4.FindLast() then begin
                            if ProductionHeaderRec4.Type = ProductionHeaderRec4.Type::Saw then
                                if ProductionHeaderRec."Input Qty" = 0 then
                                    ActualFinishDate := ProductionHeaderRec."Prod Date"
                                else
                                    ActualFinishDate := ProductionHeaderRec."Prod Date";
                        end;
                        NavAppProdRec.Reset();
                        NavAppProdRec.SetRange("No.", "No.");
                        NavAppProdRec.SetCurrentKey(PlanDate);
                        NavAppProdRec.Ascending(true);
                        if NavAppProdRec.FindFirst() then begin
                            PlanInput := NavAppProdRec.PlanDate;
                        end;
                        NavAppProdRec2.Reset();
                        NavAppProdRec2.SetRange("No.", "No.");
                        NavAppProdRec.SetCurrentKey(PlanDate);
                        NavAppProdRec2.Ascending(false);
                        if NavAppProdRec.FindLast() then begin
                            Planfinish := NavAppProdRec.PlanDate;
                        end;

                    end;
                }
                trigger OnPreDataItem()
                begin
                    SetRange("Prod Date", FilterDate);
                    SetRange("Factory No.", FactortFilter);
                end;

                trigger OnAfterGetRecord()

                begin
                    LocationRec.SetRange(Code, "Factory No.");
                    if LocationRec.FindFirst() then begin
                        FactoryName := LocationRec.Name;
                    end;
                end;
            }
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