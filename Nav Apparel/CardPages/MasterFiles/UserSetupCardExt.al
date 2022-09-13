pageextension 71012743 UserSetupCardExt extends "User Setup"
{
    layout
    {
        addafter(Email)
        {
            field("Factory Code"; "Factory Code")
            {
                ApplicationArea = All;
                Caption = 'Factory';
            }

            field("Service Approval"; "Service Approval")
            {
                ApplicationArea = All;
            }

            field("GT Pass Approval"; "GT Pass Approve")
            {
                ApplicationArea = All;
            }
        }
    }
}