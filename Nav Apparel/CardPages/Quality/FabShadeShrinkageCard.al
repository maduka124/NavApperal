page 50699 FabShadeShrinkageCard
{
    PageType = Card;
    SourceTable = FabShadeBandShriHeader;
    Caption = 'Fabric Shade Shrinkage';

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
                        FabTwistHeaderRec: Record FabTwistHeader;
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
                                Get_Roll_details4();
                                Get_Roll_details5();

                                //Get Fabric Twist Average
                                FabTwistHeaderRec.RESET;
                                FabTwistHeaderRec.SetRange("Style No.", "Style No.");
                                FabTwistHeaderRec.SetRange("Buyer No.", "Buyer No.");
                                FabTwistHeaderRec.SetRange("PO No.", "PO No.");
                                FabTwistHeaderRec.SetRange(GRN, GRN);
                                FabTwistHeaderRec.SetRange("Color No", "Color No");
                                FabTwistHeaderRec.SetRange("Item No", "Item No");

                                IF FabTwistHeaderRec.FindSet() THEN
                                    "Fab Twist Avg" := FabTwistHeaderRec.Avg;

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

                field("Fab Twist Avg"; "Fab Twist Avg")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Approved Shade"; "Approved Shade")
                {
                    ApplicationArea = All;
                }
            }

            group("FABRIC SHADE")
            {
                part(FabShdaeShrinkageListPart1; FabShadeShrinkageListPart1)
                {
                    ApplicationArea = All;
                    Caption = '  ';
                    SubPageLink = "FabShadeNo." = FIELD("FabShadeNo.");
                }
            }

            group("FABRIC WIDTH")
            {
                part(FabShdaeShrinkageListPart2; FabShadeShrinkageListPart2)
                {
                    ApplicationArea = All;
                    Caption = '  ';
                    SubPageLink = "FabShadeNo." = FIELD("FabShadeNo.");
                }
            }

            group("LENGTH SHRINKAGE")
            {
                part(FabShdaeShrinkageListPart3; FabShadeShrinkageListPart3)
                {
                    ApplicationArea = All;
                    Caption = '  ';
                    SubPageLink = "FabShadeNo." = FIELD("FabShadeNo.");
                }
            }

            group("WIDTH SHRINKAGE")
            {
                part(FabShdaeShrinkageListPart4; FabShadeShrinkageListPart4)
                {
                    ApplicationArea = All;
                    Caption = '  ';
                    SubPageLink = "FabShadeNo." = FIELD("FabShadeNo.");
                }
            }

            group("PATTERN USE")
            {
                part(FabShdaeShrinkageListPart5; FabShadeShrinkageListPart5)
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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."FabShadShrink Nos.", xRec."FabShadeNo.", "FabShadeNo.") THEN BEGIN
            NoSeriesMngment.SetSeries("FabShadeNo.");
            EXIT(TRUE);
        END;
    end;


    // trigger OnDeleteRecord(): Boolean
    // var
    //     FabShadeLineRec: Record FabShadeLine;
    // begin
    //     FabShadeLineRec.reset();
    //     FabShadeLineRec.SetRange("FabShadeNo.", "FabShadeNo.");
    //     if FabShadeLineRec.FindSet() then
    //         FabShadeLineRec.DeleteAll();
    // end;


    procedure Get_Roll_details1()
    var
        FabProLineRec: Record FabricProceLine;
        FabShadeShriLine1Rec: Record FabShadeBandShriLine1;
        Lineno: Integer;
        Shade: text[50];
        ShadeNo: Code[20];
    begin

        //Get Max line no
        FabShadeShriLine1Rec.Reset();
        FabShadeShriLine1Rec.SetRange("FabShadeNo.", "FabShadeNo.");

        if FabShadeShriLine1Rec.FindLast() then
            Lineno := FabShadeShriLine1Rec."Line No.";

        //Deleet old records
        FabShadeShriLine1Rec.Reset();
        FabShadeShriLine1Rec.SetRange("FabShadeNo.", "FabShadeNo.");
        if FabShadeShriLine1Rec.FindSet() then
            FabShadeShriLine1Rec.DeleteAll();


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

                    FabShadeShriLine1Rec.Init();
                    FabShadeShriLine1Rec."FabShadeNo." := "FabShadeNo.";
                    FabShadeShriLine1Rec."Line No." := Lineno;
                    FabShadeShriLine1Rec."Total Rolls" := FabProLineRec.Qty;
                    FabShadeShriLine1Rec."Total YDS" := FabProLineRec.YDS;
                    FabShadeShriLine1Rec.Shade := FabProLineRec.Shade;
                    FabShadeShriLine1Rec."Shade No" := FabProLineRec."Shade No";
                    FabShadeShriLine1Rec.Insert();

                end
                else begin

                    FabShadeShriLine1Rec.Reset();
                    FabShadeShriLine1Rec.SetRange("FabShadeNo.", "FabShadeNo.");
                    FabShadeShriLine1Rec.SetRange("Shade No", ShadeNo);

                    if FabShadeShriLine1Rec.FindSet() then begin
                        FabShadeShriLine1Rec."Total Rolls" := FabShadeShriLine1Rec."Total Rolls" + FabProLineRec.Qty;
                        FabShadeShriLine1Rec."Total YDS" := FabShadeShriLine1Rec."Total YDS" + FabProLineRec.YDS;
                        FabShadeShriLine1Rec.Modify();
                    end;

                end;

            until FabProLineRec.Next() = 0;
        end;
    end;


    procedure Get_Roll_details2()
    var
        FabProLineRec: Record FabricProceLine;
        FabShadeShriLine2Rec: Record FabShadeBandShriLine2;
        Lineno: Integer;
        ActWidth: Decimal;
    begin

        //Get Max line no
        FabShadeShriLine2Rec.Reset();
        FabShadeShriLine2Rec.SetRange("FabShadeNo.", "FabShadeNo.");

        if FabShadeShriLine2Rec.FindLast() then
            Lineno := FabShadeShriLine2Rec."Line No.";

        //Deleet old records
        FabShadeShriLine2Rec.Reset();
        FabShadeShriLine2Rec.SetRange("FabShadeNo.", "FabShadeNo.");
        if FabShadeShriLine2Rec.FindSet() then
            FabShadeShriLine2Rec.DeleteAll();


        //Get Rolldetails for the item and GRN
        FabProLineRec.Reset();
        FabProLineRec.SetRange("Item No", "Item No");
        FabProLineRec.SetRange(GRN, GRN);
        FabProLineRec.SetCurrentKey("Act. Width");

        if FabProLineRec.FindSet() then begin
            repeat
                Lineno += 1;

                IF ActWidth <> FabProLineRec."Act. Width" THEN BEGIN
                    ActWidth := FabProLineRec."Act. Width";

                    FabShadeShriLine2Rec.Init();
                    FabShadeShriLine2Rec."FabShadeNo." := "FabShadeNo.";
                    FabShadeShriLine2Rec."Line No." := Lineno;
                    FabShadeShriLine2Rec."Total Rolls" := FabProLineRec.Qty;
                    FabShadeShriLine2Rec."Total YDS" := FabProLineRec.YDS;
                    FabShadeShriLine2Rec.Width := FabProLineRec."Act. Width";
                    FabShadeShriLine2Rec.Insert();

                end
                else begin

                    FabShadeShriLine2Rec.Reset();
                    FabShadeShriLine2Rec.SetRange("FabShadeNo.", "FabShadeNo.");
                    FabShadeShriLine2Rec.SetRange(Width, FabProLineRec."Act. Width");

                    if FabShadeShriLine2Rec.FindSet() then begin
                        FabShadeShriLine2Rec."Total Rolls" := FabShadeShriLine2Rec."Total Rolls" + FabProLineRec.Qty;
                        FabShadeShriLine2Rec."Total YDS" := FabShadeShriLine2Rec."Total YDS" + FabProLineRec.YDS;
                        FabShadeShriLine2Rec.Modify();
                    end;

                end;

            until FabProLineRec.Next() = 0;
        end;
    end;


    procedure Get_Roll_details3()
    var
        FabProLineRec: Record FabricProceLine;
        FabShadeShriLine3Rec: Record FabShadeBandShriLine3;
        Lineno: Integer;
        SHR: Decimal;
    begin

        //Get Max line no
        FabShadeShriLine3Rec.Reset();
        FabShadeShriLine3Rec.SetRange("FabShadeNo.", "FabShadeNo.");

        if FabShadeShriLine3Rec.FindLast() then
            Lineno := FabShadeShriLine3Rec."Line No.";

        //Deleet old records
        FabShadeShriLine3Rec.Reset();
        FabShadeShriLine3Rec.SetRange("FabShadeNo.", "FabShadeNo.");
        if FabShadeShriLine3Rec.FindSet() then
            FabShadeShriLine3Rec.DeleteAll();


        //Get Rolldetails for the item and GRN
        FabProLineRec.Reset();
        FabProLineRec.SetRange("Item No", "Item No");
        FabProLineRec.SetRange(GRN, GRN);
        FabProLineRec.SetCurrentKey("Length%");

        if FabProLineRec.FindSet() then begin
            repeat
                Lineno += 1;

                IF SHR <> FabProLineRec."Length%" THEN BEGIN
                    SHR := FabProLineRec."Length%";

                    FabShadeShriLine3Rec.Init();
                    FabShadeShriLine3Rec."FabShadeNo." := "FabShadeNo.";
                    FabShadeShriLine3Rec."Line No." := Lineno;
                    FabShadeShriLine3Rec."Total Rolls" := FabProLineRec.Qty;
                    FabShadeShriLine3Rec.Shrinkage := FabProLineRec."Length%";
                    FabShadeShriLine3Rec.Insert();

                end
                else begin

                    FabShadeShriLine3Rec.Reset();
                    FabShadeShriLine3Rec.SetRange("FabShadeNo.", "FabShadeNo.");
                    FabShadeShriLine3Rec.SetRange(Shrinkage, FabProLineRec."Length%");

                    if FabShadeShriLine3Rec.FindSet() then begin
                        FabShadeShriLine3Rec."Total Rolls" := FabShadeShriLine3Rec."Total Rolls" + FabProLineRec.Qty;
                        FabShadeShriLine3Rec.Modify();
                    end;

                end;

            until FabProLineRec.Next() = 0;
        end;
    end;


    procedure Get_Roll_details4()
    var
        FabProLineRec: Record FabricProceLine;
        FabShadeShriLine4Rec: Record FabShadeBandShriLine4;
        Lineno: Integer;
        SHR: Decimal;
    begin

        //Get Max line no
        FabShadeShriLine4Rec.Reset();
        FabShadeShriLine4Rec.SetRange("FabShadeNo.", "FabShadeNo.");

        if FabShadeShriLine4Rec.FindLast() then
            Lineno := FabShadeShriLine4Rec."Line No.";

        //Deleet old records
        FabShadeShriLine4Rec.Reset();
        FabShadeShriLine4Rec.SetRange("FabShadeNo.", "FabShadeNo.");
        if FabShadeShriLine4Rec.FindSet() then
            FabShadeShriLine4Rec.DeleteAll();


        //Get Rolldetails for the item and GRN
        FabProLineRec.Reset();
        FabProLineRec.SetRange("Item No", "Item No");
        FabProLineRec.SetRange(GRN, GRN);
        FabProLineRec.SetCurrentKey("WiDth%");

        if FabProLineRec.FindSet() then begin
            repeat
                Lineno += 1;

                IF SHR <> FabProLineRec."WiDth%" THEN BEGIN
                    SHR := FabProLineRec."WiDth%";

                    FabShadeShriLine4Rec.Init();
                    FabShadeShriLine4Rec."FabShadeNo." := "FabShadeNo.";
                    FabShadeShriLine4Rec."Line No." := Lineno;
                    FabShadeShriLine4Rec."Total Rolls" := FabProLineRec.Qty;
                    FabShadeShriLine4Rec."WIDTH Shrinkage" := FabProLineRec."WiDth%";
                    FabShadeShriLine4Rec.Insert();

                end
                else begin

                    FabShadeShriLine4Rec.Reset();
                    FabShadeShriLine4Rec.SetRange("FabShadeNo.", "FabShadeNo.");
                    FabShadeShriLine4Rec.SetRange("WIDTH Shrinkage", FabProLineRec."WiDth%");

                    if FabShadeShriLine4Rec.FindSet() then begin
                        FabShadeShriLine4Rec."Total Rolls" := FabShadeShriLine4Rec."Total Rolls" + FabProLineRec.Qty;
                        FabShadeShriLine4Rec.Modify();
                    end;

                end;

            until FabProLineRec.Next() = 0;
        end;
    end;


    procedure Get_Roll_details5()
    var
        FabProLineRec: Record FabricProceLine;
        FabShrTestLineRec: Record FabShrinkageTestLine;
        FabShadeShriLine5Rec: Record FabShadeBandShriLine5;
        Lineno: Integer;
        Pattern: Code[20];
    begin

        //Get Max line no
        FabShadeShriLine5Rec.Reset();
        FabShadeShriLine5Rec.SetRange("FabShadeNo.", "FabShadeNo.");

        if FabShadeShriLine5Rec.FindLast() then
            Lineno := FabShadeShriLine5Rec."Line No.";

        //Deleet old records
        FabShadeShriLine5Rec.Reset();
        FabShadeShriLine5Rec.SetRange("FabShadeNo.", "FabShadeNo.");
        if FabShadeShriLine5Rec.FindSet() then
            FabShadeShriLine5Rec.DeleteAll();


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

                    FabShadeShriLine5Rec.Init();
                    FabShadeShriLine5Rec."FabShadeNo." := "FabShadeNo.";
                    FabShadeShriLine5Rec."Line No." := Lineno;
                    FabShadeShriLine5Rec.Pattern := FabProLineRec."PTTN GRP";

                    FabShrTestLineRec.Reset();
                    FabShrTestLineRec.SetRange("Pattern Code", FabProLineRec."PTTN GRP");

                    if FabShrTestLineRec.FindSet() then begin
                        FabShadeShriLine5Rec."WIDTH%" := FabShrTestLineRec."WiDth%";
                        FabShadeShriLine5Rec."Length%" := FabShrTestLineRec."Length%";
                    end;

                    FabShadeShriLine5Rec.Insert();

                end;

            until FabProLineRec.Next() = 0;
        end;
    end;
}