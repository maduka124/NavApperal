page 51044 "Dependency Style Para List"
{
    PageType = ListPart;
    SourceTable = "Dependency Style Line";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Dependency Group"; rec."Dependency Group")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Action Type"; rec."Action Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Action Description"; rec."Action Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Gap Days"; rec."Gap Days")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Plan Date"; rec."Plan Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Select; rec.Select)
                {
                    ApplicationArea = All;
                    Editable = true;
                }

                field("MK Critical"; rec."MK Critical")
                {
                    ApplicationArea = All;
                    Editable = true;
                }

                field("Action User"; rec."Action User")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}