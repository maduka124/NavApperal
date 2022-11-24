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

        field(71012583; "GT Pass Approve"; Boolean)
        {

        }

        field(71012584; "UserRole"; Text[50])
        {

        }

        field(71012585; "Global Dimension Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1), Blocked = CONST(false));
        }

        field(71012586; "Purchasing Approval"; Boolean)
        {

        }

        field(71012587; "Merchandizer Head"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
}

