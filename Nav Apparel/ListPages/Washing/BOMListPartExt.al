pageextension 50658 WashinBOMList extends "Production BOM Lines"
{
    layout
    {
        addafter(Type)
        {
            field("Main Category Code"; "Main Category Code")
            {
                ApplicationArea = All;
            }

            field("Main Category Name"; "Main Category Name")
            {
                ApplicationArea = All;
                Editable = false;
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

        modify("No.")
        {

            ApplicationArea = all;

            // trigger OnLookup(var texts: text): Boolean
            // var
            //IteRec: Record Item;
            //begin
            // IteRec.Reset();
            // IteRec.SetRange("Main Category Name", 'CHEMICAL');
            // IteRec.FindSet();

            //end;

            // TableRelation = if ("Main Category Name" = filter('CHEMICAL')) Item where("Main Category Name" = filter('CHEMICAL'))
            // else
            // Item;
        }
    }
}