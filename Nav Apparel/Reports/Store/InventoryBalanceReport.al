report 51310 InventotyBalanceReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Inventory Balance Report';
    RDLCLayout = 'Report_Layouts/Store/InventoryBalanceReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {


        dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
        {
            // DataItemLinkReference = "Style Master";
            // DataItemLink = StyleNo = field("No.");
            DataItemTableView = where(Type = filter(item));

            column(Buyer; "Buyer Name")
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(Factory_Name; LocationName)
            { }
            // column(ContractNo; ContractNo)
            // { }
            column(Style_Name; StyleName)
            { }
            column(Location_Code; "Location Code")
            { }
            dataitem("Contract/LCStyle"; "Contract/LCStyle")
            {
                DataItemLinkReference = "Purch. Rcpt. Line";
                DataItemLink = "Style No." = field(StyleNo);

                column(ContractNo; "No.")
                { }
                trigger OnPreDataItem()
                var

                begin
                    if ContractFilter <> '' then
                        SetRange("No.", ContractFilter);
                end;
            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLinkReference = "Purch. Rcpt. Line";
                DataItemLink = "Item No." = field("No.");
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
            trigger OnAfterGetRecord()

            begin
                comRec.Get;
                comRec.CalcFields(Picture);

                LocationRec.Reset();
                LocationRec.SetRange(Code, "Location Code");
                if LocationRec.FindFirst() then begin
                    LocationName := LocationRec.Name;
                end;

                StyleRec.Reset();
                StyleRec.SetRange("No.", StyleNo);
                if StyleRec.FindSet() then begin

                end;
            end;

            trigger OnPreDataItem()

            begin
                if FactoryFilter <> '' then
                    SetRange("Location Code", FactoryFilter);

                if BuyerFilter <> '' then
                    SetRange("Buyer No.", BuyerFilter);


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
                        // TableRelation = Location.Code;
                        Caption = 'Factory';


                        trigger OnLookup(var texts: text): Boolean
                        var
                            LocationRec: Record Location;
                            LocationRec2: Record Location;
                            UserRec: Record "User Setup";
                        begin
                            LocationRec.Reset();
                            UserRec.Reset();
                            UserRec.Get(UserId);

                            LocationRec2.Reset();
                            LocationRec.Reset();
                            LocationRec.SetRange(Code, UserRec."Factory Code");
                            if LocationRec.FindSet() then begin
                                if Page.RunModal(15, LocationRec) = Action::LookupOK then begin
                                    FactoryFilter := LocationRec.Code;
                                end;
                            end
                            // else
                            //     if Page.RunModal(15, LocationRec2) = Action::LookupOK then begin
                            //         FactortFilter := LocationRec2.Code;
                            //     end;
                        end;

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
                            // else
                            // if Page.RunModal(50641, MainCat) = Action::LookupOK then begin
                            //     MAinCatFilter := MainCat."Master Category Name";
                            // end;
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


                        trigger OnLookup(var Text: Text): Boolean
                        var
                            ContracRec: Record "Contract/LCMaster";
                        begin

                            ContracRec.Reset();

                            ContracRec.SetRange("Buyer No.", BuyerFilter);


                            if ContracRec.FindSet() then begin
                                if Page.RunModal(50503, ContracRec) = Action::LookupOK then
                                    ContractFilter := ContracRec."No.";
                            end
                            else
                                if Page.RunModal(50503, ContracRec) = Action::LookupOK then
                                    ContractFilter := ContracRec."No.";
                        end;

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

        StyleRec: Record "Style Master";
        LocationName: Text[100];
        LocationRec: Record Location;
        ContractFilter: Code[20];
        BuyerFilter: Code[20];
        MAinCatFilter: Text[50];
        FactoryFilter: Code[10];
        comRec: Record "Company Information";

}