page 71012689 "BOM Line Size ListPart"
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

                field("GMR Size Name"; "GMR Size Name")
                {
                    ApplicationArea = All;
                    Caption = 'GMT Size';
                    Editable = false;
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

                field("Dimension Name"; "Dimension Name")
                {
                    ApplicationArea = All;
                    Caption = 'Dimension';

                    trigger OnValidate()
                    var
                        DimensionRec: Record DimensionWidth;
                    begin
                        DimensionRec.Reset();
                        DimensionRec.SetRange("Dimension Width", "Dimension Name");
                        if DimensionRec.FindSet() then
                            "Dimension No." := DimensionRec."No.";

                        CurrPage.Update();
                        if "Dimension No." <> '' then begin
                            "Main Cat size Name" := ''
                        end;
                    end;
                }

                field("Main Cat size Name"; "Main Cat size Name")
                {
                    ApplicationArea = All;
                    Caption = 'Main Category size';
                    ShowMandatory = false;

                    trigger OnValidate()
                    var

                    begin
                        if "Main Cat size Name" <> '' then begin
                            "Dimension No." := '';
                            "Dimension Name" := '';
                        end;
                    end;
                }

                field(Placement; Placement)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Price; Price)
                {
                    ApplicationArea = All;
                }

                field(WST; WST)
                {
                    ApplicationArea = All;
                }

                field(Select; Select)
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

                    if "Dimension No." <> '' then begin
                        Message('Clear Dimension Value Size');
                    end
                    else begin
                        BOMLineRec.Reset();
                        BOMLineRec.SetRange("No.", "No.");
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
                    BOMLineRec.SetRange("No.", "No.");
                    BOMLineRec.SetRange(Type, 2);
                    BOMLineRec.SetRange("Item No.", ItemNo);
                    BOMLineRec.SetRange("Main Cat size Name", SizeName);
                    BOMLineRec.FindSet();

                    BOMLineRec.ModifyAll(Price, Price);
                    CurrPage.Update();

                end;
            }
        }
    }


    trigger OnAfterGetCurrRecord()
    var

    begin
        SizeName := "GMR Size Name";
        Lineno := "Line No";
        Price := Price;
        ItemNo := "Item No.";
        MainCateSize := "Main Cat size Name";
    end;

    var
        Lineno: Integer;
        SizeName: Text[50];
        Price: Decimal;
        ItemNo: Code[20];
        MainCateSize: Text[50];

}