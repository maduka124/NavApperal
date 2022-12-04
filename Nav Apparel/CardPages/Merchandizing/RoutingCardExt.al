pageextension 71012839 "RoutingCard Extension" extends Routing
{
    layout
    {
        addafter("Last Date Modified")
        {

            field("Sample Router"; rec."Sample Router")
            {
                ApplicationArea = All;
            }

            field("Bulk Router"; rec."Bulk Router")
            {
                ApplicationArea = All;
            }

            field("Washing Router"; rec."Washing Router")
            {
                ApplicationArea = All;
            }

            field("With Wash Router"; rec."With Wash Router")
            {
                ApplicationArea = All;
            }

            field("Without Wash Router"; rec."Without Wash Router")
            {
                ApplicationArea = All;
            }
        }
    }
}