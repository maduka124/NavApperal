
table 50674 "FabricProceLine"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "FabricProceNo."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Roll No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "YDS"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(5; "Width"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(6; "Act. Width"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(7; "Shade No"; code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Shade"; text[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Shade.Shade;
            ValidateTableRelation = false;
        }

        field(9; "BW. Length"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(10; "AW. Length"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(11; "BW. Width"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(12; "AW. Width"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(13; "Length%"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(14; "WiDth%"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(15; "PTTN GRP"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(16; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Active,Hold,Rejected;
            OptionCaption = 'Active,Hold,Rejected';
        }

        field(17; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(18; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(19; "MFShade No"; code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(20; "MFShade"; text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(21; "Item No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(22; "Item Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(23; "GRN"; Code[20]) //From Header table
        {
            DataClassification = ToBeClassified;
        }

        field(24; "Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "FabricProceNo.", "Line No.")
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
