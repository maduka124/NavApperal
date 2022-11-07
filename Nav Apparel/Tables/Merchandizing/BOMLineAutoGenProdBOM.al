
table 71012826 "BOM Line AutoGen ProdBOM"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(71012581; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012610; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(71012622; "Production BOM No."; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012601; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012602; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.", "Item No.", "Line No.", "Production BOM No.")
        {
            Clustered = true;
        }
    }


    trigger OnInsert()
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;
   

}
