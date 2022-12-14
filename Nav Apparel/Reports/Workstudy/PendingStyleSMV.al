report 50640 PendingStyleSMV
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Pending Style SMV';
    RDLCLayout = 'Report_Layouts/Workstudy/PendingStyleSMV.rdl';
    DefaultLayout = RDLC;


    dataset
    {
        dataitem("Style Master"; "Style Master")
        {
            DataItemTableView = sorting("No.");

            column(FactoryName; "Factory Name")
            { }
            column(BuyerN; BuyerN)
            { }
            column(StyleN; StyleN)
            { }
            column(GarmentType; GarmentType)
            { }
            column(OrderQty; OrderQty)
            { }
            column(ShipDate; ShipDate)
            { }
            column(CreateDate; CreateDate)
            { }
            column(CostSMV; CostSMV)
            { }
            column(MerchantName; MerchantName)
            { }
            column(Season; Season)
            { }
            column(CompLogo; comRec.Picture)
            { }


            trigger OnAfterGetRecord()

            begin
                if CostingSMV = 0 then begin
                    BuyerN := "Buyer Name";
                    StyleN := "Style No.";
                    GarmentType := "Garment Type Name";
                    OrderQty := "Order Qty";
                    ShipDate := "Ship Date";
                    CreateDate := "Created Date";
                    CostSMV := CostingSMV;
                    MerchantName := "Merchandiser Name";
                    Season := "Season Name";

                end;
                comRec.Get;
                comRec.CalcFields(Picture);
            end;

            trigger OnPreDataItem()

            begin
                SetRange("Factory Code", FactoryCode);
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
                    field(FactoryCode; FactoryCode)
                    {
                        ApplicationArea = All;
                        TableRelation = Location.Code;
                        Caption = 'Factory';

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

        BuyerN: Text[50];
        StyleN: Text[50];
        GarmentType: Text[50];
        OrderQty: BigInteger;
        ShipDate: Date;
        CreateDate: Date;
        CostSMV: Decimal;
        MerchantName: Text[50];
        Season: Text[50];
        comRec: Record "Company Information";
        FactoryCode: Code[20];

}