page 50703 FabShadeShrinkageListPart3
{
    PageType = ListPart;
    SourceTable = FabShadeBandShriLine3;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Shrinkage; rec.Shrinkage)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Legth Shrinkage(%)';
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