
table 50656 LaySheetLine5
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "LaySheetNo."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Type"; code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Docket"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Marker"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Issuing"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Laying"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Cutting"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Return"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Bundling"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Dispatch"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "LaySheetNo.", Type)
        {
            Clustered = true;
        }
    }

    // fieldgroups
    // {
    //     fieldgroup(DropDown; "Marker Name", "Cut No")
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
    begin

    end;

    trigger OnRename()
    begin

    end;

}
