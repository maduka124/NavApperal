
table 50467 "New Breakdown Op Line1"
{
    DataClassification = ToBeClassified;
    LookupPageId = "New Operation";
    DrillDownPageId = "New Operation";

    fields
    {
        field(1; "NewBRNo."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "LineNo."; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Item Type No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Item Type Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Garment Part No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Garment Part Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Description"; text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "SMV"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Target Per Hour"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Grade"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = D,A,S;
            OptionCaption = 'D,A,S';
        }

        field(12; "Department No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Department Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Department."Department Name";
            ValidateTableRelation = false;
        }

        field(14; "Machine No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Machine Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Machine Master"."Machine Description";
            ValidateTableRelation = false;
        }

        field(16; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(17; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(18; "Video"; Media)
        {
            DataClassification = ToBeClassified;
        }

        field(19; "Upload Video"; Text[30])
        {
            DataClassification = ToBeClassified;
            InitValue = 'Upload Video File.....';
        }

        field(20; "Download Video"; Text[40])
        {
            DataClassification = ToBeClassified;
            InitValue = 'Download Video File.....';
        }

        field(21; "Select"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(22; "Selected Seq"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "NewBRNo.", "LineNo.")
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
}
