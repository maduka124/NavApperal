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
                    MerchantName := "Merchandiser Name";
                    Season := "Season Name";

                end;

                comRec.Get;
                comRec.CalcFields(Picture);


            end;

            trigger OnPreDataItem()

            begin
                user := UserId;
                UserReC.Get(UserId);
                if UserReC."User ID" = user then begin
                    if UserReC."Factory Code" = 'ABC' then begin
                        vis1 := true
                    end
                    else
                        vis1 := false;
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
                    field(FactoryCode; FactoryCode)
                    {
                        ApplicationArea = All;
                        // TableRelation = Location.Code;
                        Caption = 'Factory';
                        Visible = vis1;

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
        MerchantName: Text[50];
        Season: Text[50];
        comRec: Record "Company Information";
        FactoryCode: Code[20];
        user: Text[100];
        UserReC: Record "User Setup";
        vis1: Boolean;
        vis2: Boolean;

}