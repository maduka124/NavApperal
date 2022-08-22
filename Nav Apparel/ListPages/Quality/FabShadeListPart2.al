page 50752 FabShadeListPart2
{
    PageType = ListPart;
    SourceTable = FabShadeLine2;
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

                field("Total Rolls"; "Total Rolls")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Total YDS"; "Total YDS")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}