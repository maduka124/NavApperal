page 50690 "FabTwistCard"
{
    PageType = Card;
    SourceTable = FabTwistHeader;
    Caption = 'Fabric Twisting/Skewness Test';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("FabTwistNo."; rec."FabTwistNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Fab. Twist No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Buyer Name."; rec."Buyer Name.")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';

                    trigger OnValidate()
                    var
                        CustomerRec: Record Customer;
                    begin
                        CustomerRec.Reset();
                        CustomerRec.SetRange(Name, rec."Buyer Name.");
                        if CustomerRec.FindSet() then
                            rec."Buyer No." := CustomerRec."No.";

                        CurrPage.Update();
                    end;
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';

                    trigger OnValidate()
                    var
                        StyleMasterRec: Record "Style Master";
                    begin
                        StyleMasterRec.Reset();
                        StyleMasterRec.SetRange("Style No.", rec."Style Name");
                        if StyleMasterRec.FindSet() then
                            rec."Style No." := StyleMasterRec."No.";

                        CurrPage.Update();
                    end;
                }

                field("PO No."; rec."PO No.")
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
                        PurchRcpLineRec.SetRange(StyleNo, rec."Style No.");

                        IF PurchRcpLineRec.FINDFIRST THEN BEGIN
                            REPEAT
                                IF PO <> PurchRcpLineRec."Order No." THEN BEGIN
                                    PO := PurchRcpLineRec."Order No.";
                                    PurchRcpLineRec.MARK(TRUE);
                                END;
                            UNTIL PurchRcpLineRec.NEXT = 0;
                            PurchRcpLineRec.MARKEDONLY(TRUE);

                            if Page.RunModal(50675, PurchRcpLineRec) = Action::LookupOK then
                                rec."PO No." := PurchRcpLineRec."Order No.";
                        END;
                    END;
                }

                field(GRN; rec.GRN)
                {
                    ApplicationArea = All;

                    trigger OnLookup(var texts: text): Boolean
                    var
                        PurchRcpLineRec: Record "Purch. Rcpt. Line";
                        DocNo: Code[20];
                    begin
                        PurchRcpLineRec.RESET;
                        PurchRcpLineRec.SetCurrentKey("Document No.");
                        PurchRcpLineRec.SetRange("Order No.", rec."PO No.");

                        IF PurchRcpLineRec.FINDFIRST THEN BEGIN
                            REPEAT
                                IF DocNo <> PurchRcpLineRec."Document No." THEN BEGIN
                                    DocNo := PurchRcpLineRec."Document No.";
                                    PurchRcpLineRec.MARK(TRUE);
                                END;
                            UNTIL PurchRcpLineRec.NEXT = 0;
                            PurchRcpLineRec.MARKEDONLY(TRUE);

                            if Page.RunModal(50676, PurchRcpLineRec) = Action::LookupOK then
                                rec.GRN := PurchRcpLineRec."Document No.";
                        END;
                    END;
                }

                field("Color Name"; rec."Color Name")
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
                        PurchRcpLineRec.SetRange("Document No.", rec.GRN);

                        IF PurchRcpLineRec.FINDFIRST THEN BEGIN
                            REPEAT
                                IF Colour <> PurchRcpLineRec."Color No." THEN BEGIN
                                    Colour := PurchRcpLineRec."Color No.";

                                    PurchRcpLineRec.MARK(TRUE);
                                END;
                            UNTIL PurchRcpLineRec.NEXT = 0;
                            PurchRcpLineRec.MARKEDONLY(TRUE);

                            if Page.RunModal(50672, PurchRcpLineRec) = Action::LookupOK then begin
                                rec."Color No" := PurchRcpLineRec."Color No.";
                                rec."Color Name" := PurchRcpLineRec."Color Name";
                            end;

                        END;
                    END;
                }

                field("Item Name"; rec."Item Name")
                {
                    ApplicationArea = All;
                    Caption = 'Item';

                    trigger OnLookup(var texts: text): Boolean
                    var
                        PurchRcpLineRec: Record "Purch. Rcpt. Line";
                        ItemRec: Record Item;
                        ItemNo: Code[20];
                    begin
                        PurchRcpLineRec.RESET;
                        PurchRcpLineRec.SetCurrentKey("No.");
                        PurchRcpLineRec.SetRange("Document No.", rec.GRN);
                        PurchRcpLineRec.SetRange("Color No.", rec."Color No");

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
                                rec."Item No" := PurchRcpLineRec."No.";
                                CurrPage.Update();

                                ItemRec.Reset();
                                ItemRec.SetRange("No.", rec."Item No");
                                if ItemRec.FindSet() then
                                    rec."Item Name" := ItemRec.Description;

                                //Get Roll details
                                Get_Roll_details();

                                CurrPage.Update();
                            end;
                        END;
                    END;
                }

                field("Fabric Code"; rec."Fabric Code")
                {
                    ApplicationArea = All;
                    Caption = 'Fabric';

                    trigger OnValidate()
                    var
                        FabicCodeRec: Record FabricCodeMaster;
                    begin
                        FabicCodeRec.Reset();
                        FabicCodeRec.SetRange(FabricCode, rec."Fabric Code");
                        if FabicCodeRec.FindSet() then begin
                            rec.Composition := FabicCodeRec.Composition;
                            rec.Construction := FabicCodeRec.Construction;
                        end;
                    end;
                }

                field(Composition; rec.Composition)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Construction; rec.Construction)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Avg; rec.Avg)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Average';
                }
            }

            group(" ")
            {
                part(FabTwistListPart; FabTwistListPart)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "FabTwistNo." = FIELD("FabTwistNo.");
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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."FabTwist Nos.", xRec."FabTwistNo.", rec."FabTwistNo.") THEN BEGIN
            NoSeriesMngment.SetSeries(rec."FabTwistNo.");
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        FabTwistLineRec: Record FabTwistLine;
    begin
        FabTwistLineRec.reset();
        FabTwistLineRec.SetRange("FabTwistNo.", rec."FabTwistNo.");
        if FabTwistLineRec.FindSet() then
            FabTwistLineRec.DeleteAll();
    end;


    procedure Get_Roll_details()
    var
        ItemLedEntryRec: Record "Item Ledger Entry";
        FabTwistLineRec: Record FabTwistLine;
        Lineno: Integer;
    begin

        //Get Max line no
        FabTwistLineRec.Reset();
        FabTwistLineRec.SetRange("FabTwistNo.", rec."FabTwistNo.");

        if FabTwistLineRec.FindLast() then
            Lineno := FabTwistLineRec."Line No.";

        //Deleet old records
        FabTwistLineRec.Reset();
        FabTwistLineRec.SetRange("FabTwistNo.", rec."FabTwistNo.");
        if FabTwistLineRec.FindSet() then
            FabTwistLineRec.DeleteAll();


        //Get Rolldetails for the item and GRN
        ItemLedEntryRec.Reset();
        ItemLedEntryRec.SetRange("Item No.", rec."Item No");
        ItemLedEntryRec.SetRange("Document No.", rec.GRN);

        if ItemLedEntryRec.FindSet() then begin
            repeat
                Lineno += 1;
                if ItemLedEntryRec."Remaining Quantity" > 0 then begin
                    FabTwistLineRec.Init();
                    FabTwistLineRec."FabTwistNo." := rec."FabTwistNo.";
                    FabTwistLineRec."Line No." := Lineno;
                    FabTwistLineRec."RollID" := ItemLedEntryRec."Lot No.";
                    FabTwistLineRec."Color No" := ItemLedEntryRec."Color No";
                    FabTwistLineRec."Color Name" := ItemLedEntryRec.Color;
                    FabTwistLineRec.NoofRolls := ItemLedEntryRec.Quantity;
                    FabTwistLineRec.Qty := ItemLedEntryRec."Length Tag";
                    FabTwistLineRec."BW Width CM" := 0;
                    FabTwistLineRec."BW Twist CM" := 0;
                    FabTwistLineRec."BW Twist%" := 0;
                    FabTwistLineRec."AW Width CM" := 0;
                    FabTwistLineRec."AW Twist CM" := 0;
                    FabTwistLineRec."AW Twist%" := 0;
                    FabTwistLineRec.Insert();
                end;
            until ItemLedEntryRec.Next() = 0;
        end;
    end;

}