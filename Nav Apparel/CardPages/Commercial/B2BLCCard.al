page 50522 "B2B LC Card"
{
    PageType = Card;
    SourceTable = "B2BLCMaster";

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
                    begin
                        CustomerRec.Reset();
                        CustomerRec.SetRange(Name, "Buyer");

                        if CustomerRec.FindSet() then
                            "Buyer No." := CustomerRec."No.";
                    end;
                }

                field("Beneficiary Name"; "Beneficiary Name")
                {
                    ApplicationArea = All;
                    Caption = 'Supplier';

                    trigger OnValidate()
                    var
                        VendorRec: Record Vendor;
                    begin
                        VendorRec.Reset();
                        VendorRec.SetRange(Name, "Beneficiary Name");
                        if VendorRec.FindSet() then
                            Beneficiary := VendorRec."No.";

                        CurrPage.Update();
                    end;
                }

                field("LC/Contract No."; "LC/Contract No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        "ContLCMasRec": Record "Contract/LCMaster";
                        PIDetMasterRec: Record "PI Details Header";
                        B2BRec: Record B2BLCMaster;
                    begin

                        if Beneficiary = '' then
                            Error('Select Beneficiary.');

                        PIDetMasterRec.Reset();
                        PIDetMasterRec.SetCurrentKey("Supplier No.");
                        PIDetMasterRec.SetRange("Supplier No.", Beneficiary);

                        if PIDetMasterRec.FindSet() then begin
                            repeat
                                PIDetMasterRec.B2BNo := "No.";
                                PIDetMasterRec.Modify();
                            until PIDetMasterRec.Next() = 0;
                        end;

                        ContLCMasRec.Reset();
                        ContLCMasRec.SetRange("Contract No", "LC/Contract No.");
                        if ContLCMasRec.FindSet() then begin
                            "LC Value" := ContLCMasRec."Contract Value";
                            "B2B LC Limit" := (ContLCMasRec."Contract Value" * ContLCMasRec.BBLC) / 100;
                        end;

                        //Calculate B2B LC opened  and %
                        B2BRec.Reset();
                        B2BRec.SetRange("LC/Contract No.", "LC/Contract No.");

                        if B2BRec.FindSet() then begin
                            repeat
                                "B2B LC Opened (Value)" += B2BRec."B2B LC Value";
                            until B2BRec.Next() = 0;

                            "B2B LC Opened (%)" := ("B2B LC Opened (Value)" / "LC Value") * 100;
                        end;

                        Balance := "B2B LC Limit" - "B2B LC Opened (Value)";

                    end;
                }

                field("B2B LC No"; "B2B LC No")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
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

                field("LC Value"; "LC Value")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("B2B LC Limit"; "B2B LC Limit")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("B2B LC Opened (Value)"; "B2B LC Opened (Value)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("B2B LC Opened (%)"; "B2B LC Opened (%)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Balance; Balance)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Opening Date"; "Opening Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        if format("Expiry Date") <> '' then
                            "B2B LC Duration (Days)" := "Expiry Date" - "Opening Date";
                    end;
                }

                field("Last Shipment Date"; "Last Shipment Date")
                {
                    ApplicationArea = All;
                }

                field("Expiry Date"; "Expiry Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        if format("Opening Date") <> '' then
                            "B2B LC Duration (Days)" := "Expiry Date" - "Opening Date";
                    end;
                }

                field("B2B LC Duration (Days)"; "B2B LC Duration (Days)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(AMD; AMD)
                {
                    ApplicationArea = All;
                }

                field("AMD Date"; "AMD Date")
                {
                    ApplicationArea = All;
                }
            }

            group(" ")
            {
                part("B2B PI ListPart1"; "B2B PI ListPart1")
                {
                    ApplicationArea = All;
                    Caption = 'Available PIs';
                    SubPageLink = "Supplier No." = FIELD(Beneficiary);
                }

                part("B2B PI ListPart2"; "B2B PI ListPart2")
                {
                    ApplicationArea = All;
                    Caption = 'Selected PIs';
                    SubPageLink = "B2BNo." = FIELD("No.");
                }
            }

            group("  ")
            {
                field("B2B LC Value"; "B2B LC Value")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Payment Terms (Days)"; "Payment Terms (Days)")
                {
                    ApplicationArea = All;
                    Caption = 'Payment Terms';

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

                field("Interest%"; "Interest%")
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
                            "LC Issue Bank No." := BankRec."No.";
                    end;
                }

                field("LC Receive Bank"; "LC Receive Bank")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        BankRec: Record "Bank Account";
                    begin
                        BankRec.Reset();
                        BankRec.SetRange(Name, "LC Receive Bank");
                        if BankRec.FindSet() then
                            "LC Receive Bank No." := BankRec."No.";
                    end;
                }

                field("Tolerence (%)"; "Tolerence (%)")
                {
                    ApplicationArea = All;
                }

                field("Bank Charges"; "Bank Charges")
                {
                    ApplicationArea = All;
                }

                field("B2B LC Status"; "B2B LC Status")
                {
                    ApplicationArea = All;
                }

                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    RowSpan = 10;
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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."B2BLC Nos.", xRec."No.", "No.") THEN BEGIN
            NoSeriesMngment.SetSeries("No.");
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        B2BLCPIRec: Record B2BLCPI;
    begin
        B2BLCPIRec.SetRange("B2BNo.", "No.");
        B2BLCPIRec.SetRange("B2BNo.", "No.");
        B2BLCPIRec.DeleteAll();
    end;


    trigger OnOpenPage()
    var
        // B2BRec: Record B2BLCMaster;
        B2B1Rec: Record B2BLCMaster;
        // "LC/ContractNo": Code[20];
        "Tot B2B LC Opened (Value)": Decimal;
    begin
        //Calculate B2B LC opened  and %
        // B2BRec.Reset();
        // B2BRec.SetRange("No.", "No.");
        // if B2BRec.FindSet() then begin
        // "LC/ContractNo" := B2BRec."LC/Contract No.";

        B2B1Rec.Reset();
        B2B1Rec.SetRange("LC/Contract No.", "LC/Contract No.");

        if B2B1Rec.FindSet() then begin
            repeat
                "Tot B2B LC Opened (Value)" += B2B1Rec."B2B LC Value";
            until B2B1Rec.Next() = 0;
        end;

        "B2B LC Opened (Value)" := "Tot B2B LC Opened (Value)";
        "B2B LC Opened (%)" := ("Tot B2B LC Opened (Value)" / "LC Value") * 100;
        Balance := "B2B LC Limit" - "Tot B2B LC Opened (Value)";
        CurrPage.Update();
        //end
    end;
}