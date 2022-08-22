pageextension 50733 FACardExt extends "Fixed Asset Card"
{
    layout
    {
        addafter("Last Date Modified")
        {
            field("Machine category"; "Machine category")
            {
                ApplicationArea = All;
            }

            field("Model number"; "Model number")
            {
                ApplicationArea = All;
            }

            field("RPM/Machine type"; "RPM/Machine type")
            {
                ApplicationArea = All;
            }

            field("Motor number"; "Motor number")
            {
                ApplicationArea = All;
            }

            field("Features "; "Features ")
            {
                ApplicationArea = All;
            }
        }
    }
}