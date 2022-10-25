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
                dataitem(B2BLCPI; B2BLCPI)
                {
                    DataItemLinkReference = B2BLCMaster;
                    DataItemLink = "B2BNo." = field("No.");
                    DataItemTableView = sorting("B2BNo.");
                    // column(MainCatName; MainCatName)
                    // { }
                    dataitem("PI Po Item Details"; "PI Po Item Details")
                    {
                        DataItemLinkReference = B2BLCPI;
                        DataItemLink = "PI No." = field("PI No.");
                        DataItemTableView = sorting("PI No.");
                        column(MainCatName; "Main Category Name")
                        { }
                        column(B2B_LC_Value; Value)
                        { }

                    }
                    // trigger OnAfterGetRecord()

                    // begin
                    //     PiPORec.SetRange("PI No.", "No.");
                    //     if PiPORec.FindLast() then begin
                    //         MainCatName := PiPORec."Main Category Name";
                    //         // Message('test');
                    //     end;
                    // end;

                }

                trigger OnAfterGetRecord()

                begin
                    LCPIRec.SetRange("B2BNo.", "No.");
                    if LCPIRec.FindFirst() then begin
                        PIValue += LCPIRec."PI Value";
                    end;
                end;
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
                column(OrderQty; OrderQty)
                { }


                trigger OnAfterGetRecord()

                begin

                    StylePoRec.SetRange("Style No.", "Style No.");
                    if StylePoRec.FindFirst() then begin
                        UniPrice := StylePoRec."Unit Price";
                    end;
                    stylerec.SetRange("No.", "Contract/LCStyle"."Style No.");
                    if stylerec.FindFirst() then begin
                        OrderQty := stylerec."Order Qty";
                        ShipDate := stylerec."Ship Date";
                    end;


                end;

            }
            trigger OnAfterGetRecord()
            begin


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
        StylePoRec: Record "Style Master PO";
        UniPrice: Decimal;
        comRec: Record "Company Information";
        LCPIRec: Record B2BLCPI;
        PIValue: Decimal;
        PiPORec: Record "PI Po Item Details";
        MainCatName: Text[50];
}