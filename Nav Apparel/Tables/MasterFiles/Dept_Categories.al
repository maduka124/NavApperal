
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

        field(71012592; "Factory Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012593; "Factory Name"; Text[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Name;
            ValidateTableRelation = false;
        }

         field(71012594; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }

        key(SK; "Factory Name", "Category Name", No)
        {
        }

        key(SK1; "Factory Name", "Department Name", "Category Name", No)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Factory Name", "Department Name", "Category Name")
        {

        }
    }

    trigger OnInsert()
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

}