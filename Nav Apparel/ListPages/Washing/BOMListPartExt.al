pageextension 50658 WashinBOMList extends "Production BOM Lines"
{
    layout
    {
        addafter(Type)
        {
            field("Main Category Name"; "Main Category Name")
            {
                ApplicationArea = All;

                trigger OnValidate()
                var
                    MainCategoryRec: Record "Main Category";
                    ItemRec: Record Item;
                begin
                    MainCategoryRec.Reset();
                    MainCategoryRec.SetRange("Main Category Name", "Main Category Name");
                    if MainCategoryRec.FindSet() then
                        "Main Category Code" := MainCategoryRec."No.";
                end;

            }
        }


        addafter("Unit of Measure Code")
        {
            field(Step; Step)
            {
                ApplicationArea = All;
            }

            field("Water(L)"; "Water(L)")
            {
                ApplicationArea = All;
            }

            field(Temperature; Temperature)
            {
                ApplicationArea = All;
                Caption = 'Temperature (C)';
            }

            field(Time; Time)
            {
                ApplicationArea = All;
                Caption = 'Time (Minutes)';
            }

            field("Weight(Kg)"; "Weight(Kg)")
            {
                ApplicationArea = All;
            }

            field(Remark; Remark)
            {
                ApplicationArea = All;
            }
        }
    }
}