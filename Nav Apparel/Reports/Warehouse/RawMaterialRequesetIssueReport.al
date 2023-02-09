report 51238 RawMaterialRequesetIssue
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Raw Material Request/Issue Report';
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/Warehouse/RawMaterialRequesetIssueReport.rdl';

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

            dataitem("Daily Consumption Header"; "Daily Consumption Header")
            {
                DataItemLinkReference = "Style Master";
                DataItemLink = "Style No." = field("Style No.");
                DataItemTableView = where("Journal Template Name" = filter('CONSUMPTIO'));

                column(No_; "No.")
                { }
                column(Main_Category_Name; "Main Category Name")
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
                dataitem("Daily Consumption Line"; "Daily Consumption Line")
                {
                    DataItemLinkReference = "Daily Consumption Header";
                    DataItemLink = "Document No." = field("No.");
                    DataItemTableView = sorting("Document No.", "Line No.");

                    column(ItemNo; "Item No.")
                    { }
                    column(ReqQty; "Daily Consumption")
                    { }

                    dataitem("Item Ledger Entry"; "Item Ledger Entry")
                    {
                        DataItemLinkReference = "Daily Consumption Line";
                        DataItemLink = "Document No." = field("Prod. Order No."), "Order Line No." = field("Line No.");
                        DataItemTableView = where("Entry Type" = filter('Consumption'));

                        column(ItemLeQuantity; Quantity * -1)
                        { }
                        column(OrginalDailyReq; "Original Daily Requirement")
                        { }
                    }
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
                    end;
                }
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


}