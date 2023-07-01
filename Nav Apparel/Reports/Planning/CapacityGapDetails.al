report 50623 CapacityGapDetailsReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Capacity Gap Details Report';
    RDLCLayout = 'Report_Layouts/Planning/CapacityGapDetailsReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("NavApp Prod Plans Details"; "NavApp Prod Plans Details")
        {
            column(Factory_No_; "Factory No.")
            { }
            column(Resource_No_; WorkCenterName)
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(BookingEff; BookingEff)
            { }
            column(BookingSMV; BookingSMV)
            { }
            column(HoursPerDay; HoursPerDay)
            { }
            column(Carder; Carder)
            { }
            column(Line_No_; "Line No.")
            { }
            column(StartDate; StartDate)    //min ate
            { }
            column(EndDate; EndDate)   //max date
            { }
            column(Days; Days)
            { }
            column(stDateFilter; stDateFilter)
            { }
            column(endDateFilter; endDateFilter)
            { }
            column(DisplaySeq; DisplaySeq)
            { }
            column(No_; "No.")
            { }
            column(Pcs; Pcs)
            { }

            trigger OnAfterGetRecord()
            begin
                comRec.Get;
                comRec.CalcFields(Picture);

                WorkCenterRec.SetRange("No.", "Resource No.");
                if WorkCenterRec.FindFirst() then begin
                    WorkCenterName := WorkCenterRec.Name;
                    DisplaySeq := WorkCenterRec."Work Center Seq No";
                end;

                NavAppSetup.Reset();
                NavAppSetup.FindSet();
                BookingEff := NavAppSetup."Capacity Book Eff";
                BookingSMV := NavAppSetup."Capacity Book SMV";

                ProdPlanRec.Reset();
                ProdPlanRec.SetRange("Line No.", "Line No.");
                ProdPlanRec.SetCurrentKey(PlanDate);
                ProdPlanRec.Ascending(true);
                if ProdPlanRec.FindFirst() then
                    StartDate := ProdPlanRec."PlanDate";

                ProdPlanRec.Reset();
                ProdPlanRec.SetRange("Line No.", "Line No.");
                ProdPlanRec.SetCurrentKey(PlanDate);
                ProdPlanRec.Ascending(true);
                if ProdPlanRec.FindLast() then
                    EndDate := ProdPlanRec."PlanDate";

                Days := EndDate - StartDate;
                Pcs := round((Carder * HoursPerDay * 60 * BookingEff) / BookingSMV, 1);
            end;


            trigger OnPreDataItem()
            begin
                SetRange(PlanDate, stDateFilter, endDateFilter);

                if FTY <> '' then
                    SetRange("Factory No.", FTY);
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
                    field(FTY; FTY)
                    {
                        ApplicationArea = All;
                        Caption = 'Factory';
                        TableRelation = Location.Code where("Sewing Unit" = filter(true));
                    }

                    field(stDateFilter; stDateFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                    }

                    field(endDateFilter; endDateFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                    }
                }
            }
        }
    }

    var
        FTY: Code[20];
        WorkCenterName: Text[100];
        StyleMasterRec: Record "Style Master";
        NavAppSetup: Record "NavApp Setup";
        Factory_Name: Text[50];
        BookingEff: Decimal;
        BookingSMV: Decimal;
        StartDate: Date;
        EndDate: Date;
        Days: Integer;
        stDateFilter: Date;
        endDateFilter: Date;
        comRec: Record "Company Information";
        WorkCenterRec: Record "Work Center";
        ProdPlanRec: Record "NavApp Prod Plans Details";
        DisplaySeq: Integer;
        Pcs: BigInteger;
}