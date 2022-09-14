table 50786 "Activities Cue 1"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Gate Pass - Pending Approvals"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Gate Pass Header" where(Status = filter("Pending Approval")));
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}