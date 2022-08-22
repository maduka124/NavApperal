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
            // column()
            // { }
            // column()
            // { }
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

                trigger OnAfterGetRecord()

                begin

                    StyleRec.SetRange("Style No.", "Style No.");
                    if StyleRec.FindFirst() then begin
                        UniPrice := StyleRec."Unit Price";
                    end;


                end;

            }
            trigger OnPreDataItem()

            begin
                SetRange("Buyer No.", BuyerName);
            end;

            trigger OnAfterGetRecord()

            begin
                comRec.Get;
                comRec.CalcFields(Picture);
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
                    field(BuyerName; BuyerName)
                    {
                        ApplicationArea = All;
                        Caption = 'Buyer Name';
                        TableRelation = Customer."No.";

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
        StyleRec: Record "Style Master PO";
        UniPrice: Decimal;
        ConStRec: Record "Contract/LCStyle";
        Qt: BigInteger;
        BuyerName: Code[50];
        comRec: Record "Company Information";


}