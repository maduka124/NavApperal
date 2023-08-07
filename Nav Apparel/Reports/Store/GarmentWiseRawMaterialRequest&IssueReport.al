report 51238 GarmentWiseRawMaterialRequest
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Garment Wise Raw Material Request & Issue Report';
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/Store/GarmentWiseRawMaterialRequest&IssueReport.rdl';

    dataset
    {
        dataitem("Style Master"; "Style Master")
        {
            DataItemTableView = sorting("No.");

            column(Style_No_; "Style No.")
            { }
            column(Garment_Type_Name; "Garment Type Name")
            { }
            column(Buyer_Name; "Buyer Name")
            { }
            column(Order_Qty; "Order Qty")
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(Factory_Name; "Factory Name")
            { }
            column(PoQty; PoQty)
            { }
            column(PONo; PONo)
            { }
            column(LotNo; LotNo)
            { }

            dataitem("Daily Consumption Header"; "Daily Consumption Header")
            {
                DataItemLinkReference = "Style Master";
                DataItemLink = "Style No." = field("Style No.");
                DataItemTableView = where("Journal Template Name" = filter('CONSUMPTIO'));

                column(No_; "No.")
                { }
                column(Main_Category_Name; 'xxxxx')
                { }
                column(SizeRange; SizeRange)
                { }
                column(color; color)
                { }
                column(Article; Article)
                { }
                column(Dimenshion; Dimenshion)
                { }
                column(UOM; UOM)
                { }
                column(PO; PO)
                { }
                column(ItemName; ItemName)
                { }

                ////////////
                column(ItemLeQuantity; ItemLeQuantity)
                { }
                column(OrginalDailyReq; RoundDailyReq)
                { }
                column(GMTISSUEQty; GMTISSUEQty)
                { }


                dataitem("Daily Consumption Line"; "Daily Consumption Line")
                {
                    DataItemLinkReference = "Daily Consumption Header";
                    DataItemLink = "Document No." = field("No.");
                    DataItemTableView = sorting("Document No.", "Line No.");

                    column(ItemNo; "Item No.")
                    { }
                    column(ReqQty; "Daily Consumption")
                    { }
                    column(Document_No_; "Document No.")
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
                            Article := ItemRec."Article No.";
                            Dimenshion := ItemRec."Dimension Width No.";
                            UOM := ItemRec."Base Unit of Measure";
                            ItemName := ItemRec.Description;
                        end;

                        /////////////////
                        ItemLeQuantity := 0;
                        GMTISSUEQty := 0;
                        RoundDailyReq := 0;

                        //get Original Daily Requirement
                        ItemLedgRec.Reset();
                        ItemLedgRec.SetRange("Source No.", "Daily Consumption Line"."Item No.");
                        ItemLedgRec.SetRange("Daily Consumption Doc. No.", "Daily Consumption Line"."Document No.");
                        ItemLedgRec.SetFilter("Entry Type", '=%1', ItemLedgRec."Entry Type"::Consumption);
                        ItemLedgRec.SetCurrentKey("Original Daily Requirement");
                        ItemLedgRec.Ascending(false);
                        if ItemLedgRec.FindSet() then
                            RoundDailyReq := ItemLedgRec."Original Daily Requirement";


                        //Calculate parameters
                        ItemLedgRec.Reset();
                        ItemLedgRec.SetRange("Source No.", "Daily Consumption Line"."Item No.");
                        ItemLedgRec.SetRange("Daily Consumption Doc. No.", "Daily Consumption Line"."Document No.");
                        ItemLedgRec.SetFilter("Entry Type", '=%1', ItemLedgRec."Entry Type"::Consumption);
                        if ItemLedgRec.FindSet() then begin

                            repeat
                                //RoundDailyReq += Round(ItemLedgRec."Original Daily Requirement", 0.01, '>');

                                if RoundDailyReq = 0 then
                                    GMTISSUEQty := 0
                                else
                                    GMTISSUEQty += round(("Daily Consumption Line"."Daily Consumption" / RoundDailyReq) * (ItemLedgRec.Quantity * -1), 1);

                                ItemLeQuantity += ItemLedgRec.Quantity * -1;

                            until ItemLedgRec.Next() = 0;
                        end;

                    end;
                }

                trigger OnAfterGetRecord()
                begin

                end;
            }

            trigger OnAfterGetRecord()
            begin
                comRec.Get;
                comRec.CalcFields(Picture);
                StylePoRec.Reset();
                StylePoRec.SetRange("Style No.", "No.");
                if StylePoRec.FindFirst() then begin
                    PoQty := StylePoRec.Qty;
                    PONo := StylePoRec."PO No.";
                    LotNo := StylePoRec."Lot No.";
                end;

            end;

            trigger OnPreDataItem()
            begin
                SetRange("No.", FilterNo);
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
                    field(FilterNo; FilterNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Style';

                        TableRelation = "Style Master"."No.";
                    }
                }
            }
        }
    }




    var
        LotNo: Code[20];

        ItemLe: Decimal;
        RoundDailyReq: Decimal;
        PONo: Code[20];
        PoQty: BigInteger;
        StylePoRec: Record "Style Master PO";
        ItemName: Text[100];
        ReqQty: Decimal;
        DailyConsLineRec: Record "Daily Consumption Line";
        UOM: Code[20];
        Article: Code[20];
        Dimenshion: code[20];
        color: Code[20];
        SizeRange: Code[250];
        ItemRec: Record Item;
        ItemLedgRec: Record "Item Ledger Entry";
        DailyConsumptionLineRec: Record "Daily Consumption Line";
        comRec: Record "Company Information";
        FilterNo: Code[30];
        GMTISSUEQty: Decimal;
        ItemLeQuantity: Decimal;


}