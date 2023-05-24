report 51310 InventotyBalanceReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Inventory Balance Report';
    RDLCLayout = 'Report_Layouts/Store/InventoryBalanceReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Style Master"; "Style Master")
        {
            DataItemTableView = sorting("No.");
            column(Buyer; "Buyer Name")
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(Factory_Name; "Factory Name")
            { }
            column(ContractNo; ContractNo)
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
                    DataItemLinkReference = "Style Master";
                    DataItemLink = "Style No." = field("No.");
                    DataItemTableView = where("Entry Type" = filter(Consumption));
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

                if BuyerFilter <> '' then
                    SetRange("Buyer No.", BuyerFilter);

                if ContractFilter <> '' then
                    SetRange(ContractNo, ContractFilter);
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
                            MainCat.SetFilter("Style Related", '=%1', true);
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
                    field(BuyerFilter; BuyerFilter)
                    {
                        ApplicationArea = All;
                        TableRelation = Customer."No.";
                        Caption = 'Buyer';


                    }
                    field(ContractFilter; ContractFilter)
                    {
                        ApplicationArea = All;
                        TableRelation = "Contract/LCMaster"."No.";
                        Caption = 'Contract No';

                    }
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
        ColorItem: Code[20];
        TotalValue: Decimal;
        Unitprice: Decimal;
        ContractFilter: Code[20];
        BuyerFilter: Code[20];
        MAinCatFilter: Text[50];
        FactoryFilter: Code[20];
        comRec: Record "Company Information";
        Dimension: Text[100];
        Article: Text[250];
        Size: Code[20];
        ItemName: Text[100];
        ItemRec: Record Item;
}