page 51033 "BOM Line Size ListPart"
{
    PageType = ListPart;
    SourceTable = "BOM Line";
    SourceTableView = where(Type = filter('2'));
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

                field("GMR Size Name"; rec."GMR Size Name")
                {
                    ApplicationArea = All;
                    Caption = 'GMT Size';
                    Editable = false;
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

                        CurrPage.Update();
                        if rec."Dimension No." <> '' then begin
                            rec."Main Cat size Name" := ''
                        end;
                    end;
                }

                field("Main Cat size Name"; rec."Main Cat size Name")
                {
                    ApplicationArea = All;
                    Caption = 'Main Category size';
                    ShowMandatory = false;

                    trigger OnValidate()
                    var

                    begin
                        if rec."Main Cat size Name" <> '' then begin
                            rec."Dimension No." := '';
                            rec."Dimension Name" := '';
                        end;
                    end;
                }

                field(Placement; rec.Placement)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Price; rec.Price)
                {
                    ApplicationArea = All;
                }

                field(WST; rec.WST)
                {
                    ApplicationArea = All;
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
            action("Copy Size")
            {
                ApplicationArea = All;
                Image = CopyBOMVersion;

                trigger OnAction()
                var
                    BOMLineRec: Record "BOM Line";
                begin

                    if rec."Dimension No." <> '' then begin
                        Message('Clear Dimension Value Size');
                    end
                    else begin
                        BOMLineRec.Reset();
                        BOMLineRec.SetRange("No.", rec."No.");
                        BOMLineRec.SetRange(Type, 2);
                        BOMLineRec.SetRange("Line No", Lineno);
                        BOMLineRec.FindSet();
                        BOMLineRec."Main Cat size Name" := SizeName;
                        BOMLineRec.Modify();
                        CurrPage.Update();
                    end;
                end;
            }

            action("Copy Price to same Sizes")
            {
                ApplicationArea = All;
                Image = Price;

                trigger OnAction()
                var
                    BOMLineRec: Record "BOM Line";
                begin

                    BOMLineRec.Reset();
                    BOMLineRec.SetRange("No.", rec."No.");
                    BOMLineRec.SetRange(Type, 2);
                    BOMLineRec.SetRange("Item No.", ItemNo);
                    BOMLineRec.SetRange("Main Cat size Name", SizeName);
                    BOMLineRec.FindSet();

                    BOMLineRec.ModifyAll(Price, rec.Price);
                    CurrPage.Update();

                end;
            }
        }
    }


    trigger OnAfterGetCurrRecord()
    var

    begin
        SizeName := rec."GMR Size Name";
        Lineno := rec."Line No";
        Pricee := rec.Price;
        ItemNo := rec."Item No.";
        MainCateSize := rec."Main Cat size Name";
    end;

    var
        Lineno: Integer;
        SizeName: Text[50];
        Pricee: Decimal;
        ItemNo: Code[20];
        MainCateSize: Text[50];

}