page 50855 CapacityUtilizationSAH
{
    PageType = Card;
    SourceTable = YearTable;
    Caption = 'Capacity Utilization By SAH';

    layout
    {
        area(Content)
        {
            group("General")
            {
                field(Year; Year)
                {
                    ApplicationArea = all;
                    TableRelation = YearTable.Year;
                }
            }

            group("Capacity Allocation")
            {
                part(SAH_CapacityAllocationListPart; SAH_CapacityAllocationListPart)
                {
                    ApplicationArea = All;
                    Caption = '';
                    SubPageLink = Year = field(Year);
                }
            }

            group("Plan Efficiency")
            {
                part(SAH_PlanEfficiencyListPart; SAH_PlanEfficiencyListPart)
                {
                    ApplicationArea = All;
                    Caption = '';
                    SubPageLink = Year = field(Year);
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Generate Data")
            {
                ApplicationArea = All;
                Image = CreateYear;

                trigger OnAction();
                var
                    CapacityAlloRec: Record SAH_CapacityAllocation;
                    PlanEfficiencyRec: Record SAH_PlanEfficiency;
                    LocationsRec: Record Location;
                    WorkCenterRec: Record "Work Center";
                    SeqNo: BigInteger;
                begin

                    if Year > 0 then begin

                        /////////Capacity Allocations
                        //Get max record
                        CapacityAlloRec.Reset();
                        if CapacityAlloRec.Findlast() then
                            SeqNo := CapacityAlloRec."No.";

                        //Check for existing records
                        CapacityAlloRec.Reset();
                        CapacityAlloRec.SetRange(Year, Year);
                        if not CapacityAlloRec.FindSet() then begin

                            //Get all the factories
                            LocationsRec.Reset();
                            LocationsRec.SetFilter("Sewing Unit", '=%1', true);
                            if LocationsRec.FindSet() then begin
                                repeat

                                    //Get all the lines for the above factory
                                    WorkCenterRec.Reset();
                                    WorkCenterRec.SetRange("Factory No.", LocationsRec.Code);
                                    if WorkCenterRec.FindSet() then begin
                                        repeat
                                            SeqNo += 1;

                                            //Insert lines
                                            CapacityAlloRec.Init();
                                            CapacityAlloRec."No." := SeqNo;
                                            CapacityAlloRec.Year := Year;
                                            CapacityAlloRec."Factory Code" := LocationsRec.Code;
                                            CapacityAlloRec."Factory Name" := LocationsRec.Name;
                                            CapacityAlloRec."Line No." := WorkCenterRec."No.";
                                            CapacityAlloRec."Line Name" := WorkCenterRec.Name;
                                            CapacityAlloRec."Created User" := UserId;
                                            CapacityAlloRec.Insert();

                                        until WorkCenterRec.Next() = 0;
                                    end;

                                until LocationsRec.Next() = 0;
                            end;
                        end;


                        /////////Planning Efficiency                        
                        //Check for existing records
                        PlanEfficiencyRec.Reset();
                        PlanEfficiencyRec.SetRange(Year, Year);
                        if not PlanEfficiencyRec.FindSet() then begin
                            //Insert lines
                            PlanEfficiencyRec.Init();
                            PlanEfficiencyRec.Year := Year;
                            PlanEfficiencyRec."Created User" := UserId;
                            PlanEfficiencyRec.Insert();
                        end;

                    end
                    else
                        Error('Year is blank.');
                end;
            }
        }
    }


    trigger OnOpenPage()
    var
        YearRec: Record YearTable;
        Y: Integer;
    begin
        evaluate(Y, copystr(Format(Today()), 7, 2));
        Y := 2000 + Y;
        YearRec.Reset();
        YearRec.SetRange(Year, Y);
        if not YearRec.FindSet() then begin
            YearRec.Init();
            YearRec.Year := Y;
            YearRec.Insert();
        end;
    end;
}