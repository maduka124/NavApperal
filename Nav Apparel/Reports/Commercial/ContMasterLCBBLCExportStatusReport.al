report 50630 ExportStatusReport1
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Contract Master LC/BBLC & Export Status Report';
    RDLCLayout = 'Report_Layouts/Commercial/ContMasterLCBBLCExportStatusReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {

        dataitem(B2BLCMaster; B2BLCMaster)
        {
            DataItemTableView = sorting("No.");
            column(BBLC; BBLC)
            { }
            column(Quantity__Pcs_; QtyContract)
            { }
            column(Contract_Value; ContractValue)
            { }
            column(Currency; Currency)
            { }
            column(BuyerFilter; Buyer)
            { }
            column(No_; ContractName)
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(Qty; Qty)
            { }
            column(UniPrice; UniPrice)
            { }
            column(tot; Qty * UniPrice)
            { }
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
            column(Margin_A_C_Amount; MarginAcAmt)
            { }
            column(Invoice_No; FtyInvoiceNo)
            { }
            column(Invoice_Amount; Total)
            { }
            column(BankRefNo_; BankRefNo)
            { }
            column(Release_Amount; ReleaseAmt)
            { }
            column(FC_A_C_Amount; FCACAMT)
            { }
            column(Current_A_C_Amount; CurrentACAMT)
            { }
       


            trigger OnPreDataItem()

            begin
                SetRange("LC/Contract No.", No);
            end;

            trigger OnAfterGetRecord()

            begin
                comRec.Get;
                comRec.CalcFields(Picture);

                ContractRec.Reset();
                ContractRec.SetRange("Contract No", "LC/Contract No.");
                if ContractRec.FindSet() then begin
                    BBLC := ContractRec.BBLC;
                    QtyContract := ContractRec."Quantity (Pcs)";
                    ContractValue := ContractRec."Contract Value";
                    ContractName := ContractRec."Contract No";

                    ConStRec.Reset();
                    ConStRec.SetRange("No.", ContractRec."No.");
                    if ConStRec.FindSet() then begin
                        Qty := ConStRec.Qty;
                        StyleRec.SetRange("Style No.", ConStRec."Style No.");
                        if StyleRec.FindFirst() then begin
                            UniPrice := StyleRec."Unit Price";
                        end;
                    end;
                end;



                BankRecColHRec.Reset();
                BankRecColHRec.SetRange("LC/Contract No.", "LC/Contract No.");
                if BankRecColHRec.FindSet() then begin
                    MarginAcAmt := BankRecColHRec."Margin A/C Amount";
                    Total := BankRecColHRec.Total;
                    BankRefNo := BankRecColHRec."BankRefNo.";
                    ReleaseAmt := BankRecColHRec."Release Amount";
                    FCACAMT := BankRecColHRec."FC A/C Amount";
                    CurrentACAMT := BankRecColHRec."Current A/C Amount";


                    BankRefColLineRec.Reset();
                    BankRefColLineRec.SetRange("BankRefNo.", BankRecColHRec."BankRefNo.");
                    if BankRefColLineRec.FindFirst() then begin
                        FtyInvoiceNo := BankRefColLineRec."Factory Invoice No";
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



                        trigger OnLookup(var texts: text): Boolean
                        var
                            ContractRec: Record "Contract/LCMaster";
                        begin

                            ContractRec.Reset();
                            if ContractRec.FindSet() then begin
                                if Page.RunModal(50503, ContractRec) = Action::LookupOK then begin
                                    No := ContractRec."Contract No";
                                end;
                            end;
                        end;


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
        ContractName: Text[100];
        QtyContract: Decimal;
        ContractValue: Decimal;
        BBLC: Decimal;
        ContractRec: Record "Contract/LCMaster";
        FCACAMT: Decimal;
        CurrentACAMT: Decimal;
        ReleaseAmt: Decimal;
        BankRefNo: Code[20];
        Total: Decimal;
        MarginAcAmt: Decimal;
        BankRecColHRec: Record BankRefCollectionHeader;
        ContractNo: Code[50];
        B2bLcValue: Decimal;
        LcValue: Decimal;
        Buyername: Text[100];
        OpeningDate: Date;
        ExDate: Date;
        B2bLcNo: Code[20];
        B2bRec: Record B2BLCMaster;
        FtyInvoiceNo: Text[50];
        BankRefColLineRec: Record BankRefCollectionLine;
        StyleRec: Record "Style Master PO";
        UniPrice: Decimal;
        ConStRec: Record "Contract/LCStyle";
        Qty: BigInteger;
        No: Code[50];
        comRec: Record "Company Information";


}