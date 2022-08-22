page 50696 FabShadeListPart1
{
    PageType = ListPart;
    SourceTable = FabShadeLine1;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Roll No"; "Roll No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(YDS; YDS)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Shade; Shade)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("PTTN GRP"; "PTTN GRP")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
            }
        }
    }
}