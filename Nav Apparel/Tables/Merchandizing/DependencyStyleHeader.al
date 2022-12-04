
table 50908 "Dependency Style Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(71012581; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Style Name."; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master"."Style No.";
            ValidateTableRelation = false;
        }

        field(71012583; "Store No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012584; "Store Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012585; "Brand No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012586; "Brand Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012587; "Buyer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012588; "Buyer Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(71012589; "Season No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012590; "Season Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012591; "Department No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012592; "Department Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012593; "Min X-Fac Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012594; "BPCD"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012595; "Quantity"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(71012596; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012597; "Created Date"; Date)
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
