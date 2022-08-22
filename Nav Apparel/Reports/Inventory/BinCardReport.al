report 50635 BinCardReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Bin Card Report';
    RDLCLayout = 'Report_Layouts/Inventory/BinCardReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = sorting("No.");
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLinkReference = Item;
                DataItemLink = "Item No." = field("No.");
                DataItemTableView = sorting("Entry No.");
                column(Description; ItemDes)
                { }
                column(Color_Name; ItemColor)
                { }
                column(Dimension; Dimension)
                { }
                column(Article; Article)
                { }
                column(Size_Range_No_; SizeRangeNo)
                { }
                column(Base_Unit_of_Measure; BaseUnitMes)
                { }
                column(IssueQty; IssueQty)
                { }
                column(GRNNo; GRNNo)
                { }
                column(Qty; Qty)
                { }
                column(PostingDate; "Posting Date")
                { }
                column(Style; StyleName)
                { }
                column(Balance; Balance)
                { }

                column(CompLogo; comRec.Picture)
                { }

                trigger OnAfterGetRecord()

                begin

                    IssueQty := 0;
                    GRNNo := '';

                    ItemRec.SetRange("No.", "Item Ledger Entry"."Item No.");
                    if ItemRec.FindFirst() then begin
                        ItemDes := ItemRec.Description;
                        ItemColor := ItemRec."Color Name";
                        SizeRangeNo := ItemRec."Size Range No.";
                        BaseUnitMes := ItemRec."Base Unit of Measure";
                    end;

                    if "Entry Type" = "Entry Type"::Purchase then begin
                        Qty := Quantity;
                        GRNNo := "Document No.";

                    end
                    else
                        if "Entry Type" = "Entry Type"::Consumption then begin
                            IssueQty := Quantity;
                            GRNNo := "Document No.";
                        end;


                    // PurchRcptRec.Reset();
                    PurchRcptRec.SetRange("Document No.", "Document No.");
                    if PurchRcptRec.FindSet() then begin
                        StyleName := PurchRcptRec.StyleName;
                    end;


                    DimenRec.Reset();
                    DimenRec.SetRange("No.", ItemRec."Dimension Width No.");
                    if DimenRec.FindFirst() then begin
                        Dimension := DimenRec."Dimension Width";
                    end;

                    ArticleRec.Reset();
                    ArticleRec.SetRange("No.", ItemRec."Article No.");
                    if ArticleRec.FindFirst() then begin
                        Article := ArticleRec.Article;
                    end;


                    Balance := Balance + (Qty + IssueQty);

                    comRec.Get;
                    comRec.CalcFields(Picture);
                end;

                trigger OnPreDataItem()
                begin
                    SetRange("Posting Date", stDate, endDate);
                end;
            }
            trigger OnPreDataItem()
            begin
                SetRange("No.", ItemCode);
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
                        Caption = 'Start Date';

                    }
                    field(endDate; endDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';

                    }
                    field(ItemCode; ItemCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Item';
                        TableRelation = Item."No.";
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
        GRNNo: Code[30];
        IssueQty: Decimal;
        Balance: Decimal;
        ItemLedgRec: Record "Item Ledger Entry";
        PostingDate: Date;
        Qty: Decimal;
        stDate: Date;
        endDate: Date;
        PurchRcptRec: Record "Purch. Rcpt. Line";
        StyleName: text[200];
        ItemRec: Record Item;
        ItemDes: text[100];
        ItemColor: text[50];
        SizeRangeNo: Code[50];
        BaseUnitMes: Code[50];
        ItemCode: Code[50];
        comRec: Record "Company Information";


}