
table 50777 "CostingPlanningParaLine"
{
    DataClassification = ToBeClassified;
    // LookupPageId = "Factory CPM List";
    // DrillDownPageId = "Factory CPM List";

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Seq No"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(3; "From SMV"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(4; "To SMV"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(5; "From Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "To Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Costing Eff%"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Costing Avg Pro"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Planning Eff%"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Planning Avg Pro"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.", "Seq No")
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
