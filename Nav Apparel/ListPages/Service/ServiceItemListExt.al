pageextension 50807 ServiceItemListExt extends "Service Item List"
{
    layout
    {
        addafter("Customer No.")
        {
            field(Brand; rec.Brand)
            {
                ApplicationArea = ALL;
            }

            field(Model; rec.Model)
            {
                ApplicationArea = ALL;
            }

            field("Purchase Year"; rec."Purchase Year")
            {
                ApplicationArea = ALL;
            }

            field(Factory; rec.Factory)
            {
                ApplicationArea = ALL;
            }

            field(Location; rec.Location)
            {
                ApplicationArea = All;
            }

            field("Machine Category"; rec."Machine Category")
            {
                ApplicationArea = All;
            }

            field(Ownership; rec.Ownership)
            {
                ApplicationArea = All;
            }
        }
    }
}