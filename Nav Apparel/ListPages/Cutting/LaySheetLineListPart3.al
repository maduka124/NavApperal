page 50653 "Lay Sheet Line3"
{
    PageType = ListPart;
    SourceTable = LaySheetLine3;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Shade; Shade)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Shade Wise Total Fab (Meters)"; "Shade Wise Total Fab (Meters)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("No of Plies From Shade"; "No of Plies From Shade")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}