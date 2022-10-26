
table 50654 LaySheetLine4
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "LaySheetNo."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Shade No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Shade"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Batch"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Role ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Ticket Length"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(8; "Allocated Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        // field(9; "Piles Excess"; Decimal)
        // {
        //     DataClassification = ToBeClassified;
        //     InitValue = 0;
        // }

        // field(10; "Net Length"; Decimal)
        // {
        //     DataClassification = ToBeClassified;
        //     InitValue = 0;
        // }

        field(11; "Damages"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(12; "Joints"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(13; "Ends"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(14; "Shortage +"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(15; "Shortage -"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(16; "Binding Length"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(17; "Comments"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(18; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(19; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(20; "UOM Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(21; UOM; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(22; "Planned Plies"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(23; "Actual Plies"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }
    }

    keys
    {
        key(PK; "LaySheetNo.", "Line No.")
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
