pageextension 50837 WorkCenterListExt extends "Work Center List"
{
    layout
    {
        addafter(Name)
        {
            field("Planning Line"; "Planning Line")
            {
                ApplicationArea = all;
            }

            field("Linked To Service Item"; "Linked To Service Item")
            {
                ApplicationArea = all;
            }
        }
    }
}