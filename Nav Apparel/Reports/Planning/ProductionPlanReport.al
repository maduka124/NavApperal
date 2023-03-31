report 50621 ProductionPlanReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Production Plan Report';
    RDLCLayout = 'Report_Layouts/Planning/ProductionPlanReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Style Master"; "Style Master")
        {
            DataItemTableView = sorting("No.");
            column(Merchandiser_Name; "Merchandiser Code")
            { }
            column(Buyer_Name; "Buyer Name")
            { }
            column(BPCD; BPCDPo)
            { }
            column(Start_Date; stDate)
            { }
            column(End_Date; endDate)
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(LineQty; LineQty)
            { }
            column(StartDt; StartDt)
            { }
            column(EndDt; EndDt)
            { }
            column(InSpectionDt; InSpectionDt)
            { }
            column(PRDHR; PRDHR)
            { }
            column(Factory_Name; FactoryFilter)
            { }

            dataitem("NavApp Planning Lines"; "NavApp Planning Lines")
            {
                DataItemLinkReference = "Style Master";
                DataItemLink = "Style No." = field("No.");
                DataItemTableView = sorting("Line No.");

                column(Order_Qty; PoQty)
                { }
                column(Order_NO; PoNo)
                { }
                column(Style_Name; "Style Name")
                { }
                column(Style_Description; Description)
                { }
                column(SMV; SMV)
                { }
                column(PlanTGT; Target)
                { }
                column(PRD_Days; ProdUpdDays)
                { }
                column(Resource_No; "Resource No.")
                { }
                column(Planing_input; Qty)
                { }
                column(Lot_No_; "Lot No.")
                { }
                column(Ship_Date; shDate)
                { }
                column(Carder; Carder)
                { }
                column(Learning_Curve_No_; "Learning Curve No.")
                { }
                column(PO_No_; "PO No.")
                { }
                column("Resource_Name"; "Resource Name")
                { }
                column(WorkcenterNo; WorkcenterNo)
                { }

                trigger OnAfterGetRecord()
                var
                begin
                    shDate := 0D;
                    BPCDPo := 0D;
                    StyleMasterPoRec.Reset();
                    StyleMasterPoRec.SetRange("Style No.", "Style No.");
                    StyleMasterPoRec.SetRange("Lot No.", "Lot No.");
                    if StyleMasterPoRec.FindFirst() then begin
                        shDate := StyleMasterPoRec."Ship Date";
                        BPCDPo := StyleMasterPoRec.BPCD;
                    end;

                    PoNo := '';
                    PoQty := 0;
                    stylePORec.Reset();
                    stylePORec.SetRange("Style No.", "Style No.");
                    stylePORec.SetRange("PO No.", "PO No.");
                    if stylePORec.FindFirst() then begin
                        PoNo := stylePORec."PO No.";
                        PoQty := stylePORec.Qty
                    end;

                    StartDt := 0D;
                    StartDate := 0D;
                    EndDt := 0D;
                    InSpectionDt := 0D;

                    NavAppProdPlanRec.Reset();
                    NavAppProdPlanRec.SetRange("Line No.", "Line No.");
                    NavAppProdPlanRec.SetCurrentKey(PlanDate);
                    NavAppProdPlanRec.Ascending(true);
                    if NavAppProdPlanRec.FindFirst() then begin
                        StartDt := NavAppProdPlanRec."PlanDate" - 2;
                        StartDate := NavAppProdPlanRec."PlanDate";
                    end;

                    NavAppProdPlanRec.Reset();
                    NavAppProdPlanRec.SetRange("Line No.", "Line No.");
                    NavAppProdPlanRec.SetCurrentKey(PlanDate);
                    NavAppProdPlanRec.Ascending(true);
                    if NavAppProdPlanRec.FindLast() then begin
                        EndDt := NavAppProdPlanRec."PlanDate";
                        InSpectionDt := NavAppProdPlanRec."PlanDate" + 10;
                    end;

                    // NavRec.Reset();
                    // NavRec.SetCurrentKey("Start Date");
                    // NavRec.SetAscending("Start Date", true);
                    // // NavRec.SetRange("Style No.", "Style No.");
                    // NavRec.SetRange("Resource No.", "Resource No.");
                    // NavRec.SetRange("PO No.", "PO No.");
                    // if NavRec.FindFirst() then begin
                    //     StartDt := NavRec."Start Date" - 2;
                    //     StartDate := NavRec."Start Date";
                    // end;

                    // if NavRec.FindLast() then begin
                    //     EndDt := NavRec."End Date";
                    //     InSpectionDt := NavRec."End Date" + 10;
                    // end;

                    PRDHR := EndDt - StartDate;

                    LineQty := 0;
                    PurchLineRec.SetRange(StyleNo, "Style No.");
                    PurchLineRec.SetRange(PONo, "PO No.");
                    if PurchLineRec.FindSet() then begin
                        repeat
                            LineQty += PurchLineRec.Quantity;
                        until PurchLineRec.Next() = 0;
                    end;
                    WorkcenterNo := 0;
                    WorkCenterRec.Reset();
                    WorkCenterRec.SetRange("No.", "Resource No.");
                    if WorkCenterRec.FindFirst() then begin
                        WorkcenterNo := WorkCenterRec."Work Center Seq No";
                    end;

                end;

                trigger OnPreDataItem()
                begin
                    if StartDate <> 0D then
                        SetRange("Start Date", stDate, endDate);

                    if FactoryFilter <> '' then
                        SetRange(Factory, FactoryFilter);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                comRec.Get;
                comRec.CalcFields(Picture);
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

                    //Done By sachith On 14/02/23
                    field(FactoryFilter; FactoryFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Factory';


                        trigger OnLookup(var texts: text): Boolean
                        var
                            LocationRec: Record Location;
                            LocationRec2: Record Location;
                            UserRec: Record "User Setup";
                        begin
                            LocationRec.Reset();
                            UserRec.Reset();
                            UserRec.Get(UserId);

                            LocationRec2.Reset();
                            LocationRec.Reset();
                            LocationRec.SetRange(Code, UserRec."Factory Code");
                            LocationRec.SetFilter("Sewing Unit", '=%1', true);
                            if LocationRec.FindSet() then begin
                                if Page.RunModal(15, LocationRec) = Action::LookupOK then begin
                                    FactoryFilter := LocationRec.Code;
                                end;
                            end
                            else
                                if Page.RunModal(15, LocationRec2) = Action::LookupOK then begin
                                    FactoryFilter := LocationRec2.Code;
                                end;
                        end;
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
        WorkcenterNo: Integer;
        WorkCenterRec: Record "Work Center";
        BPCDPo: Date;
        myInt: Integer;
        StyleMasterPoRec: Record "Style Master PO";
        stDate: Date;
        endDate: Date;
        shDate: Date;
        comRec: Record "Company Information";
        stylePORec: Record "Style Master PO";
        PoNo: Code[20];
        PoQty: BigInteger;
        PurchLineRec: Record "Purch. Rcpt. Line";
        LineQty: Decimal;
        NavAppProdPlanRec: Record "NavApp Prod Plans Details";
        StartDt: Date;
        EndDt: Date;
        InSpectionDt: Date;
        StartDate: Date;
        PRDHR: Integer;
        NavRec: Record "NavApp Planning Lines";
        //Done By sachith On 14/02/23
        FactoryFilter: Code[20];
}