page 50511 "Nav Prod Filter"
{
    PageType = List;
    SourceTable = "NavApp Prod Plans Details";
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Editable = false;

                field(PlanDate; PlanDate)
                {
                    ApplicationArea = All;
                    Caption = 'Plan Date';
                }

                field("Style No."; "Style No.")
                {
                    ApplicationArea = All;
                    Caption = 'No';
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}