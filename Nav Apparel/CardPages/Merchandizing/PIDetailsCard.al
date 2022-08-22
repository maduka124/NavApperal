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
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Doc No';

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

                    trigger OnValidate()
                    var
                        StyleMasterRec: Record "Style Master";
                    begin
                        StyleMasterRec.Reset();
                        StyleMasterRec.SetRange("Style No.", "Style Name");
                        if StyleMasterRec.FindSet() then begin

                            "Style No." := StyleMasterRec."No.";
                            "Season No." := StyleMasterRec."Season No.";
                            "Season Name" := StyleMasterRec."Season Name";
                            "Store No." := StyleMasterRec."Store No.";
                            "Store Name" := StyleMasterRec."Store Name";
                        end;
                    end;
                }

                field("Season Name"; "Season Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Season';
                }

                field("Store Name"; "Store Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Store';
                }

                field("Supplier Name"; "Supplier Name")
                {
                    ApplicationArea = All;
                    Caption = 'Supplier';

                    trigger OnValidate()
                    var
                        SupplierRec: Record Vendor;
                        PurchaseHeaderRec: Record "Purchase Header";
                    begin

                        SupplierRec.Reset();
                        SupplierRec.SetRange(Name, "Supplier Name");
                        if SupplierRec.FindSet() then
                            "Supplier No." := SupplierRec."No.";

                        PurchaseHeaderRec.Reset();
                        PurchaseHeaderRec.SetCurrentKey("Buy-from Vendor No.");
                        PurchaseHeaderRec.SetRange("Buy-from Vendor No.", SupplierRec."No.");

                        if PurchaseHeaderRec.FindSet() then begin
                            repeat
                                PurchaseHeaderRec."PI No." := "No.";
                                PurchaseHeaderRec.Modify();
                            until PurchaseHeaderRec.Next() = 0;
                        end;
                    end;
                }

                field("PI No"; "PI No")
                {
                    ApplicationArea = All;
                }

                field("PI Date"; "PI Date")
                {
                    ApplicationArea = All;
                }

                field("PI Value"; "PI Value")
                {
                    ApplicationArea = All;
                }

                field("Payment Mode Name"; "Payment Mode Name")
                {
                    ApplicationArea = All;
                    Caption = 'Payment Mode';

                    trigger OnValidate()
                    var
                        PaymentMethodRec: Record "Payment Method";
                    begin
                        PaymentMethodRec.Reset();
                        PaymentMethodRec.SetRange(Description, "Payment Mode Name");
                        if PaymentMethodRec.FindSet() then
                            "Payment Mode" := PaymentMethodRec.Code;
                    end;
                }

                field("Shipment Date"; "Shipment Date")
                {
                    ApplicationArea = All;
                }

                field(Currency; Currency)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        CurrencyRec: Record Currency;
                    begin
                        CurrencyRec.Reset();
                        CurrencyRec.SetRange(Description, Currency);
                        if CurrencyRec.FindSet() then
                            "Currency Code" := CurrencyRec.Code;
                    end;
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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."PI Nos.", xRec."No.", "No.") THEN BEGIN
            NoSeriesMngment.SetSeries("No.");
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        PIPoDetailsRec: Record "PI Po Details";
        PIPoItemsDetailsRec: Record "PI Po Item Details";
    begin
        PIPoDetailsRec.SetRange("PI No.", "PI No");
        PIPoDetailsRec.DeleteAll();

        PIPoItemsDetailsRec.SetRange("PI No.", "PI No");
        PIPoItemsDetailsRec.DeleteAll();
    end;
}