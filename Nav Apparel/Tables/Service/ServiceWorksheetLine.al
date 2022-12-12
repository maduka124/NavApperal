
table 50729 "ServiceWorksheet"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Service Item No"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Work Center No"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Work Center Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Service Date"; date)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Standard Service Desc"; text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Standard Service Code".Description;
            ValidateTableRelation = false;
        }

        field(7; "Standard Service Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Doc No"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Remarks"; text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Next Service Date"; date)
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(14; "Service Item Name"; text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "Service Item No")
        {
            Clustered = true;
        }
    }

    // fieldgroups
    // {
    //     fieldgroup(DropDown; "No.", "Wash Type Name")
    //     {

    //     }
    // }

    trigger OnInsert()
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    var
    begin


    end;

    trigger OnRename()
    begin

    end;

}
