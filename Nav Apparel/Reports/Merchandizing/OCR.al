report 50612 OCR
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = 'Report_Layouts/Merchandizing/OCR.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Style Master"; "Style Master")
        {
            DataItemTableView = sorting("No.");
            column(Season_Name; "Season Name")
            { }
            column(Buyer_Name; "Buyer Name")
            { }
            column(Garment_Type_Name; "Garment Type Name")
            { }
            column(Style_No_; "Style No.")
            { }
            column(Order_Qty; "Order Qty")
            { }
            column(Garment_Type_No_; "Garment Type No.")
            { }
            column(No_; "No.")
            { }
            column(PO_Total; "PO Total")
            { }
            column(styleNO_p; styleNO_p)
            { }
            column(Department_Name_style; "Department Name")
            { }
            column(Ship_Date_Style; "Ship Date")
            { }
            column(Factory_Name; "Factory Name")
            { }
            column(FobPcs; FobPcs)
            { }
            column(CompLogo; comRec.Picture)
            { }

            dataitem(BOM; BOM)
            {
                DataItemLinkReference = "Style Master";
                DataItemLink = "Style No." = field("No.");
                DataItemTableView = sorting(No);

                dataitem("BOM Line AutoGen"; "BOM Line AutoGen")
                {
                    DataItemLinkReference = BOM;
                    DataItemLink = "No." = field(No);
                    DataItemTableView = sorting("Item No.");

                    column(Placement_of_GMT; "Placement of GMT")
                    { }
                    column(GMT_Color_Name; "GMT Color Name")
                    { }
                    column(Article_Name_; "Article Name.")
                    { }
                    column(Item_No_; "Item No.")
                    { }
                    column(Item_Color_Name; "Item Color Name")
                    { }
                    column(Unit_N0_; "Unit N0.")
                    { }
                    column(Qty; Qty)
                    { }
                    column(WST; WST)
                    { }
                    column(Type; Type)
                    { }
                    column(Consumption; Consumption)
                    { }
                    column(RequirmentQTY; Requirment)
                    { }
                    column(AjstReq; AjstReq)
                    { }
                    column(Dimension_Name_; "Dimension Name.")
                    { }
                    column(Revishion; Revishion)
                    { }
                    column(Item_Name; "Item Name")
                    { }
                    column(UnitPrice; Rate)
                    { }
                    column(Main_Category_Name; "Main Category Name")
                    { }
                    column(Value; Value)
                    { }
                    column(TotFab; TotFab)
                    { }
                    column(GarmentConsumption; GarmentConsumption)
                    { }
                    column(GMT_Qty; "GMT Qty")
                    { }
                    column(Divi; Divi)
                    { }
                    column(Actual_Procured; ActualProc)
                    { }
                    column(ActualProcVal; ActualProcVal)
                    { }
                    column(TransferLineRecSReceived; TransferLineRecSReceived)
                    { }
                    column(NewItemNo; "New Item No.")
                    { }
                    column(Supplier_Name_; "Supplier Name.")
                    { }

                    trigger OnAfterGetRecord()
                    var
                    begin
                        ActualProc := 0;
                        purchRec.Reset();
                        purchRec.SetRange("No.", "BOM Line AutoGen"."New Item No.");
                        purchRec.SetRange(StyleName, "Style Master"."Style No.");
                        purchRec.SetRange(PONo, "BOM Line AutoGen"."PO");
                        purchRec.SetRange(Lot, "BOM Line AutoGen"."Lot No.");
                        purchRec.SetRange("Color Name", "BOM Line AutoGen"."Item Color Name");
                        if purchRec.Findset() then begin
                            repeat
                                ActualProc += purchRec.Quantity;
                            until purchRec.Next() = 0;
                        end;

                        // if "Item No." = 'ABA-ITEM-0407' then
                        //     "Item No." := "Item No.";

                        ActualProcVal := ActualProc * Rate;

                        TransferLineRecSReceived := 0;
                        ItemLeRec.Reset();
                        ItemLeRec.SetRange("Style No.", "Style Master"."No.");
                        ItemLeRec.SetRange(PO, "BOM Line AutoGen"."PO");
                        ItemLeRec.SetRange("Item No.", "BOM Line AutoGen"."New Item No.");
                        if ItemLeRec.FindSet() then begin
                            repeat
                                if ItemLeRec."Entry Type" = ItemLeRec."Entry Type"::Consumption then begin
                                    TransferLineRecSReceived += ItemLeRec.Quantity * -1;
                                end;
                            until ItemLeRec.Next() = 0;
                        end;

                        TotFab := 0;
                        GarmentConsumption := Qty * Consumption;

                        // TransferLineRec.Reset();
                        // TransferLineRec.SetRange("Item No.", "BOM Line AutoGen"."Item No.");
                        // if TransferLineRec.FindSet() then begin
                        //     // TransferLineRecSReceived := TransferLineRec."Quantity Received"
                        // end;

                        BomRec.Reset();
                        BomRec.SetRange(No, "Style Master"."No.");
                        BomRec.SetRange("Style No.", "Style Master"."Style No.");
                        if BomRec.FindFirst() then begin
                            Revishion := BomRec.Revision;
                        end;

                        if "Main Category Name" = 'FABRIC' then begin
                            TotFab += Value;
                        end;
                        Divi := 0;
                        if Type = 0 then begin
                            Divi := 12;
                        end
                        else
                            Divi := 1;
                    end;
                }
            }

            dataitem("Style Master PO"; "Style Master PO")
            {
                DataItemLinkReference = "Style Master";
                DataItemLink = "Style No." = field("No.");
                DataItemTableView = sorting("Style No.");

                column(PoNum; "PO No.")
                { }
                column(shipDate; "Ship Date")
                { }
                column(QTY1; Qty)
                { }
                column(lineAmt; lineAmt)
                { }
                column(Unit_Price_PO; "Unit Price")
                { }
                column(Style_No_po; "Style No.")
                { }
                column(salesInvoiceLineQuanty; salesInvoiceLineQuanty)
                { }

                // dataitem("Sales Invoice Header"; "Sales Invoice Header")
                // {
                //     DataItemLinkReference = "Style Master PO";
                //     DataItemLink = "Order No." = field("PO No.");
                //     DataItemTableView = sorting("No.");
                //     column(salesInvoiceLineQuanty; salesInvoiceLineQuanty)
                //     { }

                //     trigger OnAfterGetRecord()
                //     var
                //     begin
                //         salesInvoiceLineRec.Reset();
                //         salesInvoiceLineRec.SetRange("Document No.", "Sales Invoice Header"."No.");
                //         if salesInvoiceLineRec.FindFirst() then begin
                //             salesInvoiceLineQuanty := salesInvoiceLineRec.Quantity
                //         end;
                //     end;
                // }

                trigger OnAfterGetRecord()
                var
                    SalesInvHeaderRec: Record "Sales Invoice Header";
                    SalesInvLineRec: Record "Sales Invoice Line";
                begin
                    lineAmt := 0;
                    salesInvoiceLineQuanty := 0;
                    lineAmt := "Style Master PO".Qty * "Style Master PO"."Unit Price";

                    SalesInvHeaderRec.Reset();
                    SalesInvHeaderRec.SetRange("Style No", "Style No.");
                    SalesInvHeaderRec.SetRange("PO No", "po No.");
                    if SalesInvHeaderRec.Findset() then begin
                        repeat
                            SalesInvLineRec.Reset();
                            SalesInvLineRec.SetRange("Document No.", SalesInvHeaderRec."No.");
                            if SalesInvLineRec.Findset() then begin
                                repeat
                                    salesInvoiceLineQuanty += SalesInvLineRec.Quantity;
                                until SalesInvLineRec.Next() = 0;
                            end;
                        until SalesInvHeaderRec.Next() = 0;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                PoTOt := "PO Total";
                BomEstiRec.SetRange("No.", "No.");
                if BomEstiRec.FindFirst() then begin
                    FobPcs := BomEstiRec."FOB Pcs";
                end;

                comRec.Get;
                comRec.CalcFields(Picture);
            end;

            trigger OnPreDataItem()
            begin
                SetRange("No.", FilterNo);
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
                    field(FilterNo; FilterNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Style';
                        TableRelation = "Style Master"."No.";
                    }
                }
            }
        }
    }

    var
        NoFilter: Code[20];
        StyleMasterPoRec: Record "Style Master PO";
        BomRec: Record BOM;
        styleNO_p: Code[20];
        Revishion: Integer;
        postedPurchLineRec: Record "Purch. Rcpt. Line";
        QuantityPurch: Decimal;
        TotFab: Decimal;
        lineAmt: Decimal;
        // TransferLineRec: Record "Transfer Line";
        TransferLineRecSReceived: Decimal;
        styleNOFil: Text[50];
        salesInvoiceLineRec: Record "Sales Invoice Line";
        salesInvoiceLineQuanty: Decimal;
        GarmentConsumption: Decimal;
        ItemLeRec: Record "Item Ledger Entry";
        ReqQty: Decimal;
        PoTOt: BigInteger;
        Divi: Integer;
        vbalance: Decimal;
        BomEstiRec: Record "BOM Estimate Cost";
        FobPcs: Decimal;
        comRec: Record "Company Information";
        FilterNo: Code[30];
        ItemLedgerRec: Record "Item Ledger Entry";
        IssueQty: Decimal;
        purchRec: Record "Purch. Rcpt. Line";
        ActualProc: Decimal;
        ActualProcVal: Decimal;
}


