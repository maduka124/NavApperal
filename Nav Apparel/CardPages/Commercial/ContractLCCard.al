page 50502 "Contract/LC Card"
{
    PageType = Card;
    SourceTable = "Contract/LCMaster";
    Caption = 'Contract/Master LC';

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
                        "StyleRec": Record "Style Master";
                        UsersRec: Record "User Setup";
                        LocationRec: Record Location;
                    begin

                        CustomerRec.Reset();
                        CustomerRec.SetRange(Name, rec.Buyer);
                        if CustomerRec.FindSet() then
                            rec."Buyer No." := CustomerRec."No.";

                        StyleRec.Reset();
                        StyleRec.SetCurrentKey("Buyer No.");
                        StyleRec.SetRange("Buyer No.", CustomerRec."No.");

                        if StyleRec.FindSet() then begin
                            repeat
                                StyleRec.ContractNo := rec."No.";
                                StyleRec.Modify();
                            until StyleRec.Next() = 0;
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

                        //Done By Sachith 03/01/23
                        //Get user location
                        UsersRec.Reset();
                        UsersRec.SetRange("User ID", UserId());
                        UsersRec.FindSet();

                        if UsersRec.FindSet() then begin
                            rec."Factory No." := UsersRec."Factory Code";
                            Rec."Global Dimension Code" := UsersRec."Global Dimension Code";
                        end;

                        LocationRec.Reset();
                        LocationRec.SetRange(Code, rec."Factory No.");
                        if LocationRec.FindSet() then
                            rec.Factory := LocationRec.Name;
                    end;
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
                            rec."Season No." := SeasonsRec."No.";
                    end;
                }

                field("Factory"; rec."Factory")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        LocationRec: Record Location;
                    begin
                        LocationRec.Reset();
                        LocationRec.SetRange(Name, rec."Factory");
                        if LocationRec.FindSet() then
                            rec."Factory No." := LocationRec."code";
                    end;
                }

                field("Contract No"; rec."Contract No")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    //Done By Sachith 28/02/23
                    trigger OnValidate()
                    var
                        ContractLCRec: Record "Contract/LCMaster";
                    begin

                        ContractLCRec.Reset();
                        ContractLCRec.FindSet();
                        begin
                            repeat
                                if ContractLCRec."Contract No" = Rec."Contract No" then
                                    Error('Contract no already exists');
                            until ContractLCRec.Next() = 0;
                        end;
                    end;
                }

                field(AMD; rec.AMD)
                {
                    ApplicationArea = All;
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
                            rec."Issue Bank No." := BankRec."No.";
                    end;
                }

                field("Receive Bank"; rec."Receive Bank")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        BankRec: Record "Bank Account";
                    begin
                        BankRec.Reset();
                        BankRec.SetRange(Name, rec."Receive Bank");
                        if BankRec.FindSet() then
                            rec."Receive Bank No." := BankRec."No.";
                    end;
                }

                field("Nego Bank"; rec."Nego Bank")
                {
                    ApplicationArea = All;
                    Caption = 'Negotiation Bank';

                    trigger OnValidate()
                    var
                        BankRec: Record "Bank Account";
                    begin
                        BankRec.Reset();
                        BankRec.SetRange(Name, rec."Nego Bank");
                        if BankRec.FindSet() then
                            rec."Nego Bank No." := BankRec."No.";
                    end;
                }

                field(BBLC; rec.BBLC)
                {
                    ApplicationArea = All;
                    Caption = 'BBLC %';
                    Editable = false;
                }

                field("B2B Payment Type"; rec."B2B Payment Type")
                {
                    ApplicationArea = All;
                    Caption = 'B2B Payment Type';

                    trigger OnValidate()
                    var
                        PaymentRec: Record "Payment Method";
                    begin
                        PaymentRec.Reset();
                        PaymentRec.SetRange(Description, rec."B2B Payment Type");
                        if PaymentRec.FindSet() then
                            rec."B2B Payment Type No." := PaymentRec.Code;
                    end;
                }

                field("Shipment Mode"; rec."Shipment Mode")
                {
                    ApplicationArea = All;
                }

                field("Opening Date"; rec."Opening Date")
                {
                    ApplicationArea = All;
                }

                field("Amend Date"; rec."Amend Date")
                {
                    ApplicationArea = All;
                }

                field("Last Shipment Date"; rec."Last Shipment Date")
                {
                    ApplicationArea = All;
                }

                field("Expiry Date"; rec."Expiry Date")
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

                field("UD No"; rec."UD No")
                {
                    ApplicationArea = All;
                }

                field("UD Version"; rec."UD Version")
                {
                    ApplicationArea = All;
                }

                field("Freight Value"; rec."Freight Value")
                {
                    ApplicationArea = All;
                }

                field("Insurance Value"; rec."Insurance Value")
                {
                    ApplicationArea = All;
                }

                field("Partial Shipment"; rec."Partial Shipment")
                {
                    ApplicationArea = All;
                }

                field("Payment Terms (Days)"; rec."Payment Terms (Days)")
                {
                    ApplicationArea = All;

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

                field("Status of LC"; rec."Status of LC")
                {
                    ApplicationArea = All;
                }

                field("File No"; rec."File No")
                {
                    ApplicationArea = All;
                }

                field("Global Dimension Code"; Rec."Global Dimension Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
            }

            group(" ")
            {
                part("Style Master Contract ListPart"; "Style Master Contract ListPart")
                {
                    ApplicationArea = All;
                    Caption = 'Available Styles';
                    SubPageLink = "ContractNo" = FIELD("No."), "Buyer No." = field("Buyer No."), "Merchandizer Group Name" = field("Merchandizer Group Name");
                }

                part("StyleMasterContract ListPart 2"; "StyleMasterContract ListPart 2")
                {
                    ApplicationArea = All;
                    Caption = 'Selected Styles';
                    SubPageLink = "No." = FIELD("No.");
                }
            }

            group("Total Value/Pcs")
            {
                field("Quantity (Pcs)"; rec."Quantity (Pcs)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Contract Value"; rec."Contract Value")
                {
                    ApplicationArea = All;
                }

                field("Auto Calculate Value"; rec."Auto Calculate Value")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group("Contract Commision")
            {
                part("Contract Commision ListPart"; "Contract Commision ListPart")
                {
                    ApplicationArea = All;
                    Caption = ' ';
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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."ContractLC Nos.", xRec."No.", rec."No.") THEN BEGIN
            NoSeriesMngment.SetSeries(rec."No.");
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        "Contract/LCMasterRec": Record "Contract/LCMaster";
        "Contract/LCStyleRec": Record "Contract/LCStyle";
        "Contract CommisionRec": Record "Contract Commision";
    begin

        //Done By Sachith On 09/03/23
        "Contract/LCStyleRec".Reset();
        "Contract/LCStyleRec".SetRange("No.", Rec."No.");

        if "Contract/LCStyleRec".FindSet() then
            Error('Record cannot be deleted')
        else begin
            "Contract CommisionRec".SetRange("No.", rec."No.");
            "Contract CommisionRec".DeleteAll();

            "Contract/LCMasterRec".SetRange("No.", rec."No.");
            "Contract/LCMasterRec".DeleteAll();
        end;
    end;

    //Done By Sachith 03/01/23
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
    begin
        if rec."No." <> '' then begin

            rec.TestField(Buyer);
            rec.TestField("Contract No");
            Rec.TestField(Factory);
            Rec.TestField("Global Dimension Code");
        end;
    end;



}