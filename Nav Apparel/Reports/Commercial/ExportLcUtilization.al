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
            column(OrderQty; OrderQty)
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
            dataitem(B2BLCMaster; B2BLCMaster)
            {
                DataItemLinkReference = "Contract/LCMaster";
                DataItemLink = "LC/Contract No." = field("Contract No");
                DataItemTableView = sorting("No.");
                column(B2B_LC_No; "B2B LC No")
                { }
                column(Opening_Date_B2B; "Opening Date")
                { }
                column(B2B_LC_Value; "B2B LC Value")
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
            }
            dataitem("Contract/LCStyle"; "Contract/LCStyle")
            {
                DataItemLinkReference = "Contract/LCMaster";
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.");
                column(Qty; Qty)
                { }
                column(UniPrice; UniPrice)
                { }
                column(tot; Qty * UniPrice)
                { }
                column(Style_No_; "Style No.")
                { }

                trigger OnAfterGetRecord()

                begin

                    StylePoRec.SetRange("Style No.", "Style No.");
                    if StylePoRec.FindFirst() then begin
                        UniPrice := StylePoRec."Unit Price";
                    end;


                end;

            }
            trigger OnAfterGetRecord()
            begin
                stylerec.SetRange(ContractNo, "Contract/LCMaster"."No.");
                if stylerec.FindFirst() then begin
                    OrderQty := stylerec."Order Qty";
                    ShipDate := stylerec."Ship Date";
                end;

                ContractAmountRec.SetRange("No.", "Contract/LCMaster"."No.");
                if ContractAmountRec.FindFirst() then begin
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
        stylerec: Record "Style Master";
        OrderQty: BigInteger;
        ShipDate: Date;
        ContractAmountRec: Record "Contract Commision";
        Amount: Decimal;
        No: Code[20];
        VendorRec: Record Vendor;
        StylePoRec: Record "Style Master PO";
        UniPrice: Decimal;
        comRec: Record "Company Information";
}