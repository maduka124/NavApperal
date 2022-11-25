report 50852 SewingProductionDetails
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Sewing Production Details';
    RDLCLayout = 'Report_Layouts/Planning/SewingProductionDetails.rdl';
    DefaultLayout = RDLC;


    dataset
    {
        dataitem("NavApp Prod Plans Details"; "NavApp Prod Plans Details")
        {
            DataItemTableView = sorting("No.");
            column(Style_No_; "Style No.")
            { }
            column(Resource_No_; "Resource No.")
            { }
            column(BuyerName; BuyerName)
            { }
            column(Factory_No_; "Factory No.")
            { }
            column(PO_No_; "PO No.")
            { }
            column(TodayTarget; Qty)
            { }
            column(PlanQty; PlanQty)
            { }
            column(InputDate; InputDate)
            { }
            column(TotalOuput; TotalOuput)
            { }
            column(OutPutStartDate; OutPutStartDate)
            { }
            column(OutputComDate; OutputComDate)
            { }
            column(ShipDate; ShipDate)
            { }
            column(stDate; stDate)
            { }
            column(endDate; endDate)
            { }
            column(TodayOutput; TodayOutput)
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(Style; Style)
            { }
            column(Factory; Factory)
            { }
            column(OrderQy; OrderQy)
            { }

            trigger OnAfterGetRecord()

            begin
                comRec.Get;
                comRec.CalcFields(Picture);

                StyleRec.Reset();
                StyleRec.SetRange("No.", "Style No.");
                if StyleRec.FindFirst() then begin
                    BuyerName := StyleRec."Buyer Name";
                    Style := StyleRec."Style No.";
                    Factory := StyleRec."Factory Name";
                    OrderQy := StyleRec."Order Qty";
                end;


                NavLinesRec.Reset();
                NavLinesRec.SetRange("Style No.", "Style No.");
                NavLinesRec.SetRange("PO No.", "PO No.");
                NavLinesRec.SetRange("Line No.", "Line No.");
                if NavLinesRec.FindFirst() then begin
                    PlanQty := NavLinesRec.Qty;
                    InputDate := NavLinesRec.StartDateTime;
                    OutputComDate := NavLinesRec.FinishDateTime;
                end;

                StylePoRec.Reset();
                StylePoRec.SetRange("Style No.", "Style No.");
                StylePoRec.SetRange("PO No.", "PO No.");
                if StylePoRec.FindFirst() then begin
                    TotalOuput := StylePoRec."Sawing Out Qty";
                    ShipDate := StylePoRec."Ship Date";
                end;

                ProductionHeaderRec.Reset();
                ProductionHeaderRec.SetRange("Style No.", "Style No.");
                ProductionHeaderRec.SetRange("PO No", "PO No.");
                if ProductionHeaderRec.FindFirst() then begin
                    OutPutStartDate := ProductionHeaderRec."Prod Date";
                    TodayOutput := ProductionHeaderRec."Output Qty";
                end;
            end;

            trigger OnPreDataItem()

            begin
                SetRange(PlanDate, stDate, endDate);
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


    }



    var
        OrderQy: BigInteger;
        Factory: Text[100];
        Style: Text[50];
        comRec: Record "Company Information";
        TodayOutput: BigInteger;
        ShipDate: Date;
        OutputComDate: DateTime;
        OutPutStartDate: Date;
        ProductionHeaderRec: Record ProductionOutHeader;
        TotalOuput: BigInteger;
        StylePoRec: Record "Style Master PO";
        InputDate: DateTime;
        PlanQty: BigInteger;
        NavLinesRec: Record "NavApp Planning Lines";
        BuyerName: Text[50];
        StyleRec: Record "Style Master";
        stDate: Date;
        endDate: Date;
}