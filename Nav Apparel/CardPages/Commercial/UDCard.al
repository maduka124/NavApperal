page 51207 "UD Card"
{
    PageType = Card;
    SourceTable = UDHeader;
    Caption = 'Utilization Declaration (UD)';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'UD No';

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
                        BuyerRec: Record Customer;
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin
                        BuyerRec.Reset();
                        BuyerRec.SetRange(Name, rec."Buyer");
                        if BuyerRec.FindSet() then
                            rec."Buyer No." := BuyerRec."No.";

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

                field("LC/Contract No."; rec."LC/Contract No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        ContLCMasRec: Record "Contract/LCMaster";
                        B2BRec: Record B2BLCMaster;
                        "B2B LC Opened (Value)": Decimal;
                        "Contract/LCStyleRec": Record "Contract/LCStyle";
                        TotalQty: BigInteger;
                    begin
                        ContLCMasRec.Reset();
                        ContLCMasRec.SetRange("Contract No", rec."LC/Contract No.");
                        if ContLCMasRec.FindSet() then begin
                            rec."Value" := ContLCMasRec."Contract Value";
                            rec.Factory := ContLCMasRec.Factory;
                            rec."Factory No." := ContLCMasRec."Factory No.";
                        end;

                        //Calculate B2B LC opened  and %
                        B2BRec.Reset();
                        B2BRec.SetRange("LC/Contract No.", rec."LC/Contract No.");

                        if B2BRec.FindSet() then begin
                            repeat
                                "B2B LC Opened (Value)" += B2BRec."B2B LC Value";
                            until B2BRec.Next() = 0;

                            if rec."Value" > 0 then
                                rec."B2BLC%" := ("B2B LC Opened (Value)" / rec."Value") * 100;
                        end;

                        //Get total order qty
                        "Contract/LCStyleRec".Reset();
                        "Contract/LCStyleRec".SetRange("No.", ContLCMasRec."No.");

                        if "Contract/LCStyleRec".FindSet() then begin
                            repeat
                                TotalQty += "Contract/LCStyleRec".Qty;
                            until "Contract/LCStyleRec".Next() = 0;
                        end;

                        rec.Qantity := TotalQty;

                        //Load Style_PO details for the contract
                        Load_Style_PO_Detail();

                    end;

                }

                field(Factory; rec.Factory)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Qantity; rec.Qantity)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Value; rec.Value)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("B2BLC%"; rec."B2BLC%")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group("Style PO Information")
            {
                part("Style PO Info ListPart"; "Style PO Info ListPart")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "No." = FIELD("No.");
                }
            }

            // group("BBL LC Information")
            // {
            //     part("BBL LC Infor ListPart"; "BBL LC Infor ListPart")
            //     {
            //         ApplicationArea = All;
            //         Caption = ' ';
            //         SubPageLink = "No." = FIELD("No.");
            //     }
            // }

            // group("PI Information")
            // {
            //     part("PI Infor ListPart"; "PI Infor ListPart")
            //     {
            //         ApplicationArea = All;
            //         Caption = ' ';
            //         SubPageLink = "No." = FIELD("No.");
            //     }
            // }
        }
    }

    procedure Load_Style_PO_Detail()
    var
        UDStylePOinfoRec: Record UDStylePOinformation;
        ContLCMasRec: Record "Contract/LCMaster";
        "Contract/LCStyleRec": Record "Contract/LCStyle";
        StyleMasterRec: Record "Style Master";
        StyleMasterPORec: Record "Style Master PO";
        LineNo: Integer;
    begin

        //Delete old details
        UDStylePOinfoRec.Reset();
        UDStylePOinfoRec.SetRange("No.", rec."No.");
        if UDStylePOinfoRec.FindSet() then
            UDStylePOinfoRec.DeleteAll();

        //Check the contract
        ContLCMasRec.Reset();
        ContLCMasRec.SetRange("Contract No", rec."LC/Contract No.");
        if ContLCMasRec.FindSet() then begin

            //get styles for the contract
            "Contract/LCStyleRec".Reset();
            "Contract/LCStyleRec".SetRange("No.", ContLCMasRec."No.");

            if "Contract/LCStyleRec".FindSet() then begin
                repeat

                    //Get PO details for the style
                    StyleMasterPORec.Reset();
                    StyleMasterPORec.SetRange("Style No.", "Contract/LCStyleRec"."Style No.");

                    if StyleMasterPORec.FindSet() then begin
                        repeat
                            LineNo += 1;
                            //Insert po
                            UDStylePOinfoRec.Init();
                            UDStylePOinfoRec."No." := rec."No.";
                            UDStylePOinfoRec."Line No" := LineNo;
                            UDStylePOinfoRec."Order Qty" := StyleMasterPORec.Qty;
                            UDStylePOinfoRec."PO No" := StyleMasterPORec."PO No.";
                            UDStylePOinfoRec."Ship Date" := StyleMasterPORec."Ship Date";
                            UDStylePOinfoRec."Ship Qty" := StyleMasterPORec."Shipped Qty";
                            UDStylePOinfoRec."Ship Values" := StyleMasterPORec."Shipped Qty" * StyleMasterPORec."Unit Price";
                            UDStylePOinfoRec."Style Name" := StyleMasterPORec."Style Name";
                            UDStylePOinfoRec."Style No" := StyleMasterPORec."Style No.";
                            UDStylePOinfoRec."Unit Price" := StyleMasterPORec."Unit Price";
                            UDStylePOinfoRec.Values := StyleMasterPORec.Qty * StyleMasterPORec."Unit Price";
                            UDStylePOinfoRec.Insert();
                        until StyleMasterPORec.Next() = 0;
                    end;

                until "Contract/LCStyleRec".Next() = 0;
            end;

        end;
    end;

    // trigger OnDeleteRecord(): Boolean
    // var
    //     BankRefeCollRec: Record BankRefCollectionLine;
    // begin
    //     if rec."Cash Rece. Updated" then
    //         Error('Cash Receipt Journal updated for this Bank Ref. Cannot delete.');

    //     BankRefeCollRec.Reset();
    //     BankRefeCollRec.SetRange("BankRefNo.", rec."BankRefNo.");
    //     if BankRefeCollRec.FindSet() then
    //         BankRefeCollRec.Delete();
    // end;


    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."UD Nos.", xRec."No.", rec."No.") THEN BEGIN
            NoSeriesMngment.SetSeries(rec."No.");
            EXIT(TRUE);
        END;
    end;


}