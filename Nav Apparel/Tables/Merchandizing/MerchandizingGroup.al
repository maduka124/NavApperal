table 50847 MerchandizingGroupTable
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Group Id"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Group Head"; Text[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID" where("Merchandizer Head" = const(true));
        }

        field(3; "Group Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "Group Id")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Group Id", "Group Name", "Group Head")
        {

        }
    }

    trigger OnInsert()
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;
}