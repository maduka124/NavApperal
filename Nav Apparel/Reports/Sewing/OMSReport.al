report 51309 OMSReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'OMS Report';
    RDLCLayout = 'Report_Layouts/Sewing/OMSReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Style Master"; "Style Master")
        {
            DataItemTableView = where(Status = filter('Confirmed'));

            column(ContractLCno; ContractLCno)
            { }
            column(ContractNo; ContractNo)
            { }
            column(Store_Name; "Store Name")
            { }
            column(Season_Name; "Season Name")
            { }
            column(Brand_Name; "Brand Name")
            { }
            column(Department_Name; "Department Name")
            { }
            column(Buyer_Name; "Buyer Name")
            { }
            column(No_; "No.")
            { }
            column(Style_No_; "Style No.")
            { }
            column(Order_Qty; "Order Qty")
            { }
            column(Lot_No_; "Lot No.")
            { }
            column(CompLogo; comRec.Picture)
            { }

            dataitem("Style Master PO"; "Style Master PO")
            {
                DataItemLinkReference = "Style Master";
                DataItemLink = "Style No." = field("No.");

                column(PO_No_; "PO No.")
                { }
                column(Qty; Qty)
                { }
                column(Mode; Mode)
                { }
                column(Cut_In_Qty; "Cut In Qty")
                { }
                column(Cut_Out_Qty; "Cut Out Qty")
                { }
                column(Emb_In_Qty; "Emb In Qty")
                { }
                column(Emb_Out_Qty; "Emb Out Qty")
                { }
                column(Print_In_Qty; "Print In Qty")
                { }
                column(Print_Out_Qty; "Print Out Qty")
                { }
                column(Sawing_In_Qty; "Sawing In Qty")
                { }
                column(Sawing_Out_Qty; "Sawing Out Qty")
                { }
                column(Wash_In_Qty; "Wash In Qty")
                { }
                column(Wash_Out_Qty; "Wash Out Qty")
                { }
                column(Finish_Qty; "Finish Qty")
                { }
                column(Shipped_Qty; "Shipped Qty")
                { }
                column(shipQty; shipQty)
                { }
                column(Ship_Date; "Ship Date")
                { }
                column(Unit_Price; "Unit Price")
                { }
                column(ShipDate; ShipDate)
                { }

                trigger OnAfterGetRecord()
                var
                    PostedSalesInvHdrRec: Record "Sales Invoice Header";
                    PostedSalesInvLineRec: Record "Sales Invoice Line";
                begin

                    PostedSalesInvHdrRec.Reset();
                    PostedSalesInvHdrRec.SetRange("Style No", "Style No.");
                    PostedSalesInvHdrRec.SetRange("PO No", "PO No.");

                    if PostedSalesInvHdrRec.FindFirst() then begin

                        InvoiceNo := PostedSalesInvHdrRec."No.";
                        ShipDate := PostedSalesInvHdrRec."Shipment Date";

                        PostedSalesInvLineRec.Reset();
                        PostedSalesInvLineRec.SetRange("Document No.", InvoiceNo);

                        if PostedSalesInvLineRec.FindFirst() then begin
                            shipQty := 0;
                            repeat
                                shipQty := shipQty + PostedSalesInvLineRec.Quantity;
                            until PostedSalesInvLineRec.Next() = 0;
                        end;
                    end;



                end;
            }

            trigger OnAfterGetRecord()
            var
                ContractLCRec: Record "Contract/LCMaster";
            begin

                comRec.Get;
                comRec.CalcFields(Picture);

                ContractLCRec.Reset();
                ContractLCRec.SetRange("No.", AssignedContractNo);

                if ContractLCRec.FindFirst() then
                    ContractLCno := ContractLCRec."Contract No";
            end;
        }
    }

    var
        ContractLCno: Text[50];
        shipQty: BigInteger;
        InvoiceNo: Code[20];
        ShipDate: Date;
        comRec: Record "Company Information";
}