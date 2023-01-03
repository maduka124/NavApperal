tableextension 50917 "PO Extension" extends "Purchase Header"
{
    fields
    {
        field(50001; "PI No."; Code[20])
        {
        }

        field(50002; "Select"; Boolean)
        {
        }

        field(50003; "Assigned PI No."; Code[20])
        {
        }

        field(50406; "LC/Contract No."; Code[20])
        {
        }

        field(50407; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50408; "Merchandizer Group Name"; Text[200])
        {

        }

    }
}

