page 50695 "FabShadeCard"
{
    PageType = Card;
    SourceTable = FabShadeHeader;
    Caption = 'Fabric Shade';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("FabShadeNo."; "FabShadeNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Fab. Shade No';

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

                field("Color Name"; "Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'Color';

                    trigger OnLookup(var texts: text): Boolean
                    var
                        PurchRcpLineRec: Record "Purch. Rcpt. Line";
                        Colour: Code[20];
                        colorRec: Record Colour;
                    begin
                        PurchRcpLineRec.RESET;
                        PurchRcpLineRec.SetCurrentKey("Color No.");
                        PurchRcpLineRec.SetRange("Document No.", GRN);

                        IF PurchRcpLineRec.FINDFIRST THEN BEGIN
                            REPEAT
                                IF Colour <> PurchRcpLineRec."Color No." THEN BEGIN
                                    Colour := PurchRcpLineRec."Color No.";

                                    PurchRcpLineRec.MARK(TRUE);
                                END;
                            UNTIL PurchRcpLineRec.NEXT = 0;
                            PurchRcpLineRec.MARKEDONLY(TRUE);

                            if Page.RunModal(50672, PurchRcpLineRec) = Action::LookupOK then begin
                                "Color No" := PurchRcpLineRec."Color No.";
                                "Color Name" := PurchRcpLineRec."Color Name";
                            end;

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
                        PurchRcpLineRec.SetRange("Color No.", "Color No");

                        IF PurchRcpLineRec.FINDFIRST THEN BEGIN
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
                                if ItemRec.FindSet() then
                                    "Item Name" := ItemRec.Description;

                                //Get No of rolls
                                ItemLedEntryRec.Reset();
                                ItemLedEntryRec.SetRange("Item No.", "Item No");
                                ItemLedEntryRec.SetRange("Document No.", GRN);

                                if ItemLedEntryRec.FindSet() then begin
                                    repeat
                                        "No of Roll" := "No of Roll" + ItemLedEntryRec."Remaining Quantity";
                                    until ItemLedEntryRec.Next() = 0;
                                end;

                                Get_Roll_details1();
                                Get_Roll_details2();
                                Get_Roll_details3();
                                CurrPage.Update();
                            end;
                        END;
                    END;
                }

                field("Fabric Code"; "Fabric Code")
                {
                    ApplicationArea = All;
                    Caption = 'Fabric';

                    trigger OnValidate()
                    var
                        FabicCodeRec: Record FabricCodeMaster;
                    begin
                        FabicCodeRec.Reset();
                        FabicCodeRec.SetRange(FabricCode, "Fabric Code");
                        if FabicCodeRec.FindSet() then begin
                            Composition := FabicCodeRec.Composition;
                            Construction := FabicCodeRec.Construction;
                        end;
                    end;
                }

                field(Composition; Composition)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Construction; Construction)
                {
                    ApplicationArea = All;
                    Editable = false;
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
                part(FabShadeListPart1; FabShadeListPart1)
                {
                    ApplicationArea = All;
                    Caption = 'Roll Details';
                    SubPageLink = "FabShadeNo." = FIELD("FabShadeNo.");
                }
            }

            group("Fabric Shade")
            {
                part(FabShadeListPart2; FabShadeListPart2)
                {
                    ApplicationArea = All;
                    Caption = '  ';
                    SubPageLink = "FabShadeNo." = FIELD("FabShadeNo.");
                }
            }

            group("Fabric Patterns")
            {
                part(FabShadeListPart3; FabShadeListPart3)
                {
                    ApplicationArea = All;
                    Caption = '  ';
                    SubPageLink = "FabShadeNo." = FIELD("FabShadeNo.");
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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."FabShad Nos.", xRec."FabShadeNo.", "FabShadeNo.") THEN BEGIN
            NoSeriesMngment.SetSeries("FabShadeNo.");
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        FabShadeLine1Rec: Record FabShadeLine1;
        FabShadeLine2Rec: Record FabShadeLine2;
    begin
        FabShadeLine1Rec.reset();
        FabShadeLine1Rec.SetRange("FabShadeNo.", "FabShadeNo.");
        if FabShadeLine1Rec.FindSet() then
            FabShadeLine1Rec.DeleteAll();

        FabShadeLine2Rec.reset();
        FabShadeLine2Rec.SetRange("FabShadeNo.", "FabShadeNo.");
        if FabShadeLine2Rec.FindSet() then
            FabShadeLine2Rec.DeleteAll();

    end;


    procedure Get_Roll_details1()
    var
        ItemLedEntryRec: Record "Item Ledger Entry";
        FabProLineRec: Record FabricProceLine;
        FabShadeLineRec: Record FabShadeLine1;
        Lineno: Integer;
    begin

        //Get Max line no
        FabShadeLineRec.Reset();
        FabShadeLineRec.SetRange("FabShadeNo.", "FabShadeNo.");

        if FabShadeLineRec.FindLast() then
            Lineno := FabShadeLineRec."Line No.";

        //Deleet old records
        FabShadeLineRec.Reset();
        FabShadeLineRec.SetRange("FabShadeNo.", "FabShadeNo.");
        if FabShadeLineRec.FindSet() then
            FabShadeLineRec.DeleteAll();


        //Get Rolldetails for the item and GRN
        ItemLedEntryRec.Reset();
        ItemLedEntryRec.SetRange("Item No.", "Item No");
        ItemLedEntryRec.SetRange("Document No.", GRN);

        if ItemLedEntryRec.FindSet() then begin
            repeat
                Lineno += 1;
                if ItemLedEntryRec."Remaining Quantity" > 0 then begin

                    FabShadeLineRec.Init();
                    FabShadeLineRec."FabShadeNo." := "FabShadeNo.";
                    FabShadeLineRec."Line No." := Lineno;
                    FabShadeLineRec."Roll No" := ItemLedEntryRec."Lot No.";
                    FabShadeLineRec.YDS := ItemLedEntryRec."Length Tag";

                    FabProLineRec.Reset();
                    FabProLineRec.SetRange("Item No", "Item No");
                    FabProLineRec.SetRange("Roll No", ItemLedEntryRec."Lot No.");

                    if FabProLineRec.FindSet() then begin
                        FabShadeLineRec.Shade := FabProLineRec.Shade;
                        FabShadeLineRec."Shade No" := FabProLineRec."Shade No";
                        FabShadeLineRec."PTTN GRP" := FabProLineRec."PTTN GRP";
                    end;

                    FabShadeLineRec.Insert();
                end;
            until ItemLedEntryRec.Next() = 0;
        end;
    end;


    procedure Get_Roll_details2()
    var
        FabProLineRec: Record FabricProceLine;
        FabShadeLine2Rec: Record FabShadeLine2;
        Lineno: Integer;
        Shade: text[50];
        ShadeNo: Code[20];
    begin

        //Get Max line no
        FabShadeLine2Rec.Reset();
        FabShadeLine2Rec.SetRange("FabShadeNo.", "FabShadeNo.");

        if FabShadeLine2Rec.FindLast() then
            Lineno := FabShadeLine2Rec."Line No.";

        //Deleet old records
        FabShadeLine2Rec.Reset();
        FabShadeLine2Rec.SetRange("FabShadeNo.", "FabShadeNo.");
        if FabShadeLine2Rec.FindSet() then
            FabShadeLine2Rec.DeleteAll();


        //Get Rolldetails for the item and GRN
        FabProLineRec.Reset();
        FabProLineRec.SetRange("Item No", "Item No");
        FabProLineRec.SetRange(GRN, GRN);
        FabProLineRec.SetCurrentKey(Shade);

        if FabProLineRec.FindSet() then begin
            repeat
                Lineno += 1;

                IF Shade <> FabProLineRec.Shade THEN BEGIN
                    Shade := FabProLineRec.Shade;

                    FabShadeLine2Rec.Init();
                    FabShadeLine2Rec."FabShadeNo." := "FabShadeNo.";
                    FabShadeLine2Rec."Line No." := Lineno;
                    FabShadeLine2Rec."Total Rolls" := FabProLineRec.Qty;
                    FabShadeLine2Rec."Total YDS" := FabProLineRec.YDS;
                    FabShadeLine2Rec.Shade := FabProLineRec.Shade;
                    FabShadeLine2Rec."Shade No" := FabProLineRec."Shade No";
                    FabShadeLine2Rec.Insert();

                end
                else begin

                    FabShadeLine2Rec.Reset();
                    FabShadeLine2Rec.SetRange("FabShadeNo.", "FabShadeNo.");
                    FabShadeLine2Rec.SetRange("Shade No", ShadeNo);

                    if FabShadeLine2Rec.FindSet() then begin
                        FabShadeLine2Rec."Total Rolls" := FabShadeLine2Rec."Total Rolls" + FabProLineRec.Qty;
                        FabShadeLine2Rec."Total YDS" := FabShadeLine2Rec."Total YDS" + FabProLineRec.YDS;
                        FabShadeLine2Rec.Modify();
                    end;

                end;

            until FabProLineRec.Next() = 0;
        end;
    end;


    procedure Get_Roll_details3()
    var
        FabProLineRec: Record FabricProceLine;
        FabShadeLine3Rec: Record FabShadeLine3;
        Lineno: Integer;
        Pattern: Code[20];
    begin

        //Get Max line no
        FabShadeLine3Rec.Reset();
        FabShadeLine3Rec.SetRange("FabShadeNo.", "FabShadeNo.");

        if FabShadeLine3Rec.FindLast() then
            Lineno := FabShadeLine3Rec."Line No.";

        //Deleet old records
        FabShadeLine3Rec.Reset();
        FabShadeLine3Rec.SetRange("FabShadeNo.", "FabShadeNo.");
        if FabShadeLine3Rec.FindSet() then
            FabShadeLine3Rec.DeleteAll();


        //Get Rolldetails for the item and GRN
        FabProLineRec.Reset();
        FabProLineRec.SetRange("Item No", "Item No");
        FabProLineRec.SetRange(GRN, GRN);
        FabProLineRec.SetCurrentKey("PTTN GRP");

        if FabProLineRec.FindSet() then begin
            repeat
                Lineno += 1;

                IF Pattern <> FabProLineRec."PTTN GRP" THEN BEGIN
                    Pattern := FabProLineRec."PTTN GRP";

                    FabShadeLine3Rec.Init();
                    FabShadeLine3Rec."FabShadeNo." := "FabShadeNo.";
                    FabShadeLine3Rec."Line No." := Lineno;
                    FabShadeLine3Rec."Total Rolls" := FabProLineRec.Qty;
                    FabShadeLine3Rec."Total YDS" := FabProLineRec.YDS;
                    FabShadeLine3Rec.Pattern := FabProLineRec."PTTN GRP";
                    FabShadeLine3Rec.Insert();

                end
                else begin

                    FabShadeLine3Rec.Reset();
                    FabShadeLine3Rec.SetRange("FabShadeNo.", "FabShadeNo.");
                    FabShadeLine3Rec.SetRange(Pattern, Pattern);

                    if FabShadeLine3Rec.FindSet() then begin
                        FabShadeLine3Rec."Total Rolls" := FabShadeLine3Rec."Total Rolls" + FabProLineRec.Qty;
                        FabShadeLine3Rec."Total YDS" := FabShadeLine3Rec."Total YDS" + FabProLineRec.YDS;
                        FabShadeLine3Rec.Modify();
                    end;

                end;

            until FabProLineRec.Next() = 0;
        end;
    end;
}