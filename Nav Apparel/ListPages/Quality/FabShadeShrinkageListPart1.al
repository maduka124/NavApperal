page 50725 FabShadeShrinkageListPart1
{
    PageType = ListPart;
    SourceTable = FabShadeBandShriLine1;
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