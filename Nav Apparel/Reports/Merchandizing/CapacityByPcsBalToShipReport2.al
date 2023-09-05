report 51412 CapacityByPcsBalToShipReport2
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Shipping Balances Report';
    RDLCLayout = 'Report_Layouts/Merchandizing/CapacityByPcsBalToShipReport2.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Style Master"; "Style Master")
        {
            DataItemTableView = where(Status = filter('Confirmed'), "Buyer Name" = filter(<> ''));

            column(Season_Name; "Season Name")
            { }
            column(No_; "No.")
            { }
            column(Style_No_; "Style No.")
            { }
            column(Buyer_Name; "Buyer Name")
            { }
            column(SMV; SMV)
            { }
            column(Factory_Name; "Factory Name")
            { }
            column(Created_User; "Created User")
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(stDate; stDate)
            { }
            column(endDate; endDate)
            { }
            column(Brand_Name; "Brand Name")
            { }

            dataitem("Style Master PO"; "Style Master PO")
            {
                DataItemLinkReference = "Style Master";
                DataItemLink = "Style No." = field("No.");
                DataItemTableView = sorting("Lot No.") where(Status = filter('<> Cancel'));

                column(PO_No_; "PO No.")
                { }
                column(Qty; Qty)
                { }
                column(Mode; Mode)
                { }
                column(Sawing_Out_Qty; "Sawing Out Qty")
                { }
                column(Unit_Price; UnitPriceRound)
                { }
                column(Total; UnitPriceRound * Qty)
                { }
                column(Created_Date; "Created Date")
                { }
                column(Confirm_Date; "Confirm Date")
                { }
                column(BPCD; BPCD)
                { }
                column(Ship_Date; "Ship Date")
                { }
                column(Actual_Shipment_Qty; "ActualShipmentQty")
                { }
                column(BalShipment; "ActualShipmentQty" - Qty)
                { }

                trigger OnAfterGetRecord()
                var
                    PostSalesInvHeaderRec: Record "Sales Invoice Header";
                    PostSalesInvLineRec: Record "Sales Invoice Line";
                begin
                    UnitPriceRound := Round("Unit Price", 0.01, '=');

                    //Get postes salin invoices for the style / po
                    ActualShipmentQty := 0;
                    PostSalesInvHeaderRec.Reset();
                    PostSalesInvHeaderRec.SetRange("Style No", "Style No.");
                    PostSalesInvHeaderRec.SetRange("po No", "po No.");
                    PostSalesInvHeaderRec.SetRange(Lot, "lot No.");
                    if PostSalesInvHeaderRec.FindSet() then begin
                        repeat
                            PostSalesInvLineRec.Reset();
                            PostSalesInvLineRec.SetFilter("Document No.", PostSalesInvHeaderRec."No.");
                            if PostSalesInvLineRec.FindSet() then begin
                                repeat
                                    ActualShipmentQty += PostSalesInvLineRec.Quantity;
                                until PostSalesInvLineRec.Next() = 0;
                            end
                        until PostSalesInvHeaderRec.Next() = 0;
                    end;

                    if ActualShipmentQty >= Qty then
                        ActualShipmentQty := Qty;
                end;

                //Done By Sachith on 14/03/23
                trigger OnPreDataItem()
                begin
                    SetRange("Style Master PO"."Ship Date", stDate, endDate);
                    SetFilter(Qty, '>%1', 0);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                comRec.Get;
                comRec.CalcFields(Picture);
            end;

            trigger OnPreDataItem()
            begin
                //Done By Sachith on 28/02/23
                if "All buyers" = false then
                    SetRange("Buyer No.", Buyer);

                SetFilter("Buyer Name", '<>%1', '');
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

                    // Done By Sachith 28/02/23
                    field("All buyers"; "All buyers")
                    {
                        ApplicationArea = All;

                        Caption = 'All Buyer';
                        trigger OnValidate()
                        begin
                            if "All buyers" = true then
                                BuyerEditable := false
                            else
                                BuyerEditable := true;
                        end;
                    }

                    //Done By sachith On 14/02/23
                    field(Buyer; Buyer)
                    {
                        ApplicationArea = all;
                        Caption = 'Buyer';
                        Editable = BuyerEditable;
                        ShowMandatory = true;
                        TableRelation = Customer."No.";
                    }

                    field(stDate; stDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                        ShowMandatory = true;
                    }

                    field(endDate; endDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                        ShowMandatory = true;
                    }
                }
            }
        }

        //Done By Sachith on  28/02/23
        trigger OnOpenPage()
        begin
            BuyerEditable := true;
        end;
    }

    var
        vendorRec: Record Vendor;
        comRec: Record "Company Information";
        item: Record Item;
        Inx: Integer;
        stDate: Date;
        endDate: Date;
        UnitPriceRound: Decimal;
        //Done By sachith On 14/02/23
        Buyer: Code[20];
        "All buyers": Boolean;
        BuyerEditable: Boolean;
        ActualShipmentQty: Decimal;
}