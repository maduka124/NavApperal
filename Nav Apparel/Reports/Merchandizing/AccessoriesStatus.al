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
            column(IssueQty; IssuePlus)
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
                column(Qty; Qty)
                { }
                column(PO_No; OrderNO)
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
                    column(Article; Article)
                    { }

                    trigger OnAfterGetRecord()
                    begin

                        IssueQty := 0;
                        ItemLedgerRec.Reset();
                        ItemLedgerRec.SetRange("Style No.", "Style Master"."No.");
                        ItemLedgerRec.SetRange("Item No.", Item."No.");
                        if ItemLedgerRec.FindSet() then begin
                            repeat
                                if ItemLedgerRec."Entry Type" = ItemLedgerRec."Entry Type"::Consumption then begin
                                    IssueQty += ItemLedgerRec.Quantity
                                end;
                            until ItemLedgerRec.Next() = 0;
                        end;
                        IssuePlus := IssueQty * -1;

                        DimenRec.SetRange("No.", Item."Dimension Width No.");
                        if DimenRec.FindFirst() then begin
                            Dimension := DimenRec."Dimension Width";
                        end;
                        ArticleRec.SetRange("No.", "Article No.");
                        if ArticleRec.FindFirst() then begin
                            Article := ArticleRec.Article;
                        end;

                    end;

                }


                trigger OnAfterGetRecord()

                begin
                    Qty := 0;
                    PurchLineRec.Reset();
                    PurchLineRec.SetRange(StyleNo, StyleNo);
                    PurchLineRec.SetRange("Document No.", "Document No.");
                    PurchLineRec.SetRange("No.", "No.");
                    PurchLineRec.SetFilter("Document Type", '=%1', PurchLineRec."Document Type"::Order);
                    PurchaseArchiveRec.SetRange("Document No.", "Order No.");
                    PurchaseArchiveRec.SetFilter("Document Type", '=%1', PurchaseArchiveRec."Document Type"::Order);
                    PurchaseArchiveRec.SetRange("No.", "No.");
                    if PurchLineRec.FindSet() then
                        
                            repeat
                                if PurchLineRec.Quantity <> 0 then
                                    Qty := PurchLineRec.Quantity
                                else
                                    if PurchaseArchiveRec.FindFirst() then begin
                                        Qty := PurchaseArchiveRec.Quantity;
                                    end;
                            until PurchLineRec.Next() = 0;
                    PurchHDRec.SetRange("No.", "Document No.");
                    if PurchHDRec.FindFirst() then begin
                        OrderNO := PurchHDRec."Order No.";
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
                        Editable = not EditableGB;
                        TableRelation = "Style Master"."No.";
                    }
                }
            }
        }
    }

    procedure PassParameters(StyleNoPara: Code[20])
    var
    begin
        FilterNo := StyleNoPara;
        EditableGB := true;
    end;


    var
        EditableGB: Boolean;
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
        ItemLedgerRec: Record "Item Ledger Entry";
        IssuePlus: Decimal;

}