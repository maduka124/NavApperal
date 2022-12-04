page 50991 "Dependency Group Card"
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
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Dependency Group No';
                }

                field("Dependency Group"; rec."Dependency Group")
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