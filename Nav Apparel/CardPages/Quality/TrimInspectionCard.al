page 50570 "Trim Inspection Card"
{
    PageType = Card;
    SourceTable = "Purch. Rcpt. Header";
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'GRN No';
                    Editable = false;
                }

                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = All;
                    Caption = 'GRN Date';
                    Editable = false;
                }

                field("Buy-from Vendor Name"; rec."Buy-from Vendor Name")
                {
                    ApplicationArea = All;
                    Caption = 'Supplier';
                    Editable = false;
                }

                field("Order No."; rec."Order No.")
                {
                    ApplicationArea = All;
                    Caption = 'PO No';
                    Editable = false;
                }

                field("Trim Inspected"; rec."Trim Inspected")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group("  ")
            {
                part("Trim Inspection ListPart2"; "Trim Inspection ListPart2")
                {
                    ApplicationArea = All;
                    Caption = 'Items';
                    SubPageLink = "PurchRecNo." = FIELD("No.");
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        TrimInsRec: Record TrimInspectionLine;
        PurchRec: Record "Purch. Rcpt. Header";
        PurchLineRec: Record "Purch. Rcpt. Line";
        StyleMasRec: Record "Style Master";
        LineNo: Integer;
        ItemMasRec: Record Item;
        ArticleRec: Record Article;
        DimensionRec: Record DimensionWidth;
        MainCatRec: Record "Main Category";
        AQLRec: Record AQL;
        SqmpleQty: BigInteger;
        RejectLevel: BigInteger;
        Article: Text[100];
        Dimension: Text[100];
        BPCD: Date;
    begin

        TrimInsRec.Reset();
        TrimInsRec.SetRange("PurchRecNo.", rec."No.");

        if not TrimInsRec.FindSet() then begin

            PurchLineRec.Reset();
            PurchLineRec.SetRange("Document No.", rec."No.");

            if PurchLineRec.FindSet() then begin

                repeat

                    //Get Item details
                    ItemMasRec.Reset();
                    ItemMasRec.SetRange("No.", PurchLineRec."No.");

                    if ItemMasRec.FindSet() then begin

                        //Get Master Category
                        MainCatRec.Reset();
                        MainCatRec.SetRange("No.", ItemMasRec."Main Category No.");

                        if MainCatRec.FindSet() then begin

                            if (MainCatRec."Master Category Name" = 'SEWING TRIMS') or (MainCatRec."Master Category Name" = 'FINISHING TRIMS') then begin

                                LineNo += 1;

                                //Get Article details
                                ArticleRec.Reset();
                                ArticleRec.SetRange("No.", ItemMasRec."Article No.");

                                if ArticleRec.FindSet() then
                                    Article := ArticleRec.Article;

                                //Get Dimension details
                                DimensionRec.Reset();
                                DimensionRec.SetRange("No.", ItemMasRec."Dimension Width No.");

                                if DimensionRec.FindSet() then
                                    Dimension := DimensionRec."Dimension Width";

                                //Get AQL details
                                AQLRec.Reset();
                                AQLRec.SetFilter("From Qty", '<=%1', round(PurchLineRec.Quantity, 1));
                                AQLRec.SetFilter("To Qty", '>=%1', round(PurchLineRec.Quantity, 1));

                                if AQLRec.FindSet() then begin
                                    SqmpleQty := AQLRec."SMPL Qty";
                                    RejectLevel := AQLRec."Reject Qty";
                                end;

                                //Get Style BPCD
                                StyleMasRec.Reset();
                                StyleMasRec.SetRange("No.", PurchLineRec.StyleNo);

                                if StyleMasRec.FindSet() then
                                    BPCD := StyleMasRec.BPCD;


                                TrimInsRec.Init();
                                TrimInsRec."PurchRecNo." := rec."No.";
                                TrimInsRec."Line No" := LineNo;
                                TrimInsRec.StyleName := PurchLineRec.StyleName;
                                TrimInsRec.StyleNo := PurchLineRec.StyleNo;
                                TrimInsRec.BPCD := BPCD;
                                TrimInsRec.ArticleNo := ItemMasRec."Article No.";
                                TrimInsRec.Article := Article;
                                TrimInsRec."Color Name" := ItemMasRec."Color Name";
                                TrimInsRec."Color No." := ItemMasRec."Color No.";
                                TrimInsRec.DimensionNo := ItemMasRec."Dimension Width No.";
                                TrimInsRec.Dimension := Dimension;
                                TrimInsRec."Item Name" := ItemMasRec.Description;
                                TrimInsRec."Item No." := ItemMasRec."No.";
                                TrimInsRec."Main Category Name" := ItemMasRec."Main Category Name";
                                TrimInsRec."Main Category No." := ItemMasRec."Main Category No.";
                                TrimInsRec.Size := ItemMasRec."Size Range No.";
                                TrimInsRec."Unit Name" := PurchLineRec."Unit of Measure Code";
                                TrimInsRec."Unit No." := PurchLineRec."Unit of Measure";
                                TrimInsRec."GRN Qty" := PurchLineRec.Quantity;
                                TrimInsRec."Sample Qty" := SqmpleQty;
                                TrimInsRec.Reject := 0;
                                TrimInsRec.Accept := 0;
                                TrimInsRec.RejectLevel := RejectLevel;
                                TrimInsRec.Insert();

                            end;
                        end;
                    end;

                until PurchLineRec.Next() = 0;
            end;
        end;

    end;

}