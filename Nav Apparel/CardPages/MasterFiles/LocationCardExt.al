pageextension 71012738 LocationCardExt extends "Location Card"
{
    layout
    {
        addafter("Use As In-Transit")
        {
            field("Plant Type No."; "Plant Type No.")
            {
                ApplicationArea = All;
                Caption = 'Plant Type No';
                TableRelation = "Plant Type"."Plant Type No.";

                trigger OnValidate()
                var
                    PlantTypeRec: Record "Plant Type";
                begin
                    PlantTypeRec.get("Plant Type No.");
                    "Plant Type Name" := PlantTypeRec."Plant Type Name";
                end;
            }

            field("Plant Type Name"; "Plant Type Name")
            {
                ApplicationArea = All;
            }

            field("Sewing Unit"; "Sewing Unit")
            {
                ApplicationArea = All;
            }

            field("Start Time"; "Start Time")
            {
                ApplicationArea = ALL;
            }

            field("Finish Time"; "Finish Time")
            {
                ApplicationArea = ALL;
            }
        }
    }
}