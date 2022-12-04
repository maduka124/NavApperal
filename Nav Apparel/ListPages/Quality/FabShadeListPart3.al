page 50712 FabShadeListPart3
{
    PageType = ListPart;
    SourceTable = FabShadeLine3;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Pattern; rec.Pattern)
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