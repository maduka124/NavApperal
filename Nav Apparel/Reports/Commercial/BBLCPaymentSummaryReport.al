report 51408 BBLCPaymentSummaryReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'BBLC Payment Summary Report';
    RDLCLayout = 'Report_Layouts/Commercial/BBLCPaymentSummaryReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(GITBaseonLC; GITBaseonLC)
        {
            DataItemTableView = sorting("GITLCNo.");

            column(CompLogo; comRec.Picture)
            { }
            column(BuyerNo; BuyerNo)
            { }
            column(BuyerName; BuyerName)
            { }
            column(ContractNo; ContractNo)
            { }
            column(B2BLCNo; B2BLCNo)
            { }
            column(B2B_LC_Value; B2BLCValue)
            { }
            column(Supplier; "Suppler Name")
            { }
            column(InvoiceDate; "Invoice Date")
            { }
            column(InvoiceNo; "Invoice No")
            { }
            column(InvoiceValue; "Invoice Value")
            { }
            column(OriginalDocRecvDate; "Original Doc. Recv. Date")
            { }
            column(BLNO; "BL/AWB NO")
            { }
            column(BLDate; "BL Date")
            { }
            column(ContainerNo; "Container No")
            { }
            column(CarrierName; "Carrier Name")
            { }
            column(Agent; "Agent")
            { }
            column(MVesselName; "M. Vessel Name")
            { }
            column(MVesselDate; "M. Vessel ETD")
            { }
            column(FVesselName; "F. Vessel Name")
            { }
            column(FVesselETA; "F. Vessel ETA")
            { }
            column(FVesselETD; "F. Vessel ETD")
            { }
            column(OriginaltoCF; "Original to C&F")
            { }
            column(Goodinhouse; "Good inhouse")
            { }
            column(Billofentry; "Bill of entry")
            { }
            column(Remarks; "Remarks")
            { }
            column(AcceptedDate; "AcceptedDate")
            { }
            column(AcceptedValue; "AcceptedValue")
            { }


            trigger OnPreDataItem()
            begin
                if BuyerNo = '' then
                    Error('Select a buyer.');

                if ContractNo = '' then
                    Error('Select a Contract.');

                if B2BLCNo = '' then
                    Error('Select a B2B LC.');

                SetRange("ContractLC No", ContractNo);
                SetRange("B2B LC No.", B2BLCNo);
            end;


            trigger OnAfterGetRecord()
            var
                AcceptanceHeaderRec: Record AcceptanceHeader;
                B2BLCRec: Record B2BLCMaster;
            begin
                B2BLCValue := 0;

                comRec.Get;
                comRec.CalcFields(Picture);

                B2BLCRec.Reset();
                B2BLCRec.SetRange("B2B LC No", B2BLCNo);
                if B2BLCRec.FindSet() then
                    B2BLCValue := B2BLCRec."B2B LC Value";

                AcceptanceHeaderRec.Reset();
                AcceptanceHeaderRec.SetRange("B2BLC No", B2BLCNo);
                if AcceptanceHeaderRec.FindSet() then begin
                    if AcceptanceHeaderRec.Approved = true and AcceptanceHeaderRec.Paid = true then begin
                        AcceptedDate := AcceptanceHeaderRec."Accept Date";
                        AcceptedValue := AcceptanceHeaderRec."Accept Value"
                    end
                    else begin
                        AcceptedDate := 0D;
                        AcceptedValue := 0;
                    end;
                end
                else begin
                    AcceptedDate := 0D;
                    AcceptedValue := 0;
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
                group(Filter)
                {
                    Caption = 'Filter By';

                    field(BuyerNo; BuyerNo)
                    {
                        ApplicationArea = all;
                        Caption = 'Buyer';
                        TableRelation = Customer."No.";

                        trigger OnValidate()
                        var
                            CustomerRec: Record Customer;
                        begin
                            CustomerRec.Reset();
                            CustomerRec.SetRange("No.", BuyerNo);
                            CustomerRec.FindSet();
                            BuyerName := CustomerRec.Name;
                        end;
                    }

                    field(ContractNo; ContractNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Contract No';

                        trigger OnLookup(var texts: text): Boolean
                        var
                            ContractRec: Record "Contract/LCMaster";
                        begin
                            ContractRec.Reset();
                            ContractRec.SetRange("Buyer No.", BuyerNo);
                            if ContractRec.FindSet() then begin
                                if Page.RunModal(50503, ContractRec) = Action::LookupOK then begin
                                    ContractNo := ContractRec."Contract No";
                                end;
                            end;
                        end;
                    }

                    field(B2BLCNo; B2BLCNo)
                    {
                        ApplicationArea = All;
                        Caption = 'B2B LC No';

                        trigger OnLookup(var texts: text): Boolean
                        var
                            GITBaseonLCRec: Record GITBaseonLC;
                            B2BLCNo1: Text[50];
                        begin
                            GITBaseonLCRec.Reset();
                            GITBaseonLCRec.SetRange("ContractLC No", ContractNo);
                            if GITBaseonLCRec.FindSet() then begin
                                repeat
                                    if B2BLCNo1 <> GITBaseonLCRec."B2B LC No." then begin
                                        B2BLCNo1 := GITBaseonLCRec."B2B LC No.";
                                        GITBaseonLCRec.Mark(true);
                                    end
                                until GITBaseonLCRec.Next() = 0;
                                GITBaseonLCRec.MarkedOnly(true);

                                if Page.RunModal(51409, GITBaseonLCRec) = Action::LookupOK then begin
                                    B2BLCNo := GITBaseonLCRec."B2B LC No.";
                                end;
                            end;
                        end;
                    }
                }
            }
        }
    }


    var
        BuyerNo: Code[20];
        BuyerName: Text[200];
        ContractNo: Code[50];
        B2BLCNo: Code[50];
        comRec: Record "Company Information";
        AcceptedDate: Date;
        AcceptedValue: Decimal;
        B2BLCValue: Decimal;

}