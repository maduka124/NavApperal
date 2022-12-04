page 71012687 "BOM Line Color ListPart"
{
    PageType = ListPart;
    SourceTable = "BOM Line";
    SourceTableView = where(Type = filter('1'));
    AutoSplitKey = true;
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

                field("GMT Color Name."; rec."GMT Color Name.")
                {
                    ApplicationArea = All;
                    Caption = 'GMT Color ';

                    trigger OnValidate()
                    var
                        ColourRec: Record Colour;
                    begin
                        ColourRec.Reset();
                        ColourRec.SetRange("Colour Name", rec."GMT Color Name.");
                        if ColourRec.FindSet() then
                            rec."GMT Color No." := ColourRec."No.";
                    end;
                }

                field("Item Name"; rec."Item Name")
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

                field("Construction Name."; rec."Construction Name.")
                {
                    ApplicationArea = All;
                    Caption = 'Article/Construction';

                    trigger OnValidate()
                    var
                        ConstructionRec: Record Article;
                    begin
                        ConstructionRec.Reset();
                        ConstructionRec.SetRange(Article, rec."Construction Name.");
                        if ConstructionRec.FindSet() then
                            rec."Construction No." := ConstructionRec."No.";
                    end;
                }

                field("Dimension Name"; rec."Dimension Name")
                {
                    ApplicationArea = All;
                    Caption = 'Dimension';

                    trigger OnValidate()
                    var
                        DimensionRec: Record DimensionWidth;
                    begin
                        DimensionRec.Reset();
                        DimensionRec.SetRange("Dimension Width", rec."Dimension Name");
                        if DimensionRec.FindSet() then
                            rec."Dimension No." := DimensionRec."No.";
                    end;
                }

                field("Item Color Name."; rec."Item Color Name.")
                {
                    ApplicationArea = All;
                    Caption = 'Item Color';

                    trigger OnValidate()
                    var
                        ColourRec: Record Colour;
                    begin
                        ColourRec.Reset();
                        ColourRec.SetRange("Colour Name", rec."item Color Name.");
                        if ColourRec.FindSet() then
                            rec."Item Color No." := ColourRec."No.";
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

    actions
    {
        area(Processing)
        {
            action("Copy Color")
            {
                ApplicationArea = All;
                Image = CopyDepreciationBook;

                trigger OnAction()
                var
                    BOMLineRec: Record "BOM Line";
                begin
                    BOMLineRec.Reset();
                    BOMLineRec.SetRange("No.", rec."No.");
                    BOMLineRec.SetRange(Type, 1);
                    BOMLineRec.SetRange("Line No", Lineno);
                    BOMLineRec.FindSet();
                    BOMLineRec."Item Color No." := ColorNo;
                    BOMLineRec."Item Color Name." := ColorName;
                    BOMLineRec.Modify();
                    CurrPage.Update();
                end;
            }
        }
    }


    trigger OnAfterGetCurrRecord()
    var

    begin
        ColorNo := rec."GMT Color No.";
        ColorName := rec."GMT Color Name.";
        Lineno := rec."Line No";
    end;

    var
        Lineno: Integer;
        ColorNo: Code[20];
        ColorName: Text[50];

}