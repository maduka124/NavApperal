page 50635 "Roll Issuing Note Card"
{
    PageType = Card;
    SourceTable = RoleIssuingNoteHeader;
    Caption = 'Roll Issuing Note';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("RoleIssuNo."; "RoleIssuNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Roll Issuing No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Req No."; "Req No.")
                {
                    ApplicationArea = All;
                    Caption = 'Fabric Requsition No';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        FabricReqRec: Record FabricRequsition;
                        StyleWiseGRNRec: Record StyleWiseGRN;
                        GRNListRec: Record "Purch. Rcpt. Line";
                        ItemRec: Record Item;
                        DocNo: Text[50];
                    begin
                        FabricReqRec.Reset();
                        FabricReqRec.SetRange("FabReqNo.", "Req No.");

                        if FabricReqRec.FindSet() then begin
                            "Style No." := FabricReqRec."Style No.";
                            "Style Name" := FabricReqRec."Style Name";
                            "Colour No" := FabricReqRec."Colour No";
                            "Colour Name" := FabricReqRec."Colour Name";
                            UOM := FabricReqRec.UOM;
                            "UOM Code" := FabricReqRec."UOM Code";
                            "Required Width" := FabricReqRec."Marker Width";
                            "Required Length" := FabricReqRec."Required Length";
                            "GRN Filter User ID" := UserId;
                            "GRN No" := '';

                            //Load GRN for the style
                            //Delete old record
                            StyleWiseGRNRec.Reset();
                            StyleWiseGRNRec.SetRange("User ID", UserId);
                            if StyleWiseGRNRec.FindSet() then
                                StyleWiseGRNRec.DeleteAll();

                            //Get GRN for the style
                            GRNListRec.Reset();
                            GRNListRec.SetCurrentKey("Document No.");
                            GRNListRec.SetRange("StyleNo", "Style No.");

                            if GRNListRec.FindSet() then begin
                                repeat
                                    if DocNo <> GRNListRec."Document No." then begin

                                        ItemRec.Reset();
                                        ItemRec.SetRange("No.", GRNListRec."No.");
                                        ItemRec.SetFilter("Main Category Name", '=%1', 'FABRIC');

                                        if ItemRec.FindSet() then begin
                                            StyleWiseGRNRec.Init();
                                            StyleWiseGRNRec."User ID" := UserId;
                                            StyleWiseGRNRec."GRN No." := GRNListRec."Document No.";
                                            StyleWiseGRNRec."Style Name" := GRNListRec.StyleName;
                                            StyleWiseGRNRec."Style No" := GRNListRec.StyleNo;
                                            StyleWiseGRNRec.Insert();
                                            DocNo := GRNListRec."Document No.";
                                        end;

                                    end;
                                until GRNListRec.Next() = 0;
                            end;

                            CurrPage.Update();
                        end;
                    end;
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Colour Name"; "Colour Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Colour';
                }

                field("GRN No"; "GRN No")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    TableRelation = StyleWiseGRN."GRN No." where("User ID" = field("GRN Filter User ID"));

                    trigger OnValidate()
                    var
                        GRNLineRec: Record "Purch. Rcpt. Line";
                        LocRec: Record Location;
                    begin
                        GRNLineRec.Reset();
                        GRNLineRec.SetRange("Document No.", "GRN No");
                        GRNLineRec.SetFilter(Type, '%1', GRNLineRec.Type::Item);
                        if GRNLineRec.FindSet() then begin
                            "Location Code" := GRNLineRec."Location Code";
                            LocRec.Reset();
                            LocRec.Get(GRNLineRec."Location Code");
                            "Location Name" := LocRec.Name;
                        end;
                    end;
                }

                field("Item Name"; "Item Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Item';

                    trigger OnValidate()
                    var
                        ItemRec: Record item;
                    begin
                        ItemRec.Reset();
                        ItemRec.SetRange(Description, "Item Name");
                        if ItemRec.FindSet() then begin
                            "Item No" := ItemRec."No.";
                            ItemRec.CalcFields(Inventory);
                            OnHandQty := ItemRec.Inventory;
                        end;

                        Generate_Role_Details();

                    end;
                }

                field(OnHandQty; OnHandQty)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'On Hand Qty';
                }

                field(UOM; UOM)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Required Width"; "Required Width")
                {
                    ApplicationArea = All;
                }

                field("Required Length"; "Required Length")
                {
                    ApplicationArea = All;
                }

                field("Selected Qty"; "Selected Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Selected Qty (Tag Length)';
                }
            }

            group("Items")
            {
                part("Roll Issuing Note ListPart"; "Roll Issuing Note ListPart")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "RoleIssuNo." = FIELD("RoleIssuNo."), "Item No" = field("Item No");
                }
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        RoleIssuingNoteLineRec: Record RoleIssuingNoteLine;
        LaysheetRec: Record LaySheetHeader;
    begin
        //Check in the laysheet
        LaySheetRec.Reset();
        LaySheetRec.SetRange("LaySheetNo.", "RoleIssuNo.");

        if LaySheetRec.FindSet() then begin
            Message('Cannot delete. Role Issue No already used in the Laysheet No : %1', LaySheetRec."LaySheetNo.");
            exit(false);
        end;

        RoleIssuingNoteLineRec.reset();
        RoleIssuingNoteLineRec.SetRange("RoleIssuNo.", "RoleIssuNo.");
        RoleIssuingNoteLineRec.DeleteAll();
    end;


    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."RoleIssu Nos.", xRec."RoleIssuNo.", "RoleIssuNo.") THEN BEGIN
            NoSeriesMngment.SetSeries("RoleIssuNo.");
            EXIT(TRUE);
        END;
    end;

    procedure Generate_Role_Details()
    var
        FabricProceHeaderRec: Record FabricProceHeader;
        FabricProceLineRec: Record FabricProceLine;
        RoleIssuLineRec: Record RoleIssuingNoteLine;
        Lineno: BigInteger;
    begin

        //Delete old records
        RoleIssuLineRec.Reset();
        RoleIssuLineRec.SetRange("RoleIssuNo.", "RoleIssuNo.");
        if RoleIssuLineRec.FindSet() then
            RoleIssuLineRec.DeleteAll();

        FabricProceHeaderRec.Reset();
        FabricProceHeaderRec.SetRange("Style No.", "Style No.");
        FabricProceHeaderRec.SetRange(GRN, "GRN No");
        FabricProceHeaderRec.SetRange("Color No", "Colour No");
        FabricProceHeaderRec.SetRange("Item No", "Item No");
        FabricProceHeaderRec.FindSet();

        FabricProceLineRec.Reset();
        FabricProceLineRec.SetRange("FabricProceNo.", FabricProceHeaderRec."FabricProceNo.");

        if FabricProceLineRec.FindSet() then begin

            repeat

                Lineno += 1;
                RoleIssuLineRec.Init();
                RoleIssuLineRec."RoleIssuNo." := "RoleIssuNo.";
                RoleIssuLineRec."Line No." := Lineno;
                RoleIssuLineRec."Location No" := "Location Code";
                RoleIssuLineRec."Location Name" := "Location Name";
                RoleIssuLineRec."Item No" := "Item No";
                RoleIssuLineRec."Length Act" := FabricProceLineRec."Act. Legth";
                RoleIssuLineRec."Length Tag" := FabricProceLineRec.YDS;
                RoleIssuLineRec."Length Allocated" := FabricProceLineRec."Act. Legth";
                RoleIssuLineRec."Width Act" := FabricProceLineRec."Act. Width";
                RoleIssuLineRec."Width Tag" := FabricProceLineRec.Width;
                RoleIssuLineRec."Role ID" := FabricProceLineRec."Roll No";
                RoleIssuLineRec."Shade No" := FabricProceLineRec."Shade No";
                RoleIssuLineRec.Shade := FabricProceLineRec.Shade;
                RoleIssuLineRec."PTTN GRP" := FabricProceLineRec."PTTN GRP";
                //RoleIssuLineRec.InvoiceNo := FabricProceLineRec.InvoiceNo;
                //RoleIssuLineRec."Supplier Batch No." := FabricProceLineRec.;
                //RoleIssuLineRec. := FabricProceLineRec.Qty;
                RoleIssuLineRec.Insert();

            until FabricProceLineRec.Next() = 0;

        end;

    end;
}