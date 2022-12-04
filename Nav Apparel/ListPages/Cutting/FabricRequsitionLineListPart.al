page 50623 "FabricRequisitionLineListPart"
{
    PageType = ListPart;
    SourceTable = FabricRequsitionLine;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Layering Start Date/Time"; Rec."Layering Start Date/Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Cut Start Date/Time"; Rec."Cut Start Date/Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}