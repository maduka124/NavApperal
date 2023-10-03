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
                field("InsNo."; rec."InsNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Fab. Ins. No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Buyer Name"; rec."Buyer Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Buyer';

                    trigger OnValidate()
                    var
                        BuyerRec: Record Customer;
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin
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


                        BuyerRec.Reset();
                        BuyerRec.SetRange(Name, rec."Buyer Name");
                        if BuyerRec.FindSet() then
                            rec."Buyer No." := BuyerRec."No.";
                    end;
                }

                field("Style Name"; rec."Style Name")
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
                        StyleMasRec.SetRange("Style No.", rec."Style Name");
                        if StyleMasRec.FindSet() then
                            rec."Style No" := StyleMasRec."No.";

                        CurrPage.Update();

                        //Deleet old recorsd
                        StyleColorRec.Reset();
                        StyleColorRec.SetRange("User ID", UserId);
                        if StyleColorRec.FindSet() then
                            StyleColorRec.DeleteAll();

                        //Get Colors for the style
                        AssoRec.Reset();
                        AssoRec.SetCurrentKey("Style No.", "Colour Name");
                        AssoRec.SetRange("Style No.", rec."Style No");
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

                field(Scale; rec.Scale)
                {
                    ApplicationArea = All;
                }

                field("Inspection Stage"; rec."Inspection Stage")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        InsStageRec: Record InspectionStage;
                    begin
                        InsStageRec.Reset();
                        InsStageRec.SetRange("Inspection Stage", rec."Inspection Stage");
                        if InsStageRec.FindSet() then
                            rec."Inspection Stage No." := InsStageRec."No.";
                    end;
                }

                field(GRN; rec.GRN)
                {
                    ApplicationArea = All;

                    trigger OnLookup(var texts: text): Boolean
                    var
                        PurchRcpLineRec: Record "Purch. Rcpt. Line";
                        DocNo: Code[20];
                        ItemRec: Record Item;
                    begin
                        PurchRcpLineRec.RESET;
                        PurchRcpLineRec.SetCurrentKey("Document No.");
                        PurchRcpLineRec.SetRange(StyleNo, rec."Style No");


                        IF PurchRcpLineRec.FINDFIRST THEN BEGIN
                            REPEAT

                                ItemRec.Reset();
                                ItemRec.SetRange("No.", PurchRcpLineRec."No.");
                                
                                IF DocNo <> PurchRcpLineRec."Document No." THEN BEGIN
                                    if ItemRec.FindFirst() then begin
                                        if ItemRec."Main Category Name" = 'FABRIC' then begin
                                            DocNo := PurchRcpLineRec."Document No.";
                                            PurchRcpLineRec.MARK(TRUE);
                                            ItemRec.Mark(true);

                                        end;
                                    end;
                                END;
                            UNTIL PurchRcpLineRec.NEXT = 0;
                            PurchRcpLineRec.MARKEDONLY(TRUE);

                            if Page.RunModal(50676, PurchRcpLineRec) = Action::LookupOK then
                                rec.GRN := PurchRcpLineRec."Document No.";
                        END;
                    END;
                    //
                }

                field("Item Name";
                rec."Item Name")
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
                        PurchRcpLineRec.SetRange("Document No.", rec.GRN);

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

                                //get Color
                                ItemRec.Reset();
                                ItemRec.SetRange("No.", rec."Item No");
                                if ItemRec.FindSet() then begin
                                    rec."Item Name" := ItemRec.Description;
                                    rec."Color No." := ItemRec."Color No.";
                                    rec."Color" := ItemRec."Color Name";
                                end;

                                //Get roll details
                                rec."Total Fab. Rec. YDS" := 0;
                                ItemLedEntryRec.Reset();
                                ItemLedEntryRec.SetRange("Item No.", rec."Item No");
                                ItemLedEntryRec.SetRange("Document No.", rec.GRN);

                                if ItemLedEntryRec.FindSet() then begin
                                    repeat
                                        rec."Total Fab. Rec. YDS" := rec."Total Fab. Rec. YDS" + ItemLedEntryRec."Length Tag";
                                    until ItemLedEntryRec.Next() = 0;
                                end;

                                CurrPage.Update();
                            end;
                        END;
                    END;
                }

                field(Color; rec.Color)
                {
                    ApplicationArea = All;
                    Caption = 'GMT Color ';
                    Editable = false;
                }

                field("Total Fab. Rec. YDS"; rec."Total Fab. Rec. YDS")
                {
                    ApplicationArea = All;
                }

                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = All;
                }
            }


            group("Roll Details")
            {
                field("Roll No"; rec."Roll No")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        ItemLedEnRec: Record "Item Ledger Entry";
                    begin
                        ItemLedEnRec.Reset();
                        ItemLedEnRec.SetRange("Lot No.", rec."Roll No");
                        ItemLedEnRec.SetRange("Item No.", rec."Item No");
                        ItemLedEnRec.SetRange("Document No.", rec.GRN);
                        if ItemLedEnRec.FindSet() then begin
                            rec."Batch No" := ItemLedEnRec."Supplier Batch No.";
                            rec."TKT Length" := ItemLedEnRec."Length Tag";
                            rec."TKT Width" := ItemLedEnRec."Width Tag";
                            rec."Actual Length" := ItemLedEnRec."Length Act";
                            rec."Actual Width" := ItemLedEnRec."Width Act";
                        end;
                    end;
                }

                field("Batch No"; rec."Batch No")
                {
                    ApplicationArea = All;
                }

                field("TKT Length"; rec."TKT Length")
                {
                    ApplicationArea = All;
                }

                field("TKT Width"; rec."TKT Width")
                {
                    ApplicationArea = All;
                }

                field("Actual Length"; rec."Actual Length")
                {
                    ApplicationArea = All;
                }

                field("Actual Width"; rec."Actual Width")
                {
                    ApplicationArea = All;
                }

                field("Face Seal Start"; rec."Face Seal Start")
                {
                    ApplicationArea = All;
                }
                field("Face Seal End"; rec."Face Seal End")
                {
                    ApplicationArea = All;
                }

                field("Length Wise Colour Shading"; rec."Length Wise Colour Shading")
                {
                    ApplicationArea = All;
                }

                field("Width Wise Colour Shading"; rec."Width Wise Colour Shading")
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
                field("1 Point (Up to 3 inches)"; rec."1 Point (Up to 3 inches)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("2 Point (Up to 3-6 inches)"; rec."2 Point (Up to 3-6 inches)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("3 Point (Up to 6-9 inches)"; rec."3 Point (Up to 6-9 inches)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("4 Point (Above 9 inches) "; rec."4 Point (Above 9 inches)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("1 Point"; rec."1 Point")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("2 Point"; rec."2 Point")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("3 Point "; rec."3 Point")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("4 Point"; rec."4 Point")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Points per 100 SQ Yds 1"; rec."Points per 100 SQ Yds 1")
                {
                    ApplicationArea = All;
                    Caption = '1 Point (Up to 3 Inches)';
                    Editable = false;
                }

                field("Points per 100 SQ Yds 2"; rec."Points per 100 SQ Yds 2")
                {
                    ApplicationArea = All;
                    Caption = '2 Point (Between 3 -6 Inches)';
                    Editable = false;
                }

                field(Status; rec.Status)
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
        FabricInspectionLineRec.SetRange("InsNo.", rec."InsNo.");
        FabricInspectionLineRec.DeleteAll();
    end;


    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."Ins Nos.", xRec."InsNo.", rec."InsNo.") THEN BEGIN
            NoSeriesMngment.SetSeries(rec."InsNo.");
            EXIT(TRUE);
        END;
    end;

}