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
                field("RoleIssuNo."; rec."RoleIssuNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Roll Issuing No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Req No."; rec."Req No.")
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


                        FabricReqRec.Reset();
                        FabricReqRec.SetRange("FabReqNo.", rec."Req No.");

                        if FabricReqRec.FindSet() then begin
                            rec."Style No." := FabricReqRec."Style No.";
                            rec."Style Name" := FabricReqRec."Style Name";
                            rec."Colour No" := FabricReqRec."Colour No";
                            rec."Colour Name" := FabricReqRec."Colour Name";
                            rec.UOM := FabricReqRec.UOM;
                            rec."UOM Code" := FabricReqRec."UOM Code";
                            rec."Required Width" := FabricReqRec."Marker Width";
                            rec."Required Length" := FabricReqRec."Required Length";
                            rec."GRN Filter User ID" := UserId;
                            rec."GRN No" := '';
                            rec."Po No." := FabricReqRec."PO No.";
                            rec."Group ID" := FabricReqRec."Group ID";


                            //Load GRN for the style
                            //Delete old record
                            StyleWiseGRNRec.Reset();
                            StyleWiseGRNRec.SetRange("User ID", UserId);
                            if StyleWiseGRNRec.FindSet() then
                                StyleWiseGRNRec.DeleteAll();

                            //Get GRN for the style
                            GRNListRec.Reset();
                            GRNListRec.SetCurrentKey("Document No.");
                            GRNListRec.SetRange("StyleNo", rec."Style No.");

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

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Colour Name"; rec."Colour Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Colour';
                }

                field("Group ID"; rec."Group ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("PO No."; rec."PO No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("GRN No"; rec."GRN No")
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
                        GRNLineRec.SetRange("Document No.", rec."GRN No");
                        GRNLineRec.SetFilter(Type, '%1', GRNLineRec.Type::Item);
                        if GRNLineRec.FindSet() then begin
                            rec."Location Code" := GRNLineRec."Location Code";
                            LocRec.Reset();
                            LocRec.Get(GRNLineRec."Location Code");
                            rec."Location Name" := LocRec.Name;
                        end;
                    end;
                }

                field("Item Name"; rec."Item Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Item';

                    trigger OnValidate()
                    var
                        ItemRec: Record item;
                    begin
                        ItemRec.Reset();
                        ItemRec.SetRange(Description, rec."Item Name");
                        if ItemRec.FindSet() then begin
                            rec."Item No" := ItemRec."No.";
                            ItemRec.CalcFields(Inventory);
                            rec.OnHandQty := ItemRec.Inventory;
                        end;

                        Generate_Role_Details();

                    end;
                }

                field(OnHandQty; rec.OnHandQty)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'On Hand Qty';
                }

                field(UOM; rec.UOM)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Required Width"; rec."Required Width")
                {
                    ApplicationArea = All;
                }

                field("Required Length"; rec."Required Length")
                {
                    ApplicationArea = All;
                }

                field("Selected Qty"; rec."Selected Qty")
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
        LaySheetRec.SetRange("LaySheetNo.", rec."RoleIssuNo.");

        if LaySheetRec.FindSet() then begin
            Message('Cannot delete. Role Issue No already used in the Laysheet No : %1', LaySheetRec."LaySheetNo.");
            exit(false);
        end;

        RoleIssuingNoteLineRec.reset();
        RoleIssuingNoteLineRec.SetRange("RoleIssuNo.", rec."RoleIssuNo.");
        RoleIssuingNoteLineRec.DeleteAll();
    end;


    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."RoleIssu Nos.", xRec."RoleIssuNo.", rec."RoleIssuNo.") THEN BEGIN
            NoSeriesMngment.SetSeries(rec."RoleIssuNo.");
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
        RoleIssuLineRec.SetRange("RoleIssuNo.", rec."RoleIssuNo.");
        if RoleIssuLineRec.FindSet() then
            RoleIssuLineRec.DeleteAll();

        FabricProceHeaderRec.Reset();
        FabricProceHeaderRec.SetRange("Style No.", rec."Style No.");
        FabricProceHeaderRec.SetRange(GRN, rec."GRN No");
        FabricProceHeaderRec.SetRange("Color No", rec."Colour No");
        FabricProceHeaderRec.SetRange("Item No", rec."Item No");
        FabricProceHeaderRec.FindSet();

        FabricProceLineRec.Reset();
        FabricProceLineRec.SetRange("FabricProceNo.", FabricProceHeaderRec."FabricProceNo.");

        if FabricProceLineRec.FindSet() then begin

            repeat

                Lineno += 1;
                RoleIssuLineRec.Init();
                RoleIssuLineRec."RoleIssuNo." := rec."RoleIssuNo.";
                RoleIssuLineRec."Line No." := Lineno;
                RoleIssuLineRec."Location No" := rec."Location Code";
                RoleIssuLineRec."Location Name" := rec."Location Name";
                RoleIssuLineRec."Item No" := rec."Item No";
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