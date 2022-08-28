
table 50779 "CostingPlanningParaHeader"
{
    DataClassification = ToBeClassified;
    // LookupPageId = "Factory CPM List";
    // DrillDownPageId = "Factory CPM List";

    fields
    {
        field(1; "No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Created Date"; Date)
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
    }

    // fieldgroups
    // {
    //     fieldgroup(DropDown; "Factory Name", CPM)
    //     {
    //     }
    // }

    trigger OnInsert()
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;
}
