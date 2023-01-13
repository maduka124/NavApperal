report 50852 SewingProductionDetails
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Sewing Production Details';
    RDLCLayout = 'Report_Layouts/Planning/SewingProductionDetails.rdl';
    DefaultLayout = RDLC;


    dataset
    {
        dataitem(ProductionOutHeader; ProductionOutHeader)
        {
            DataItemTableView = where(Type = filter('Saw'));
            column(TodayOutput; "Output Qty")
            { }
            column(OutPutStartDate; "Prod Date")
            { }
            column(Resource_No_; "Resource Name")
            { }
            column(PO_No_; "PO No")
            { }
            column(TodayTarget; Quantity)
            { }
            column(BuyerName; BuyerName)
            { }
            column(PlanQty; PlanQty)
            { }
            column(InputDate; InputDate)
            { }
            column(TotalOuput; TotalOuput)
            { }
            column(OutputComDate; OutputComDate)
            { }
            column(ShipDate; ShipDate)
            { }
            column(stDate; stDate)
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(Style; "Out Style Name")
            { }
            column(Factory; Factory)
            { }
            column(OrderQy; OrderQy)
            { }
            column(Style_No_; "Out Style No.")
            { }

            trigger OnPreDataItem()

            begin
                SetRange("Prod Date", stDate);
            end;

            trigger OnAfterGetRecord()

            begin

                NavAppProdRec.Reset();
                NavAppProdRec.SetRange("Style No.", "Out Style No.");
                NavAppProdRec.SetRange(PlanDate, "Prod Date");
                if NavAppProdRec.FindFirst() then begin
                    Quantity := NavAppProdRec.Qty;
                end;

                StylePoRec.Reset();
                StylePoRec.SetRange("Style No.", "Out Style No.");
                StylePoRec.SetRange("PO No.", "PO No");
                if StylePoRec.FindFirst() then begin
                    TotalOuput += StylePoRec."Sawing Out Qty";
                    ShipDate := StylePoRec."Ship Date";
                    OrderQy := StylePoRec.Qty;
                end;

                StyleRec.Reset();
                StyleRec.SetRange("No.", "Out Style No.");
                if StyleRec.FindFirst() then begin
                    BuyerName := StyleRec."Buyer Name";
                    Style := StyleRec."Style No.";
                    Factory := StyleRec."Factory Name";
                end;

                comRec.Get;
                comRec.CalcFields(Picture);


                NavLinesRec.Reset();
                NavLinesRec.SetRange("Style No.", "Out Style No.");
                // NavLinesRec.SetRange("Resource No.", "Resource No.");
                // NavLinesRec.SetRange("PO No.", "PO No");
                // NavLinesRec.SetRange("Line No.", "Line No.");
                if NavLinesRec.FindFirst() then begin
                    PlanQty := NavLinesRec.Qty;
                    InputDate := NavLinesRec.StartDateTime;
                    OutputComDate := NavLinesRec.FinishDateTime;
                    ResourceName := NavLinesRec."Resource Name";
                end;

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
                        Caption = 'Date';

                    }

                }
            }
        }


    }



    var


        Quantity: Decimal;
        NavAppProdRec: Record "NavApp Prod Plans Details";
        ResourceName: Text[100];
        WorkcenterRec: Record "Work Center";
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

}