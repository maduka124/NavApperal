report 50633 AccessoriesStatusReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Accessories Status Report';
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/Merchandizing/AccessoriesStatusReport.rdl';



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
            column(Dimension; Dimension)
            { }
            column(Article; Article)
            { }
            column(PO_No; OrderNO)
            { }
            column(IssueQty; IssueQty)
            { }
            column(Qty; Qty)
            { }
            column(CompLogo; comRec.Picture)
            { }

            dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
            {
                DataItemLinkReference = "Style Master";
                DataItemLink = StyleNo = field("No.");
                DataItemTableView = sorting("Line No.");
                column(GRNQty; Quantity)
                { }
                dataitem(Item; Item)
                {
                    DataItemLinkReference = "Purch. Rcpt. Line";
                    DataItemLink = "No." = field("No.");
                    DataItemTableView = sorting("No.");
                    column(Size_Range_Name; "Size Range No.")
                    { }
                    column(ItemDes; Description)
                    { }
                    column(Unit; "Base Unit of Measure")
                    { }
                    column(Colour; "Color Name")
                    { }

                    dataitem("Item Ledger Entry"; "Item Ledger Entry")
                    {
                        DataItemLinkReference = Item;
                        DataItemLink = "Item No." = field("No.");
                        DataItemTableView = sorting("Entry No.");

                        trigger OnAfterGetRecord()

                        begin

                            SetRange("Document No.", "Purch. Rcpt. Line"."Order No.");
                            if "Entry Type" = "Item Ledger Entry"."Entry Type"::Consumption then begin
                                IssueQty := Quantity
                            end;
                        end;

                    }
                    trigger OnAfterGetRecord()
                    begin

                        PurchHDRec.SetRange("No.", "Purch. Rcpt. Line"."Document No.");
                        if PurchHDRec.FindFirst() then begin
                            OrderNO := PurchHDRec."Order No.";
                        end;



                        DimenRec.SetRange("No.", Item."Dimension Width No.");
                        if DimenRec.FindFirst() then begin
                            Dimension := DimenRec."Dimension Width";
                        end;
                        ArticleRec.SetRange("No.", Item."Article No.");
                        if ArticleRec.FindFirst() then begin
                            Article := ArticleRec.Article;
                        end;
                        PurchaseArchiveRec.SetRange("Document No.", "Purch. Rcpt. Line"."Order No.");
                        if PurchaseArchiveRec.FindFirst() then begin
                            Qty := PurchaseArchiveRec.Quantity;
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
                        Caption = 'Style No';
                        TableRelation = "Style Master"."No.";

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

        DimenRec: Record DimensionWidth;
        Dimension: Text[200];
        ArticleRec: Record Article;
        Article: text[50];
        PurchLineRec: Record "Purchase Line";
        Qty: Decimal;
        PurchRcptLineRec: Record "Purch. Rcpt. Line";
        IssueQty: Decimal;
        PurchHDRec: Record "Purch. Rcpt. Header";
        OrderNO: code[50];
        PurchaseArchiveRec: Record "Purchase Line Archive";
        comRec: Record "Company Information";
        FilterNo: Code[30];

}