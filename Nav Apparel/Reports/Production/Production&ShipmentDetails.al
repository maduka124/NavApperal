report 50627 ProductionAndShipmentDetails
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Production & Shipment Details';
    RDLCLayout = 'Report_Layouts/Production/ProductionAndShipmentDetails.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Style Master PO"; "Style Master PO")
        {

            DataItemTableView = where("Cut Out Qty" = filter(> 0));
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
            column(stDate; stDate)
            { }
            column(endDate; endDate)
            { }
            column(Buyer; Buyer)
            { }
            column(StyleNo; StyleName)
            { }
            column(SMV; SMV)
            { }
            column(OrderQty; OrderQty)
            { }
            column(AssignedContractNo; AssignContrantNo)
            { }
            column(CompLogo; comRec.Picture)
            { }


            trigger OnPreDataItem()
            begin
                SetRange("Ship Date", stDate, endDate);
            end;

            trigger OnAfterGetRecord()

            begin
                comRec.Get;
                comRec.CalcFields(Picture);

                StyleMasterRec.Reset();
                StyleMasterRec.SetRange("No.", "Style No.");
                if StyleMasterRec.FindFirst() then begin
                    Buyer := StyleMasterRec."Buyer Name";
                    StyleName := StyleMasterRec."Style No.";
                    SMV := StyleMasterRec.SMV;
                    OrderQty := StyleMasterRec."Order Qty";
                    AssignContrantNo := StyleMasterRec.AssignedContractNo;
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
        AssignContrantNo: Code[20];
        OrderQty: BigInteger;
        SMV: Decimal;
        StyleName: Text[50];
        Buyer: Text[50];
        StyleMasterRec: Record "Style Master";
        stDate: Date;
        endDate: Date;
        comRec: Record "Company Information";
}