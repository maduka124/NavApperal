page 50528 "GIT Baseon LC Card"
{
    PageType = Card;
    SourceTable = GITBaseonLC;
    Caption = 'Goods In Transit - Base On LC';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("GITLCNo."; "GITLCNo.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Suppler Name"; "Suppler Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Suppler';

                    trigger OnValidate()
                    var
                        VendorRec: Record Vendor;
                    begin
                        VendorRec.Reset();
                        VendorRec.SetRange(Name, "Suppler Name");
                        if VendorRec.FindSet() then
                            "Suppler No." := VendorRec."No.";

                        CurrPage.Update();
                    end;
                }

                field("B2B LC No. (System)"; "B2B LC No. (System)")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        B2BLCRec: Record B2BLCMaster;
                        B2BLCPI: Record B2BLCPI;
                        PIPOItemsRec: Record "PI Po Item Details";
                        GITLCItemsRec: Record GITBaseonLCLine;
                        PurReceiptRec: Record "Purch. Rcpt. Line";
                        ItemRec: Record Item;
                        LineNo: Integer;
                        ReqTotal: Decimal;
                        GRNTotal: Decimal;
                    begin

                        //Delete old rfecords
                        GITLCItemsRec.Reset();
                        GITLCItemsRec.SetRange("GITLCNo.", "GITLCNo.");
                        GITLCItemsRec.DeleteAll();

                        B2BLCRec.Reset();
                        B2BLCRec.SetRange("No.", "B2B LC No. (System)");

                        if B2BLCRec.FindSet() then begin
                            "ContractLC No" := B2BLCRec."LC/Contract No.";
                            "B2B LC No." := B2BLCRec."B2B LC No";
                            "B2B LC Value" := B2BLCRec."B2B LC Value";

                            //Load Items
                            B2BLCPI.Reset();
                            B2BLCPI.SetRange("B2BNo.", "B2B LC No. (System)");

                            if B2BLCPI.FindSet() then begin

                                //Get Max Lineno
                                GITLCItemsRec.Reset();
                                GITLCItemsRec.SetRange("GITLCNo.", "GITLCNo.");

                                if GITLCItemsRec.FindLast() then
                                    LineNo := GITLCItemsRec."Line No";

                                repeat
                                    PIPOItemsRec.Reset();
                                    PIPOItemsRec.SetRange("PI No.", B2BLCPI."PI No.");

                                    if PIPOItemsRec.FindSet() then begin
                                        repeat

                                            LineNo += 1;
                                            //Insert to the GIT Items table
                                            GITLCItemsRec.Init();
                                            GITLCItemsRec."GITLCNo." := "GITLCNo.";
                                            GITLCItemsRec."Line No" := LineNo;
                                            GITLCItemsRec."Created Date" := Today;
                                            GITLCItemsRec."Created User" := UserId;
                                            GITLCItemsRec."Currency Name" := B2BLCRec."Currency";
                                            GITLCItemsRec."Currency No." := B2BLCRec."Currency No.";
                                            GITLCItemsRec."Item No." := PIPOItemsRec."Item No.";
                                            GITLCItemsRec."Item Name" := PIPOItemsRec."Item Name";
                                            GITLCItemsRec.PINo := B2BLCPI."PI No.";

                                            //GetMain category
                                            ItemRec.Reset();
                                            ItemRec.SetRange("No.", PIPOItemsRec."Item No.");
                                            ItemRec.FindSet();
                                            GITLCItemsRec."Main Category No." := ItemRec."Main Category No.";
                                            GITLCItemsRec."Main Category Name" := ItemRec."Main Category Name";

                                            //Get GRn Quantity
                                            PurReceiptRec.Reset();
                                            PurReceiptRec.SetRange("Order No.", PIPOItemsRec."PO No.");
                                            PurReceiptRec.SetRange("No.", PIPOItemsRec."Item No.");
                                            if PurReceiptRec.FindSet() then
                                                GITLCItemsRec."GRN Qty" := PurReceiptRec.Quantity;

                                            GITLCItemsRec."Rec. Value" := GITLCItemsRec."GRN Qty" * PurReceiptRec."Unit Cost";
                                            GRNTotal += GITLCItemsRec."Rec. Value";

                                            GITLCItemsRec."Req Qty" := PIPOItemsRec.Qty;
                                            GITLCItemsRec."Total Value" := PIPOItemsRec.Value;
                                            ReqTotal += PIPOItemsRec.Value;
                                            GITLCItemsRec."Unit No." := PIPOItemsRec."UOM Code";
                                            GITLCItemsRec."Unit Name" := PIPOItemsRec.UOM;
                                            GITLCItemsRec."Unit Price" := PIPOItemsRec."Unit Price";
                                            //GITLCItemsRec."Unit Qty" := PIPOItemsRec.Qty;
                                            GITLCItemsRec.Insert();

                                        until PIPOItemsRec.Next() = 0;
                                    end;
                                until B2BLCPI.Next() = 0;

                                "GRN Balance" := GRNTotal - ReqTotal;
                            end;

                        end
                        else
                            "ContractLC No" := '';
                    end;
                }

                field("B2B LC No."; "B2B LC No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'B2B LC No';
                }

                field("ContractLC No"; "ContractLC No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("B2B LC Value"; "B2B LC Value")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Invoice No"; "Invoice No")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field("Invoice Value"; "Invoice Value")
                {
                    ApplicationArea = All;
                }

                field("Invoice Date"; "Invoice Date")
                {
                    ApplicationArea = All;
                }

                field("Original Doc. Recv. Date"; "Original Doc. Recv. Date")
                {
                    ApplicationArea = All;
                }

                field("B2B LC Balance"; "B2B LC Balance")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Mode of Ship"; "Mode of Ship")
                {
                    ApplicationArea = All;
                }

                field("BL/AWB NO"; "BL/AWB NO")
                {
                    ApplicationArea = All;
                }

                field("BL Date"; "BL Date")
                {
                    ApplicationArea = All;
                }

                field("Container No"; "Container No")
                {
                    ApplicationArea = All;
                    Caption = 'Container';
                }

                field("Carrier Name"; "Carrier Name")
                {
                    ApplicationArea = All;
                    Caption = 'Carrier';
                }

                field(Agent; Agent)
                {
                    ApplicationArea = All;
                }

                field("M. Vessel Name"; "M. Vessel Name")
                {
                    ApplicationArea = All;
                    Caption = 'M. Vessel';
                }

                field("M. Vessel ETD"; "M. Vessel ETD")
                {
                    ApplicationArea = All;
                }

                field("F. Vessel Name"; "F. Vessel Name")
                {
                    ApplicationArea = All;
                    Caption = 'F. Vessel';
                }

                field("F. Vessel ETA"; "F. Vessel ETA")
                {
                    ApplicationArea = All;
                }

                field("F. Vessel ETD"; "F. Vessel ETD")
                {
                    ApplicationArea = All;
                }

                field("N.N Docs DT"; "N.N Docs DT")
                {
                    ApplicationArea = All;
                }

                field("Original to C&F"; "Original to C&F")
                {
                    ApplicationArea = All;
                }

                field("Good inhouse"; "Good inhouse")
                {
                    ApplicationArea = All;
                }

                field("Bill of entry"; "Bill of entry")
                {
                    ApplicationArea = All;
                }
            }

            group("  ")
            {
                part("GIT Based on LC ListPart"; "GIT Based on LC ListPart")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "GITLCNo." = FIELD("GITLCNo.");
                }
            }

            group("   ")
            {
                field("GRN Balance"; "GRN Balance")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }


    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."GITLC Nos.", xRec."GITLCNo.", "GITLCNo.") THEN BEGIN
            NoSeriesMngment.SetSeries("GITLCNo.");
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        GITBaseonLCLineRec: Record GITBaseonLCLine;
    begin
        GITBaseonLCLineRec.SetRange("GITLCNo.", "GITLCNo.");
        GITBaseonLCLineRec.DeleteAll();
    end;
}