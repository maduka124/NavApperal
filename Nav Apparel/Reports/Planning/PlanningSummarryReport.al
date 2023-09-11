report 51414 PlanningSummarryReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Planning Summary Report';
    RDLCLayout = 'Report_Layouts/Planning/PlanningSummaryReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("NavApp Prod Plans Details"; "NavApp Prod Plans Details")
        {

            DataItemTableView = sorting("Resource No.");

            column(Factory_No_; "Factory No.")
            { }

            column(Style_Name; "Style Name")
            { }
            column(PO_No_; "PO No.")
            { }
            column(Resource_No_; "Resource No.")
            { }
            column(PlanStartDate; PlanStartDate)
            { }
            column(PlanEndDate; PlanEndDate)
            { }

            column(TotalPlanQty; TotalPlanQty)
            { }

            column(MerchandGroupHead; MerchandGroupHead)
            { }

            column(BuyerName; BuyerName)
            { }

            column(CompLogo; comRec.Picture)
            { }

            column(StartDate; StartDate)
            { }

            column(EndDate; EndDate)
            { }

            column(Qty; Qty)
            { }

            trigger OnPreDataItem()
            begin
                SetRange(PlanDate, StartDate, EndDate);
                SetRange("Factory No.", Factory);
            end;

            trigger OnAfterGetRecord()
            var
                MerchandGroupRec: Record MerchandizingGroupTable;
                NavProdetailRec: Record "NavApp Prod Plans Details";
                StyleMasterRec: Record "Style Master";
            begin

                comRec.Get;
                comRec.CalcFields(Picture);

                StyleMasterRec.Reset();
                StyleMasterRec.SetRange("No.", "Style No.");

                if StyleMasterRec.FindSet() then
                    BuyerName := StyleMasterRec."Buyer Name";

                TotalPlanQty := 0;

                MerchandGroupRec.Reset();
                MerchandGroupRec.SetRange("Group Id", "Group Id");

                if MerchandGroupRec.FindSet() then
                    MerchandGroupHead := MerchandGroupRec."Group Head";

                NavProdetailRec.Reset();
                NavProdetailRec.SetRange("No.", "No.");
                NavProdetailRec.SetRange("Resource No.", "Resource No.");
                NavProdetailRec.SetRange("Lot No.", "Lot No.");
                NavProdetailRec.SetRange("Style No.", "Style No.");
                NavProdetailRec.SetRange("PO No.", "PO No.");
                NavProdetailRec.SetFilter(PlanDate, '%1..%2', StartDate, EndDate);

                if NavProdetailRec.FindSet() then begin
                    repeat
                        TotalPlanQty += NavProdetailRec.Qty;
                    until NavProdetailRec.Next() = 0;
                end;

                NavProdetailRec.Reset();
                NavProdetailRec.SetRange("PO No.", "PO No.");
                NavProdetailRec.SetRange("Style No.", "Style No.");
                NavProdetailRec.SetFilter(PlanDate, '%1..%2', StartDate, EndDate);
                NavProdetailRec.SetCurrentKey(PlanDate);
                NavProdetailRec.Ascending(true);

                if NavProdetailRec.FindSet() then
                    PlanStartDate := NavProdetailRec.PlanDate;

                if NavProdetailRec.FindLast() then
                    PlanEndDate := NavProdetailRec.PlanDate;









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
                    Caption = 'Filterd By';
                    field(Factory; Factory)
                    {
                        ApplicationArea = All;
                        TableRelation = Location.Code;
                    }

                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                    }

                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    var
        TotalPlanQty: Decimal;
        PlanStartDate: Date;
        PlanEndDate: Date;
        GroupHead: Text[100];
        StartDate: Date;
        EndDate: Date;
        Factory: Code[20];
        MerchandGroupHead: Text[200];
        BuyerName: Text[50];
        comRec: Record "Company Information";
}