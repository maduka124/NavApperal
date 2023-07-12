page 50996 "PI Details Card"
{
    PageType = Card;
    SourceTable = "PI Details Header";
    Caption = 'Proforma Invoice Details';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Doc No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field(Buyer; rec.Buyer)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        CustomerRec: Record Customer;
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin

                        CustomerRec.Reset();
                        CustomerRec.SetRange(Name, rec.Buyer);
                        if CustomerRec.FindSet() then
                            rec."Buyer No." := CustomerRec."No.";

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
                    end;
                }
                field("Style Filter"; Rec."Style Filter")
                {
                    ApplicationArea = All;
                }
                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';

                    trigger OnValidate()
                    var
                        PiPODetailsRec: Record PIPODetails1;
                        StyleMasterRec: Record "Style Master";
                        PurchHRec: Record "Purchase Header";
                        PurchHLineRe: Record "Purchase Line";
                        Line: BigInteger;
                    begin
                        StyleMasterRec.Reset();
                        StyleMasterRec.SetRange("Style No.", rec."Style Name");
                        if StyleMasterRec.FindSet() then begin
                            rec."Style No." := StyleMasterRec."No.";
                            rec."Season No." := StyleMasterRec."Season No.";
                            rec."Season Name" := StyleMasterRec."Season Name";
                            rec."Store No." := StyleMasterRec."Store No.";
                            rec."Store Name" := StyleMasterRec."Store Name";
                            rec.MerchantGrp := StyleMasterRec."Merchandizer Group Name"
                        end;



                    end;



                }
                field("Season Name"; rec."Season Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Season';
                }

                field("Store Name"; rec."Store Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Store';
                }

                field("Supplier Name"; rec."Supplier Name")
                {
                    ApplicationArea = All;
                    Caption = 'Supplier';

                    // trigger OnValidate()
                    // var
                    //     SupplierRec: Record Vendor;
                    // // PurchaseHeaderRec: Record "Purchase Header";
                    // begin



                    //     // SupplierRec.Reset();
                    //     // SupplierRec.SetRange(Name, rec."Supplier Name");
                    //     // if SupplierRec.FindSet() then
                    //     //     rec."Supplier No." := SupplierRec."No.";

                    //     // PurchaseHeaderRec.Reset();
                    //     // PurchaseHeaderRec.SetCurrentKey("Buy-from Vendor No.");
                    //     // PurchaseHeaderRec.SetRange("Buy-from Vendor No.", SupplierRec."No.");

                    //     // if PurchaseHeaderRec.FindSet() then begin
                    //     //     repeat
                    //     //         PurchaseHeaderRec."PI No." := rec."No.";
                    //     //         PurchaseHeaderRec.Modify();
                    //     //     until PurchaseHeaderRec.Next() = 0;
                    //     // end;
                    // end;

                    // trigger OnValidate()
                    // var
                    //     PiPODetailsRec: Record PIPODetails1;
                    //     StyleMasterRec: Record "Style Master";
                    //     PurchHRec: Record "Purchase Header";
                    //     PurchHLineRe: Record "Purchase Line";
                    //     Line: BigInteger;
                    // begin
                    // PiPODetailsRec.Reset();
                    // if PiPODetailsRec.FindLast() then begin
                    //     Line := PiPODetailsRec."Line No";
                    // end;
                    // if Rec."Style Filter" = true then begin
                    //     PurchHLineRe.Reset();
                    //     PurchHLineRe.SetRange(StyleNo, Rec."Style No.");
                    //     PurchHLineRe.SetRange("Document Type", PurchHLineRe."Document Type"::Order);
                    //     if PurchHLineRe.FindSet() then begin
                    //         repeat
                    //             PurchHRec.Reset();
                    //             PurchHRec.SetRange("No.", PurchHLineRe."Document No.");
                    //             PurchHRec.SetRange("Document Type", PurchHRec."Document Type"::Order);
                    //             if PurchHRec.FindSet() then begin
                    //                 repeat
                    //                     PiPODetailsRec.Reset();
                    //                     PiPODetailsRec.SetRange("PO No.", PurchHRec."No.");
                    //                     if not PiPODetailsRec.FindSet() then begin
                    //                         Line += 1;
                    //                         PiPODetailsRec.Init();
                    //                         PiPODetailsRec."Line No" := Line;
                    //                         PiPODetailsRec."Proforma Invoice No." := Rec."No.";
                    //                         PIPODetailsRec."PI No." := PurchHRec."PI No.";
                    //                         PIPODetailsRec."PO No." := PurchHRec."No.";
                    //                         PurchHRec.CalcFields("Amount Including VAT");
                    //                         PIPODetailsRec."PO Value" := PurchHRec."Amount Including VAT";
                    //                         PiPODetailsRec."Buy-from Vendor No." := PurchHRec."Buy-from Vendor No.";
                    //                         PiPODetailsRec."Merchandizer Group Name" := PurchHRec."Merchandizer Group Name";
                    //                         PIPODetailsRec."Created Date" := WorkDate();
                    //                         PIPODetailsRec."Created User" := UserId;
                    //                         PiPODetailsRec.Insert();
                    //                     end;
                    //                 until PurchHRec.Next() = 0;
                    //             end;
                    //         until PurchHLineRe.Next() = 0;
                    //     end;
                    // end
                    // else begin
                    //     PurchHLineRe.Reset();
                    //     PurchHLineRe.SetRange("Document Type", PurchHLineRe."Document Type"::Order);
                    //     if PurchHLineRe.FindSet() then begin
                    //         repeat
                    //             PurchHRec.Reset();
                    //             PurchHRec.SetRange("No.", PurchHLineRe."Document No.");
                    //             PurchHRec.SetRange("Document Type", PurchHRec."Document Type"::Order);
                    //             if PurchHRec.FindSet() then begin
                    //                 repeat
                    //                     PiPODetailsRec.Reset();
                    //                     PiPODetailsRec.SetRange("PO No.", PurchHRec."No.");
                    //                     if not PiPODetailsRec.FindSet() then begin
                    //                         Line += 1;
                    //                         PiPODetailsRec.Init();
                    //                         PiPODetailsRec."Line No" := Line;
                    //                         PiPODetailsRec."Proforma Invoice No." := Rec."No.";
                    //                         PIPODetailsRec."PI No." := PurchHRec."PI No.";
                    //                         PIPODetailsRec."PO No." := PurchHRec."No.";
                    //                         PurchHRec.CalcFields("Amount Including VAT");
                    //                         PIPODetailsRec."PO Value" := PurchHRec."Amount Including VAT";
                    //                         PiPODetailsRec."Buy-from Vendor No." := PurchHRec."Buy-from Vendor No.";
                    //                         PiPODetailsRec."Merchandizer Group Name" := PurchHRec."Merchandizer Group Name";
                    //                         PIPODetailsRec."Created Date" := WorkDate();
                    //                         PIPODetailsRec."Created User" := UserId;
                    //                         PiPODetailsRec.Insert();
                    //                     end;
                    //                 until PurchHRec.Next() = 0;
                    //             end;
                    //         until PurchHLineRe.Next() = 0;
                    //     end;
                    // end;
                    // end;

                    //Done By Sachith on 24/03/23
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        // GRNRec: Record "Purch. Rcpt. Line";
                        PipoRec2: Record "PI Po Details";
                        PiPODetailsRec: Record PIPODetails1;
                        StyleMasterRec: Record "Style Master";
                        PurchHRec: Record "Purchase Header";
                        PurchHLineRe: Record "Purchase Line";
                        Line: BigInteger;

                        SupplierRec: Record Vendor;
                        "Suplier No": Code[20];
                        PurchaseHeaderRec: Record "Purchase Header";
                        BOMAutogenRec: Record "BOM Line AutoGen";
                        BOMRec: Record bom;
                    begin
                        PipoRec2.Reset();
                        PipoRec2.SetRange("PI No.", Rec."No.");
                        if PipoRec2.FindSet() then begin
                            Error('Cannot Change Supplier');
                        end;

                        BOMRec.Reset();
                        BOMRec.SetRange("Style No.", Rec."Style No.");
                        if not BOMRec.FindSet() then
                            Error('Cannot find a BOM');


                        BOMAutogenRec.Reset();
                        BOMAutogenRec.SetCurrentKey("Supplier Name.");
                        BOMAutogenRec.Ascending(true);
                        BOMAutogenRec.SetRange("No.", BOMRec.No);

                        if BOMAutogenRec.FindSet() then begin
                            SupplierRec.Reset();
                            SupplierRec.Ascending(true);
                            SupplierRec.FindSet();
                            repeat

                                if "Suplier No" <> BOMAutogenRec."Supplier No." then begin
                                    "Suplier No" := BOMAutogenRec."Supplier No.";
                                    SupplierRec.FindFirst();
                                    repeat
                                        if BOMAutogenRec."Supplier No." = SupplierRec."No." then
                                            SupplierRec.MARK(TRUE);
                                    until SupplierRec.Next() = 0;
                                end;
                            until BOMAutogenRec.Next() = 0;
                        end;
                        SupplierRec.MarkedOnly(true);

                        if Page.RunModal(51274, SupplierRec) = Action::LookupOK then begin
                            Rec."Supplier Name" := SupplierRec.Name;
                            Rec."Supplier No." := SupplierRec."No.";

                            PurchaseHeaderRec.Reset();
                            PurchaseHeaderRec.SetCurrentKey("Buy-from Vendor No.");
                            PurchaseHeaderRec.SetRange("Buy-from Vendor No.", SupplierRec."No.");

                            if PurchaseHeaderRec.FindSet() then begin
                                repeat
                                    PurchaseHeaderRec."PI No." := rec."No.";
                                    PurchaseHeaderRec.Modify();
                                until PurchaseHeaderRec.Next() = 0;
                            end;

                            PurchaseHeaderRec.Reset();
                            PurchaseHeaderRec.SetCurrentKey("Buy-from Vendor No.");
                            PurchaseHeaderRec.SetRange("Buy-from Vendor No.", SupplierRec."No.");
                            if PurchaseHeaderRec.FindSet() then begin
                                repeat
                                    PurchaseHeaderRec."PI No." := rec."No.";
                                    PurchaseHeaderRec.Modify();
                                until PurchaseHeaderRec.Next() = 0;
                            end;
                        end;

                        PiPODetailsRec.Reset();
                        if PiPODetailsRec.FindLast() then begin
                            Line := PiPODetailsRec."Line No";
                        end;

                        if Rec."Style Filter" = true then begin

                            // PiPODetailsRec.Reset();
                            // if PiPODetailsRec.FindSet() then begin
                            //     PiPODetailsRec.DeleteAll();
                            // end;

                            PurchHLineRe.Reset();
                            PurchHLineRe.SetRange(StyleNo, Rec."Style No.");
                            PurchHLineRe.SetRange("Document Type", PurchHLineRe."Document Type"::Order);
                            if PurchHLineRe.FindSet() then begin
                                repeat
                                    PurchHRec.Reset();
                                    PurchHRec.SetRange("No.", PurchHLineRe."Document No.");
                                    PurchHRec.SetRange("Document Type", PurchHRec."Document Type"::Order);
                                    if PurchHRec.FindSet() then begin
                                        repeat
                                            // PipoRec2.Reset();
                                            // PipoRec2.SetRange("PO No.", PiPODetailsRec."PO No.");
                                            // if not PipoRec2.FindSet() then begin

                                            PiPODetailsRec.Reset();
                                            PiPODetailsRec.SetRange("PO No.", PurchHRec."No.");
                                            if not PiPODetailsRec.FindSet() then begin
                                                Line += 1;
                                                PiPODetailsRec.Init();
                                                PiPODetailsRec."Line No" := Line;
                                                PiPODetailsRec."Proforma Invoice No." := Rec."No.";
                                                PiPODetailsRec.Status := PurchHRec.Status;
                                                PIPODetailsRec."PI No." := PurchHRec."PI No.";
                                                PIPODetailsRec."PO No." := PurchHRec."No.";
                                                PurchHRec.CalcFields("Amount Including VAT");
                                                PIPODetailsRec."PO Value" := PurchHRec."Amount Including VAT";
                                                PiPODetailsRec."Buy-from Vendor No." := PurchHRec."Buy-from Vendor No.";
                                                PiPODetailsRec."Merchandizer Group Name" := PurchHRec."Merchandizer Group Name";
                                                PIPODetailsRec."Created Date" := WorkDate();
                                                PIPODetailsRec."Created User" := UserId;
                                                PiPODetailsRec.Insert();
                                            end;
                                        // end;
                                        until PurchHRec.Next() = 0;
                                    end;
                                until PurchHLineRe.Next() = 0;


                                PiPODetailsRec.Reset();
                                PiPODetailsRec.SetRange("Proforma Invoice No.", Rec."No.");
                                if PiPODetailsRec.FindSet() then begin
                                    PipoRec2.Reset();
                                    PipoRec2.SetRange("PO No.", PiPODetailsRec."PO No.");
                                    if PipoRec2.FindSet() then begin
                                        PiPODetailsRec.DeleteAll();
                                    end;
                                    CurrPage.Update();
                                end;

                            end;
                        end
                        else begin
                            PurchHLineRe.Reset();
                            PurchHLineRe.SetRange("Document Type", PurchHLineRe."Document Type"::Order);
                            if PurchHLineRe.FindSet() then begin
                                repeat
                                    PurchHRec.Reset();
                                    PurchHRec.SetRange("No.", PurchHLineRe."Document No.");
                                    PurchHRec.SetRange("Document Type", PurchHRec."Document Type"::Order);
                                    if PurchHRec.FindSet() then begin
                                        repeat
                                            // PipoRec2.Reset();
                                            // PipoRec2.SetRange("PO No.", PurchHRec."No.");
                                            // if not PipoRec2.FindSet() then begin

                                            PiPODetailsRec.Reset();
                                            PiPODetailsRec.SetRange("PO No.", PurchHRec."No.");
                                            if not PiPODetailsRec.FindSet() then begin
                                                Line += 1;
                                                PiPODetailsRec.Init();
                                                PiPODetailsRec."Line No" := Line;
                                                PiPODetailsRec."Proforma Invoice No." := Rec."No.";
                                                PiPODetailsRec.Status := PurchHRec.Status;
                                                PIPODetailsRec."PI No." := PurchHRec."PI No.";
                                                PIPODetailsRec."PO No." := PurchHRec."No.";
                                                PurchHRec.CalcFields("Amount Including VAT");
                                                PIPODetailsRec."PO Value" := PurchHRec."Amount Including VAT";
                                                PiPODetailsRec."Buy-from Vendor No." := PurchHRec."Buy-from Vendor No.";
                                                PiPODetailsRec."Merchandizer Group Name" := PurchHRec."Merchandizer Group Name";
                                                PIPODetailsRec."Created Date" := WorkDate();
                                                PIPODetailsRec."Created User" := UserId;
                                                PiPODetailsRec.Insert();
                                            end;
                                        // end;
                                        until PurchHRec.Next() = 0;
                                    end;
                                until PurchHLineRe.Next() = 0;

                                PiPODetailsRec.Reset();
                                PiPODetailsRec.SetRange("Proforma Invoice No.", Rec."No.");
                                if PiPODetailsRec.FindSet() then begin
                                    PipoRec2.Reset();
                                    PipoRec2.SetRange("PO No.", PiPODetailsRec."PO No.");
                                    if PipoRec2.FindSet() then begin
                                        PiPODetailsRec.DeleteAll();
                                    end;
                                    CurrPage.Update();
                                end;
                            end;
                        end;
                    end;
                }

                field("PI No"; rec."PI No")
                {
                    ApplicationArea = All;
                }

                field("PI Date"; rec."PI Date")
                {
                    ApplicationArea = All;
                }

                field("PI Value"; rec."PI Value")
                {
                    ApplicationArea = All;

                    // trigger OnValidate()
                    // var
                    // begin
                    //     if rec."PO Total" <> rec."PI Value" then
                    //         Error('Total PO value and PI value does not match.');
                    // end;
                }

                field("Payment Mode Name"; rec."Payment Mode Name")
                {
                    ApplicationArea = All;
                    Caption = 'Payment Mode';

                    trigger OnValidate()
                    var
                        PaymentMethodRec: Record "Payment Method";
                    begin

                        PaymentMethodRec.Reset();
                        PaymentMethodRec.SetRange(Description, rec."Payment Mode Name");
                        if PaymentMethodRec.FindSet() then
                            rec."Payment Mode" := PaymentMethodRec.Code;
                    end;


                }

                field("Shipment Date"; rec."Shipment Date")
                {
                    ApplicationArea = All;
                }

                field(Currency; rec.Currency)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        CurrencyRec: Record Currency;
                    begin
                        CurrencyRec.Reset();
                        CurrencyRec.SetRange(Description, rec.Currency);
                        if CurrencyRec.FindSet() then
                            rec."Currency Code" := CurrencyRec.Code;
                    end;
                }

                field("PO Total"; rec."PO Total")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

            }

            group("PO Details")
            {
                // part("PI Po Details ListPart 1"; "PI Po Details ListPart 1")
                part("PI Po Details ListPart 1"; "PI Po Details ListPart 1 New")
                {
                    ApplicationArea = All;
                    Caption = 'All POs Awaiting PI';
                    SubPageLink = "Buy-from Vendor No." = FIELD("Supplier No."), "Merchandizer Group Name" = field(MerchantGrp), "Proforma Invoice No." = field("No.");
                }

                part("PI Po Details ListPart 2"; "PI Po Details ListPart 2")
                {
                    ApplicationArea = All;
                    Caption = 'POs attached to PI';
                    SubPageLink = "PI No." = FIELD("No.");
                }
            }

            group("PI Item Details")
            {
                part("PI Po Item Details ListPart"; "PI Po Item Details ListPart")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "PI No." = FIELD("No.");
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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."PI Nos.", xRec."No.", rec."No.") THEN BEGIN
            NoSeriesMngment.SetSeries(rec."No.");
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        Pipodetails1Rec: Record PIPODetails1;
        PIDetailHRec: Record "PI Details Header";
        PurchaseHeadRec: Record "Purchase Header";
        PIPoDetailsRec: Record "PI Po Details";
        PIPoItemsDetailsRec: Record "PI Po Item Details";
    begin
        // Pipodetails1Rec.Reset();
        // if Pipodetails1Rec.FindSet() then begin
        //     Pipodetails1Rec.DeleteAll();
        // end;
        // PipoRec.Reset();
        // if PipoRec.FindSet() then begin
        //     PipoRec.DeleteAll();
        // end;

        // PIPoDetailsRec.Reset();
        // if PIPoDetailsRec.FindSet() then begin
        //     PIPoDetailsRec.DeleteAll();
        // end;

        PIDetailHRec.Reset();
        PIDetailHRec.SetRange("No.", Rec."No.");
        if PIDetailHRec.FindSet() then begin
            if PIDetailHRec.AssignedB2BNo <> '' then
                Error('This Record Cannot be delete.Record Assigned to the B2BLC');
        end;

        PurchaseHeadRec.Reset();
        PurchaseHeadRec.SetRange("PI No.", Rec."No.");
        if PurchaseHeadRec.FindSet() then begin
            repeat
                PurchaseHeadRec."Assigned PI No." := '';
                PurchaseHeadRec.Modify();
            until PurchaseHeadRec.Next() = 0;

            //Mihiranga 2023/07/26
            PIPoDetailsRec.Reset();
            PIPoDetailsRec.SetRange("PI No.", PurchaseHeadRec."PI No.");
            if PIPoDetailsRec.FindSet() then begin
                repeat
                    PIPoDetailsRec.DeleteAll();
                until PIPoDetailsRec.Next() = 0;
            end;
        end;


        PIPoDetailsRec.Reset();
        PIPoDetailsRec.SetRange("PI No.", rec."No.");
        if PIPoDetailsRec.FindSet() then begin
            repeat
                PIPoDetailsRec.DeleteAll();
            until PIPoDetailsRec.Next() = 0;
        end;

        PIPoItemsDetailsRec.SetRange("PI No.", rec."PI No");
        PIPoItemsDetailsRec.DeleteAll();

    end;



    trigger OnOpenPage()
    var
        PurchaseHeaderRec: Record "Purchase Header";
    begin
        if rec."Supplier No." <> '' then begin
            PurchaseHeaderRec.Reset();
            PurchaseHeaderRec.SetCurrentKey("Buy-from Vendor No.");
            PurchaseHeaderRec.SetRange("Buy-from Vendor No.", rec."Supplier No.");

            if PurchaseHeaderRec.FindSet() then begin
                repeat
                    PurchaseHeaderRec."PI No." := rec."No.";
                    PurchaseHeaderRec.Modify();
                until PurchaseHeaderRec.Next() = 0;
            end;
        end;


    end;


    trigger OnAfterGetCurrRecord()
    var
        PurchaseHeaderRec: Record "Purchase Header";
    begin
        if rec."Supplier No." <> '' then begin
            PurchaseHeaderRec.Reset();
            PurchaseHeaderRec.SetCurrentKey("Buy-from Vendor No.");
            PurchaseHeaderRec.SetRange("Buy-from Vendor No.", rec."Supplier No.");

            if PurchaseHeaderRec.FindSet() then begin
                repeat
                    PurchaseHeaderRec."PI No." := rec."No.";
                    PurchaseHeaderRec.Modify();
                until PurchaseHeaderRec.Next() = 0;
            end;
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var

    begin
        Rec.Validate("Payment Mode Name", 'Letter of Credit');
        Rec.Validate(Currency, 'United States Dollars');
    end;

    trigger OnClosePage()
    var
    begin
        if rec."PO Total" <> rec."PI Value" then
            Error('Total PO value and PI value does not match.');
    end;

    var
        PipoRec: Record PIPODetails1;

}