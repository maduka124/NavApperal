page 71012702 "Dependency Buyer Para List"
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
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Code';
                }

                field("Dependency Group"; "Dependency Group")
                {
                    ApplicationArea = All;
                }

                field("Action Description"; "Action Description")
                {
                    ApplicationArea = All;
                }

                field("Gap Days"; "Gap Days")
                {
                    ApplicationArea = All;
                }

                field("MK Critical"; "MK Critical")
                {
                    ApplicationArea = All;
                }

                field("Buyer No."; "Buyer No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Action Type"; "Action Type")
                {
                    ApplicationArea = All;
                }

                field("Action User"; "Action User")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}