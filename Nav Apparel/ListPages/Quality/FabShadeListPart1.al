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
                field("Roll No"; rec."Roll No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(YDS; rec.YDS)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Shade; rec.Shade)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("PTTN GRP"; rec."PTTN GRP")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
            }
        }
    }
}