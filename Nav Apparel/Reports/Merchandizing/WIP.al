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
            column(Lot_No_; "Lot No.")
            { }
            column(PO_No; "PO No")
            { }
            column(PO_Total; "PO Total")
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(LC_No_Contract; "LC No/Contract")
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
                //  column()
                // { }
                //      column()
                // { }
                //      column()
                // { }
                //      column()
                // { }
                //      column()
                // { }
                //      column()
                // { }
                //      column()
                // { }
                //      column()
                // { }

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

                end;
            }
            trigger OnAfterGetRecord()

            begin
                comRec.Get;
                comRec.CalcFields(Picture);
            end;

            trigger OnPreDataItem()
            begin

                UserReC.Get(UserId);

                "Style Master".SetRange("Factory Code", UserReC."Factory Code");
                SetRange("Buyer No.", BuyerName);
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
                    field(BuyerName; BuyerName)
                    {
                        ApplicationArea = All;
                        Caption = 'Buyer';
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
        myInt: Integer;
        ShipMode: Option;
        SHMode: Text[50];
        comRec: Record "Company Information";
        UserReC: Record "User Setup";
        BuyerName: Code[20];
}