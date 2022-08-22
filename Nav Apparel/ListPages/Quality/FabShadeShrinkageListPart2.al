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
                field(Width; Width)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Total YDS"; "Total YDS")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Total Rolls"; "Total Rolls")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}