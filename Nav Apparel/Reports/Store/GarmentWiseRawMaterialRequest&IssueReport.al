report 51238 GarmentWiseRawMaterialRequest
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Garment Wise Raw Material Request & Issue Report';
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/Store/GarmentWiseRawMaterialRequest&IssueReport.rdl';

    dataset
    {
        dataitem("Daily Consumption Header"; "Daily Consumption Header")
        {
            DataItemTableView = where("Journal Template Name" = filter('CONSUMPTIO'));

            column(DocNo; "No.")
            { }
            column(PO; PO)
            { }
            column(Style_Name; "Style Name")
            { }
            column(CompLogo; comRec.Picture)
            { }

            column(Garment_Type_Name; "GarmentTypeName")
            { }
            column(Buyer_Name; "BuyerName")
            { }
            column(Order_Qty; "OrderQty")
            { }
            column(Factory_Name; "Factory")
            { }
            column(PoQty; PoQty)
            { }

            dataitem("Daily Consumption Line"; "Daily Consumption Line")
            {
                DataItemLinkReference = "Daily Consumption Header";
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.", "Line No.");

                column(FGNo; "Item No.")
                { }
                column(FGName; ItemName)
                { }
                column(color; color)
                { }
                column(SizeRange; SizeRange)
                { }
                column(ReqQtyGM; "Daily Consumption")
                { }
                column(ReqQtyRM; ReqQtyRM)
                { }
                column(IssuedQtyGM; IssuedQtyGM)
                { }
                column(IssuedQtyRM; IssuedQtyRM)
                { }

                // dataitem("Item Ledger Entry"; "Item Ledger Entry")
                // {
                //     DataItemLinkReference = "Daily Consumption Line";
                //     DataItemLink = "Source No." = field("Item No."), "Daily Consumption Doc. No." = field("Document No.");
                //     DataItemTableView = where("Entry Type" = filter(Consumption));
                //    
                //     column(ItemLeQuantity; Quantity * -1)
                //     { }
                //     column(OrginalDailyReq; RoundDailyReq)
                //     { }
                //     column(GMTISSUEQty; GMTISSUEQty)
                //     { }

                //     trigger OnAfterGetRecord()
                //     begin
                //         RoundDailyReq := Round("Original Daily Requirement", 0.01, '>');
                //         if RoundDailyReq = 0 then
                //             GMTISSUEQty := 0
                //         else
                //             GMTISSUEQty := round(("Daily Consumption Line"."Daily Consumption" / RoundDailyReq) * (Quantity * -1), 1);
                //     end;
                // }

                trigger OnAfterGetRecord()
                begin
                    ItemRec.Reset();
                    ItemRec.SetRange("No.", "Item No.");
                    if ItemRec.FindFirst() then begin
                        SizeRange := ItemRec."Size Range No.";
                        color := ItemRec."Color No.";
                        ItemName := ItemRec.Description;
                    end;

                    ReqQtyRM := 0;
                    IssuedQtyGM := 0;
                    IssuedQtyRM := 0;

                    //get Original Daily Requirement
                    ItemLedgRec.Reset();
                    ItemLedgRec.SetRange("Source No.", "Daily Consumption Line"."Item No.");
                    ItemLedgRec.SetRange("Daily Consumption Doc. No.", "Daily Consumption Line"."Document No.");
                    ItemLedgRec.SetFilter("Entry Type", '=%1', ItemLedgRec."Entry Type"::Consumption);
                    ItemLedgRec.SetCurrentKey("Original Daily Requirement");
                    ItemLedgRec.Ascending(false);
                    if ItemLedgRec.FindSet() then
                        ReqQtyRM := ItemLedgRec."Original Daily Requirement";

                    //Calculate parameters
                    ItemLedgRec.Reset();
                    ItemLedgRec.SetRange("Source No.", "Daily Consumption Line"."Item No.");
                    ItemLedgRec.SetRange("Daily Consumption Doc. No.", "Daily Consumption Line"."Document No.");
                    ItemLedgRec.SetFilter("Entry Type", '=%1', ItemLedgRec."Entry Type"::Consumption);
                    if ItemLedgRec.FindSet() then begin
                        repeat
                            if ReqQtyRM = 0 then
                                IssuedQtyGM := 0
                            else
                                IssuedQtyGM += round(("Daily Consumption Line"."Daily Consumption" / ReqQtyRM) * (ItemLedgRec.Quantity * -1), 1);
                            IssuedQtyRM += ItemLedgRec.Quantity * -1;
                        until ItemLedgRec.Next() = 0;
                    end;
                end;


                trigger OnPreDataItem()
                begin
                    SetFilter("Daily Consumption", '>%1', 0);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                comRec.Get;
                comRec.CalcFields(Picture);
                StylePoRec.Reset();
                StylePoRec.SetRange("Style No.", "Style Master No.");
                StylePoRec.SetRange("PO No.", PO);
                if StylePoRec.FindFirst() then begin
                    PoQty := StylePoRec.Qty;
                end;

                StyleMasRec.Reset();
                StyleMasRec.SetRange("No.", "Style Master No.");
                if StyleMasRec.FindFirst() then begin
                    BuyerName := StyleMasRec."Buyer Name";
                    GarmentTypeName := StyleMasRec."Garment Type Name";
                    OrderQty := StyleMasRec."Order Qty";
                    Factory := StyleMasRec."Factory Name";
                end;
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Style Name", FilterNo);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Filter)
                {
                    Caption = 'Filter By';
                    field(FilterNo; FilterNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Style';

                        trigger OnLookup(var texts: text): Boolean
                        var
                            DailyConsRec: Record "Daily Consumption Header";
                            StyleName: text[200];
                        begin
                            DailyConsRec.Reset();
                            DailyConsRec.SetCurrentKey("Style Name");
                            DailyConsRec.Ascending(true);
                            if DailyConsRec.FindSet() then begin
                                repeat
                                    if StyleName <> DailyConsRec."Style Name" then begin
                                        StyleName := DailyConsRec."Style Name";
                                        DailyConsRec.MARK(TRUE);
                                    end;
                                until DailyConsRec.Next() = 0;

                                DailyConsRec.MARKEDONLY(TRUE);
                                if Page.RunModal(51388, DailyConsRec) = Action::LookupOK then begin
                                    FilterNo := DailyConsRec."Style Name";
                                end;
                            end;
                        end;
                    }
                }
            }
        }
    }

    var
        GarmentTypeName: Text[50];
        BuyerName: Text[50];
        OrderQty: BigInteger;
        Factory: Text[50];
        FilterNo: text[200];
        StylePoRec: Record "Style Master PO";
        StyleMasRec: Record "Style Master";
        PoQty: BigInteger;
        SizeRange: Code[250];
        ItemRec: Record Item;
        comRec: Record "Company Information";
        ItemLedgRec: Record "Item Ledger Entry";
        ItemName: Text[100];
        color: Text[200];
        ReqQtyRM: Decimal;
        IssuedQtyGM: Decimal;
        IssuedQtyRM: Decimal;
}