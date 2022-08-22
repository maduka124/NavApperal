page 71012768 "BOM EstimateCost Line Listpart"
{
    PageType = ListPart;
    SourceTable = "BOM Estimate Costing Line";
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Master Category Name"; "Master Category Name")
                {
                    ApplicationArea = All;
                    Caption = 'Category';
                    Editable = false;
                }

                field(Value; Value)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Doz Cost"; "Doz Cost")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}