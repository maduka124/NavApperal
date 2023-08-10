page 51386 "Production Order List Lookup"
{
    Caption = 'Production Order List';
    PageType = List;
    SourceTable = "Production Order";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Lot No."; rec."Lot No.")
                {
                    ApplicationArea = All;
                    Caption = 'Lot No';
                }

                field(PO; rec.PO)
                {
                    ApplicationArea = All;
                }

                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Prod. Order No';
                }
            }
        }
    }
}
