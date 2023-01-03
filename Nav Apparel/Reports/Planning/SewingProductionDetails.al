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
            column(Resource_No_; ResourceName)
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
            // column(OutPutStartDate; OutPutStartDate)
            // { }
            column(OutputComDate; OutputComDate)
            { }
            column(ShipDate; ShipDate)
            { }
            column(stDate; stDate)
            { }
            // column(TodayOutput; TodayOutput)
            // { }
            column(CompLogo; comRec.Picture)
            { }
            column(Style; Style)
            { }
            column(Factory; Factory)
            { }
            column(OrderQy; OrderQy)
            { }


            dataitem(ProductionOutHeader; ProductionOutHeader)
            {
                DataItemLinkReference = "NavApp Prod Plans Details";
                DataItemLink = "PO No" = field("PO No."),"Prod Date"= field(PlanDate);
                DataItemTableView = sorting("No.");

                column(TodayOutput; "Output Qty")
                { }
                column(OutPutStartDate; "Prod Date")
                { }
                // column(TodayOutput; TodayOutput)
                // { }
                // column(OutPutStartDate; OutPutStartDate)
                // { }
                // trigger OnAfterGetRecord()
                // var
                //     myInt: Integer;
                // begin
                //     if Type = Type::Saw then begin
                //         OutPutStartDate := "Prod Date";
                //         TodayOutput := "Output Qty";
                //     end;

                // end;
            }
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
                StylePoRec.SetRange("Lot No.", "Lot No.");
                StylePoRec.SetRange("PO No.", "PO No.");
                if StylePoRec.FindFirst() then begin
                    TotalOuput := StylePoRec."Sawing Out Qty";
                    ShipDate := StylePoRec."Ship Date";
                    OrderQy := StylePoRec.Qty;
                end;

                // ProductionHeaderRec.Reset();
                // ProductionHeaderRec.SetRange("Resource No.", "Resource No.");
                // ProductionHeaderRec.SetRange("Style No.", "Style No.");
                // ProductionHeaderRec.SetRange("PO No", "PO No.");
                // if ProductionHeaderRec.FindFirst() then begin
                //     if ProductionHeaderRec.Type = ProductionHeaderRec.Type::Saw then begin
                //         OutPutStartDate := ProductionHeaderRec."Prod Date";
                //         TodayOutput := ProductionHeaderRec."Output Qty";
                //     end;

                // end;


                WorkcenterRec.Reset();
                WorkcenterRec.SetRange("No.", "Resource No.");
                if WorkcenterRec.FindFirst() then begin
                    ResourceName := WorkcenterRec.Name;
                end;
            end;

            trigger OnPreDataItem()

            begin
                SetRange(PlanDate, stDate);
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