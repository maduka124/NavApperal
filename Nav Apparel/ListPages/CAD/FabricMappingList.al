page 50626 FabricMappingList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = FabricMapping;
    InsertAllowed = true;
    Editable = true;
    SourceTableView = sorting(No) order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(No; No)
                {
                    ApplicationArea = All;
                    Caption = 'Seq No';
                    Visible = false;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        StyleRec: Record "Style Master";
                    begin
                        StyleRec.Reset();
                        StyleRec.SetRange("Style No.", "Style Name");
                        if StyleRec.FindSet() then
                            "Style No." := StyleRec."No.";

                        CurrPage.Update();
                    end;
                }

                field("Colour Name"; "Colour Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Colour';

                    trigger OnLookup(var texts: text): Boolean
                    var
                        AssoDetailsRec: Record AssortmentDetails;
                        Colour: Code[20];
                        colorRec: Record Colour;
                    begin
                        AssoDetailsRec.RESET;
                        AssoDetailsRec.SetCurrentKey("Colour No");
                        AssoDetailsRec.SetRange("Style No.", "Style No.");

                        IF AssoDetailsRec.FINDFIRST THEN BEGIN
                            REPEAT
                                IF Colour <> AssoDetailsRec."Colour No" THEN BEGIN
                                    Colour := AssoDetailsRec."Colour No";
                                    AssoDetailsRec.MARK(TRUE);
                                END;
                            UNTIL AssoDetailsRec.NEXT = 0;
                            AssoDetailsRec.MARKEDONLY(TRUE);

                            if Page.RunModal(71012677, AssoDetailsRec) = Action::LookupOK then begin
                                "Colour No" := AssoDetailsRec."Colour No";
                                colorRec.Reset();
                                colorRec.SetRange("No.", "Colour No");
                                colorRec.FindSet();
                                "Colour Name" := colorRec."Colour Name";
                            end;
                        END;
                    END;
                }

                field("Component Group"; "Component Group")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field("Main Category Name"; "Main Category Name")
                {
                    ApplicationArea = All;
                    Caption = 'Main Category';

                    trigger OnValidate()
                    var
                        MainCategoryRec: Record "Main Category";
                    begin
                        MainCategoryRec.Reset();
                        MainCategoryRec.SetRange("Main Category Name", "Main Category Name");
                        if MainCategoryRec.FindSet() then
                            "Main Category No." := MainCategoryRec."No.";
                    end;
                }

                field("Item Name"; "Item Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnLookup(var texts: text): Boolean
                    var
                        // ItemLedRec: Record "Item Ledger Entry";
                        PurchRecptLineRec: Record "Purch. Rcpt. Line";
                        ItemCode: Code[20];
                        ItemRec: Record Item;
                        ItemRec1: Record Item;
                    begin

                        // ItemLedRec.RESET;
                        // ItemLedRec.SetCurrentKey("Item No.");
                        // ItemLedRec.SetRange("Document Type", ItemLedRec."Document Type"::"Purchase Receipt");

                        // IF ItemLedRec.FindSet() THEN BEGIN

                        //     REPEAT
                        //         IF ItemCode <> ItemLedRec."Item No." THEN BEGIN
                        //             ItemCode := ItemLedRec."Item No.";

                        //             ItemRec.Reset();
                        //             ItemRec.SetRange("No.", ItemCode);
                        //             ItemRec.SetRange("Main Category No.", "Main Category No.");

                        //             if ItemRec.FindSet() then begin

                        //                 PurchRecptLineRec.Reset();
                        //                 PurchRecptLineRec.SetRange("No.", ItemCode);
                        //                 PurchRecptLineRec.SetRange(StyleName, "Style Name");

                        //                 if PurchRecptLineRec.FindSet() then
                        //                     ItemLedRec.MARK(TRUE);
                        //             end;
                        //         END;
                        //     UNTIL ItemLedRec.NEXT = 0;

                        //     ItemLedRec.MARKEDONLY(TRUE);

                        //     if Page.RunModal(50760, ItemLedRec) = Action::LookupOK then begin
                        //         "Item No." := ItemLedRec."Item No.";
                        //         ItemRec1.Reset();
                        //         ItemRec1.SetRange("No.", "Item No.");
                        //         ItemRec1.FindSet();
                        //         "Item Name" := ItemRec1.Description;

                        //     end;
                        // end;

                        PurchRecptLineRec.Reset();
                        PurchRecptLineRec.SetCurrentKey("No.");
                        PurchRecptLineRec.SetRange(StyleName, "Style Name");

                        IF PurchRecptLineRec.FindSet() THEN BEGIN

                            REPEAT
                                IF ItemCode <> PurchRecptLineRec."No." THEN BEGIN
                                    ItemCode := PurchRecptLineRec."No.";

                                    ItemRec.Reset();
                                    ItemRec.SetRange("No.", ItemCode);
                                    ItemRec.SetRange("Main Category No.", "Main Category No.");
                                    ItemRec.SetRange("Color No.", "Colour No");

                                    if ItemRec.FindSet() then
                                        PurchRecptLineRec.MARK(TRUE);
                                END;
                            UNTIL PurchRecptLineRec.NEXT = 0;

                            PurchRecptLineRec.MARKEDONLY(TRUE);

                            if Page.RunModal(50760, PurchRecptLineRec) = Action::LookupOK then begin
                                "Item No." := PurchRecptLineRec."No.";
                                ItemRec1.Reset();
                                ItemRec1.SetRange("No.", "Item No.");
                                ItemRec1.FindSet();
                                "Item Name" := ItemRec1.Description;
                            end;
                        end;
                        CurrPage.Update();
                    end;
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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."FabMap Nos.", xRec."No", "No") THEN BEGIN
            NoSeriesMngment.SetSeries("No");
            CurrPage.Update();
            EXIT(TRUE);
        END;
    end;
}