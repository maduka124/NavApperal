page 71012831 "Gate Pass ListPart"
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

                field("Inventory Type"; "Inventory Type")
                {
                    ApplicationArea = All;
                }

                field("Main Category Name"; "Main Category Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        MainCategoryRec: Record "Main Category";
                        FAClassRec: Record "FA Class";
                    begin
                        if ("Inventory Type" = "Inventory Type"::Inventory) then begin
                            MainCategoryRec.Reset();
                            MainCategoryRec.SetRange("Main Category Name", "Main Category Name");
                            if MainCategoryRec.FindSet() then
                                "Main Category Code" := MainCategoryRec."No.";
                        end
                        else
                            if ("Inventory Type" = "Inventory Type"::"Fixed Assets") then begin
                                FAClassRec.Reset();
                                FAClassRec.SetRange(name, "Main Category Name");
                                if FAClassRec.FindSet() then
                                    "Main Category Code" := FAClassRec."code";
                            end;

                        CurrPage.Update();
                    end;


                }

                field(Description; Description)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        ItemRec: Record Item;
                        FARec: Record "Fixed Asset";
                        UOMRec: Record "Unit of Measure";
                    begin

                        if ("Inventory Type" = "Inventory Type"::Inventory) then begin
                            ItemRec.Reset();
                            ItemRec.SetRange(Description, Description);
                            if ItemRec.FindSet() then begin
                                "Item No." := ItemRec."No.";
                                "UOM Code" := ItemRec."Base Unit of Measure";

                                UOMRec.Reset();
                                UOMRec.SetRange(Code, "UOM Code");
                                if UOMRec.FindSet() then
                                    UOM := UOMRec.Description;
                            end;
                        end
                        else
                            if ("Inventory Type" = "Inventory Type"::"Fixed Assets") then begin
                                FARec.Reset();
                                FARec.SetRange(Description, Description);
                                if FARec.FindSet() then
                                    "Item No." := FARec."No.";
                            end;

                        //Enabled := true;
                    end;
                }

                field(UOM; UOM)
                {
                    ApplicationArea = All;
                }

                field(Qty; Qty)
                {
                    ApplicationArea = All;
                }

                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    // var
    //     Enabled: Boolean;
}