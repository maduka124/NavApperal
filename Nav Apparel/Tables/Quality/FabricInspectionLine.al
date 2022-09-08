
table 50557 FabricInspectionLine1
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "InsNo."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "DefectsNo."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Point 1"; code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Point 2"; code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Point 3"; code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Point 4"; code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Point Total"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Defects"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Defects.Defects;
            ValidateTableRelation = false;
        }
    }

    keys
    {
        key(PK; "InsNo.", "DefectsNo.")
        {
            Clustered = true;
        }
    }


    trigger OnInsert()
    var
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}
