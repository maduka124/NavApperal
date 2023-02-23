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
            column(LC_No_Contract; ContractNo)
            { }
            // column()
            // {}
            dataitem("Style Master PO"; "Style Master PO")
            {

                DataItemLinkReference = "Style Master";
                DataItemLink = "Style No." = field("No.");
                DataItemTableView = sorting("Style No.");
                column(SHMode; SHMode)
                { }
                column(Cut_In_Qty; "Cut In Qty")
                { }
                column(Emb_Out_Qty; "Emb Out Qty")
                { }
                column(Emb_In_Qty; "Emb In Qty")
                { }
                column(Print_Out_Qty; "Print Out Qty")
                { }
                column(Print_In_Qty; "Print In Qty")
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
                trigger OnAfterGetRecord()
                var

                begin
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
                end;

            }

            trigger OnAfterGetRecord()

            begin
                comRec.Get;
                comRec.CalcFields(Picture);

                LcStyleRec.SetRange("Style No.", "No.");
                if LcStyleRec.FindFirst() then begin
                    ContractRec.SetRange("No.", LcStyleRec."No.");
                    if ContractRec.FindFirst() then begin
                        ContractNo := ContractRec."Contract No";
                    end;
                end;
            end;

            trigger OnPreDataItem()
            begin

                UserReC.Get(UserId);

                "Style Master".SetRange("Factory Code", UserReC."Factory Code");
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

                    }
                }
            }
        }


    }

    procedure PassParameters(StyleNoPara: Code[20])
    var
    begin
        STFilter := StyleNoPara;
    end;

    var
        myInt: Integer;
        ShipMode: Option;
        SHMode: Text[50];
        comRec: Record "Company Information";
        UserReC: Record "User Setup";
        STFilter: Code[20];
        SalesInvoiceRec: Record "Sales Invoice Header";
        ExtDate: Date;
        ContractRec: Record "Contract/LCMaster";
        ContractNo: Text[50];
        LcStyleRec: Record "Contract/LCStyle";
        RoundUnitPrice: Decimal;

}