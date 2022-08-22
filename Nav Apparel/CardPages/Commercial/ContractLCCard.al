page 50502 "Contract/LC Card"
{
    PageType = Card;
    SourceTable = "Contract/LCMaster";
    Caption = 'Contract LC Master';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field(Buyer; Buyer)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        CustomerRec: Record Customer;
                        "StyleRec": Record "Style Master";
                    begin

                        CustomerRec.Reset();
                        CustomerRec.SetRange(Name, Buyer);
                        if CustomerRec.FindSet() then
                            "Buyer No." := CustomerRec."No.";

                        StyleRec.Reset();
                        StyleRec.SetCurrentKey("Buyer No.");
                        StyleRec.SetRange("Buyer No.", CustomerRec."No.");

                        if StyleRec.FindSet() then begin
                            repeat
                                StyleRec.ContractNo := "No.";
                                StyleRec.Modify();
                            until StyleRec.Next() = 0;
                        end;
                    end;
                }

                field(Season; Season)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        SeasonsRec: Record Seasons;
                    begin
                        SeasonsRec.Reset();
                        SeasonsRec.SetRange("Season Name", "Season");

                        if SeasonsRec.FindSet() then
                            "Season No." := SeasonsRec."No.";
                    end;
                }

                field("Factory"; "Factory")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        LocationRec: Record Location;
                    begin
                        LocationRec.Reset();
                        LocationRec.SetRange(Name, "Factory");
                        if LocationRec.FindSet() then
                            "Factory No." := LocationRec."code";
                    end;
                }

                field("Contract No"; "Contract No")
                {
                    ApplicationArea = All;
                }

                field(AMD; AMD)
                {
                    ApplicationArea = All;
                }

                field("Issue Bank"; "Issue Bank")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        BankRec: Record "Bank Account";
                    begin
                        BankRec.Reset();
                        BankRec.SetRange(Name, "Issue Bank");
                        if BankRec.FindSet() then
                            "Issue Bank No." := BankRec."No.";
                    end;
                }

                field("Receive Bank"; "Receive Bank")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        BankRec: Record "Bank Account";
                    begin
                        BankRec.Reset();
                        BankRec.SetRange(Name, "Receive Bank");
                        if BankRec.FindSet() then
                            "Receive Bank No." := BankRec."No.";
                    end;
                }

                field("Nego Bank"; "Nego Bank")
                {
                    ApplicationArea = All;
                    Caption = 'Negotiation Bank';

                    trigger OnValidate()
                    var
                        BankRec: Record "Bank Account";
                    begin
                        BankRec.Reset();
                        BankRec.SetRange(Name, "Nego Bank");
                        if BankRec.FindSet() then
                            "Nego Bank No." := BankRec."No.";
                    end;
                }

                field(BBLC; BBLC)
                {
                    ApplicationArea = All;
                    Caption = 'BBLC %';
                }

                field("B2B Payment Type"; "B2B Payment Type")
                {
                    ApplicationArea = All;
                    Caption = 'B2B Payment Type';

                    trigger OnValidate()
                    var
                        PaymentRec: Record "Payment Method";
                    begin
                        PaymentRec.Reset();
                        PaymentRec.SetRange(Description, "B2B Payment Type");
                        if PaymentRec.FindSet() then
                            "B2B Payment Type No." := PaymentRec.Code;
                    end;
                }

                field("Shipment Mode"; "Shipment Mode")
                {
                    ApplicationArea = All;
                }

                field("Opening Date"; "Opening Date")
                {
                    ApplicationArea = All;
                }

                field("Amend Date"; "Amend Date")
                {
                    ApplicationArea = All;
                }

                field("Last Shipment Date"; "Last Shipment Date")
                {
                    ApplicationArea = All;
                }

                field("Expiry Date"; "Expiry Date")
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
                            "Currency No." := CurrencyRec.Code;
                    end;
                }

                field("UD No"; "UD No")
                {
                    ApplicationArea = All;
                }

                field("UD Version"; "UD Version")
                {
                    ApplicationArea = All;
                }

                field("Freight Value"; "Freight Value")
                {
                    ApplicationArea = All;
                }

                field("Insurance Value"; "Insurance Value")
                {
                    ApplicationArea = All;
                }

                field("Partial Shipment"; "Partial Shipment")
                {
                    ApplicationArea = All;
                }

                field("Payment Terms (Days)"; "Payment Terms (Days)")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        PaymentTermsRec: Record "Payment Terms";
                    begin
                        PaymentTermsRec.Reset();
                        PaymentTermsRec.SetRange(Description, "Payment Terms (Days)");
                        if PaymentTermsRec.FindSet() then
                            "Payment Terms (Days) No." := PaymentTermsRec.Code;
                    end;
                }

                field("Status of LC"; "Status of LC")
                {
                    ApplicationArea = All;
                }

                field("File No"; "File No")
                {
                    ApplicationArea = All;
                }
            }

            group(" ")
            {
                part("Style Master Contract ListPart"; "Style Master Contract ListPart")
                {
                    ApplicationArea = All;
                    Caption = 'Available Styles';
                    SubPageLink = "ContractNo" = FIELD("No.");
                }

                part("StyleMasterContract ListPart 2"; "StyleMasterContract ListPart 2")
                {
                    ApplicationArea = All;
                    Caption = 'Selected Styles';
                    SubPageLink = "No." = FIELD("No.");
                }
            }

            group("  ")
            {
                field("Quantity (Pcs)"; "Quantity (Pcs)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Contract Value"; "Contract Value")
                {
                    ApplicationArea = All;
                }

                field("Auto Calculate Value"; "Auto Calculate Value")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group("   ")
            {
                part("Contract Commision ListPart"; "Contract Commision ListPart")
                {
                    ApplicationArea = All;
                    Caption = 'Contract Commision';
                    SubPageLink = "No." = FIELD("No.");
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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."ContractLC Nos.", xRec."No.", "No.") THEN BEGIN
            NoSeriesMngment.SetSeries("No.");
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        "Contract/LCMasterRec": Record "Contract/LCMaster";
        "Contract/LCStyleRec": Record "Contract/LCStyle";
        "Contract CommisionRec": Record "Contract Commision";
    begin
        "Contract/LCMasterRec".SetRange("No.", "No.");
        "Contract/LCMasterRec".DeleteAll();

        "Contract/LCStyleRec".SetRange("No.", "No.");
        "Contract/LCStyleRec".DeleteAll();

        "Contract CommisionRec".SetRange("No.", "No.");
        "Contract CommisionRec".DeleteAll();
    end;



}