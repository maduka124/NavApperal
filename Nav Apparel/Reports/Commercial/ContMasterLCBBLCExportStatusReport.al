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

            column(Buyer; Buyer)
            { }
            column(LC_Contract_No_; "LC/Contract No.")
            { }
            column(Currency; Currency)
            { }
            column(LC_Value; "LC Value")
            { }
            column(Quantity__Pcs_; "QtyContract")
            { }
            column(tot; Qty * UniPrice)
            { }
            column(B2B_LC_Value; LcValue)
            { }
            column(BBLC; BBLC)
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(B2B_LC_No; "B2B LC No")
            { }
            column(Opening_Date; "Opening Date")
            { }
            column(Expiry_Date; "Expiry Date")
            { }
            column(No_; ContractName)
            { }
            column(Contract_Value; ContractValue)
            { }
            column(BBLCAmount; BBLCAmount)
            { }
            column(QtyPcs; QtyPcs)
            { }
            column(FOBValue; FOBValue)
            { }
            column(Total; Total)
            { }


            dataitem("Sales Invoice Header"; "Sales Invoice Header")
            {
                DataItemLinkReference = B2BLCMaster;
                DataItemLink = "Contract No" = field("LC/Contract No.");
                DataItemTableView = sorting("No.") where(Closed = filter(false));

                column(BankRefNo_; BankRefNoV)
                { }
                column(Invoice_No; "Your Reference")
                { }
                column("InvNo"; "No.")
                { }
                column(Invoice_Amount; Amount)
                { }
                column(Release_Amount; ReleaseAmt)
                { }
                column(FC_A_C_Amount; FCACAMT)
                { }
                column(Current_A_C_Amount; CurrentACAMT)
                { }
                column(Margin_A_C_Amount; MarginAcAmt)
                { }
                column(ReleaseAmount; ReleaseAmount)
                { }

                trigger OnAfterGetRecord()
                var
                    SalesInVRec: Record "Sales Invoice Header";
                    BankRefeInvoiceRec: Record BankReferenceInvoice;
                begin
                    AmtIncValue := 0;
                    FOBValue := 0;
     

                    BanKInv.Reset();
                    BanKInv.SetRange("No.", "No.");
                    if BanKInv.FindSet() then begin
                        FtyInvoiceNo := BanKInv."Factory Inv No";
                    end;

                    //Get Bank Ref for the invoice
                    BankRefeInvoiceRec.Reset();
                    BankRefeInvoiceRec.SetRange("Invoice No", "No.");
                    if BankRefeInvoiceRec.FindSet() then
                        BankRefNoV := BankRefeInvoiceRec.BankRefNo
                    else
                        BankRefNoV := '';


                    ReleaseAmount := 0;
                    BankRefColLineRec.Reset();
                    BankRefColLineRec.SetRange("Invoice No", "No.");
                    BankRefColLineRec.SetRange("BankRefNo.", BankRefNoV);
                    if BankRefColLineRec.FindSet() then begin
                        ReleaseAmount := BankRefColLineRec."Release Amount";
                    end;


                    MarginAcAmt := 0;
                    FCACAMT := 0;
                    CurrentACAMT := 0;
                    ReleaseAmt := 0;
                    BankRefColLineRec.Reset();
                    BankRefColLineRec.SetRange("Invoice No", "No.");
                    BankRefColLineRec.SetRange("BankRefNo.", BankRefNoV);
                    if BankRefColLineRec.FindSet() then begin
                        ReleaseAmt += BankRefColLineRec."Release Amount";
                        FCACAMT := BankRefColLineRec."FC A/C Amount";
                        CurrentACAMT := BankRefColLineRec."Current A/C Amount";
                        MarginAcAmt := BankRefColLineRec."Margin A/C Amount";
                    end;



                end;
            }


            trigger OnPreDataItem()
            begin
                SetRange("LC/Contract No.", ContractNoFilter);
            end;


            trigger OnAfterGetRecord()
            var
                SalesInVRec: Record "Sales Invoice Header";
            begin
                comRec.Get;
                comRec.CalcFields(Picture);

                FOBValue := 0;
                ContractRec.Reset();
                ContractRec.SetRange("Contract No", "LC/Contract No.");
                if ContractRec.FindSet() then begin
                    BBLC := ContractRec.BBLC;
                    QtyContract := ContractRec."Quantity (Pcs)";
                    ContractValue := ContractRec."Contract Value";
                    ContractName := ContractRec."Contract No";
                    BBLCAmount := (ContractRec."Contract Value" * ContractRec.BBLC) / 100;
                    ConStRec.Reset();
                    ConStRec.SetRange("No.", ContractRec."No.");
                    if ConStRec.FindSet() then begin
                        Qty := ConStRec.Qty;

                        ConStRec.CalcSums(Qty);
                        QtyPcs := ConStRec.Qty;

                        StyleRec.SetRange("Style No.", ConStRec."Style No.");
                        if StyleRec.FindFirst() then begin
                            UniPrice := StyleRec."Unit Price";
                        end;
                    end;
                end;

                B2BTot := 0;
                BankRecColHRec.Reset();
                BankRecColHRec.SetRange("LC/Contract No.", "LC/Contract No.");
                if BankRecColHRec.FindSet() then begin

                    repeat
                        B2BTot += BankRecColHRec.Total;
                    until BankRefColLineRec.Next() = 0;
                end;
                LcValue := 0;
                B2bMasterRec.Reset();
                B2bMasterRec.SetRange("No.", "No.");
                B2bMasterRec.SetRange("LC/Contract No.", ContractNoFilter);
                B2bMasterRec.SetRange("B2B LC No", "B2B LC No");
                if B2bMasterRec.FindSet() then begin
                    LcValue := B2bMasterRec."LC Value";
                end;

                Total := 0;
                B2bMasterRec.Reset();
                B2bMasterRec.SetRange("LC/Contract No.", ContractNoFilter);
                if B2bMasterRec.FindSet() then begin
                    repeat
                        Total += B2bMasterRec."LC Value";
                    until B2bMasterRec.Next() = 0;
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
                    field(ContractNoFilter; ContractNoFilter)
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
                                    ContractNoFilter := ContractRec."Contract No";
                                end;
                            end;
                        end;
                    }
                }
            }
        }
    }


    var
        ReleaseAmount: Decimal;
        Total: Decimal;
        B2bMasterRec: Record B2BLCMaster;
        BanKInv: Record BankReferenceInvoice;
        B2BTot: Decimal;
        BankRefHRec: Record BankRefCollectionHeader;
        InvNo: Code[20];
        AmtIncValue: Decimal;
        BankRefNoV: Code[50];
        QtyPcs: Decimal;
        FOBValue: Decimal;
        BBLCAmount: Decimal;
        ContractName: Text[100];
        QtyContract: Decimal;
        ContractValue: Decimal;
        BBLC: Decimal;
        ContractRec: Record "Contract/LCMaster";
        FCACAMT: Decimal;
        CurrentACAMT: Decimal;
        ReleaseAmt: Decimal;
        MarginAcAmt: Decimal;
        BankRecColHRec: Record BankRefCollectionHeader;
        LcValue: Decimal;
        B2bRec: Record B2BLCMaster;
        FtyInvoiceNo: Text[50];
        BankRefColLineRec: Record BankRefCollectionLine;
        BankRefHeRec: Record BankReferenceHeader;
        StyleRec: Record "Style Master PO";
        UniPrice: Decimal;
        ConStRec: Record "Contract/LCStyle";
        Qty: BigInteger;
        ContractNoFilter: Code[50];
        comRec: Record "Company Information";
}