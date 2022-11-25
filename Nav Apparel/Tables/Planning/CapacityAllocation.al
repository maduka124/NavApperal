
table 50853 CapacityAllocation
{
    DataClassification = ToBeClassified;
    // LookupPageId = "Learning Curve";
    // DrillDownPageId = "Learning Curve";

    fields
    {
        field(1; "No."; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Factory Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Factory Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Line No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Line Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "JAN"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = MerchandizingGroupTable."Group Id";
        }
        field(8; "FEB"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = MerchandizingGroupTable."Group Id";
        }

        field(9; "MAR"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = MerchandizingGroupTable."Group Id";
        }

        field(10; "APR"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = MerchandizingGroupTable."Group Id";
        }

        field(11; "MAY"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = MerchandizingGroupTable."Group Id";
        }

        field(12; "JUN"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = MerchandizingGroupTable."Group Id";
        }

        field(13; "JUL"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = MerchandizingGroupTable."Group Id";
        }

        field(14; "AUG"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = MerchandizingGroupTable."Group Id";
        }

        field(15; "SEP"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = MerchandizingGroupTable."Group Id";
        }

        field(16; "OCT"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = MerchandizingGroupTable."Group Id";
        }

        field(17; "NOV"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = MerchandizingGroupTable."Group Id";
        }

        field(18; "DEC"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = MerchandizingGroupTable."Group Id";
        }

        field(19; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(20; "Created Date"; Date)
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

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Year, "Factory Name", "Line Name")
        {

        }
    }

    trigger OnInsert()
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

}
