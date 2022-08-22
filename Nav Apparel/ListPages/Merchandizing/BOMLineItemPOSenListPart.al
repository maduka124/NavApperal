page 71012691 "BOM Line ItemPO ListPart"
{
    PageType = ListPart;
    SourceTable = "BOM Line";
    SourceTableView = where(Type = filter('4'));
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Main Category Name"; "Main Category Name")
                {
                    ApplicationArea = All;
                    Caption = 'Main Category';

                    trigger OnValidate()
                    var
                        MainCategoryRec: Record "Main Category";
                    begin
                        MainCategoryRec.Reset();
                        MainCategoryRec.SetRange("Main Category Name", "Main Category Name");
                        if MainCategoryRec.FindSet() then
                            "Main Category No." := MainCategoryRec."No.";
                    end;
                }

                field("Item Name"; "Item Name")
                {
                    ApplicationArea = All;
                    Caption = 'Item';

                    trigger OnValidate()
                    var
                        ItemRec: Record "Item";
                    begin
                        ItemRec.Reset();
                        ItemRec.SetRange(Description, "Item Name");
                        if ItemRec.FindSet() then
                            "Item No." := ItemRec."No.";
                    end;
                }

                field("Lot No."; "Lot No.")
                {
                    ApplicationArea = All;
                    Caption = 'Lot';
                    Editable = false;
                }
                field("PO No."; "PO No.")
                {
                    ApplicationArea = All;
                    Caption = 'PO';
                    Editable = false;
                }

                field(Placement; Placement)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Select; Select)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}