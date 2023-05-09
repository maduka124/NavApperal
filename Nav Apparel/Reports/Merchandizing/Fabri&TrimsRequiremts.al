report 50610 FabricAndTrimsRequiremts
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Fabric & Trims requirements';
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
            dataitem(BOMPOSelection; BOMPOSelection)
            {

                DataItemLinkReference = BOM;
                DataItemLink = "BOM No." = field(No);
                DataItemTableView = sorting("BOM No.", "Style No.", "Lot No.");

                column(Factory_Name; FactoryName)
                { }
                column(Brand_Name; BrandName)
                { }
                column(PO_Total; PoTotal)
                { }
                column(PoNum; "PO No.")
                { }
                column(QTY1; Qty)
                { }
                column(shipDate; "Ship Date")
                { }
                trigger OnAfterGetRecord()
                var
                begin
                    BomRec.Reset();
                    BomRec.SetRange("Style No.", "Style No.");
                    if BomRec.FindFirst() then begin
                        Revishion := BomRec.Revision;
                    end;

                    StyleRec.Reset();
                    StyleRec.SetRange("No.", "Style No.");
                    if StyleRec.FindFirst() then begin
                        FactoryName := StyleRec."Factory Name";
                        BrandName := StyleRec."Brand Name";
                        PoTotal := StyleRec."PO Total";
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
                column(Revishion; Revishion)
                { }
                column(Item_Name; "Item Name")
                { }
                column(Main_Category_Name; "Main Category Name")
                { }
                column(Lot_No_; "Lot No.")
                { }
                column(PO; PO)
                { }
                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    StyleMasterPoRec.Reset();
                    StyleMasterPoRec.SetRange("PO No.", PO);
                    if StyleMasterPoRec.FindSet() then begin
                        POQty := StyleMasterPoRec.Qty
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
        FactoryName: Text[50];
        BrandName: Text[50];
        PoTotal: BigInteger;
        StyleRec: Record "Style Master";
        POQty: BigInteger;
        myInt: Integer;
        NoFilter: Code[20];
        StyleMasterPoRec: Record "Style Master PO";
        BomRec: Record BOM;
        styleNO_p: Code[20];
        Revishion: Integer;
        comRec: Record "Company Information";
        filterBom: Code[30];

}


