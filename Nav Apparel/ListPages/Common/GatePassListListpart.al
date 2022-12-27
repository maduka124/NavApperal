page 50628 "Gate Pass ListPart"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = "Gate Pass Line";
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("Inventory Type"; Rec."Inventory Type")
                {
                    ApplicationArea = All;
                }

                field("Main Category Name"; Rec."Main Category Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        MainCategoryRec: Record "Main Category";
                        FAClassRec: Record "FA Class";
                        ServiceItemRec: Record "Service Item";
                        GatepassLineRec: Record "Gate Pass Line";
                    begin

                        if (Rec."Inventory Type" = Rec."Inventory Type"::Inventory) then begin
                            MainCategoryRec.Reset();
                            MainCategoryRec.SetRange("Main Category Name", Rec."Main Category Name");
                            if MainCategoryRec.FindSet() then
                                Rec."Main Category Code" := MainCategoryRec."No.";
                        end;

                        if (Rec."Inventory Type" = Rec."Inventory Type"::"Fixed Assets") then begin
                            FAClassRec.Reset();
                            FAClassRec.SetRange(name, Rec."Main Category Name");
                            if FAClassRec.FindSet() then
                                Rec."Main Category Code" := FAClassRec."code";
                        end;
                    end;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        ItemRec: Record Item;
                        FARec: Record "Fixed Asset";
                        UOMRec: Record "Unit of Measure";
                        ServiceItemRec: Record "Service Item";
                    begin
                        if (Rec."Inventory Type" = Rec."Inventory Type"::Inventory) then begin
                            ItemRec.Reset();
                            ItemRec.SetRange(Description, Rec.Description);
                            if ItemRec.FindSet() then begin
                                Rec."Item No." := ItemRec."No.";
                                Rec."UOM Code" := ItemRec."Base Unit of Measure";

                                UOMRec.Reset();
                                UOMRec.SetRange(Code, Rec."UOM Code");
                                if UOMRec.FindSet() then
                                    Rec.UOM := UOMRec.Description;
                            end;
                        end;

                        if (Rec."Inventory Type" = Rec."Inventory Type"::"Fixed Assets") then begin
                            FARec.Reset();
                            FARec.SetRange(Description, Rec.Description);
                            if FARec.FindSet() then
                                Rec."Item No." := FARec."No.";
                        end;

                        if (Rec."Inventory Type" = rec."Inventory Type"::"Service Machine") then begin

                            ServiceItemRec.Reset();
                            ServiceItemRec.SetRange(Description, Rec.Description);
                            if ServiceItemRec.FindSet() then
                                Rec.Description := ServiceItemRec.Description;
                            Rec."Item No." := ServiceItemRec."Item No.";

                            ItemRec.Reset();
                            ItemRec.SetRange("No.", Rec."Item No.");
                            if ItemRec.FindSet() then
                                rec.UOM := ItemRec."Base Unit of Measure";
                        end;
                        CurrPage.Update();
                    end;
                }

                field(UOM; Rec.UOM)
                {
                    ApplicationArea = All;
                }

                field(Qty; Rec.Qty)
                {
                    ApplicationArea = All;
                }

                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}