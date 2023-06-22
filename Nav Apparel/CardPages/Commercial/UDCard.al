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

                        //Load BBLC details for the contract
                        Load_BBLC_Detail();

                        //Load PI details for the contract
                        Load_PI_Detail();

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

            group("BBL LC Information")
            {
                part("BBL LC Infor ListPart"; "BBL LC Infor ListPart")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "No." = FIELD("No.");
                }
            }

            group("PI Information")
            {
                part("PI Infor ListPart"; "PI Infor ListPart")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "No." = FIELD("No.");
                }
            }
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
        TotOrderQty: BigInteger;
        TotValue: Decimal;
        TotShipQty: BigInteger;
        TotShipValue: Decimal;
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

                            TotOrderQty += StyleMasterPORec.Qty;
                            TotShipQty += StyleMasterPORec."Shipped Qty";
                            TotValue += StyleMasterPORec.Qty * StyleMasterPORec."Unit Price";
                            TotShipValue += StyleMasterPORec."Shipped Qty" * StyleMasterPORec."Unit Price";

                        until StyleMasterPORec.Next() = 0;
                    end;

                until "Contract/LCStyleRec".Next() = 0;

                UDStylePOinfoRec.Init();
                UDStylePOinfoRec."No." := rec."No.";
                UDStylePOinfoRec."Line No" := LineNo + 1;
                UDStylePOinfoRec."Order Qty" := TotOrderQty;
                UDStylePOinfoRec."Ship Qty" := TotShipQty;
                UDStylePOinfoRec."Ship Values" := TotShipValue;
                UDStylePOinfoRec."Style Name" := 'Total';
                UDStylePOinfoRec.Values := TotValue;
                UDStylePOinfoRec.Insert();

            end;

        end;
    end;


    procedure Load_BBLC_Detail()
    var
        UDBBLcInfoRec: Record UDBBLcInformation;
        B2BLCMasterRec: Record B2BLCMaster;
        LineNo: Integer;
    begin

        //Delete old details
        UDBBLcInfoRec.Reset();
        UDBBLcInfoRec.SetRange("No.", rec."No.");
        if UDBBLcInfoRec.FindSet() then
            UDBBLcInfoRec.DeleteAll();

        //GetB2BLC for the contract
        B2BLCMasterRec.Reset();
        B2BLCMasterRec.SetRange("LC/Contract No.", rec."LC/Contract No.");

        if B2BLCMasterRec.FindSet() then begin
            repeat

                LineNo += 1;
                //Insert po
                UDBBLcInfoRec.Init();
                UDBBLcInfoRec."No." := rec."No.";
                UDBBLcInfoRec."Line No" := LineNo;
                UDBBLcInfoRec.BBLCValue := B2BLCMasterRec."B2B LC Value";
                UDBBLcInfoRec."Expice Date" := B2BLCMasterRec."Expiry Date";
                UDBBLcInfoRec."Issue Bank" := B2BLCMasterRec."Issue Bank";
                UDBBLcInfoRec."Issue Bank No" := B2BLCMasterRec."LC Issue Bank No.";
                UDBBLcInfoRec."LC Amount" := B2BLCMasterRec."LC Value";
                UDBBLcInfoRec."Open Date" := B2BLCMasterRec."Opening Date";
                UDBBLcInfoRec."Payment Mode No" := B2BLCMasterRec."Payment Terms (Days) No.";
                UDBBLcInfoRec."Payment Mode" := B2BLCMasterRec."Payment Terms (Days)";
                UDBBLcInfoRec."Supplier Name" := B2BLCMasterRec."Beneficiary Name";
                UDBBLcInfoRec."Supplier No" := B2BLCMasterRec.Beneficiary;
                UDBBLcInfoRec.Insert();

            until B2BLCMasterRec.Next() = 0;
        end;

    end;


    procedure Load_PI_Detail()
    var
        UDPIInfoRec: Record UDPIinformationLine;
        B2BLCMasterRec: Record B2BLCMaster;
        PIHeaderRec: Record "PI Details Header";
        PIItemsRec: Record "PI Po Item Details";
        B2BLCPIRec: Record B2BLCPI;
        LineNo: Integer;
        TotOrderQty: Decimal;
        TotValue: Decimal;
    begin

        //Delete old details
        UDPIInfoRec.Reset();
        UDPIInfoRec.SetRange("No.", rec."No.");
        if UDPIInfoRec.FindSet() then
            UDPIInfoRec.DeleteAll();

        //Get B2BLC for the contract
        B2BLCMasterRec.Reset();
        B2BLCMasterRec.SetRange("LC/Contract No.", rec."LC/Contract No.");

        if B2BLCMasterRec.FindSet() then begin
            repeat

                B2BLCPIRec.Reset();
                B2BLCPIRec.SetRange("B2BNo.", B2BLCMasterRec."No.");

                if B2BLCPIRec.FindSet() then begin
                    repeat

                        PIHeaderRec.Reset();
                        PIHeaderRec.SetRange("No.", B2BLCPIRec."PI No.");

                        if PIHeaderRec.FindSet() then begin

                            PIItemsRec.Reset();
                            PIItemsRec.SetRange("PI No.", PIHeaderRec."No.");

                            if PIItemsRec.FindSet() then begin

                                repeat

                                    LineNo += 1;

                                    UDPIInfoRec.Init();
                                    UDPIInfoRec."No." := rec."No.";
                                    UDPIInfoRec."Line No" := LineNo;
                                    UDPIInfoRec."BBLC No" := B2BLCPIRec."B2BNo.";
                                    UDPIInfoRec."Item Code" := PIItemsRec."Item No.";
                                    UDPIInfoRec."Item Description" := PIItemsRec."Item Name";
                                    UDPIInfoRec."Main Category" := PIItemsRec."Main Category Name";
                                    UDPIInfoRec."Main Category No" := PIItemsRec."Main Category No.";
                                    UDPIInfoRec."Order Qty1" := PIItemsRec.Qty;
                                    UDPIInfoRec."Supplier" := PIHeaderRec."Supplier Name";
                                    UDPIInfoRec."Suplier No" := PIHeaderRec."Supplier No.";
                                    UDPIInfoRec."Unit Price" := PIItemsRec."Unit Price";
                                    UDPIInfoRec.Value := PIItemsRec.Value;
                                    UDPIInfoRec.Insert();

                                    TotOrderQty += PIItemsRec.Qty;
                                    TotValue += PIItemsRec.Value;

                                until PIItemsRec.Next() = 0;
                            end;

                        end;

                    until B2BLCPIRec.Next() = 0;
                end;

            until B2BLCMasterRec.Next() = 0;

            UDPIInfoRec.Init();
            UDPIInfoRec."No." := rec."No.";
            UDPIInfoRec."Line No" := LineNo + 1;
            UDPIInfoRec."Order Qty1" := TotOrderQty;
            UDPIInfoRec."BBLC No" := 'Total';
            UDPIInfoRec.Value := TotValue;
            UDPIInfoRec.Insert();

        end;

    end;


    trigger OnDeleteRecord(): Boolean
    var
        UDBBLcInfoRec: Record UDBBLcInformation;
        UDStyPOInfoRec: Record UDStylePOinformation;
        UDPIInfoRec: Record UDPIinformationLine;
    begin

        UDBBLcInfoRec.Reset();
        UDBBLcInfoRec.SetRange("No.", rec."No.");
        if UDBBLcInfoRec.FindSet() then
            UDBBLcInfoRec.DeleteAll();

        UDStyPOInfoRec.Reset();
        UDStyPOInfoRec.SetRange("No.", rec."No.");
        if UDStyPOInfoRec.FindSet() then
            UDStyPOInfoRec.DeleteAll();

        UDPIInfoRec.Reset();
        UDPIInfoRec.SetRange("No.", rec."No.");
        if UDPIInfoRec.FindSet() then
            UDPIInfoRec.DeleteAll();
    end;


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