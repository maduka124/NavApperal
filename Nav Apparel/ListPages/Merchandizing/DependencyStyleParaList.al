page 71012780 "Dependency Style Para List"
{
    PageType = ListPart;
    SourceTable = "Dependency Style Line";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Dependency Group"; "Dependency Group")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Action Type"; "Action Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Action Description"; "Action Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Gap Days"; "Gap Days")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Plan Date"; "Plan Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Select; Select)
                {
                    ApplicationArea = All;
                    Editable = true;
                }

                field("MK Critical"; "MK Critical")
                {
                    ApplicationArea = All;
                    Editable = true;
                }

                field("Action User"; "Action User")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}