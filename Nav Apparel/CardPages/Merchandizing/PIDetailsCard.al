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

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';

                    trigger OnValidate()
                    var
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                        StyleMasterRec: Record "Style Master";
                    begin
                        StyleMasterRec.Reset();
                        StyleMasterRec.SetRange("Style No.", rec."Style Name");
                        if StyleMasterRec.FindSet() then begin

                            rec."Style No." := StyleMasterRec."No.";
                            rec."Season No." := StyleMasterRec."Season No.";
                            rec."Season Name" := StyleMasterRec."Season Name";
                            rec."Store No." := StyleMasterRec."Store No.";
                            rec."Store Name" := StyleMasterRec."Store Name";
                        end;


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

                    //Done By Sachith on 24/03/23
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        // GRNRec: Record "Purch. Rcpt. Line";
                        SupplierRec: Record Vendor;
                        "Suplier No": Code[20];
                        PurchaseHeaderRec: Record "Purchase Header";
                        BOMAutogenRec: Record "BOM Line AutoGen";
                        BOMRec: Record bom;
                    begin

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
                part("PI Po Details ListPart 1"; "PI Po Details ListPart 1")
                {
                    ApplicationArea = All;
                    Caption = 'All POs Awaiting PI';
                    SubPageLink = "Buy-from Vendor No." = FIELD("Supplier No.");
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
        PIPoDetailsRec: Record "PI Po Details";
        PIPoItemsDetailsRec: Record "PI Po Item Details";
    begin
        PIPoDetailsRec.SetRange("PI No.", rec."PI No");
        PIPoDetailsRec.DeleteAll();

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

}