page 71012788 "PI Details Card"
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

                    trigger OnValidate()
                    var
                        SupplierRec: Record Vendor;
                        PurchaseHeaderRec: Record "Purchase Header";
                    begin

                        SupplierRec.Reset();
                        SupplierRec.SetRange(Name, rec."Supplier Name");
                        if SupplierRec.FindSet() then
                            rec."Supplier No." := SupplierRec."No.";

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

                    trigger OnValidate()
                    var
                    begin
                        if rec."PO Total" <> rec."PI Value" then
                            Error('Total PO value and PI value does not match.');
                    end;
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

            group(" ")
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

            group("  ")
            {
                part("PI Po Item Details ListPart"; "PI Po Item Details ListPart")
                {
                    ApplicationArea = All;
                    Caption = 'PI Item Details';
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


    trigger OnClosePage()
    var

    begin
        if rec."PO Total" <> rec."PI Value" then
            Error('Total PO value and PI value does not match.');

    end;

}