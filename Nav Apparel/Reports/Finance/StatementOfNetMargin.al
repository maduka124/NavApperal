report 50637 StatementOfNetMargin
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Statement Of Net Margin Report';
    RDLCLayout = 'Report_Layouts/Finance/StatementOfNetMargin.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Style Master PO"; "Style Master PO")
        {
            DataItemTableView = sorting("Style No.");
            column(Style_No_; "Style No.")
            { }
            column(Qty; Qty)
            { }
            column(Unit_Price; "Unit Price")
            { }
            column(TotalValue; Qty * "Unit Price")
            { }
            // column(Description; Description)
            // { }
            column(stDate; stDate)
            { }
            column(endDate; endDate)
            { }
            column(CompLogo; comRec.Picture)
            { }


            dataitem("BOM Estimate Cost"; "BOM Estimate Cost")
            {
                DataItemLinkReference = "Style Master PO";
                DataItemLink = "Style No." = field("Style No.");
                DataItemTableView = sorting("No.");
                column(Washing__Dz__; "Washing (Dz.)")
                { }
                column(Raw_Material__Dz__; "Raw Material (Dz.)")
                { }
                column(Commercial_Pcs; "Commercial Pcs")
                { }
                column(Profit_Margin_Pcs; "Profit Margin Pcs")
                { }
                column(Commission_Pcs; "Commission Pcs")
                { }
                column(Description; "Style No.")
                { }

                column(TOT; "Washing (Dz.)" + "Raw Material (Dz.)" + "Commission Pcs" + "Profit Margin Pcs" + "Commercial Pcs")
                { }
                //     column()
                // { }
                //     column()
                // { }
                dataitem("Style Master"; "Style Master")
                {
                    DataItemLinkReference = "Style Master PO";
                    DataItemLink = "No." = field("Style No.");
                    DataItemTableView = sorting("No.");

                    column(buyer; "Buyer Name")
                    { }
                    column(Vendor;"Merchandiser Name")
                    { }

                    trigger OnPreDataItem()
                    begin
                        SetRange("Buyer No.", buyerName);
                    end;


                }
                trigger OnAfterGetRecord()
                var

                begin
                    // StyleRec.Get("Style No.");
                    // ItemRec.SetRange("No.", StyleRec."Item No");
                    // if ItemRec.FindFirst() then begin
                    //     Description := ItemRec.Description;
                    // end;
                    // VendorRec.SetRange("No.", ItemRec."Vendor No.");
                    // if VendorRec.FindFirst() then begin
                    // vendor := VendorRec.Name;
                    // end;

                end;
            }
            trigger OnPreDataItem()
            begin
                SetRange("Created Date", stDate, endDate);
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
                    field(stDate; stDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';

                    }
                    field(endDate; endDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';


                    }
                    field(buyerName; buyerName)
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
        StyleRec: Record "Style Master";
        ItemRec: Record Item;
        Description: text[200];
        VendorRec: Record Vendor;
        stDate: Date;
        endDate: Date;
        buyerName: code[20];
        vendor: text[100];
        comRec: Record "Company Information";

}