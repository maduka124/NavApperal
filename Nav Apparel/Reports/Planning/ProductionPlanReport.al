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
            column(Merchandiser_Name; "Merchandiser Name")
            { }
            column(Factory_Name; "Factory Name")
            { }
            column(Buyer_Name; "Buyer Name")
            { }
            column(Order_Qty; PoQty)
            { }
            column(BPCD; BPCD)
            { }
            column(Start_Date; stDate)
            { }
            column(End_Date; endDate)
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(Order_NO; PoNo)
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

            dataitem("NavApp Planning Lines"; "NavApp Planning Lines")
            {
                DataItemLinkReference = "Style Master";
                DataItemLink = "Style No." = field("No.");
                DataItemTableView = sorting("Line No.");

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

                trigger OnAfterGetRecord()
                var
                begin
                    StyleMasterPoRec.SetRange("Style No.", "Style No.");
                    StyleMasterPoRec.SetRange("Lot No.", "Lot No.");

                    if StyleMasterPoRec.FindFirst() then begin
                        shDate := StyleMasterPoRec."Ship Date";
                    end;
                end;
            }
            trigger OnPreDataItem()
            begin
                SetRange("Style Master"."Created Date", stDate, endDate);
            end;

            trigger OnAfterGetRecord()
            begin
                comRec.Get;
                comRec.CalcFields(Picture);

                stylePORec.SetRange("Style No.", "No.");
                if stylePORec.FindFirst() then begin
                    PoNo := stylePORec."PO No.";
                    PoQty := stylePORec.Qty
                end;
                PurchLineRec.SetRange(StyleNo, "No.");
                if PurchLineRec.FindFirst() then begin
                    LineQty := PurchLineRec.Quantity;
                end;

                NavAppRec.SetRange("Style No.", "No.");
                if NavAppRec.FindFirst() then begin
                    StartDt := NavAppRec."Start Date" - 2;
                    StartDate := NavAppRec."Start Date";
                end;

                if NavAppRec.FindLast() then begin
                    EndDt := NavAppRec."End Date";
                    InSpectionDt := NavAppRec."End Date" + 10;
                end;
                PRDHR := EndDt - StartDate;
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
        NavAppRec: Record "NavApp Planning Lines";
        StartDt: Date;
        EndDt: Date;
        InSpectionDt: Date;
        StartDate: Date;
        PRDHR: Integer;


}