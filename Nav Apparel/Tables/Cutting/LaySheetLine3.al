
table 50652 LaySheetLine3
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "LaySheetNo."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Shade No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Shade"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Shade Wise Total Fab (Meters)"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(5; "No of Plies From Shade"; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(6; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "LineNo."; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "LaySheetNo.", "LineNo.")
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
