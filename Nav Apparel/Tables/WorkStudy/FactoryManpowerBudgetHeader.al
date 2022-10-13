
table 50812 FactoryManpowerBudgetHeader
{
    DataClassification = ToBeClassified;
    LookupPageId = "Factory Manpower Budget List";
    DrillDownPageId = "Factory Manpower Budget List";

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
            TableRelation = Location.Name;
            ValidateTableRelation = false;
        }

        field(4; "Date"; date)
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Created Date"; Date)
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

        key(SK; Date, "Factory Name")
        {

        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Factory Name", Date)
        {
        }
    }

    trigger OnInsert()
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        NavAppSetup.TestField("ManBudget Nos.");

        "No." := NoSeriesMngment.GetNextNo(NavAppSetup."ManBudget Nos.", Today, true);

        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;
}
