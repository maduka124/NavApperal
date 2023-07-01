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
                //Done by sachith on 17/05/23
                column(ProdUpdQty; ProdUpdQty)
                { }
                column(HoursPerDay; HoursPerDay)
                { }
                column(LineName; LineName)
                { }
                column(DisplaySeq; DisplaySeq)
                { }
                column(Factory_No_; "Factory No.")
                { }

                trigger OnAfterGetRecord()
                var
                begin
                    WorkCenterRec.SetRange("No.", "NavApp Prod Plans Details"."Resource No.");
                    if WorkCenterRec.FindFirst() then begin
                        LineName := WorkCenterRec.Name;
                        DisplaySeq := WorkCenterRec."Work Center Seq No";
                    end;

                    Diff := ("NavApp Prod Plans Details".ProdUpdQty - "NavApp Prod Plans Details".Qty);
                end;

                trigger OnPreDataItem()
                begin
                    SetFilter("Qty", '>%1', 0);
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
                        TableRelation = "Style Master"."No." where(Status = filter(Confirmed));

                        trigger OnValidate()
                        var
                            NavAppProdRec: Record "NavApp Prod Plans Details";
                        begin
                            NavAppProdRec.Reset();
                            NavAppProdRec.SetRange("Style No.", FilterCode);
                            if not NavAppProdRec.FindSet() then
                                Error('Style not planned.');
                        end;
                    }
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
        DisplaySeq: Integer;
}