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
                field(Shade; rec.Shade)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Total Rolls"; rec."Total Rolls")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Total YDS"; rec."Total YDS")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}