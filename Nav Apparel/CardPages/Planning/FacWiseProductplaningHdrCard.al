page 50862 FacWiseProductplaningHdrCard
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = FactWiseProductPlaningHdrtbale;
    Caption = 'Factory Wise Production Planning';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(No; rec.No)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Factory Name"; rec."Factory Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        LocationRec: Record Location;
                    begin

                        LocationRec.Reset();
                        LocationRec.SetRange(Name, rec."Factory Name");

                        if LocationRec.FindSet() then
                            rec."Factory Code" := LocationRec.Code;
                    end;
                }

                field("From Date"; rec."From Date")
                {
                    ApplicationArea = All;
                }

                field("To Date"; rec."To Date")
                {
                    ApplicationArea = All;
                }
            }

            part(FacWiseProductplaningPart; FacWiseProductplaningPart)
            {
                ApplicationArea = All;
                Caption = '  ';
                SubPageLink = "No." = field(No);
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Load)
            {
                ApplicationArea = All;
                Image = WorkCenterLoad;

                trigger OnAction()
                var
                    ProductionOutHeaderRec: Record ProductionOutHeader;
                    FacWiseProductplaningLineRec: Record FacWiseProductplaningLineTable;
                    FacWiseProductplaning2LineRec: Record FacWiseProductplaningLineTable;
                    StylemasterRec: Record "Style Master";
                    NavappPlaningRec: Record "NavApp Prod Plans Details";
                    SewingProductionOutHeaderRec: Record ProductionOutHeader;
                    FinishingProductionOutHeaderRec: Record ProductionOutHeader;
                    WorkcentersRec: record "Work Center";

                begin
                    if rec."Factory Name" = '' then
                        Error('Select factory first');

                    if (rec."From Date" = 0D) or (rec."To Date" = 0D) then
                        Error('Invalid date period');

                    if (rec."From Date" > rec."To Date") then
                        Error('Invalid date period');

                    // Delete Line Details
                    FacWiseProductplaning2LineRec.Reset();
                    FacWiseProductplaning2LineRec.SetRange("No.", rec.No);

                    if FacWiseProductplaning2LineRec.FindSet() then
                        FacWiseProductplaning2LineRec.DeleteAll();

                    //Cutting Out Qty
                    ProductionOutHeaderRec.Reset();
                    ProductionOutHeaderRec.SetRange("Prod Date", rec."From Date", rec."To Date");
                    ProductionOutHeaderRec.SetFilter(Type, '=%1', ProductionOutHeaderRec.Type::Cut);

                    if ProductionOutHeaderRec.FindSet() then begin
                        repeat

                            WorkcentersRec.Reset();
                            WorkcentersRec.SetRange("No.", ProductionOutHeaderRec."Resource No.");
                            WorkcentersRec.SetRange("Factory No.", rec."Factory Code");

                            if WorkcentersRec.FindSet() then begin

                                FacWiseProductplaningLineRec.Reset();
                                FacWiseProductplaningLineRec.SetRange(Date, ProductionOutHeaderRec."Prod Date");
                                FacWiseProductplaningLineRec.SetRange("No.", rec.No);

                                if not FacWiseProductplaningLineRec.FindSet() then begin

                                    FacWiseProductplaningLineRec.Init();
                                    FacWiseProductplaningLineRec."No." := rec.No;
                                    FacWiseProductplaningLineRec.Date := ProductionOutHeaderRec."Prod Date";
                                    FacWiseProductplaningLineRec."Cutting Achieved" := ProductionOutHeaderRec."Output Qty";
                                    FacWiseProductplaningLineRec."Cutting Difference" := ProductionOutHeaderRec."Output Qty" - FacWiseProductplaningLineRec."Cutting Planned";
                                    FacWiseProductplaningLineRec.Insert();

                                end
                                else begin
                                    FacWiseProductplaningLineRec."Cutting Achieved" := FacWiseProductplaningLineRec."Cutting Achieved" + ProductionOutHeaderRec."Output Qty";
                                    FacWiseProductplaningLineRec."Cutting Difference" := FacWiseProductplaningLineRec."Cutting Achieved" - FacWiseProductplaningLineRec."Cutting Planned";
                                    FacWiseProductplaningLineRec.Modify();

                                end;
                            end;

                        until ProductionOutHeaderRec.Next() = 0;
                    end;

                    //Sewing Planinned qty
                    NavappPlaningRec.Reset();
                    NavappPlaningRec.SetRange(PlanDate, rec."From Date", rec."To Date");
                    NavappPlaningRec.SetRange("Factory No.", rec."Factory Code");

                    if NavappPlaningRec.FindSet() then begin
                        repeat

                            FacWiseProductplaningLineRec.Reset();
                            FacWiseProductplaningLineRec.SetRange(Date, NavappPlaningRec.PlanDate);
                            FacWiseProductplaningLineRec.SetRange("No.", rec.No);

                            if FacWiseProductplaningLineRec.FindSet() then begin
                                FacWiseProductplaningLineRec."Sewing Planned" := FacWiseProductplaningLineRec."Sewing Planned" + NavappPlaningRec.Qty;
                                FacWiseProductplaningLineRec.Modify();

                            end;

                            if not FacWiseProductplaningLineRec.FindSet() then begin
                                FacWiseProductplaningLineRec.Init();
                                FacWiseProductplaningLineRec."No." := rec.No;
                                FacWiseProductplaningLineRec.Date := NavappPlaningRec.PlanDate;
                                FacWiseProductplaningLineRec."Sewing Planned" := NavappPlaningRec.Qty;
                                FacWiseProductplaningLineRec.Insert();

                            end;
                        until NavappPlaningRec.Next() = 0;
                    End;

                    // Sewing Out Qty
                    SewingProductionOutHeaderRec.Reset();
                    SewingProductionOutHeaderRec.SetRange("Prod Date", rec."From Date", rec."To Date");
                    SewingProductionOutHeaderRec.SetFilter(Type, '=%1', SewingProductionOutHeaderRec.Type::Saw);

                    if SewingProductionOutHeaderRec.FindSet() then begin
                        repeat

                            WorkcentersRec.Reset();
                            WorkcentersRec.SetRange("Name", SewingProductionOutHeaderRec."Resource Name");
                            WorkcentersRec.SetRange("Factory No.", rec."Factory Code");

                            if WorkcentersRec.FindSet() then begin
                                FacWiseProductplaningLineRec.Reset();
                                FacWiseProductplaningLineRec.SetRange(Date, SewingProductionOutHeaderRec."Prod Date");
                                FacWiseProductplaningLineRec.SetRange("No.", rec.No);

                                if not FacWiseProductplaningLineRec.findset then begin
                                    FacWiseProductplaningLineRec.Init();
                                    FacWiseProductplaningLineRec."No." := rec.No;
                                    FacWiseProductplaningLineRec.Date := SewingProductionOutHeaderRec."Prod Date";
                                    FacWiseProductplaningLineRec."Sewing Achieved" := SewingProductionOutHeaderRec."Output Qty";
                                    FacWiseProductplaningLineRec."Sewing Difference" := SewingProductionOutHeaderRec."Output Qty" - FacWiseProductplaningLineRec."Sewing Planned";
                                    FacWiseProductplaningLineRec.Insert();

                                end;

                                if FacWiseProductplaningLineRec.FindSet() then begin
                                    FacWiseProductplaningLineRec."Sewing Achieved" := SewingProductionOutHeaderRec."Output Qty";
                                    FacWiseProductplaningLineRec."Sewing Difference" := FacWiseProductplaningLineRec."Sewing Achieved" - FacWiseProductplaningLineRec."Sewing Planned";
                                    FacWiseProductplaningLineRec.Modify();

                                end;
                            end
                        until SewingProductionOutHeaderRec.Next() = 0;
                    end;

                    // Finishing Out Qty
                    FinishingProductionOutHeaderRec.Reset();
                    FinishingProductionOutHeaderRec.SetRange("Prod Date", rec."From Date", rec."To Date");
                    FinishingProductionOutHeaderRec.SetFilter(Type, '=%1', FinishingProductionOutHeaderRec.Type::Fin);

                    if FinishingProductionOutHeaderRec.FindSet() then begin
                        repeat

                            WorkcentersRec.Reset();
                            WorkcentersRec.SetRange("Name", FinishingProductionOutHeaderRec."Resource Name");
                            WorkcentersRec.SetRange("Factory No.", rec."Factory Code");

                            if WorkcentersRec.FindSet() then begin
                                FacWiseProductplaningLineRec.Reset();
                                FacWiseProductplaningLineRec.SetRange(Date, FinishingProductionOutHeaderRec."Prod Date");
                                FacWiseProductplaningLineRec.SetRange("No.", rec.No);

                                if not FacWiseProductplaningLineRec.FindSet() then begin
                                    FacWiseProductplaningLineRec.Init();
                                    FacWiseProductplaningLineRec."No." := rec.No;
                                    FacWiseProductplaningLineRec.Date := FinishingProductionOutHeaderRec."Prod Date";
                                    FacWiseProductplaningLineRec."Finishing Achieved" := FinishingProductionOutHeaderRec."Output Qty";
                                    FacWiseProductplaningLineRec."Finishing Difference" := FinishingProductionOutHeaderRec."Output Qty" - FacWiseProductplaningLineRec."Finishing Planned";
                                    FacWiseProductplaningLineRec.Insert()
                                end;

                                if FacWiseProductplaningLineRec.FindSet() then begin
                                    FacWiseProductplaningLineRec."Finishing Achieved" := FinishingProductionOutHeaderRec."Output Qty";
                                    FacWiseProductplaningLineRec."Finishing Difference" := FinishingProductionOutHeaderRec."Output Qty" - FacWiseProductplaningLineRec."Finishing Planned";
                                    FacWiseProductplaningLineRec.Modify();
                                end;
                            end;
                        until FinishingProductionOutHeaderRec.Next() = 0;
                    end;
                end;
            }
        }
    }
}