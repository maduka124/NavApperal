page 51037 "Dependency Buyer Para List"
{
    PageType = ListPart;
    SourceTable = "Dependency Buyer Para";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Code';
                }

                field("Dependency Group"; rec."Dependency Group")
                {
                    ApplicationArea = All;
                }

                field("Action Description"; rec."Action Description")
                {
                    ApplicationArea = All;
                }

                field("Gap Days"; rec."Gap Days")
                {
                    ApplicationArea = All;
                }

                field("MK Critical"; rec."MK Critical")
                {
                    ApplicationArea = All;
                }

                field("Buyer No."; rec."Buyer No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Action Type"; rec."Action Type")
                {
                    ApplicationArea = All;
                }

                field("Action User"; rec."Action User")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}