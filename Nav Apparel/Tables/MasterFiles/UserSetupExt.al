tableextension 71012660 "User Setup Extension" extends "User Setup"
{
    fields
    {
        field(71012581; "Factory Code"; Code[20])
        {
            TableRelation = Location.Code;
        }

        field(71012582; "Service Approval"; Boolean)
        {

        }
    }
}

