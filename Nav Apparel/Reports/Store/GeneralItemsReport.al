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
            column(Location_Code; "Factory Code")
            { }
            dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
            {
                DataItemLinkReference = "Style Master";
                DataItemLink = StyleNo = field("No.");
                DataItemTableView = where(Type = filter(item));

                dataitem("Item Ledger Entry"; "Item Ledger Entry")
                {
                    DataItemLinkReference = "Purch. Rcpt. Line";
                    DataItemLink = "Document No." = field("Document No.");
                    // DataItemTableView = where("Entry Type" = filter(Consumption));

                    column(Quantity; Quantity * -1)
                    { }

                }
                dataitem(Item; Item)
                {
                    DataItemLinkReference = "Purch. Rcpt. Line";
                    DataItemLink = "No." = field("No.");
                    DataItemTableView = sorting("No.");

                    column(Unitprice; "Unit Price")
                    { }
                    column(Unit_of_Measure_Code; "Base Unit of Measure")
                    { }
                    column(Color; "Color No.")
                    { }
                    column(Size; "Size Range No.")
                    { }
                    column(Article; Article)
                    { }
                    column(Dimension; "Dimension Width No.")
                    { }
                    column(Main_Category_Name; "Main Category Name")
                    { }
                    column(ItemName; Description)
                    { }
                    column(Item_No_; "No.")
                    { }
                    trigger OnPreDataItem()
                    var
                        myInt: Integer;
                    begin
                        if MAinCatFilter <> '' then
                            SetRange("Main Category Name", MAinCatFilter);
                    end;
                }


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
                        // TableRelation = "Main Category"."No." where("Style Related" = filter(false));
                        Caption = 'Main Category';

                        trigger OnLookup(var texts: text): Boolean
                        var
                            MainCat: Record "Main Category";

                        begin
                            MainCat.Reset();
                            MainCat.SetFilter("Style Related", '=%1', false);
                            if MainCat.FindSet() then begin
                                if Page.RunModal(50641, MainCat) = Action::LookupOK then begin
                                    MAinCatFilter := MainCat."Master Category Name";
                                end;
                            end
                            else
                                if Page.RunModal(50641, MainCat) = Action::LookupOK then begin
                                    MAinCatFilter := MainCat."Master Category Name";
                                end;
                        end;


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
        ColorItem: Code[20];
        TotalValue: Decimal;
        Unitprice: Decimal;
        MAinCatFilter: Text[50];
        FactoryFilter: Code[20];
        comRec: Record "Company Information";
        Dimension: Text[100];
        Article: Text[250];
        Size: Code[20];
        ItemName: Text[100];
        ItemRec: Record Item;
}