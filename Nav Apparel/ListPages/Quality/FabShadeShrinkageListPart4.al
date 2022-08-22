page 50705 FabShadeShrinkageListPart4
{
    PageType = ListPart;
    SourceTable = FabShadeBandShriLine4;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("WIDTH Shrinkage"; "WIDTH Shrinkage")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Width Shrinkage(%)';
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