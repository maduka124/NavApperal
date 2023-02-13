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
            column(No_; "No.")
            { }
            column(Buyer; Buyer)
            { }
            column(CompLogo; comRec.Picture)
            { }
            // column()
            // { }
            // column()
            // { }
            // column()
            // { }

            dataitem("Contract/LCStyle"; "Contract/LCStyle")
            {
                DataItemLinkReference = "Contract/LCMaster";
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.");

                column(Style_Name; "Style Name")
                { }
                column(PoNo; PoNo)
                { }
                column(GarmentType; GarmentType)
                { }
                column(ShipDate; ShipDate)
                { }
                column(Color; Color)
                { }
                column(AssormentQty; AssormentQty)
                { }
                column(UnitPrice; UnitPrice)
                { }
                column(PoQty; PoQty)
                { }
                column(ShippedQty; ShippedQty)
                { }

                trigger OnAfterGetRecord()

                begin
                    StyleRec.Reset();
                    StyleRec.SetRange("No.", "Style No.");
                    if StyleRec.FindFirst() then begin
                        PoNo := StyleRec."PO No";
                        GarmentType := StyleRec."Garment Type Name";
                    end;

                    StylePoRec.Reset();
                    StylePoRec.SetRange("Style No.", "Style No.");
                    if StylePoRec.FindFirst() then begin
                        ShipDate := StylePoRec."Ship Date";
                        UnitPrice := StylePoRec."Unit Price";
                        PoQty := StylePoRec.Qty;
                        ShippedQty := StylePoRec."Shipped Qty";
                    end;

                    AssortmentRec.Reset();
                    AssortmentRec.SetRange("Style No.", "Style No.");
                    if AssortmentRec.FindFirst() then begin
                        Color := AssortmentRec."Colour Name";
                        AssormentQty := AssortmentRec.Qty;
                    end;
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
        comRec: Record "Company Information";
        ShippedQty: BigInteger;
        PoQty: Integer;
        UnitPrice: Decimal;
        AssormentQty: Integer;
        Color: Text[50];
        AssortmentRec: Record AssortmentDetails;
        ShipDate: Date;
        StylePoRec: Record "Style Master PO";
        GarmentType: text[50];
        PoNo: Code[20];
        StyleRec: Record "Style Master";
}