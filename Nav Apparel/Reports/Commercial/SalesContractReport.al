report 51245 SalesContractReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Sales Contract Report';
    RDLCLayout = 'Report_Layouts/Commercial/SalesContractReport.rdl';
    DefaultLayout = RDLC;


    dataset
    {
        dataitem("Contract/LCMaster"; "Contract/LCMaster")
        {
            RequestFilterFields = "No.";
            column(No_; "Contract No")
            { }
            column(Buyer; Buyer)
            { }
            column(CompLogo; comRec.Picture)
            { }
            dataitem("Contract/LCStyle"; "Contract/LCStyle")
            {
                DataItemLinkReference = "Contract/LCMaster";
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.");

                column(Style_Name; "Style Name")
                { }
                dataitem("Style Master PO"; "Style Master PO")
                {
                    DataItemLinkReference = "Contract/LCStyle";
                    DataItemLink = "Style No." = field("Style No.");
                    DataItemTableView = sorting("Style No.", "Lot No.");
                    column(GarmentType; GarmentType)
                    { }
                    column(UnitPrice; "Unit Price")
                    { }
                    column(PoQty; Qty)
                    { }
                    column(ShippedQty; "Shipped Qty")
                    { }
                    column(PoNo; "PO No.")
                    { }
                    column(ShipDate; "Ship Date")
                    { }
                    dataitem(AssortmentDetails; AssortmentDetails)
                    {
                        DataItemLinkReference = "Style Master PO";
                        DataItemLink = "Style No." = field("Style No."), "PO No." = field("PO No.");
                        DataItemTableView = sorting("Style No.", "Lot No.");

                        column(Color; "Colour Name")
                        { }
                        column(AssormentQty; AssormentQty)
                        { }
                        trigger OnAfterGetRecord()

                        begin
                            AssorColorRationRec.Reset();
                            AssorColorRationRec.SetRange("Style No.", "Style No.");
                            AssorColorRationRec.SetRange("PO No.", "PO No.");
                            AssorColorRationRec.SetRange("Colour No", "Colour No");
                            if AssorColorRationRec.FindFirst() then begin
                                AssormentQty := AssorColorRationRec.Total;
                            end;
                        end;
                    }
                    trigger OnAfterGetRecord()
                    begin

                        StyleRec.Reset();
                        StyleRec.SetRange("No.", "Style No.");
                        if StyleRec.FindFirst() then begin
                            GarmentType := StyleRec."Garment Type Name";
                        end;
                    end;
                }
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
                    // field(Name; SourceExpression)
                    // {
                    //     ApplicationArea = All;

                    // }
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
        AssormentQty: Integer;
        AssorColorRationRec: Record AssorColorSizeRatio;
        comRec: Record "Company Information";
        Color: Text[50];
        GarmentType: text[50];
        StyleRec: Record "Style Master";
}