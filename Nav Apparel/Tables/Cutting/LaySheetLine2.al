
table 50650 LaySheetLine2
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "LaySheetNo."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(3; "Pattern Version"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "No of Plies"; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(5; "LayLength"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(6; "Cutting Wastage"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 1;
        }

        field(7; "Fab. Req. For Lay"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(8; "Act. Width"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(9; "Revised Marker Length"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(10; "Revised Tot. Fab. Req."; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(11; "Issued Qty(Meters)"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(12; "Retuned Qty(Meters)"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(72; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(73; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(74; "UOM Code"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure".Code;
        }

        field(75; UOM; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "LaySheetNo.", "Line No")
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
