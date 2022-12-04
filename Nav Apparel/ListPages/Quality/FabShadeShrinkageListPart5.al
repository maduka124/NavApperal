page 50708 FabShadeShrinkageListPart5
{
    PageType = ListPart;
    SourceTable = FabShadeBandShriLine5;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Pattern;rec. Pattern)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Length%"; rec."Length%")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("WIDTH%"; rec."WIDTH%")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}