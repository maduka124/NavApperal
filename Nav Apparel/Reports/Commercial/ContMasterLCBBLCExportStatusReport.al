report 50630 ExportStatusReport1
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Contract Master LC/BBLC & Export Status Report';
    RDLCLayout = 'Report_Layouts/Commercial/ContMasterLCBBLCExportStatusReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Contract/LCMaster"; "Contract/LCMaster")
        {
            DataItemTableView = sorting("No.");
            column(BBLC; BBLC)
            { }
            column(Quantity__Pcs_; "Quantity (Pcs)")
            { }
            column(Contract_Value; "Contract Value")
            { }
            column(Currency; Currency)
            { }
            column(BuyerFilter; Buyer)
            { }
            column(No_; "Contract No")
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(Qty; Qty)
            { }
            column(UniPrice; UniPrice)
            { }
            column(tot; Qty * UniPrice)
            { }
            dataitem(B2BLCMaster; B2BLCMaster)
            {
                DataItemTableView = sorting("No.");
                DataItemLinkReference = "Contract/LCMaster";
                DataItemLink = "LC/Contract No." = field("Contract No");

                column(B2B_LC_No; "B2B LC No")
                { }
                column(Opening_Date; "Opening Date")
                { }
                column(Expiry_Date; "Expiry Date")
                { }
                column(LC_Value; "LC Value")
                { }
                column(Buyer; Buyer)
                { }
                column(LC_Contract_No_; "LC/Contract No.")
                { }
                column(B2B_LC_Value; "B2B LC Value")
                { }
            }
            dataitem(BankRefCollectionHeader; BankRefCollectionHeader)
            {
                DataItemLinkReference = "Contract/LCMaster";
                DataItemLink = "LC/Contract No." = field("Contract No");
                DataItemTableView = sorting("BankRefNo.");

                column(Margin_A_C_Amount; "Margin A/C Amount")
                { }
                column(Invoice_No; FtyInvoiceNo)
                { }
                column(Invoice_Amount; Total)
                { }
                column(BankRefNo_; "BankRefNo.")
                { }
                column(Release_Amount; "Release Amount")
                { }
                column(FC_A_C_Amount; "FC A/C Amount")
                { }
                column(Current_A_C_Amount; "Current A/C Amount")
                { }

                trigger OnAfterGetRecord()

                begin
                    BankRefColLineRec.Reset();
                    BankRefColLineRec.SetRange("BankRefNo.", "BankRefNo.");
                    if BankRefColLineRec.FindSet() then begin
                        FtyInvoiceNo := BankRefColLineRec."Factory Invoice No";
                    end;
                end;
            }

            trigger OnPreDataItem()

            begin
                SetRange("No.", No);
            end;

            trigger OnAfterGetRecord()

            begin
                comRec.Get;
                comRec.CalcFields(Picture);

                ConStRec.Reset();
                ConStRec.SetRange("No.", "No.");
                if ConStRec.FindSet() then begin
                    Qty := ConStRec.Qty;
                    StyleRec.SetRange("Style No.", ConStRec."Style No.");
                    if StyleRec.FindFirst() then begin
                        UniPrice := StyleRec."Unit Price";
                    end;
                end;
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
        FtyInvoiceNo: Text[50];
        BankRefColLineRec: Record BankRefCollectionLine;
        StyleRec: Record "Style Master PO";
        UniPrice: Decimal;
        ConStRec: Record "Contract/LCStyle";
        Qty: BigInteger;
        No: Code[50];
        comRec: Record "Company Information";


}