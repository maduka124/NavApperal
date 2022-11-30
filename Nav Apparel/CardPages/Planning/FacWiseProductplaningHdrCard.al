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

                field(No; No)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Factory; Factory)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        LocationRec: Record Location;
                    begin

                        LocationRec.Reset();
                        LocationRec.SetRange(Name, Factory);

                        if LocationRec.FindSet() then
                            "Factory Code" := LocationRec.Code;
                    end;
                }

                field("From Date"; "From Date")
                {
                    ApplicationArea = All;
                }

                field("To Date"; "To Date")
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

                trigger OnAction()
                var
                    ProductionOutHeaderRec: Record ProductionOutHeader;
                    FacWiseProductplaningLineRec: Record FacWiseProductplaningLineTable;
                    FacWiseProductplaning2LineRec: Record FacWiseProductplaningLineTable;
                    // FacWiseProductplaning3LineRec: Record FacWiseProductplaningLineTable;
                    // FacWiseProductplaning4LineRec: Record FacWiseProductplaningLineTable;
                    StylemasterRec: Record "Style Master";
                    navappPlaningRec: Record "NavApp Prod Plans Details";
                    SewingProductionOutHeaderRec: Record ProductionOutHeader;
                    workcentersRec: record "Work Center";
                    Total: Integer;
                begin
                    if Factory = '' then
                        Error('Selcet factory first');

                    if ("From Date" = 0D) or ("To Date" = 0D) then
                        Error('Invalid date period');

                    if ("From Date" > "To Date") then
                        Error('Invalid date period');

                    // Delete Line Details
                    FacWiseProductplaning2LineRec.Reset();
                    FacWiseProductplaning2LineRec.SetRange("No.", No);

                    if FacWiseProductplaning2LineRec.FindSet() then
                        FacWiseProductplaning2LineRec.DeleteAll();

                    //Cutting Out Qty
                    ProductionOutHeaderRec.Reset();
                    ProductionOutHeaderRec.SetRange("Prod Date", "From Date", "To Date");

                    if ProductionOutHeaderRec.FindSet() then begin
                        repeat

                            StylemasterRec.Reset();
                            StylemasterRec.SetRange("Style No.", ProductionOutHeaderRec."Style Name");
                            StylemasterRec.SetRange("Factory Name", Factory);

                            if StylemasterRec.FindSet() then begin

                                FacWiseProductplaningLineRec.Reset();
                                FacWiseProductplaningLineRec.SetRange(Date, ProductionOutHeaderRec."Prod Date");
                                FacWiseProductplaningLineRec.SetRange("No.", No);

                                if not FacWiseProductplaningLineRec.FindSet() then begin

                                    FacWiseProductplaningLineRec.Init();
                                    FacWiseProductplaningLineRec."No." := No;
                                    FacWiseProductplaningLineRec.Date := ProductionOutHeaderRec."Prod Date";
                                    FacWiseProductplaningLineRec."Cutting Achieved" := ProductionOutHeaderRec."Output Qty";
                                    FacWiseProductplaningLineRec."Cutting Difference" := ProductionOutHeaderRec."Output Qty" - FacWiseProductplaningLineRec."Cutting Planned";
                                    FacWiseProductplaningLineRec.Insert();

                                end
                                else begin

                                    FacWiseProductplaningLineRec."Cutting Achieved" := FacWiseProductplaningLineRec."Cutting Achieved" + ProductionOutHeaderRec."Output Qty";
                                    FacWiseProductplaningLineRec."Cutting Difference" := FacWiseProductplaningLineRec."Cutting Achieved" - FacWiseProductplaningLineRec."Cutting Planned";
                                    FacWiseProductplaningLineRec.Modify();
                                    CurrPage.Update();

                                end;
                            end;

                        until ProductionOutHeaderRec.Next() = 0;
                    end;

                    //Sewing Planinned qty
                    navappPlaningRec.Reset();
                    navappPlaningRec.SetRange(PlanDate, "From Date", "To Date");
                    navappPlaningRec.SetRange("Factory No.", "Factory Code");

                    if navappPlaningRec.FindSet() then begin
                        repeat

                            FacWiseProductplaningLineRec.Reset();
                            FacWiseProductplaningLineRec.SetRange(Date, navappPlaningRec.PlanDate);
                            FacWiseProductplaningLineRec.SetRange("No.", No);

                            if not FacWiseProductplaningLineRec.FindSet() then begin

                                FacWiseProductplaningLineRec.Init();
                                FacWiseProductplaningLineRec."No." := No;
                                FacWiseProductplaningLineRec.Date := navappPlaningRec.PlanDate;
                                FacWiseProductplaningLineRec."Sewing Planned" := navappPlaningRec.Qty;
                                FacWiseProductplaningLineRec.Insert();

                            end;

                            if FacWiseProductplaningLineRec.FindSet() then begin
                                FacWiseProductplaningLineRec."Sewing Planned" := FacWiseProductplaningLineRec."Sewing Planned" + navappPlaningRec.Qty;
                            end;

                        until navappPlaningRec.Next() = 0;

                        SewingProductionOutHeaderRec.Reset();
                        SewingProductionOutHeaderRec.SetRange("Prod Date", "From Date", "To Date");

                        if SewingProductionOutHeaderRec.FindSet() then begin
                            repeat

                                workcentersRec.Reset();
                                workcentersRec.SetRange("Name", SewingProductionOutHeaderRec."Resource Name");
                                workcentersRec.SetRange("Factory Name", Factory);

                                if workcentersRec.FindSet() then begin

                                    FacWiseProductplaningLineRec.Reset();
                                    FacWiseProductplaningLineRec.SetRange(Date, SewingProductionOutHeaderRec."Prod Date");
                                    FacWiseProductplaningLineRec.SetRange("No.", No);

                                    if not FacWiseProductplaningLineRec.findset then begin
                                        FacWiseProductplaningLineRec.Init();
                                        FacWiseProductplaningLineRec."No." := No;
                                        FacWiseProductplaningLineRec.Date := SewingProductionOutHeaderRec."Prod Date";
                                        FacWiseProductplaningLineRec."Sewing Achieved" := SewingProductionOutHeaderRec."Output Qty";
                                        FacWiseProductplaningLineRec."Sewing Difference" := SewingProductionOutHeaderRec."Output Qty" - FacWiseProductplaningLineRec."Sewing Planned";
                                        FacWiseProductplaningLineRec.Insert();

                                    end;
                                    if FacWiseProductplaningLineRec.FindSet() then begin

                                        FacWiseProductplaningLineRec."Sewing Achieved" := SewingProductionOutHeaderRec."Output Qty";
                                        FacWiseProductplaningLineRec."Sewing Difference" := FacWiseProductplaningLineRec."Sewing Achieved" - FacWiseProductplaningLineRec."Sewing Planned";
                                        FacWiseProductplaningLineRec.Modify();
                                        CurrPage.Update();
                                    end;
                                end
                            until SewingProductionOutHeaderRec.Next() = 0;
                        end;
                    end;
                end;
            }
        }
    }
}