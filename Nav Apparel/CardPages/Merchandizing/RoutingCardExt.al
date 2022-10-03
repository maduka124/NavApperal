pageextension 71012839 "RoutingCard Extension" extends Routing
{
    layout
    {
        addafter("Last Date Modified")
        {

            field("Sample Router"; "Sample Router")
            {
                ApplicationArea = All;
            }

            field("Bulk Router"; "Bulk Router")
            {
                ApplicationArea = All;
            }

            field("Washing Router"; "Washing Router")
            {
                ApplicationArea = All;
            }

            field("With Wash Router"; "With Wash Router")
            {
                ApplicationArea = All;
            }

            field("Without Wash Router"; "Without Wash Router")
            {
                ApplicationArea = All;
            }
        }
    }
}