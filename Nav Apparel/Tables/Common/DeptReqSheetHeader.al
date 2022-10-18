table 50819 DeptReqSheetHeader
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Req No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Factory Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Factory Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Department Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Department Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Department."Department Name";
            ValidateTableRelation = false;
        }

        field(6; "Request Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Remarks"; text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Pending,Posted;
            OptionCaption = 'Pending,Posted';
        }
    }

    keys
    {
        key(PK; "Req No")
        {
            Clustered = true;
        }
    }
}