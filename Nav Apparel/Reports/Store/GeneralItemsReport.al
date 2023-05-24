report 50311 GeneralItemesReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'General Item Report';
    RDLCLayout = 'Report_Layouts/Store/GeneralItemsReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Style Master"; "Style Master")
        {
            DataItemTableView = sorting("No.");

            column(CompLogo; comRec.Picture)
            { }
            column(Factory_Name; "Factory Name")
            { }
            column(Style_Name; "Style No.")
            { }

            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLinkReference = "Style Master";
                DataItemLink = "Style No." = field("No.");
                DataItemTableView = where("Entry Type" = filter(Consumption));

                column(Main_Category_Name; "Main Category Name")
                { }
                column(Location_Code; "Location Code")
                { }
                column(Item_No_; "Item No.")
                { }
                column(ItemName; ItemName)
                { }
                column(Color; Color)
                { }
                column(Size; Size)
                { }
                column(Article; Article)
                { }
                column(Dimension; Dimension)
                { }
                column(Unit_of_Measure_Code; "Unit of Measure Code")
                { }
                column(Quantity; Quantity * -1)
                { }
                column(Unitprice; Unitprice)
                { }
                column(TotalValue; TotalValue)
                { }


                trigger OnAfterGetRecord()

                begin
                    ItemRec.Reset();
                    ItemRec.SetRange("No.", "Item No.");
                    if ItemRec.FindFirst() then begin
                        ItemName := ItemRec.Description;
                        Size := ItemRec."Size Range No.";
                        Article := ItemRec.Article;
                        Dimension := ItemRec."Dimension Width";
                        Unitprice := ItemRec."Unit Price";
                    end;


                    TotalValue := (Quantity * -1) * Unitprice
                end;

                trigger OnPreDataItem()

                begin
                    if MAinCatFilter <> '' then
                        SetRange(MainCategory, MAinCatFilter);
                end;
            }
            trigger OnAfterGetRecord()

            begin
                comRec.Get;
                comRec.CalcFields(Picture);
            end;

            trigger OnPreDataItem()

            begin
                if FactoryFilter <> '' then
                    SetRange("Factory Code", FactoryFilter);

              
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
                    field(FactoryFilter; FactoryFilter)
                    {
                        ApplicationArea = All;
                        TableRelation = Location.Code;
                        Caption = 'Factory';

                    }
                    field(MAinCatFilter; MAinCatFilter)
                    {
                        ApplicationArea = All;
                        TableRelation = "Main Category"."No." where("Style Related" = filter(false));
                        Caption = 'Main Category';


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
        TotalValue: Decimal;
        Unitprice: Decimal;
        ContractFilter: Code[20];
        BuyerFilter: Code[20];
        MAinCatFilter: Code[20];
        FactoryFilter: Code[20];
        comRec: Record "Company Information";
        Dimension: Text[100];
        Article: Text[250];
        Size: Code[20];
        ItemName: Text[100];
        ItemRec: Record Item;
}