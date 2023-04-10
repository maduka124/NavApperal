page 50671 "FabricProceCard"
{
    PageType = Card;
    SourceTable = FabricProceHeader;
    Caption = 'Fabric Processing';

    layout
    {
        area(Content)
        {
            group(General)
            {

                Editable = EditableGB;

                field("FabricProceNo."; rec."FabricProceNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Fabric Processing No';

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
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                        UserRec: Record "User Setup";
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

                        //Done By Sachith on 10/04/23 
                        UserRec.Reset();
                        UserRec.Get(UserId);

                        if UserRec."Factory Code" <> '' then begin
                            Rec."Factory Code" := UserRec."Factory Code";
                            CurrPage.Update();
                        end
                        else
                            Error('Factory not assigned for the user.');


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

                field("Item Name"; rec."Item Name")
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
                        PurchRcpLineRec.SetRange("Document No.", rec.GRN);
                        //PurchRcpLineRec.SetRange("Color No.", "Color No");

                        IF PurchRcpLineRec.FindSet() THEN BEGIN
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
                                rec."No of Roll1" := 0;
                                CurrPage.Update();

                                ItemRec.Reset();
                                ItemRec.SetRange("No.", rec."Item No");
                                if ItemRec.FindSet() then begin
                                    rec."Item Name" := ItemRec.Description;
                                    rec."Color No" := ItemRec."Color No.";
                                    rec."Color Name" := ItemRec."Color Name";
                                end;

                                //Get No of rolls
                                ItemLedEntryRec.Reset();
                                ItemLedEntryRec.SetRange("Item No.", rec."Item No");
                                ItemLedEntryRec.SetRange("Document No.", rec.GRN);
                                //ItemLedEntryRec.SetFilter("Lot No.", '<>%1', '-');

                                if ItemLedEntryRec.FindSet() then begin
                                    repeat
                                        if ItemLedEntryRec."Lot No." <> '' then
                                            rec."No of Roll1" := rec."No of Roll1" + 1;
                                    //  rec."No of Roll1" := rec."No of Roll1" + ItemLedEntryRec."Remaining Quantity";
                                    until ItemLedEntryRec.Next() = 0;
                                end;

                                //Get Roll details
                                Get_Roll_details();

                                CurrPage.Update();
                            end;
                        END;
                    END;
                }

                field("Color Name"; rec."Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'Color';
                    Editable = false;

                    trigger OnValidate()
                    var
                        colorRec: Record Colour;
                    begin
                        colorRec.Reset();
                        colorRec.SetRange("Colour Name", rec."Color Name");
                        colorRec.FindSet();
                        rec."Color No" := colorRec."No.";
                    end;

                    // trigger OnLookup(var texts: text): Boolean
                    // var
                    //     PurchRcpLineRec: Record "Purch. Rcpt. Line";
                    //     Colour: Code[20];
                    //     colorRec: Record Colour;
                    // begin
                    //     PurchRcpLineRec.RESET;
                    //     PurchRcpLineRec.SetCurrentKey("Color No.");
                    //     PurchRcpLineRec.SetRange("Document No.", GRN);
                    //     PurchRcpLineRec.SetRange("No.", "Item No");

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

                field("No of Roll"; rec."No of Roll1")
                {
                    ApplicationArea = All;
                    Caption = 'No of Rolls';
                    Editable = false;
                }
            }

            group("Roll Details")
            {
                Editable = EditableGB;
                part(FabricProceListPart;
                FabricProceListPart)
                {
                    ApplicationArea = All;
                    Caption = 'Roll Details';
                    SubPageLink = "FabricProceNo." = FIELD("FabricProceNo."), "Color No" = field("Color No");
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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."FabricProce Nos.", xRec."FabricProceNo.", rec."FabricProceNo.") THEN BEGIN
            NoSeriesMngment.SetSeries(rec."FabricProceNo.");
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        FabricProLineRec: Record FabricProceLine;
        UserRec: Record "User Setup";
    begin

        //Done By sachith on 10/04/23
        UserRec.Reset();
        UserRec.Get(UserId);

        UserRec.Reset();
        UserRec.Get(UserId);
        if UserRec."Factory Code" <> '' then begin
            if (UserRec."Factory Code" <> rec."Factory Code") then
                Error('You are not authorized to delete this record.')
        end
        else
            Error('You are not authorized to delete records.');

        FabricProLineRec.reset();
        FabricProLineRec.SetRange("FabricProceNo.", rec."FabricProceNo.");
        if FabricProLineRec.FindSet() then
            FabricProLineRec.DeleteAll();
    end;

    procedure Get_Roll_details()
    var
        ItemLedEntryRec: Record "Item Ledger Entry";
        FabricProLineRec: Record FabricProceLine;
        Lineno: Integer;
    begin

        //Get Max line no
        FabricProLineRec.Reset();
        FabricProLineRec.SetRange("FabricProceNo.", rec."FabricProceNo.");

        if FabricProLineRec.FindLast() then
            Lineno := FabricProLineRec."Line No.";

        // //Deleet old records
        // FabricProLineRec.Reset();
        // FabricProLineRec.SetRange("FabricProceNo.", "FabricProceNo.");
        // if FabricProLineRec.FindSet() then
        //     FabricProLineRec.DeleteAll();


        //Get Rolldetails for the item and GRN
        ItemLedEntryRec.Reset();
        ItemLedEntryRec.SetRange("Item No.", rec."Item No");
        ItemLedEntryRec.SetRange("Document No.", rec.GRN);

        if ItemLedEntryRec.FindSet() then begin
            repeat
                FabricProLineRec.Reset();
                FabricProLineRec.SetRange("FabricProceNo.", rec."FabricProceNo.");
                FabricProLineRec.SetRange("Item No", rec."Item No");
                FabricProLineRec.SetRange("Roll No", ItemLedEntryRec."Lot No.");

                if not FabricProLineRec.FindSet() then begin

                    if ItemLedEntryRec."Lot No." <> '' then begin
                        Lineno += 1;
                        FabricProLineRec.Init();
                        FabricProLineRec."FabricProceNo." := rec."FabricProceNo.";
                        FabricProLineRec."Line No." := Lineno;
                        FabricProLineRec."Roll No" := ItemLedEntryRec."Lot No.";
                        FabricProLineRec.YDS := ItemLedEntryRec."Length Tag";
                        FabricProLineRec.Width := ItemLedEntryRec."Width Tag";
                        FabricProLineRec."Act. Legth" := ItemLedEntryRec."Length Act";
                        FabricProLineRec."Act. Width" := ItemLedEntryRec."Width Act";
                        FabricProLineRec.MFShade := ItemLedEntryRec.Shade;
                        FabricProLineRec."MFShade No" := ItemLedEntryRec."Shade No";
                        FabricProLineRec.Shade := ItemLedEntryRec.Shade;
                        FabricProLineRec."Shade No" := ItemLedEntryRec."Shade No";
                        FabricProLineRec.Status := FabricProLineRec.Status::Active;
                        FabricProLineRec."Item No" := rec."Item No";
                        FabricProLineRec."Item Name" := rec."Item Name";
                        FabricProLineRec.GRN := rec.GRN;
                        FabricProLineRec.Qty := ItemLedEntryRec."Remaining Quantity";
                        FabricProLineRec."Color Name" := rec."Color Name";
                        FabricProLineRec."Color No" := rec."Color No";
                        FabricProLineRec.Insert();
                    end;
                end;
            until ItemLedEntryRec.Next() = 0;
        end;
    end;

    trigger OnOpenPage()
    var
        UserRec: Record "User Setup";
    begin

        UserRec.Reset();
        UserRec.Get(UserId);

        if rec."Factory Code" <> '' then begin
            if (UserRec."Factory Code" <> '') then begin
                if (UserRec."Factory Code" = rec."Factory Code") then
                    EditableGB := true
                else
                    EditableGB := false;
            end
            else
                EditableGB := false;
        end
        else
            if (UserRec."Factory Code" = '') then begin
                Error('Factory not assigned for the user.');
                EditableGB := false;
            end
            else
                EditableGB := true;
    end;

    var
        EditableGB: Boolean;
}