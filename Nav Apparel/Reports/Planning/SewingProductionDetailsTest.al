report 50800 SewingProductionDetailsTest
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Sewing Production Details Test';
    RDLCLayout = 'Report_Layouts/Planning/SewingProductionDetailsTest.rdl';
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
            column(Factory_No_; FactoryNo)
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
            column(Style; "Out Style Name")
            { }
            column(Factory; Factory)
            { }
            column(OrderQy; OrderQy)
            { }
            column(Style_No_; "Out Style No.")
            { }


            // dataitem("NavApp Prod Plans Details"; "NavApp Prod Plans Details")
            // {

            //     DataItemLinkReference = ProductionOutHeader;
            //     DataItemLink = "Style No." = field("Out Style No.");
            //     DataItemTableView = sorting("No.");



            //     trigger OnAfterGetRecord()

            //     begin


            //         // WorkcenterRec.Reset();
            //         // WorkcenterRec.SetRange("No.", "Resource No.");
            //         // if WorkcenterRec.FindFirst() then begin
            //         //     ResourceName := WorkcenterRec.Name;
            //         // end;
            //     end;


            // }

            trigger OnPreDataItem()

            begin
                SetRange("Prod Date", stDate);
            end;

            trigger OnAfterGetRecord()

            begin

                NavAppProdRec.Reset();
                NavAppProdRec.SetRange("Style No.", "Out Style No.");
                NavAppProdRec.SetRange(PlanDate, "Prod Date");
                NavAppProdRec.SetRange("Resource No.", "Resource No.");
                if NavAppProdRec.FindFirst() then begin
                    StyleNo := NavAppProdRec."Style No.";
                    Quantity := NavAppProdRec.Qty;
                    PO := NavAppProdRec."PO No.";
                    FactoryNo := NavAppProdRec."Factory No.";
                end;

                StylePoRec.Reset();
                StylePoRec.SetRange("Style No.", "Out Style No.");
                // StylePoRec.SetRange("Lot No.", "Lot No.");
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
        FactoryNo: Code[20];
        PO: Text[50];
        Quantity: Decimal;
        StyleNo: Code[20];
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