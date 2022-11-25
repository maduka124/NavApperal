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
        fieldgroup(DropDown; "Group Id", "Group Head")
        {

        }
    }
}