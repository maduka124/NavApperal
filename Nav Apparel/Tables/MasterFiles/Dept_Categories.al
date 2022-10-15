
table 50809 "Dept_Categories"
{
    DataClassification = ToBeClassified;
    LookupPageId = Dept_CategoriesList1;
    DrillDownPageId = Dept_CategoriesList1;

    fields
    {

        field(71012581; "Department No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Department Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(71012583; "Category No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012584; "Category Name"; text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(71012585; "Act Budget"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(71012586; "Final Budget with Absenteesm"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(71012587; "Absent%"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(71012588; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012589; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012590; "Show In Report"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(71012591; "No"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
    }

    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Department Name", "Category Name")
        {

        }
    }

    trigger OnInsert()
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

}