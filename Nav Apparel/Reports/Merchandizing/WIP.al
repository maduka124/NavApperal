report 50641 WIPReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'WIP Report';
    RDLCLayout = 'Report_Layouts/Merchandizing/WIPReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Style Master"; "Style Master")
        {
            DataItemTableView = sorting("No.");
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
            column(PO_Total; "PO Total")
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(LC_No_Contract; ContractName)
            { }

            dataitem("Style Master PO"; "Style Master PO")
            {
                DataItemLinkReference = "Style Master";
                DataItemLink = "Style No." = field("No.");
                DataItemTableView = sorting("Style No.");

                column(SHMode; SHMode)
                { }
                column(Cut_In_Qty; "Cut In Qty")
                { }
                column(Wash_In_Qty; "Wash In Qty")
                { }
                column(Wash_Out_Qty; "Wash Out Qty")
                { }
                column(Shipped_Qty; "Shipped Qty")
                { }
                column(Ship_Date; "Ship Date")
                { }
                column(Sawing_In_Qty; "Sawing In Qty")
                { }
                column(Sawing_Out_Qty; "Sawing Out Qty")
                { }
                column(Finish_Qty; "Finish Qty")
                { }
                column(ShValue; RoundUnitPrice * "Shipped Qty")
                { }
                column(fOB; Qty * RoundUnitPrice)
                { }
                column(ExSHORT; Qty - "Shipped Qty")
                { }
                column(PoQty; Qty)
                { }
                column(ExtDate; ExtDate)
                { }
                column(PO_No; "PO No.")
                { }
                column(Lot_No_; "Lot No.")
                { }
                column(RoundUnitPrice; RoundUnitPrice)
                { }
                column(QtyGB; "Actual Shipment Qty")
                { }
                column(ShipValue; ShipValue)
                { }

                trigger OnAfterGetRecord()
                var
                begin
                    QtyGB := 0;
                    ShipValue := 0;
                    ShipValue2 := 0;
                    ShipMode := Mode;
                    SHMode := '';
                    if ShipMode = 0 then begin
                        SHMode := 'Sea';
                    end
                    else
                        if ShipMode = 1 then begin
                            SHMode := 'Air';
                        end
                        else
                            if ShipMode = 2 then begin
                                SHMode := 'Sea-Air';
                            end
                            else
                                if ShipMode = 3 then begin
                                    SHMode := 'Air-Sea';
                                end
                                else
                                    if ShipMode = 4 then begin
                                        SHMode := 'By-Road';
                                    end;

                    SalesInvoiceRec.SetRange("Style No", "Style No.");
                    SalesInvoiceRec.SetRange("PO No", "PO No.");
                    if SalesInvoiceRec.FindFirst() then begin
                        ExtDate := SalesInvoiceRec."Document Date";
                    end;

                    RoundUnitPrice := Round("Unit Price", 0.01, '=');

                    salesInvoiceLineRec.Reset();
                    // QtyGB := 0;
                    SalesInvoiceRec.Reset();
                    SalesInvoiceRec.SetRange(Lot, "Lot No.");
                    SalesInvoiceRec.SetRange("Style No", "Style No.");
                    SalesInvoiceRec.SetRange("PO No", "PO No.");
                    SalesInvoiceRec.SetFilter(Cancelled, '<>%1', true);
                    if SalesInvoiceRec.FindSet() then begin
                        // repeat
                        SalesInvoiceLineRec.SetRange("Document No.", SalesInvoiceRec."No.");
                        SalesInvoiceLineRec.SetRange(Type, SalesInvoiceLineRec.Type::Item);
                        if SalesInvoiceLineRec.FindSet() then begin
                            repeat
                                // QtyGB := QtyGB + SalesInvoiceLineRec.Quantity;
                                // SalesInvoiceLineRec.CalcSums("Line Amount");
                                ShipValue2 := SalesInvoiceLineRec."Line Amount";
                                ShipValue := ShipValue + ShipValue2;
                            until SalesInvoiceLineRec.Next() = 0;
                        end;
                        // until SalesInvoiceRec.Next() = 0;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                comRec.Get;
                comRec.CalcFields(Picture);

                ContractRec.SetRange("No.", AssignedContractNo);
                if ContractRec.FindFirst() then begin
                    ContractName := ContractRec."Contract No";
                end;


            end;


            trigger OnPreDataItem()
            begin
                //UserReC.Get(UserId);
                //"Style Master".SetRange("Factory Code", UserReC."Factory Code");
                if STFilter <> '' then
                    SetRange("No.", STFilter);
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
                    field(STFilter; STFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Style';
                        TableRelation = "Style Master"."No.";

                        // trigger OnLookup(var Text: Text): Boolean
                        // var
                        //     StyleMasterRec: Record "Style Master";
                        //     Users: Record "User Setup";
                        // begin
                        //     StyleMasterRec.Reset();
                        //     Users.Reset();
                        //     Users.SetRange("User ID", UserId());
                        //     if Users.FindSet() then begin
                        //         if Users."Factory Code" <> '' then
                        //             StyleMasterRec.SetRange("Factory Code", Users."Factory Code");
                        //         if StyleMasterRec.FindSet() then begin
                        //             if Page.RunModal(51067, StyleMasterRec) = Action::LookupOK then
                        //                 STFilter := StyleMasterRec."No.";
                        //         end
                        //         else begin
                        //             if Page.RunModal(51067, StyleMasterRec) = Action::LookupOK then
                        //                 STFilter := StyleMasterRec."No.";
                        //         end;
                        //     end;
                        // end;
                    }
                }
            }
        }
    }

    procedure PassParameters(StyleNoPara: Code[200])
    var
    begin
        STFilter := StyleNoPara;
    end;

    var

        // CutIn: BigInteger;
        // CutIn: BigInteger;

        ProdRec: Record ProductionOutHeader;
        ShipMode: Option;
        SHMode: Text[50];
        comRec: Record "Company Information";
        UserReC: Record "User Setup";
        STFilter: Code[200];
        // SalesInvoiceRec: Record "Sales Invoice Header";
        ExtDate: Date;
        ContractRec: Record "Contract/LCMaster";
        ContractName: Text[100];
        LcStyleRec: Record "Contract/LCStyle";
        RoundUnitPrice: Decimal;
        SalesInvoiceRec: Record "Sales Invoice Header";
        SalesInvoiceLineRec: Record "Sales Invoice Line";
        QtyGB: Integer;
        ShipValue: Decimal;
        ShipValue2: Decimal;
}