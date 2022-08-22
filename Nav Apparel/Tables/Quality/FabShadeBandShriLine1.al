
table 50698 FabShadeBandShriLine1
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "FabShadeNo."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Total Rolls"; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(4; "Total YDS"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(5; "Shade No"; code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Shade"; text[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Shade.Shade;
            ValidateTableRelation = false;
        }

        field(7; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "FabShadeNo.", "Line No.")
        {
            Clustered = true;
        }
    }


    fieldgroups
    {
        fieldgroup(DropDown; Shade)
        {

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
