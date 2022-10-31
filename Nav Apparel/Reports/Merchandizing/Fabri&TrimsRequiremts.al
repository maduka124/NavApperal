report 50610 FabricAndTrimsRequiremts
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Fabric & Trims requiremts';
    RDLCLayout = 'Report_Layouts/Merchandizing/FabricAndTrimsRequiremts.rdl';
    DefaultLayout = RDLC;


    dataset
    {
        dataitem(BOM; BOM)
        {
            DataItemTableView = sorting(No);

            column(Buyer_Name; "Buyer Name")
            { }
            column(Season_Name; "Season Name")
            { }
            column(Style_No_; "Style Name")
            { }
            column(Garment_Type_Name; "Garment Type Name")
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(Garment_Type_No_; "Garment Type No.")
            { }
            dataitem("Style Master"; "Style Master")
            {

                DataItemLinkReference = BOM;
                DataItemLink = "No." = field("Style No.");
                DataItemTableView = sorting("No.");


                // column(Order_Qty; "Order Qty")
                // { }
                // column(No_; "No.")
                // { }
                column(PO_Total; "PO Total")
                { }
                // column(styleNO_p; styleNO_p)
                // { }


                dataitem("Style Master PO"; "Style Master PO")
                {
                    DataItemLinkReference = BOM;
                    DataItemLink = "Style No." = field("Style No.");

                    DataItemTableView = sorting("Lot No.");
                    column(PoNum; "PO No.")
                    { }
                    column(shipDate; "Ship Date")
                    { }
                    column(QTY1; Qty)
                    { }

                }





                trigger OnAfterGetRecord()
                var

                begin

                    // StyleMasterPoRec.Get("No.", "Lot No.");
                    BomRec.Reset();
                    BomRec.SetRange(No, "Style Master"."No.");
                    BomRec.SetRange("Style No.", "Style Master"."Style No.");
                    if BomRec.FindFirst() then begin
                        Revishion := BomRec.Revision;
                    end;


                end;


            }
            dataitem("BOM Line AutoGen"; "BOM Line AutoGen")
            {
                DataItemLinkReference = BOM;
                DataItemLink = "No." = field(No);
                DataItemTableView = sorting("No.");

                column(Placement_of_GMT; "Placement of GMT")
                { }
                column(GMT_Color_Name; "GMT Color Name")
                { }
                column(Article_Name_; "Article Name.")
                { }
                column(Item_Color_Name; "Item Color Name")
                { }
                column(Unit_N0_; "Unit N0.")
                { }
                column(Qty; "GMT Qty")
                { }
                column(WST; WST)
                { }
                column(Type; Type)
                { }
                column(Consumption; Consumption)
                { }
                column(RequirmentQTY; Requirment)
                { }
                column(AjstReq; AjstReq)
                { }
                column(Dimension_Name_; "Dimension Name.")
                { }
                column(GMT_Size_Name; "GMT Size Name")
                { }
                // column(PoNum; StyleMasterPoRec."PO No.")
                // { }
                // column(shipDate; StyleMasterPoRec."Ship Date")
                // { }
                // column(QTY1; StyleMasterPoRec.Qty)
                // { }
                column(Revishion; Revishion)
                { }
                column(Item_Name; "Item Name")
                { }
                column(Main_Category_Name; "Main Category Name")
                { }

            }

            trigger OnAfterGetRecord()

            begin
                comRec.Get;
                comRec.CalcFields(Picture);
            end;

            trigger OnPreDataItem()

            begin
                SetRange(No, filterBom);
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
                    field(filterBom; filterBom)
                    {
                        ApplicationArea = All;
                        Caption = 'BOM No';
                        TableRelation = BOM.No;


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
        NoFilter: Code[20];
        StyleMasterPoRec: Record "Style Master PO";
        BomRec: Record BOM;
        // PoNum: Code[20];
        // shipDate: Date;
        // QTY1: BigInteger;
        styleNO_p: Code[20];
        Revishion: Integer;
        comRec: Record "Company Information";
        filterBom: Code[30];

}


