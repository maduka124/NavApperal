page 50753 FabShadeShrinkageListPart2
{
    PageType = ListPart;
    SourceTable = FabShadeBandShriLine2;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Width; rec.Width)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Total YDS"; rec."Total YDS")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Total Rolls"; rec."Total Rolls")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}