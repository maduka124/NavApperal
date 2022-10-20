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
                ShowMandatory = true;
            }

            field("Service Approval"; "Service Approval")
            {
                ApplicationArea = All;
            }

            field("GT Pass Approval"; "GT Pass Approve")
            {
                ApplicationArea = All;
            }

            field(UserRole; UserRole)
            {
                ApplicationArea = All;
                Caption = 'User Role';
                ShowMandatory = true;
            }

            field("Global Dimension Code"; "Global Dimension Code")
            {
                ApplicationArea = All;
                ShowMandatory = true;
            }
        }
    }
}