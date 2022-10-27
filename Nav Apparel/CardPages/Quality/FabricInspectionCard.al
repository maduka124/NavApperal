page 50561 "Fabric Inspection Card"
{
    PageType = Card;
    SourceTable = FabricInspection;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("InsNo."; "InsNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Fab. Ins. No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Buyer Name"; "Buyer Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Buyer';

                    trigger OnValidate()
                    var
                        BuyerRec: Record Customer;
                    begin
                        BuyerRec.Reset();
                        BuyerRec.SetRange(Name, "Buyer Name");
                        if BuyerRec.FindSet() then
                            "Buyer No." := BuyerRec."No.";
                    end;
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Style';

                    trigger OnValidate()
                    var
                        StyleMasRec: Record "Style Master";
                        AssoRec: Record AssorColorSizeRatio;
                        StyleColorRec: Record StyleColor;
                        Color: Code[20];
                    begin

                        StyleMasRec.Reset();
                        StyleMasRec.SetRange("Style No.", "Style Name");
                        if StyleMasRec.FindSet() then
                            "Style No" := StyleMasRec."No.";

                        CurrPage.Update();

                        //Deleet old recorsd
                        StyleColorRec.Reset();
                        StyleColorRec.SetRange("User ID", UserId);
                        if StyleColorRec.FindSet() then
                            StyleColorRec.DeleteAll();

                        //Get Colors for the style
                        AssoRec.Reset();
                        AssoRec.SetCurrentKey("Style No.", "Colour Name");
                        AssoRec.SetRange("Style No.", "Style No");
                        AssoRec.SetFilter("Colour Name", '<>%1', '*');

                        if AssoRec.FindSet() then begin
                            repeat
                                if Color <> AssoRec."Colour No" then begin
                                    StyleColorRec.Init();
                                    StyleColorRec."User ID" := UserId;
                                    StyleColorRec."Color No." := AssoRec."Colour No";
                                    StyleColorRec.Color := AssoRec."Colour Name";
                                    StyleColorRec.Insert();
                                    Color := AssoRec."Colour No";
                                end;
                            until AssoRec.Next() = 0;
                        end;

                    end;
                }

                field(Scale; Scale)
                {
                    ApplicationArea = All;
                }

                field("Inspection Stage"; "Inspection Stage")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        InsStageRec: Record InspectionStage;
                    begin
                        InsStageRec.Reset();
                        InsStageRec.SetRange("Inspection Stage", "Inspection Stage");
                        if InsStageRec.FindSet() then
                            "Inspection Stage No." := InsStageRec."No.";
                    end;
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
                        PurchRcpLineRec.SetRange(StyleNo, "Style No");

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
                        ItemNo: Code[20];
                        ItemLedEntryRec: Record "Item Ledger Entry";
                    begin
                        PurchRcpLineRec.RESET;
                        PurchRcpLineRec.SetCurrentKey("No.");
                        PurchRcpLineRec.SetRange("Document No.", GRN);

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
                                CurrPage.Update();

                                //get Color
                                ItemRec.Reset();
                                ItemRec.SetRange("No.", "Item No");
                                if ItemRec.FindSet() then begin
                                    "Item Name" := ItemRec.Description;
                                    "Color No." := ItemRec."Color No.";
                                    "Color" := ItemRec."Color Name";
                                end;

                                //Get roll details
                                "Total Fab. Rec. YDS" := 0;
                                ItemLedEntryRec.Reset();
                                ItemLedEntryRec.SetRange("Item No.", "Item No");
                                ItemLedEntryRec.SetRange("Document No.", GRN);

                                if ItemLedEntryRec.FindSet() then begin
                                    repeat
                                        "Total Fab. Rec. YDS" := "Total Fab. Rec. YDS" + ItemLedEntryRec."Length Tag";
                                    until ItemLedEntryRec.Next() = 0;
                                end;

                                CurrPage.Update();
                            end;
                        END;
                    END;
                }

                field(Color; Color)
                {
                    ApplicationArea = All;
                    Caption = 'GMT Color ';
                    Editable = false;
                }

                field("Total Fab. Rec. YDS"; "Total Fab. Rec. YDS")
                {
                    ApplicationArea = All;
                }

                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
                }
            }


            group("Roll Details")
            {
                field("Roll No"; "Roll No")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        ItemLedEnRec: Record "Item Ledger Entry";
                    begin
                        ItemLedEnRec.Reset();
                        ItemLedEnRec.SetRange("Lot No.", "Roll No");
                        ItemLedEnRec.SetRange("Item No.", "Item No");
                        ItemLedEnRec.SetRange("Document No.", GRN);
                        if ItemLedEnRec.FindSet() then begin
                            "Batch No" := ItemLedEnRec."Supplier Batch No.";
                            "TKT Length" := ItemLedEnRec."Length Tag";
                            "TKT Width" := ItemLedEnRec."Width Tag";
                            "Actual Length" := ItemLedEnRec."Length Act";
                            "Actual Width" := ItemLedEnRec."Width Act";
                        end;
                    end;
                }

                field("Batch No"; "Batch No")
                {
                    ApplicationArea = All;
                }

                field("TKT Length"; "TKT Length")
                {
                    ApplicationArea = All;
                }

                field("TKT Width"; "TKT Width")
                {
                    ApplicationArea = All;
                }

                field("Actual Length"; "Actual Length")
                {
                    ApplicationArea = All;
                }

                field("Actual Width"; "Actual Width")
                {
                    ApplicationArea = All;
                }

                field("Face Seal Start"; "Face Seal Start")
                {
                    ApplicationArea = All;
                }
                field("Face Seal End"; "Face Seal End")
                {
                    ApplicationArea = All;
                }

                field("Length Wise Colour Shading"; "Length Wise Colour Shading")
                {
                    ApplicationArea = All;
                }

                field("Width Wise Colour Shading"; "Width Wise Colour Shading")
                {
                    ApplicationArea = All;
                }
            }

            group("Calculate Defects")
            {
                part("Fabric Inspection ListPart1"; "Fabric Inspection ListPart1")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "InsNo." = FIELD("InsNo.");
                }
            }


            group("4 Point Details")
            {
                field("1 Point (Up to 3 inches)"; "1 Point (Up to 3 inches)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("2 Point (Up to 3-6 inches)"; "2 Point (Up to 3-6 inches)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("3 Point (Up to 6-9 inches)"; "3 Point (Up to 6-9 inches)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("4 Point (Above 9 inches) "; "4 Point (Above 9 inches) ")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("1 Point"; "1 Point")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("2 Point"; "2 Point")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("3 Point "; "3 Point ")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("4 Point"; "4 Point")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Points per 100 SQ Yds 1"; "Points per 100 SQ Yds 1")
                {
                    ApplicationArea = All;
                    Caption = '1 Point (Up to 3 Inches)';
                    Editable = false;
                }

                field("Points per 100 SQ Yds 2"; "Points per 100 SQ Yds 2")
                {
                    ApplicationArea = All;
                    Caption = '2 Point (Between 3 -6 Inches)';
                    Editable = false;
                }

                field(Status; Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = 'StrongAccent';
                }
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        FabricInspectionLineRec: Record FabricInspectionLine1;
    begin
        FabricInspectionLineRec.reset();
        FabricInspectionLineRec.SetRange("InsNo.", "InsNo.");
        FabricInspectionLineRec.DeleteAll();
    end;


    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."Ins Nos.", xRec."InsNo.", "InsNo.") THEN BEGIN
            NoSeriesMngment.SetSeries("InsNo.");
            EXIT(TRUE);
        END;
    end;

}