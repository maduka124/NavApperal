
table 50813 FactoryManpowerBudgetLine
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Factory Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Factory Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Date"; date)
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Department Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Department Name"; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Category No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Category Name"; text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(9; LineNo; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Act Budget"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Final Budget with Absenteesm"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Current onrall"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Absent"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(14; "Leave"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Net Present"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(16; "Excess/Short"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(17; "Remarks"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(18; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = DL,ST,GT;
            OptionCaption = 'DL,ST,GT';
        }

        field(19; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(20; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(21; "Show In Report"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.", "Factory Code", "Factory Name", Date, LineNo)
        {
            Clustered = true;
        }
    }
}
