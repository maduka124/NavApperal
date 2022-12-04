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
                field("Master Category Name"; rec."Master Category Name")
                {
                    ApplicationArea = All;
                    Caption = 'Category';
                    Editable = false;
                }

                field(Value;rec. Value)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Doz Cost"; rec."Doz Cost")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}