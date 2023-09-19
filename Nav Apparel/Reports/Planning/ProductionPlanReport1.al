report 51402 ProductionPlanReport1
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Production Plan Report';
    RDLCLayout = 'Report_Layouts/Planning/ProductionPlanReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("NavApp Prod Plans Details"; "NavApp Prod Plans Details")
        {
            DataItemTableView = sorting("Line No.");

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
            column(Eff; Eff)
            { }
            column(Order_Qty; PoQty)
            { }
            column(Order_NO; PoNo)
            { }
            column(Style_Description; "Style Name")
            { }
            column(SMV; SMV)
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
            column("Resource_Name"; "Resource_Name")
            { }
            column(WorkcenterNo; WorkcenterNo)
            { }
            column(StartDate; StartDate)
            { }
            column(color; color)
            { }

            column(Line_No_; "Line No.")
            { }

            dataitem("Style Master"; "Style Master")
            {
                DataItemLinkReference = "NavApp Prod Plans Details";
                DataItemLink = "No." = field("style No.");
                DataItemTableView = sorting("No.");

                column(Merchandiser_Name; "Merchandiser Code")
                { }
                column(Buyer_Name; "Buyer Name")
                { }

                trigger OnPreDataItem()
                var
                begin
                    if BuyerNo <> '' then
                        SetRange("Buyer No.", BuyerNo);
                end;

                trigger OnAfterGetRecord()
                begin
                    comRec.Get;
                    comRec.CalcFields(Picture);
                end;
            }

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
                stylePORec.SetRange("Lot No.", "Lot No.");
                if stylePORec.FindSet() then begin
                    PoNo := stylePORec."PO No.";
                    PoQty += stylePORec.Qty
                end;

                StartDt := 0D;
                StartDate := 0D;
                EndDt := 0D;
                InSpectionDt := 0D;

                NavAppProdPlanRec.Reset();
                NavAppProdPlanRec.SetRange("Line No.", "Line No.");
                NavAppProdPlanRec.SetCurrentKey(PlanDate);
                NavAppProdPlanRec.Ascending(true);
                if NavAppProdPlanRec.FindFirst() then
                    StartDt := NavAppProdPlanRec."PlanDate" - 2;

                NavAppProdPlanRec.Reset();
                NavAppProdPlanRec.SetRange("Line No.", "Line No.");
                NavAppProdPlanRec.SetRange("PO No.", "PO No.");
                NavAppProdPlanRec.SetCurrentKey(PlanDate);
                NavAppProdPlanRec.Ascending(true);
                if NavAppProdPlanRec.FindFirst() then
                    StartDate := NavAppProdPlanRec."PlanDate";

                NavAppProdPlanRec.Reset();
                NavAppProdPlanRec.SetRange("Line No.", "Line No.");
                NavAppProdPlanRec.SetCurrentKey(PlanDate);
                NavAppProdPlanRec.Ascending(true);
                if NavAppProdPlanRec.FindLast() then begin
                    EndDt := NavAppProdPlanRec."PlanDate";
                    InSpectionDt := NavAppProdPlanRec."PlanDate" + 10;
                end;

                color := 0;
                if EndDt > shDate then
                    color := 1;

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
                Resource_Name := '';
                WorkCenterRec.Reset();
                WorkCenterRec.SetRange("No.", "Resource No.");
                if WorkCenterRec.FindFirst() then begin
                    WorkcenterNo := WorkCenterRec."Work Center Seq No";
                    Resource_Name := WorkCenterRec.Name;
                end;

                // if LineNo <> "Resource No." then begin
                //     OrderQtyLine := Qty;
                //     LineNo := "Resource No.";
                // end
                // else begin
                //     OrderQtyLine += Qty;
                // end;

            end;

            trigger OnPreDataItem()
            begin

                if (stDate = 0D) then
                    Error('Invalid Start Date');

                if (endDate = 0D) then
                    Error('Invalid End Date');

                SetRange("PlanDate", stDate, endDate);

                if FactoryFilter <> '' then
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
                            UserRec.Reset();
                            UserRec.Get(UserId);

                            LocationRec2.Reset();
                            LocationRec2.SetFilter("Sewing Unit", '=%1', true);
                            LocationRec2.FindSet();

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

                    field(BuyerNo; BuyerNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Buyer';
                        TableRelation = Customer."No.";
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
        color: Integer;
        BuyerNo: Code[20];
        WorkcenterNo: Integer;
        WorkCenterRec: Record "Work Center";
        BPCDPo: Date;
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
        //PRD_Days: Integer;
        Resource_Name: Text[200];
        OrderQtyLine: Decimal;
        LineNo: Code[20];
}