pageextension 50807 ServiceItemListExt extends "Service Item List"
{
    layout
    {
        addafter("Customer No.")
        {
            field(Brand; Brand)
            {
                ApplicationArea = ALL;
            }

            field(Model; Model)
            {
                ApplicationArea = ALL;
            }

            field("Purchase Year"; "Purchase Year")
            {
                ApplicationArea = ALL;
            }

            field(Factory; Factory)
            {
                ApplicationArea = ALL;
            }

            field(Location; Location)
            {
                ApplicationArea = All;
            }

            field("Machine Category"; "Machine Category")
            {
                ApplicationArea = All;
            }

            field(Ownership; Ownership)
            {
                ApplicationArea = All;
            }
        }
    }
}