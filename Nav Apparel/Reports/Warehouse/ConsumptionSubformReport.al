report 51238 ConsumptionSubformReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Consumption Subform Report';
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/Warehouse/ConsumptionSubform.rdl';

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

            dataitem("Daily Consumption Header"; "Daily Consumption Header")
            {
                DataItemLinkReference = "Style Master";
                DataItemLink = "Style No." = field("Style No.");
                DataItemTableView = where("Journal Template Name" = filter('CONSUMPTIO'));
                column(No_; "No.")
                { }
                column(Main_Category_Name; "Main Category Name")
                { }
                column(ItemNo; ItemNo)
                { }
                column(ItemLeQuantity; ItemLeQuantity)
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
                column(ReqQty; ReqQty)
                { }
                column(OrginalDailyReq; OrginalDailyReq)
                { }
                column(PO; PO)
                { }
                column(ItemName; ItemName)
                { }


                trigger OnAfterGetRecord()
                begin
                    DailyConsumptionLineRec.Reset();
                    DailyConsumptionLineRec.SetRange("Document No.", "No.");
                    DailyConsumptionLineRec.SetRange("Prod. Order No.", "Prod. Order No.");
                    if DailyConsumptionLineRec.FindSet() then begin
                        ItemNo := DailyConsumptionLineRec."Item No.";
                    end;

                    ItemLedgRec.Reset();
                    ItemLedgRec.SetRange("Document No.", "Prod. Order No.");
                    ItemLedgRec.SetRange("Document No.", DailyConsumptionLineRec."Prod. Order No.");
                    if ItemLedgRec.FindSet() then begin
                        if ItemLedgRec."Entry Type" = ItemLedgRec."Entry Type"::Consumption then begin
                            ItemLeQuantity := ItemLedgRec.Quantity;
                            OrginalDailyReq := ItemLedgRec."Original Daily Requirement";
                        end;
                    end;

                    ItemRec.Reset();
                    ItemRec.SetRange("No.", DailyConsumptionLineRec."Item No.");
                    if ItemRec.FindFirst() then begin
                        SizeRange := ItemRec."Size Range No.";
                        color := ItemRec."Color No.";
                        Article := ItemRec."Article No.";
                        Dimenshion := ItemRec."Dimension Width No.";
                        UOM := ItemRec."Base Unit of Measure";
                        ItemName := ItemRec.Description;
                    end;

                    DailyConsLineRec.Reset();
                    DailyConsLineRec.SetRange("Document No.", "No.");
                    if DailyConsLineRec.FindFirst() then begin
                        ReqQty := DailyConsLineRec."Daily Consumption";
                    end;
                end;


            }
            trigger OnAfterGetRecord()
            begin
                comRec.Get;
                comRec.CalcFields(Picture);
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
        ItemName: Text[100];
        OrginalDailyReq: Decimal;
        ReqQty: Decimal;
        DailyConsLineRec: Record "Daily Consumption Line";
        UOM: Code[20];
        Article: Code[20];
        Dimenshion: code[20];
        color: Code[20];
        SizeRange: Code[250];
        ItemRec: Record Item;
        ItemLeQuantity: Decimal;
        ItemLedgRec: Record "Item Ledger Entry";
        ItemNo: Code[20];
        DailyConsumptionLineRec: Record "Daily Consumption Line";
        comRec: Record "Company Information";
        FilterNo: Code[30];


}