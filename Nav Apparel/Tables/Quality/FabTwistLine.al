
table 50688 "FabTwistLine"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "FabTwistNo."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Color No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Color Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "NoofRolls"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "BW Width CM"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "BW Twist CM"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "BW Twist%"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "AW Width CM"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "AW Twist CM"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(12; "AW Twist%"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(14; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(15; "RollID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "FabTwistNo.", "Line No.")
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
