report 50627 ProductionAndShipmentDetails
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Production & Shipment Details';
    RDLCLayout = 'Report_Layouts/Production/ProductionAndShipmentDetails.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Style Master"; "Style Master")
        {
            DataItemTableView = sorting("No.");

            column(Buyer; "Buyer Name")
            { }
            column(StyleNo; "Style No.")
            { }
            column(SMV; SMV)
            { }
            column(OrderQty; "Order Qty")
            { }
            column(stDate; stDate)
            { }
            column(endDate; endDate)
            { }
            column(AssignedContractNo; AssignedContractNo)
            { }
            column(CompLogo; comRec.Picture)
            { }

            // column()
            // { }


            dataitem("Style Master PO"; "Style Master PO")
            {
                DataItemLinkReference = "Style Master";
                DataItemLink = "Style No." = field("No.");
                DataItemTableView = sorting("Style No.");
                column(cutting; "Cut Out Qty")
                { }
                column(Sewing; "Sawing Out Qty")
                { }
                column(Finishing; "Finish Qty")
                { }
                column(ShipDate; "Ship Date")
                { }
                column(PoNo; "PO No.")
                { }


                trigger OnPreDataItem()
                begin
                    SetRange("Ship Date", stDate, endDate);
                end;
            }

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
                        Caption = 'Shipping Start Date';

                    }
                    field(endDate; endDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Shipping End Date';

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

        stDate: Date;
        endDate: Date;
        comRec: Record "Company Information";
}