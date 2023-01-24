page 50763 "Bank Reference Card"
{
    PageType = Card;
    SourceTable = BankReferenceHeader;
    UsageCategory = Tasks;
    Caption = 'Export Bank Reference';
    Permissions = tabledata "Sales Invoice Header" = rm;

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

                field("BankRefNo."; rec."BankRefNo.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Bank Reference No';

                    trigger OnValidate()
                    var
                        SalesInvRec: Record "Sales Invoice Header";
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin
                        SalesInvRec.Reset();

                        if SalesInvRec.FindSet() then begin
                            repeat
                                SalesInvRec.BankRefNo := rec."No.";
                                SalesInvRec.Modify();
                            until SalesInvRec.Next() = 0;
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

                field("Reference Date"; rec."Reference Date")
                {
                    ApplicationArea = All;
                }

                field(AirwayBillNo; rec.AirwayBillNo)
                {
                    ApplicationArea = All;
                    Caption = 'Airway Bill No';
                }

                //Done By Sachith 10/01/23
                field("Buyer Name"; Rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';

                    trigger OnValidate()
                    var
                        CustomerRec: Record Customer;
                    begin

                        CustomerRec.Reset();
                        CustomerRec.SetRange(Name, Rec."Buyer Name");

                        if CustomerRec.FindSet() then
                            Rec."Buyer No" := CustomerRec."No.";
                    end;
                }

                field("LC/Contract No."; rec."LC/Contract No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        LCContractRec: Record "Contract/LCMaster";
                        ContractStyleRec: Record "Contract/LCStyle";
                        SalesInvoiceRec: Record "Sales Invoice Header";
                        ContPostedInvRec: Record ContractPostedInvoices;
                    begin
                        //Validate contract no
                        LCContractRec.Reset();
                        LCContractRec.SetRange("Contract No", rec."LC/Contract No.");

                        if not LCContractRec.FindSet() then
                            Error('Invalid Contract No.')
                        else begin

                            ContractStyleRec.Reset();
                            ContractStyleRec.SetRange("No.", LCContractRec."No.");

                            if ContractStyleRec.FindSet() then begin

                                repeat
                                    //Get invoices for the  Style
                                    SalesInvoiceRec.Reset();
                                    SalesInvoiceRec.SetRange("Style No", ContractStyleRec."Style No.");
                                    SalesInvoiceRec.SetRange("Sell-to Customer No.", rec."Buyer No");

                                    if SalesInvoiceRec.FindSet() then begin

                                        repeat

                                            //Check duplicates
                                            ContPostedInvRec.Reset();
                                            ContPostedInvRec.SetRange("LC/Contract No.", rec."LC/Contract No.");
                                            ContPostedInvRec.SetRange("Inv No.", SalesInvoiceRec."No.");

                                            if not ContPostedInvRec.FindSet() then begin
                                                //Insert 
                                                ContPostedInvRec.Init();
                                                ContPostedInvRec.BankRefNo := rec."No.";
                                                ContPostedInvRec.AssignedBankRefNo := '';
                                                ContPostedInvRec."Created Date" := WorkDate();
                                                ContPostedInvRec."Created User" := UserId;
                                                ContPostedInvRec."Inv No." := SalesInvoiceRec."No.";
                                                SalesInvoiceRec.CalcFields(SalesInvoiceRec."Amount Including VAT");
                                                ContPostedInvRec."Inv Value" := SalesInvoiceRec."Amount Including VAT";
                                                ContPostedInvRec."LC/Contract No." := rec."LC/Contract No.";
                                                ContPostedInvRec."Inv Date" := SalesInvoiceRec."Document Date";
                                                ContPostedInvRec.Insert();
                                            end;

                                        until SalesInvoiceRec.Next() = 0;

                                    end;
                                until ContractStyleRec.Next() = 0;

                            end
                            else
                                Error('No Styles assigned for the Contract  : %1', rec."LC/Contract No.");
                        end;
                    end;
                }

                field("Airway Bill Date"; rec."Airway Bill Date")
                {
                    ApplicationArea = All;
                }

                field("Maturity Date"; rec."Maturity Date")
                {
                    ApplicationArea = All;
                }

                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = All;
                }

                field(Total; rec.Total)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group("Invoice Details")
            {
                part("Bank Ref Invoice ListPart1"; "Bank Ref Invoice ListPart1")
                {
                    ApplicationArea = All;
                    Caption = 'Available Invoices';
                    // SubPageLink = BankRefNo = FIELD("No."), "Sell-to Customer No." = field("Buyer No");
                    SubPageLink = BankRefNo = FIELD("No.");
                }

                part("Bank Ref Invoice ListPart2"; "Bank Ref Invoice ListPart2")
                {
                    ApplicationArea = All;
                    Caption = 'Selected Invoices';
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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."BankRef Nos.", xRec."No.", rec."No.") THEN BEGIN
            NoSeriesMngment.SetSeries(rec."No.");
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        BankRefeInvRec: Record BankReferenceInvoice;
        BankRefCollHeaderRec: Record BankRefCollectionHeader;
        SalesInvRec: Record "Sales Invoice Header";
        ContPostedInvRec: Record ContractPostedInvoices;
    begin

        BankRefCollHeaderRec.Reset();
        BankRefCollHeaderRec.SetRange("BankRefNo.", rec."BankRefNo.");
        if BankRefCollHeaderRec.FindSet() then
            Error('Bank Reference : %1 already used in Bank Reference Collection %2. Cannot delete.', rec."BankRefNo.", BankRefCollHeaderRec."BankRefNo.");

        //Update sales invoice header recods
        // BankRefeInvRec.Reset();
        // BankRefeInvRec.SetRange("No.", rec."No.");
        // if BankRefeInvRec.FindSet() then begin
        //     repeat
        //         SalesInvRec.Reset();
        //         SalesInvRec.SetRange("No.", BankRefeInvRec."Invoice No");
        //         if SalesInvRec.FindSet() then begin
        //             SalesInvRec.AssignedBankRefNo := '';
        //             SalesInvRec.Modify();
        //         end;
        //     until BankRefeInvRec.Next() = 0;

        //     //Delete Line records
        //     BankRefeInvRec.Delete();
        // end;


        ContPostedInvRec.Reset();
        ContPostedInvRec.SetRange("BankRefNo", rec."BankRefNo.");
        if ContPostedInvRec.FindSet() then begin
            repeat
                ContPostedInvRec.AssignedBankRefNo := '';
                ContPostedInvRec.Modify();
            until ContPostedInvRec.Next() = 0;
        end;

    end;


    trigger OnAfterGetCurrRecord()
    var
        SalesInvRec: Record "Sales Invoice Header";
    begin
        if rec."No." <> '' then begin
            SalesInvRec.Reset();
            if SalesInvRec.FindSet() then begin
                repeat
                    SalesInvRec.BankRefNo := rec."No.";
                    SalesInvRec.Modify();
                until SalesInvRec.Next() = 0;
            end;
        end;
    end;
}