page 50671 "FabricProceCard"
{
    PageType = Card;
    SourceTable = FabricProceHeader;
    Caption = 'Fabric Processing';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("FabricProceNo."; "FabricProceNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Fabric Processing No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Buyer Name."; "Buyer Name.")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';

                    trigger OnValidate()
                    var
                        CustomerRec: Record Customer;
                    begin
                        CustomerRec.Reset();
                        CustomerRec.SetRange(Name, "Buyer Name.");
                        if CustomerRec.FindSet() then
                            "Buyer No." := CustomerRec."No.";

                        CurrPage.Update();
                    end;
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';

                    trigger OnValidate()
                    var
                        StyleMasterRec: Record "Style Master";
                    begin
                        StyleMasterRec.Reset();
                        StyleMasterRec.SetRange("Style No.", "Style Name");
                        if StyleMasterRec.FindSet() then
                            "Style No." := StyleMasterRec."No.";

                        CurrPage.Update();
                    end;
                }

                field("PO No."; "PO No.")
                {
                    ApplicationArea = All;
                    Caption = 'PO No';

                    trigger OnLookup(var texts: text): Boolean
                    var
                        PurchRcpLineRec: Record "Purch. Rcpt. Line";
                        PO: Code[20];
                    begin
                        PurchRcpLineRec.RESET;
                        PurchRcpLineRec.SetCurrentKey("Order No.");
                        PurchRcpLineRec.SetRange(StyleNo, "Style No.");

                        IF PurchRcpLineRec.FINDFIRST THEN BEGIN
                            REPEAT
                                IF PO <> PurchRcpLineRec."Order No." THEN BEGIN
                                    PO := PurchRcpLineRec."Order No.";
                                    PurchRcpLineRec.MARK(TRUE);
                                END;
                            UNTIL PurchRcpLineRec.NEXT = 0;
                            PurchRcpLineRec.MARKEDONLY(TRUE);

                            if Page.RunModal(50675, PurchRcpLineRec) = Action::LookupOK then
                                "PO No." := PurchRcpLineRec."Order No.";
                        END;
                    END;
                }

                field(GRN; GRN)
                {
                    ApplicationArea = All;

                    trigger OnLookup(var texts: text): Boolean
                    var
                        PurchRcpLineRec: Record "Purch. Rcpt. Line";
                        DocNo: Code[20];
                    begin
                        PurchRcpLineRec.RESET;
                        PurchRcpLineRec.SetCurrentKey("Document No.");
                        PurchRcpLineRec.SetRange("Order No.", "PO No.");

                        IF PurchRcpLineRec.FINDFIRST THEN BEGIN
                            REPEAT
                                IF DocNo <> PurchRcpLineRec."Document No." THEN BEGIN
                                    DocNo := PurchRcpLineRec."Document No.";
                                    PurchRcpLineRec.MARK(TRUE);
                                END;
                            UNTIL PurchRcpLineRec.NEXT = 0;
                            PurchRcpLineRec.MARKEDONLY(TRUE);

                            if Page.RunModal(50676, PurchRcpLineRec) = Action::LookupOK then
                                GRN := PurchRcpLineRec."Document No.";
                        END;
                    END;
                }

                field("Item Name"; "Item Name")
                {
                    ApplicationArea = All;
                    Caption = 'Item';

                    trigger OnLookup(var texts: text): Boolean
                    var
                        PurchRcpLineRec: Record "Purch. Rcpt. Line";
                        ItemRec: Record Item;
                        ItemLedEntryRec: Record "Item Ledger Entry";
                        ItemNo: Code[20];
                    begin
                        PurchRcpLineRec.RESET;
                        PurchRcpLineRec.SetCurrentKey("No.");
                        PurchRcpLineRec.SetRange("Document No.", GRN);
                        //PurchRcpLineRec.SetRange("Color No.", "Color No");

                        IF PurchRcpLineRec.FindSet() THEN BEGIN
                            REPEAT

                                ItemRec.RESET;
                                ItemRec.SetRange("No.", PurchRcpLineRec."No.");

                                IF ItemRec.FindSet() THEN BEGIN
                                    if ItemRec."Main Category Name" = 'FABRIC' then begin
                                        IF ItemNo <> PurchRcpLineRec."No." THEN BEGIN
                                            ItemNo := PurchRcpLineRec."No.";
                                            PurchRcpLineRec.MARK(TRUE);
                                        END;
                                    end;
                                END;

                            UNTIL PurchRcpLineRec.NEXT = 0;
                            PurchRcpLineRec.MARKEDONLY(TRUE);

                            if Page.RunModal(50677, PurchRcpLineRec) = Action::LookupOK then begin
                                "Item No" := PurchRcpLineRec."No.";
                                "No of Roll" := 0;
                                CurrPage.Update();

                                ItemRec.Reset();
                                ItemRec.SetRange("No.", "Item No");
                                if ItemRec.FindSet() then begin
                                    "Item Name" := ItemRec.Description;
                                    "Color No" := ItemRec."Color No.";
                                    "Color Name" := ItemRec."Color Name";
                                end;

                                //Get No of rolls
                                ItemLedEntryRec.Reset();
                                ItemLedEntryRec.SetRange("Item No.", "Item No");
                                ItemLedEntryRec.SetRange("Document No.", GRN);
                                //ItemLedEntryRec.SetFilter("Lot No.", '<>%1', '-');

                                if ItemLedEntryRec.FindSet() then begin
                                    repeat
                                        if ItemLedEntryRec."Lot No." <> '' then
                                            "No of Roll" := "No of Roll" + ItemLedEntryRec."Remaining Quantity";
                                    until ItemLedEntryRec.Next() = 0;
                                end;

                                //Get Roll details
                                Get_Roll_details();

                                CurrPage.Update();
                            end;
                        END;
                    END;
                }

                field("Color Name"; "Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'Color';
                    Editable = false;

                    trigger OnValidate()
                    var
                        colorRec: Record Colour;
                    begin
                        colorRec.Reset();
                        colorRec.SetRange("Colour Name", "Color Name");
                        colorRec.FindSet();
                        "Color No" := colorRec."No.";
                    end;

                    // trigger OnLookup(var texts: text): Boolean
                    // var
                    //     PurchRcpLineRec: Record "Purch. Rcpt. Line";
                    //     Colour: Code[20];
                    //     colorRec: Record Colour;
                    // begin
                    //     PurchRcpLineRec.RESET;
                    //     PurchRcpLineRec.SetCurrentKey("Color No.");
                    //     PurchRcpLineRec.SetRange("Document No.", GRN);
                    //     PurchRcpLineRec.SetRange("No.", "Item No");

                    //     IF PurchRcpLineRec.FINDFIRST THEN BEGIN
                    //         REPEAT
                    //             IF Colour <> PurchRcpLineRec."Color No." THEN BEGIN
                    //                 Colour := PurchRcpLineRec."Color No.";

                    //                 PurchRcpLineRec.MARK(TRUE);
                    //             END;
                    //         UNTIL PurchRcpLineRec.NEXT = 0;
                    //         PurchRcpLineRec.MARKEDONLY(TRUE);

                    //         if Page.RunModal(50672, PurchRcpLineRec) = Action::LookupOK then begin
                    //             "Color No" := PurchRcpLineRec."Color No.";
                    //             "Color Name" := PurchRcpLineRec."Color Name";
                    //         end;

                    //     END;
                    // END;
                }

                field("No of Roll"; "No of Roll")
                {
                    ApplicationArea = All;
                    Caption = 'No of Rolls';
                    Editable = false;
                }
            }

            group("Roll Details")
            {
                part(FabricProceListPart; FabricProceListPart)
                {
                    ApplicationArea = All;
                    Caption = 'Roll Details';
                    SubPageLink = "FabricProceNo." = FIELD("FabricProceNo."), "Color No" = field("Color No");
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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."FabricProce Nos.", xRec."FabricProceNo.", "FabricProceNo.") THEN BEGIN
            NoSeriesMngment.SetSeries("FabricProceNo.");
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        FabricProLineRec: Record FabricProceLine;
    begin
        FabricProLineRec.reset();
        FabricProLineRec.SetRange("FabricProceNo.", "FabricProceNo.");
        if FabricProLineRec.FindSet() then
            FabricProLineRec.DeleteAll();
    end;

    procedure Get_Roll_details()
    var
        ItemLedEntryRec: Record "Item Ledger Entry";
        FabricProLineRec: Record FabricProceLine;
        Lineno: Integer;
    begin

        //Get Max line no
        FabricProLineRec.Reset();
        FabricProLineRec.SetRange("FabricProceNo.", "FabricProceNo.");

        if FabricProLineRec.FindLast() then
            Lineno := FabricProLineRec."Line No.";

        // //Deleet old records
        // FabricProLineRec.Reset();
        // FabricProLineRec.SetRange("FabricProceNo.", "FabricProceNo.");
        // if FabricProLineRec.FindSet() then
        //     FabricProLineRec.DeleteAll();


        //Get Rolldetails for the item and GRN
        ItemLedEntryRec.Reset();
        ItemLedEntryRec.SetRange("Item No.", "Item No");
        ItemLedEntryRec.SetRange("Document No.", GRN);

        if ItemLedEntryRec.FindSet() then begin
            repeat
                FabricProLineRec.Reset();
                FabricProLineRec.SetRange("FabricProceNo.", "FabricProceNo.");
                FabricProLineRec.SetRange("Item No", "Item No");
                FabricProLineRec.SetRange("Roll No", ItemLedEntryRec."Lot No.");

                if not FabricProLineRec.FindSet() then begin

                    if ItemLedEntryRec."Lot No." <> '' then begin
                        Lineno += 1;
                        FabricProLineRec.Init();
                        FabricProLineRec."FabricProceNo." := "FabricProceNo.";
                        FabricProLineRec."Line No." := Lineno;
                        FabricProLineRec."Roll No" := ItemLedEntryRec."Lot No.";
                        FabricProLineRec.YDS := ItemLedEntryRec."Length Tag";
                        FabricProLineRec.Width := ItemLedEntryRec."Width Tag";
                        FabricProLineRec."Act. Legth" := ItemLedEntryRec."Length Act";
                        FabricProLineRec."Act. Width" := ItemLedEntryRec."Width Act";
                        FabricProLineRec.MFShade := ItemLedEntryRec.Shade;
                        FabricProLineRec."MFShade No" := ItemLedEntryRec."Shade No";
                        FabricProLineRec.Shade := ItemLedEntryRec.Shade;
                        FabricProLineRec."Shade No" := ItemLedEntryRec."Shade No";
                        FabricProLineRec.Status := FabricProLineRec.Status::Active;
                        FabricProLineRec."Item No" := "Item No";
                        FabricProLineRec."Item Name" := "Item Name";
                        FabricProLineRec.GRN := GRN;
                        FabricProLineRec.Qty := ItemLedEntryRec."Remaining Quantity";
                        FabricProLineRec."Color Name" := "Color Name";
                        FabricProLineRec."Color No" := "Color No";
                        FabricProLineRec.Insert();
                    end;
                end;
            until ItemLedEntryRec.Next() = 0;
        end;
    end;
}