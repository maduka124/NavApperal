report 50624 TargetSheetReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Target Sheet Report';
    RDLCLayout = 'Report_Layouts/Planning/TargetSheetReport.rdl';
    DefaultLayout = RDLC;
    dataset
    {
        dataitem("Style Master"; "Style Master")
        {
            DataItemTableView = sorting("No.");

            column(BuyerName; "Buyer Name")
            { }
            column(GarmentType; "Garment Type Name")
            { }
            column(Diff; Diff)
            { }
            column(CompLogo; comRec.Picture)
            { }
            dataitem("NavApp Prod Plans Details"; "NavApp Prod Plans Details")
            {
                DataItemLinkReference = "Style Master";
                DataItemLink = "Style No." = field("No.");
                DataItemTableView = sorting("No.");
                column(Style_Name; "Style Name")
                { }
                column(Resource_No_; "Resource No.")
                { }
                column(PlanDate; PlanDate)
                { }
                column(PO_No_; "PO No.")
                { }
                column(Target; Target)
                { }
                column(Qty; Qty)
                { }
                column(HoursPerDay; HoursPerDay)
                { }
                column(LineName; LineName)
                { }


                trigger OnAfterGetRecord()
                var

                begin

                    WorkCenterRec.SetRange("No.", "NavApp Prod Plans Details"."Resource No.");
                    if WorkCenterRec.FindFirst() then begin
                        LineName := WorkCenterRec.Name;
                    end;

                    Diff := 0;
                    if "NavApp Prod Plans Details".Target = "NavApp Prod Plans Details".Qty then begin
                        Diff := 0;
                    end
                    else
                        if "NavApp Prod Plans Details".Target < "NavApp Prod Plans Details".Qty then begin
                            Diff := "NavApp Prod Plans Details".Qty;
                        end
                        else
                            Diff := ("NavApp Prod Plans Details".Target - "NavApp Prod Plans Details".Qty) * -1;



                end;


            }
            trigger OnPreDataItem()

            begin
                SetRange("No.", FilterCode);
            end;

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
                    field(FilterCode; FilterCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Style No';
                        TableRelation = "Style Master"."No.";

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
        styleMasterRec: Record "Style Master";
        Diff: BigInteger;
        WorkCenterRec: Record "Work Center";
        LineName: Text[50];
        FilterCode: Code[50];
        comRec: Record "Company Information";



}