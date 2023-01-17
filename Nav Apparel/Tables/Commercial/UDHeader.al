
table 51205 UDHeader
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Buyer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Buyer"; Text[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer.Name;
            ValidateTableRelation = false;
        }

        field(4; "LC/Contract No."; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Contract/LCMaster"."Contract No" where("Buyer No." = field("Buyer No."), "Status of LC" = filter(Active));
            ValidateTableRelation = false;
        }

        field(5; "Factory No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Factory"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Name;
            ValidateTableRelation = false;
        }

        field(7; "Qantity"; BigInteger)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(8; "B2BLC%"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(9; Value; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(10; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }


    trigger OnInsert()
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        NavAppSetup.TestField("UD Nos.");
        "No." := NoSeriesMngment.GetNextNo(NavAppSetup."UD Nos.", Today, true);
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

}
