report 51449 StyleProductionStatus
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Style Production Status Report';
    RDLCLayout = 'Report_Layouts/Production/StyleProductionStatus.rdl';
    DefaultLayout = RDLC;


    dataset
    {
        dataitem(ProductionOutHeader; ProductionOutHeader)
        {
            DataItemTableView = sorting("No.");
            column(Style_No_; "Style Name")
            { }
            column(Lot_No_; "Lot No.")
            { }
            column(PO_No_; "PO No")
            { }
            column(Cut_Out_Qty; CutOut)
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(Work_Center_No_; "Resource No.")
            { }
            column(BalOut; BalOut)
            { }
            column(BalIn; BalIn)
            { }
            column(LineIn; LineIn)
            { }
            column(LineOut; LineOut)
            { }
            column(OrderQty; OrderQty)
            { }
            column(Total; Total)
            { }
            column(PoQty; PoQty)
            { }
            column(GrandHTotal; GrandHTotal)
            { }
            column(CutOutTotal; CutOutTotal)
            { }
            column(BalOutTotal; BalOutTotal)
            { }
            column(PoTotal; PoTotal)
            { }
            column(BalInTotal; BalInTotal)
            { }
            column(LineInTot; LineInTot)
            { }
            column(BuyerName; BuyerName)
            { }
            trigger OnAfterGetRecord()
            var
                B1: Decimal;
                B2: Decimal;
                B3: Decimal;
                B4: Decimal;
                CutIN: Decimal;
                BalV: Decimal;

            begin
                comRec.Get;
                comRec.CalcFields(Picture);

                Total := 0;
                HourlyRec.Reset();
                // HourlyRec.SetRange("Factory No.", "Factory No.");
                HourlyRec.SetRange("Style No.", "Style No.");
                HourlyRec.SetRange("Work Center No.", "Resource No.");
                HourlyRec.SetFilter(Item, '=%1', 'PASS PCS');
                HourlyRec.SetFilter(Type, '=%1', HourlyRec.Type::Sewing);
                if HourlyRec.FindSet() then begin
                    repeat
                        Total += HourlyRec.Total;
                    until HourlyRec.Next() = 0;
                end;

                GrandHTotal := 0;
                HourlyRec.Reset();
                HourlyRec.SetRange("Style No.", "Style No.");
                HourlyRec.SetFilter(Item, '=%1', 'PASS PCS');
                HourlyRec.SetFilter(Type, '=%1', HourlyRec.Type::Sewing);
                if HourlyRec.FindSet() then begin
                    HourlyRec.CalcSums(Total);
                    GrandHTotal := HourlyRec.Total;
                end;

                HourlyRec.Reset();
                HourlyRec.SetRange("Style No.", "Style No.");
                HourlyRec.SetRange("Work Center No.", "Resource No.");
                HourlyRec.SetFilter(Item, '=%1', 'PASS PCS');
                HourlyRec.SetFilter(Type, '=%1', HourlyRec.Type::Sewing);
                if HourlyRec.FindSet() then begin
                    HourlyRec.CalcSums(Total);
                    GrandHTotal := HourlyRec.Total;
                end;

                StylePoRec.Reset();
                StylePoRec.SetRange("Style No.", "Style No.");
                StylePoRec.SetRange("Lot No.", "Lot No.");
                StylePoRec.SetRange("PO No.", "PO No");
                if StylePoRec.FindSet() then begin
                    // CutOut := StylePoRec."Cut Out Qty";
                    // BalOut := StylePoRec."Sawing Out Qty" - StylePoRec."Sawing In Qty";
                    // BalIn := StylePoRec."Sawing In Qty" - StylePoRec."Cut In Qty";
                    PoQty := StylePoRec.Qty;
                end;


                StylePoRec.Reset();
                StylePoRec.SetRange("Style No.", "Style No.");
                if StylePoRec.FindSet() then begin
                    StylePoRec.CalcSums("Cut Out Qty");
                    CutOutTotal := StylePoRec."Cut Out Qty";

                    StylePoRec.CalcSums("Sawing Out Qty");
                    B1 := StylePoRec."Sawing Out Qty";

                    StylePoRec.CalcSums("Sawing In Qty");
                    b2 := StylePoRec."Sawing In Qty";

                    BalOutTotal := B1 - B2;

                    StylePoRec.CalcSums("Cut In Qty");
                    B3 := StylePoRec."Cut In Qty";

                    BalInTotal := B2 - B3;

                    StylePoRec.CalcSums(Qty);
                    PoTotal := StylePoRec.Qty;

                end;
                CutOut := 0;
                CutIN := 0;
                ProdOutRec.Reset();
                ProdOutRec.SetRange("No.", "No.");
                ProdOutRec.SetRange("Style No.", "Style No.");
                ProdOutRec.SetRange("PO No", "PO No");
                ProdOutRec.SetRange("Lot No.", "Lot No.");
                ProdOutRec.SetRange(Type, ProdOutRec.Type::cut);
                ProdOutRec.SetRange("Resource No.", "Resource No.");
                if ProdOutRec.FindSet() then begin
                    repeat
                        CutOut += ProdOutRec."Output Qty";
                        CutIN += ProdOutRec."Input Qty";
                    until ProdOutRec.Next() = 0;
                end;

                BalOut := 0;
                BalIn := 0;
                LineIn := 0;
                LineOut := 0;
                BalV := 0;
                ProdOutRec.Reset();
                ProdOutRec.SetRange("No.", "No.");
                ProdOutRec.SetRange("Style No.", "Style No.");
                ProdOutRec.SetRange("PO No", "PO No");
                ProdOutRec.SetRange("Lot No.", "Lot No.");
                ProdOutRec.SetRange(Type, ProdOutRec.Type::Saw);
                ProdOutRec.SetRange("Resource No.", "Resource No.");
                if ProdOutRec.FindSet() then begin
                    repeat
                        LineIn += ProdOutRec."Input Qty";
                        LineOut += ProdOutRec."Output Qty";
                        BalV += ProdOutRec."Input Qty";
                        BalOut += ProdOutRec."Output Qty" - ProdOutRec."Input Qty";
                    until ProdOutRec.Next() = 0;
                end;

                BalIn := BalV - CutIN;

                LineInTot := 0;
                ProdOutRec.Reset();
                // ProdOutRec.SetRange("No.", "No.");
                ProdOutRec.SetRange("Style No.", "Style No.");
                ProdOutRec.SetRange("Resource No.", "Resource No.");
                ProdOutRec.SetRange(Type, ProdOutRec.Type::Saw);
                if ProdOutRec.FindSet() then begin
                    repeat
                        LineInTot += ProdOutRec."Input Qty";
                    until ProdOutRec.Next() = 0;
                    // ProdOutRec.CalcSums("Input Qty");
                    // LineInTot := ProdOutRec."Input Qty";
                end;


                StyleMasterRec.Reset();
                StyleMasterRec.SetRange("No.", "Style No.");
                if StyleMasterRec.FindSet() then begin
                    OrderQty := StyleMasterRec."Order Qty";
                    BuyerName := StyleMasterRec."Buyer Name";
                end;
            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                SetRange("Style No.", StyleFilter);
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
                    field(StyleFilter; StyleFilter)
                    {
                        ApplicationArea = All;
                        TableRelation = "Style Master"."No.";
                        Caption = 'Style';


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
        BuyerName: text[200];
        LineInTot: Decimal;
        BalInTotal: Decimal;
        PoTotal: Decimal;
        BalOutTotal: Decimal;
        CutOutTotal: Decimal;
        GrandHTotal: Decimal;
        HourlyHeadRec: Record "Hourly Production Master";
        PoQty: Integer;
        Total: Integer;
        HourlyRec: Record "Hourly Production Lines";
        StyleMasterRec: Record "Style Master";
        OrderQty: Integer;
        LineIn: BigInteger;
        LineOut: BigInteger;
        ProdOutRec: Record ProductionOutHeader;
        BalIn: Decimal;
        BalOut: Decimal;
        CutOut: Decimal;
        StylePoRec: Record "Style Master PO";
        comRec: Record "Company Information";
        StyleFilter: Code[20];
}