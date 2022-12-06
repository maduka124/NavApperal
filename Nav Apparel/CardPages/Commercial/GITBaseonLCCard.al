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
                field("GITLCNo."; rec."GITLCNo.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Suppler Name"; rec."Suppler Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Suppler';

                    trigger OnValidate()
                    var
                        VendorRec: Record Vendor;
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin
                        VendorRec.Reset();
                        VendorRec.SetRange(Name, rec."Suppler Name");
                        if VendorRec.FindSet() then
                            rec."Suppler No." := VendorRec."No.";

                        //Check whether user logged in or not
                        LoginSessionsRec.Reset();
                        LoginSessionsRec.SetRange(SessionID, SessionId());

                        if not LoginSessionsRec.FindSet() then begin  //not logged in
                            Clear(LoginRec);
                            LoginRec.LookupMode(true);
                            LoginRec.RunModal();

                            LoginSessionsRec.Reset();
                            LoginSessionsRec.SetRange(SessionID, SessionId());
                            if LoginSessionsRec.FindSet() then
                                rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end
                        else begin   //logged in
                            rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end;

                        CurrPage.Update();
                    end;
                }

                field("B2B LC No. (System)"; rec."B2B LC No. (System)")
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
                        GITLCItemsRec.SetRange("GITLCNo.", rec."GITLCNo.");
                        GITLCItemsRec.DeleteAll();

                        B2BLCRec.Reset();
                        B2BLCRec.SetRange("No.", rec."B2B LC No. (System)");

                        if B2BLCRec.FindSet() then begin
                            rec."ContractLC No" := B2BLCRec."LC/Contract No.";
                            rec."B2B LC No." := B2BLCRec."B2B LC No";
                            rec."B2B LC Value" := B2BLCRec."B2B LC Value";

                            //Load Items
                            B2BLCPI.Reset();
                            B2BLCPI.SetRange("B2BNo.", rec."B2B LC No. (System)");

                            if B2BLCPI.FindSet() then begin

                                //Get Max Lineno
                                GITLCItemsRec.Reset();
                                GITLCItemsRec.SetRange("GITLCNo.", rec."GITLCNo.");

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
                                            GITLCItemsRec."GITLCNo." := rec."GITLCNo.";
                                            GITLCItemsRec."Line No" := LineNo;
                                            GITLCItemsRec."Created Date" := Today;
                                            GITLCItemsRec."Created User" := UserId;
                                            GITLCItemsRec."Currency Name" := B2BLCRec."Currency";
                                            GITLCItemsRec."Currency No." := B2BLCRec."Currency No.";
                                            GITLCItemsRec."Item No." := PIPOItemsRec."Item No.";
                                            GITLCItemsRec."Item Name" := PIPOItemsRec."Item Name";
                                            GITLCItemsRec.PINo := B2BLCPI."PI No.";
                                            GITLCItemsRec.PONo := PIPOItemsRec."Po No.";

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

                                rec."GRN Balance" := GRNTotal - ReqTotal;
                            end;

                        end
                        else
                            rec."ContractLC No" := '';
                    end;
                }

                field("B2B LC No."; rec."B2B LC No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'B2B LC No';
                }

                field("ContractLC No"; rec."ContractLC No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("B2B LC Value"; rec."B2B LC Value")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Invoice No"; rec."Invoice No")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field("Invoice Value"; rec."Invoice Value")
                {
                    ApplicationArea = All;
                }

                field("Invoice Date"; rec."Invoice Date")
                {
                    ApplicationArea = All;
                }

                field("Original Doc. Recv. Date"; rec."Original Doc. Recv. Date")
                {
                    ApplicationArea = All;
                }

                field("B2B LC Balance"; rec."B2B LC Balance")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Mode of Ship"; rec."Mode of Ship")
                {
                    ApplicationArea = All;
                }

                field("BL/AWB NO"; rec."BL/AWB NO")
                {
                    ApplicationArea = All;
                }

                field("BL Date"; rec."BL Date")
                {
                    ApplicationArea = All;
                }

                field("Container No"; rec."Container No")
                {
                    ApplicationArea = All;
                    Caption = 'Container';
                }

                field("Carrier Name"; rec."Carrier Name")
                {
                    ApplicationArea = All;
                    Caption = 'Carrier';
                }

                field(Agent; rec.Agent)
                {
                    ApplicationArea = All;
                }

                field("M. Vessel Name"; rec."M. Vessel Name")
                {
                    ApplicationArea = All;
                    Caption = 'M. Vessel';
                }

                field("M. Vessel ETD"; rec."M. Vessel ETD")
                {
                    ApplicationArea = All;
                }

                field("F. Vessel Name"; rec."F. Vessel Name")
                {
                    ApplicationArea = All;
                    Caption = 'F. Vessel';
                }

                field("F. Vessel ETA"; rec."F. Vessel ETA")
                {
                    ApplicationArea = All;
                }

                field("F. Vessel ETD"; rec."F. Vessel ETD")
                {
                    ApplicationArea = All;
                }

                field("N.N Docs DT"; rec."N.N Docs DT")
                {
                    ApplicationArea = All;
                }

                field("Original to C&F"; rec."Original to C&F")
                {
                    ApplicationArea = All;
                }

                field("Good inhouse"; rec."Good inhouse")
                {
                    ApplicationArea = All;
                }

                field("Bill of entry"; rec."Bill of entry")
                {
                    ApplicationArea = All;
                }
            }

            group("  ")
            {
                part("GIT Based on LC ListPart"; "GIT Based on LC ListPart")
                {
                    ApplicationArea = All;
                    Caption = 'PI Items';
                    SubPageLink = "GITLCNo." = FIELD("GITLCNo.");
                }
            }

            group("   ")
            {
                field("GRN Balance"; rec."GRN Balance")
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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."GITLC Nos.", xRec."GITLCNo.", rec."GITLCNo.") THEN BEGIN
            NoSeriesMngment.SetSeries(rec."GITLCNo.");
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        GITBaseonLCLineRec: Record GITBaseonLCLine;
    begin
        GITBaseonLCLineRec.SetRange("GITLCNo.", rec."GITLCNo.");
        GITBaseonLCLineRec.DeleteAll();
    end;
}