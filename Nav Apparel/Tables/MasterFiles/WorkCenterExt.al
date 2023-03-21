tableextension 51142 "Work Center Extension" extends "Work Center"
{
    fields
    {
        field(50001; "MO"; Integer)
        {
        }

        field(50002; "HP"; Integer)
        {
        }

        field(50003; "Carder"; Integer)
        {
        }

        field(50004; "PlanEff"; Decimal)
        {
        }

        field(50005; "Department No"; code[20])
        {
        }

        field(50006; "Department Name"; Text[50])
        {
        }

        field(50007; "Supervisor Name"; Text[50])
        {
        }

        field(50008; "Factory No."; Code[20])
        {
        }

        field(50009; "Factory Name"; Text[50])
        {
        }

        field(50010; "Floor"; Text[50])
        {
        }

        field(50011; "Select"; Boolean)
        {
        }

        field(50012; "Planning Line"; Boolean)
        {
        }

        field(50013; "Linked To Service Item"; Boolean)
        {
        }

        field(50014; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Work Center Seq No"; Integer)
        {
            DataClassification = ToBeClassified;
        }

    }
}

