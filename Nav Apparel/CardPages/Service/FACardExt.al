pageextension 50733 FACardExt extends "Fixed Asset Card"
{
    layout
    {
        addafter("Last Date Modified")
        {
            field("Machine category"; rec."Machine category")
            {
                ApplicationArea = All;
            }

            field("Model number"; rec."Model number")
            {
                ApplicationArea = All;
            }

            field("RPM/Machine type"; rec."RPM/Machine type")
            {
                ApplicationArea = All;
            }

            field("Motor number"; rec."Motor number")
            {
                ApplicationArea = All;
            }

            field("Features "; rec."Features ")
            {
                ApplicationArea = All;
            }
        }
    }
}