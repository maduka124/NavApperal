page 50683 "FabShrinkageTestCard"
{
    PageType = Card;
    SourceTable = FabShrinkageTestHeader;
    Caption = 'Fabric Shrinkage Test';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("FabShrTestNo."; "FabShrTestNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Fabric Shrinkage No';

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
                                if ItemRec.FindSet() then begin
                                    "Item Name" := ItemRec.Description;
                                    "Color Name" := ItemRec."Color Name";
                                    "Color No" := ItemRec."Color No.";
                                end;

                                //Get No of rolls
                                ItemLedEntryRec.Reset();
                                ItemLedEntryRec.SetRange("Item No.", "Item No");
                                ItemLedEntryRec.SetRange("Document No.", GRN);

                                if ItemLedEntryRec.FindSet() then begin
                                    repeat
                                        "No of Roll" := "No of Roll" + ItemLedEntryRec."Remaining Quantity";
                                    until ItemLedEntryRec.Next() = 0;
                                end;

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

                    // trigger OnLookup(var texts: text): Boolean
                    // var
                    //     PurchRcpLineRec: Record "Purch. Rcpt. Line";
                    //     Colour: Code[20];
                    //     colorRec: Record Colour;
                    // begin
                    //     PurchRcpLineRec.RESET;
                    //     PurchRcpLineRec.SetCurrentKey("Color No.");
                    //     PurchRcpLineRec.SetRange("Document No.", GRN);

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
                    Caption = 'Fabric Code';
                    Editable = false;
                }
            }

            group("Details")
            {
                part(FabShrinkageTestListPart; FabShrinkageTestListPart)
                {
                    ApplicationArea = All;
                    Caption = 'Details';
                    SubPageLink = "FabShrTestNo." = FIELD("FabShrTestNo.");
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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."FabShrTest Nos.", xRec."FabShrTestNo.", "FabShrTestNo.") THEN BEGIN
            NoSeriesMngment.SetSeries("FabShrTestNo.");
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        FabShrTestLineRec: Record FabShrinkageTestLine;
    begin
        FabShrTestLineRec.reset();
        FabShrTestLineRec.SetRange("FabShrTestNo.", "FabShrTestNo.");
        if FabShrTestLineRec.FindSet() then
            FabShrTestLineRec.DeleteAll();
    end;

}