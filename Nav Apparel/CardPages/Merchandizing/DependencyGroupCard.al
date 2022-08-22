page 71012706 "Dependency Group Card"
{
    PageType = Card;
    SourceTable = "Dependency Group";
    Caption = 'Dependency Group';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Dependency Group No';
                }

                field("Dependency Group"; "Dependency Group")
                {
                    ApplicationArea = All;
                    Caption = 'Dependency Group Name';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            // action(Save)
            // {
            //     ApplicationArea = All;

            //     trigger OnAction()
            //     begin

            //     end;
            // }
        }
    }
}