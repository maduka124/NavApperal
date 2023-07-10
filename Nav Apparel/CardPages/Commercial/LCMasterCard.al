page 51351 "LC Card"
{
    PageType = Card;
    SourceTable = LCMaster;
    Caption = 'LC Master';

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
                field("LC No"; Rec."LC No")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'LC Master No';

                    trigger OnValidate()
                    var
                        LCRec: Record LCMaster;
                    begin
                        LCRec.Reset();
                        if LCRec.FindSet() then begin
                            repeat
                                if LCRec."LC No" = Rec."LC No" then
                                    Error('Contract no already exists');
                            until LCRec.Next() = 0;
                        end;
                    end;


                }

                field("Contract No"; rec."Contract No")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        LCstyle2: Record "LC Style 2";
                        LCStyleRec1: Record "LC Style";
                        ContractRec: Record "Contract/LCMaster";
                        ContractStyleRec: Record "Contract/LCStyle";
                        LCStyleRec: Record "LC Style";
                        Line: BigInteger;
                    begin
                        Line := 0;
                        LCStyleRec1.Reset();
                        if LCStyleRec1.FindLast() then begin
                            Line := LCStyleRec1."Line No";
                        end;
                        //Delete All
                        LCStyleRec.Reset();
                        if LCStyleRec.FindSet() then begin
                            LCStyleRec.DeleteAll();
                        end;

                        ContractRec.Reset();
                        ContractRec.SetRange("Contract No", Rec."Contract No");
                        if ContractRec.FindSet() then begin
                            repeat
                                ContractStyleRec.Reset();
                                ContractStyleRec.SetRange("No.", ContractRec."No.");
                                if ContractRec.FindSet() then begin
                                    repeat
                                        LCStyleRec.Init();
                                        Line += 1;
                                        LCStyleRec."Line No" += Line;
                                        LCStyleRec."LC No" := Rec."No.";
                                        LCStyleRec."No." := ContractStyleRec."No.";
                                        LCStyleRec."style No." := ContractStyleRec."Style No.";
                                        LCStyleRec."Style Name" := ContractStyleRec."Style Name";
                                        LCStyleRec."Buyer No." := ContractStyleRec."Buyer No.";
                                        LCStyleRec.Qty := ContractStyleRec.Qty;
                                        LCStyleRec."Created User" := UserId;
                                        LCStyleRec.Insert();
                                    until ContractStyleRec.Next() = 0;
                                    CurrPage.Update();
                                end;
                            until ContractRec.Next() = 0;
                        end;

                        LCstyle2.Reset();
                        LCstyle2.SetRange("No.", Rec.Contract);
                        if LCstyle2.FindSet() then begin
                            repeat
                                LCStyleRec.Reset();
                                LCStyleRec.SetRange("Style No.", LCstyle2."Style No.");
                                LCStyleRec.SetRange("Buyer No.", LCstyle2."Buyer No.");
                                // LCStyleRec.SetRange("No.", LCstyle2."No.");
                                if LCStyleRec.FindSet() then begin
                                    repeat
                                        LCStyleRec.Delete();
                                    until LCStyleRec.Next() = 0;
                                end;
                            Until LCstyle2.Next() = 0;
                            CurrPage.Update();
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
                part("LC ListPart 1"; "LC ListPart 1")
                {
                    ApplicationArea = All;
                    Caption = 'Avialable Styles';
                    SubPageLink = "No." = FIELD(Contract), "LC No" = field("No.");
                }
                part("LC ListPart 2"; "LC ListPart 2")
                {
                    ApplicationArea = All;
                    Caption = 'Selected Styles';
                    SubPageLink = "LC No" = field("No.");
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
                    Caption = 'Master LC Value';
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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."LC Master Nos.", xRec."No.", rec."No.") THEN BEGIN
            NoSeriesMngment.SetSeries(rec."No.");
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        // "Contract/LCMasterRec": Record "Contract/LCMaster";
        "Contract/LCStyleRec": Record "Contract/LCStyle";
        "Contract CommisionRec": Record "Contract Commision";
        lcStyeRec: Record "LC Style";
        LCMasterRec: Record LCMaster;
        LC2Rec: Record "LC Style 2";
    begin
        LC2Rec.Reset();
        LC2Rec.SetRange("LC No", Rec."No.");
        if LC2Rec.FindSet() then begin
            Error('Please Remove Selected Styles');
        end;

    end;





}