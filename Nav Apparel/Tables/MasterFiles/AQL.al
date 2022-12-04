
table 51082 AQL
{
    DataClassification = ToBeClassified;
    LookupPageId = AQL;
    DrillDownPageId = AQL;

    fields
    {
        field(71012581; "From Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(71012582; "To Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(71012583; "SMPL Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(71012584; "Reject Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(71012585; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012586; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    // keys
    // {
    //     key(PK; "No.")
    //     {
    //         Clustered = true;
    //     }
    // }

    fieldgroups
    {
        fieldgroup(DropDown; "From Qty", "To Qty", "SMPL Qty", "Reject Qty")
        {

        }
    }

    trigger OnInsert()
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

}
