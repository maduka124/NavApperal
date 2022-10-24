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
                                        StyleWiseGRNRec.Init();
                                        StyleWiseGRNRec."User ID" := UserId;
                                        StyleWiseGRNRec."GRN No." := GRNListRec."Document No.";
                                        StyleWiseGRNRec."Style Name" := GRNListRec.StyleName;
                                        StyleWiseGRNRec."Style No" := GRNListRec.StyleNo;
                                        StyleWiseGRNRec.Insert();
                                        DocNo := GRNListRec."Document No.";
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
}