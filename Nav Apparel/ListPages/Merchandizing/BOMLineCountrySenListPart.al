page 71012690 "BOM Line Country ListPart"
{
    PageType = ListPart;
    SourceTable = "BOM Line";
    SourceTableView = where(Type = filter('3'));
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Main Category Name"; rec."Main Category Name")
                {
                    ApplicationArea = All;
                    Caption = 'Main Category';

                    trigger OnValidate()
                    var
                        MainCategoryRec: Record "Main Category";
                    begin
                        MainCategoryRec.Reset();
                        MainCategoryRec.SetRange("Main Category Name", rec."Main Category Name");
                        if MainCategoryRec.FindSet() then
                            rec."Main Category No." := MainCategoryRec."No.";
                    end;
                }

                field("Item Name";rec. "Item Name")
                {
                    ApplicationArea = All;
                    Caption = 'Item';

                    trigger OnValidate()
                    var
                        ItemRec: Record "Item";
                    begin
                        ItemRec.Reset();
                        ItemRec.SetRange(Description, rec."Item Name");
                        if ItemRec.FindSet() then
                            rec."Item No." := ItemRec."No.";
                    end;
                }

                field("Country Name"; rec."Country Name")
                {
                    ApplicationArea = All;
                    Caption = 'Country';

                    trigger OnValidate()
                    var
                        CountryRec: Record "Country/Region";
                    begin
                        CountryRec.Reset();
                        CountryRec.SetRange("Name",rec."Country Name");
                        if CountryRec.FindSet() then
                           rec. "Country Code" := CountryRec.Code;
                    end;
                }

                field(Placement; rec.Placement)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Select; rec.Select)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}