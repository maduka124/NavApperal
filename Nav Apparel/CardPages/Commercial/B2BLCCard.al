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
                field("No."; rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field(Buyer; rec.Buyer)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        CustomerRec: Record Customer;
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin
                        CustomerRec.Reset();
                        CustomerRec.SetRange(Name, rec."Buyer");

                        if CustomerRec.FindSet() then
                            rec."Buyer No." := CustomerRec."No."
                        else
                            Error('Invalid Buyer');

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

                field("Beneficiary Name"; rec."Beneficiary Name")
                {
                    ApplicationArea = All;
                    Caption = 'Supplier';

                    trigger OnValidate()
                    var
                        VendorRec: Record Vendor;
                    begin
                        VendorRec.Reset();
                        VendorRec.SetRange(Name, rec."Beneficiary Name");
                        if VendorRec.FindSet() then
                            rec.Beneficiary := VendorRec."No."
                        else
                            Error('Invalid Beneficiary');

                        CurrPage.Update();
                    end;
                }

                field(LCContractNo; rec.LCContractNo)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        "ContLCMasRec": Record "Contract/LCMaster";
                        PIDetMasterRec: Record "PI Details Header";
                        B2BRec: Record B2BLCMaster;
                    begin

                        rec."LC/Contract No." := rec.LCContractNo;

                        if rec.Beneficiary = '' then
                            Error('Select Beneficiary.');

                        PIDetMasterRec.Reset();
                        PIDetMasterRec.SetCurrentKey("Supplier No.");
                        PIDetMasterRec.SetRange("Supplier No.", rec.Beneficiary);

                        if PIDetMasterRec.FindSet() then begin
                            repeat
                                PIDetMasterRec.B2BNo := rec."No.";
                                PIDetMasterRec.Modify();
                            until PIDetMasterRec.Next() = 0;
                        end;

                        ContLCMasRec.Reset();
                        ContLCMasRec.SetRange("Contract No", rec.LCContractNo);
                        if ContLCMasRec.FindSet() then begin
                            rec."LC Value" := ContLCMasRec."Contract Value";
                            rec."B2B LC Limit" := (ContLCMasRec."Contract Value" * ContLCMasRec.BBLC) / 100;
                        end;

                        //Calculate B2B LC opened  and %
                        B2BRec.Reset();
                        B2BRec.SetRange("LC/Contract No.", rec."LC/Contract No.");

                        if B2BRec.FindSet() then begin
                            repeat
                                rec."B2B LC Opened (Value)" += B2BRec."B2B LC Value";
                            until B2BRec.Next() = 0;

                            rec."B2B LC Opened (%)" := (rec."B2B LC Opened (Value)" / rec."LC Value") * 100;
                        end;

                        rec.Balance := rec."B2B LC Limit" - rec."B2B LC Opened (Value)";

                    end;
                }


                field("LC/Contract No."; rec."LC/Contract No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Visible = false;
                }

                field("B2B LC No"; rec."B2B LC No")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field(Season; rec.Season)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        SeasonsRec: Record Seasons;
                    begin
                        SeasonsRec.Reset();
                        SeasonsRec.SetRange("Season Name", rec."Season");
                        if SeasonsRec.FindSet() then
                            rec."Season No." := SeasonsRec."No."
                        else
                            Error('Invalid Season');
                    end;
                }

                field("LC Value"; rec."LC Value")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("B2B LC Limit"; rec."B2B LC Limit")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("B2B LC Opened (Value)"; rec."B2B LC Opened (Value)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("B2B LC Opened (%)"; rec."B2B LC Opened (%)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Balance; rec.Balance)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Opening Date"; rec."Opening Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        if format(rec."Expiry Date") <> '' then
                            rec."B2B LC Duration (Days)" := rec."Expiry Date" - rec."Opening Date";
                    end;
                }

                field("Last Shipment Date"; rec."Last Shipment Date")
                {
                    ApplicationArea = All;
                }

                field("Expiry Date"; rec."Expiry Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        if format(rec."Opening Date") <> '' then
                            rec."B2B LC Duration (Days)" := rec."Expiry Date" - rec."Opening Date";
                    end;
                }

                field("B2B LC Duration (Days)"; rec."B2B LC Duration (Days)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(AMD; rec.AMD)
                {
                    ApplicationArea = All;
                }

                field("AMD Date"; rec."AMD Date")
                {
                    ApplicationArea = All;
                }

                field("Global Dimension Code"; rec."Global Dimension Code")
                {
                    ApplicationArea = All;
                    //ShowMandatory = true;
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

            group("Bank Details")
            {
                field("B2B LC Value"; rec."B2B LC Value")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Payment Terms (Days)"; rec."Payment Terms (Days)")
                {
                    ApplicationArea = All;
                    Caption = 'Payment Terms';

                    trigger OnValidate()
                    var
                        PaymentTermsRec: Record "Payment Terms";
                    begin
                        PaymentTermsRec.Reset();
                        PaymentTermsRec.SetRange(Description, rec."Payment Terms (Days)");
                        if PaymentTermsRec.FindSet() then
                            rec."Payment Terms (Days) No." := PaymentTermsRec.Code;
                    end;
                }

                field("Interest%"; rec."Interest%")
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
                            rec."Currency No." := CurrencyRec.Code;
                    end;
                }

                field("Issue Bank"; rec."Issue Bank")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        BankRec: Record "Bank Account";
                    begin
                        BankRec.Reset();
                        BankRec.SetRange(Name, rec."Issue Bank");
                        if BankRec.FindSet() then
                            rec."LC Issue Bank No." := BankRec."No."
                        else
                            Error('Invalid Issue Bank');
                    end;
                }

                field("LC Receive Bank"; rec."LC Receive Bank")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        BankRec: Record "Bank Account";
                    begin
                        BankRec.Reset();
                        BankRec.SetRange(Name, rec."LC Receive Bank");
                        if BankRec.FindSet() then
                            rec."LC Receive Bank No." := BankRec."No."
                        else
                            Error('Invalid Receive Bank');
                    end;
                }

                field("Tolerence (%)"; rec."Tolerence (%)")
                {
                    ApplicationArea = All;
                }

                field("Bank Charges"; rec."Bank Charges")
                {
                    ApplicationArea = All;
                }

                field("B2B LC Status"; rec."B2B LC Status")
                {
                    ApplicationArea = All;
                }

                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    RowSpan = 10;
                }
            }

            part("Other Chargers"; "Other Charges")
            {
                ApplicationArea = All;
                Caption = 'Bank / Other Chargers';
                SubPageLink = "Document No." = field("No.");
            }
        }
    }

    actions
    {
        area(Creation)
        {
            action("Process Item Charge")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = IssueFinanceCharge;
                trigger OnAction()
                var
                    CustMangemnt: Codeunit "Customization Management";
                begin
                    if Confirm('Do you want to process the Item Charges?', true) then
                        CustMangemnt.CreateItemChargeEntry(Rec);
                end;
            }
        }
    }


    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."B2BLC Nos.", xRec."No.", rec."No.") THEN BEGIN
            NoSeriesMngment.SetSeries(rec."No.");
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        B2BLCPIRec: Record B2BLCPI;
    begin
        B2BLCPIRec.SetRange("B2BNo.", rec."No.");
        B2BLCPIRec.SetRange("B2BNo.", rec."No.");
        B2BLCPIRec.DeleteAll();
    end;


    trigger OnOpenPage()
    var
        // B2BRec: Record B2BLCMaster;
        B2B1Rec: Record B2BLCMaster;
        // "LC/ContractNo": Code[20];
        "Tot B2B LC Opened (Value)": Decimal;
        PIDetMasterRec: Record "PI Details Header";
    begin
        //Calculate B2B LC opened  and %
        // B2BRec.Reset();
        // B2BRec.SetRange("No.", "No.");
        // if B2BRec.FindSet() then begin
        // "LC/ContractNo" := B2BRec."LC/Contract No.";

        if rec.Beneficiary <> '' then begin
            PIDetMasterRec.Reset();
            PIDetMasterRec.SetCurrentKey("Supplier No.");
            PIDetMasterRec.SetRange("Supplier No.", rec.Beneficiary);

            if PIDetMasterRec.FindSet() then begin
                repeat
                    PIDetMasterRec.B2BNo := rec."No.";
                    PIDetMasterRec.Modify();
                until PIDetMasterRec.Next() = 0;
            end;
        end;

        B2B1Rec.Reset();
        B2B1Rec.SetRange("LC/Contract No.", rec."LC/Contract No.");

        if B2B1Rec.FindSet() then begin
            repeat
                "Tot B2B LC Opened (Value)" += B2B1Rec."B2B LC Value";
            until B2B1Rec.Next() = 0;
        end;

        rec."B2B LC Opened (Value)" := "Tot B2B LC Opened (Value)";
        if rec."LC Value" > 0 then
            rec."B2B LC Opened (%)" := ("Tot B2B LC Opened (Value)" / rec."LC Value") * 100;
        rec.Balance := rec."B2B LC Limit" - "Tot B2B LC Opened (Value)";
        CurrPage.Update();
        //end
    end;


    trigger OnAfterGetCurrRecord()
    var
        PIDetMasterRec: Record "PI Details Header";
    begin

        if rec.Beneficiary <> '' then begin
            PIDetMasterRec.Reset();
            PIDetMasterRec.SetCurrentKey("Supplier No.");
            PIDetMasterRec.SetRange("Supplier No.", rec.Beneficiary);

            if PIDetMasterRec.FindSet() then begin
                repeat
                    PIDetMasterRec.B2BNo := rec."No.";
                    PIDetMasterRec.Modify();
                until PIDetMasterRec.Next() = 0;
            end;

            // CurrPage.Update();
        end;
    end;


}