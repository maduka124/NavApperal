report 50628 ExportLcUtilizationReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Export Lc Utilization Report';
    RDLCLayout = 'Report_Layouts/Commercial/ExportLcUtilizationReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Contract/LCMaster"; "Contract/LCMaster")
        {

            DataItemTableView = sorting("No.");

            column(Buyer; Buyer)
            { }
            column(Contract_No; "Contract No")
            { }
            column(Opening_Date; "Opening Date")
            { }
            column(Expiry_Date; "Expiry Date")
            { }
            column(Freight_Value; "Freight Value")
            { }
            column(Last_Shipment_Date; "Last Shipment Date")
            { }
            column(BBLC; BBLC)
            { }
            column(ShipDate; ShipDate)
            { }
            column(Amount; Amount)
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(Quantity__Pcs_; "Quantity (Pcs)")
            { }
            column(Contract_Value; "Contract Value")
            { }
            column(No_; "Contract No")
            { }
            column(Qty; Qty)
            { }
            column(UniPrice; UniPrice)
            { }
            column(tot; Qty * UniPrice)
            { }
            column(Style_No_; StyleNo)
            { }
            column(OrderQty; OrderQty)
            { }
            dataitem(B2BLCMaster; B2BLCMaster)
            {
                DataItemLinkReference = "Contract/LCMaster";
                DataItemLink = "LC/Contract No." = field("Contract No");
                DataItemTableView = sorting("No.");
                column(B2B_LC_No; "B2B LC No")
                { }
                column(Opening_Date_B2B; "Opening Date")
                { }
                column(Remarks; Remarks)
                { }
                column(Balance; Balance)
                { }
                column(LC_Value; "LC Value")
                { }
                column(Beneficiary_Name; "Beneficiary Name")
                { }
                column(Currency; "Currency No.")
                { }
                column(PIValue; PIValue)
                { }
                column(MainCatName; MainCatName)
                { }
                column(B2B_LC_Value; Value)
                { }

                trigger OnAfterGetRecord()

                begin
                    B2bRec.Reset();
                    B2bRec.SetRange("B2BNo.", "No.");
                    if B2bRec.FindSet() then begin
                        PiPORec.reset();
                        PiPORec.SetRange("PI No.", B2bRec."PI No.");
                        if PiPORec.FindSet() then begin
                            MainCatName := PiPORec."Main Category Name";
                            Value := PiPORec.Value;
                        end;
                    end;

                    LCPIRec.SetRange("B2BNo.", "No.");
                    if LCPIRec.FindFirst() then begin
                        PIValue += LCPIRec."PI Value";
                    end;
                end;
            }
            trigger OnAfterGetRecord()
            begin

                ContractLcRec.Reset();
                ContractLcRec.SetRange("No.", No);
                if ContractLcRec.FindSet() then begin
                    Qty := ContractLcRec.Qty;

                end;


                ContractLcRec.Reset();
                ContractLcRec.SetRange("No.", No);
                if ContractLcRec.FindSet() then begin
                    StylePoRec.Reset();
                    StylePoRec.SetRange("Style No.", ContractLcRec."Style No.");
                    if StylePoRec.FindSet() then begin
                        UniPrice := StylePoRec."Unit Price";
                    end;

                    stylerec.Reset();
                    stylerec.SetRange("No.", ContractLcRec."Style No.");
                    if stylerec.FindSet() then begin
                        OrderQty := stylerec."Order Qty";
                        ShipDate := stylerec."Ship Date";
                        StyleNo := stylerec."Style No.";
                    end;
                end;


                ContractAmountRec.Reset();
                ContractAmountRec.SetRange("No.", "No.");
                if ContractAmountRec.FindSet() then begin
                    Amount := ContractAmountRec.Amount;
                end;

                comRec.Get;
                comRec.CalcFields(Picture);

            end;

            trigger OnPreDataItem()

            begin
                SetRange("No.", No);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    Caption = 'Filter By';
                    field(No; No)
                    {
                        ApplicationArea = All;
                        Caption = 'Contract No';
                        TableRelation = "Contract/LCMaster"."No.";


                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }


    var

        Value: Decimal;
        MainCatName: Text[50];
        B2bRec: Record B2BLCPI;
        StyleNo: Text[50];
        UnitPrize: Decimal;
        Qty: BigInteger;
        ContractLcRec: Record "Contract/LCStyle";
        stylerec: Record "Style Master";
        OrderQty: BigInteger;
        ShipDate: Date;
        ContractAmountRec: Record "Contract Commision";
        Amount: Decimal;
        No: Code[20];
        StylePoRec: Record "Style Master PO";
        UniPrice: Decimal;
        comRec: Record "Company Information";
        LCPIRec: Record B2BLCPI;
        PIValue: Decimal;
        PiPORec: Record "PI Po Item Details";
}