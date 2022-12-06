pageextension 50640 LocationListExt extends "Location List"
{
    layout
    {
        addlast(Control1)
        {
            field("Plant Type Name"; Rec."Plant Type Name")
            {
                ApplicationArea = ALL;
            }

            field("Sewing Unit"; Rec."Sewing Unit")
            {
                ApplicationArea = ALL;
            }

            field("Start Time"; Rec."Start Time")
            {
                ApplicationArea = ALL;
            }

            field("Finish Time"; Rec."Finish Time")
            {
                ApplicationArea = ALL;
            }
        }
    }

}