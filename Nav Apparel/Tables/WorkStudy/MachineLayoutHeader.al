
table 50478 "Machine Layout Header"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Machine Layout List";
    DrillDownPageId = "Machine Layout List";

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Style No."; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Style Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master"."Style No.";
            ValidateTableRelation = false;
        }

        field(4; "Line No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Work Center Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "NavApp Planning Lines"."Resource Name" where("Style No." = field("Style No."));
            ValidateTableRelation = false;
        }

        field(6; "Garment Type No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Garment Type"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Expected Eff"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Expected Target"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "No of Workstation"; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(11; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.", "Style No.", "Style Name")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        NavAppSetup.TestField("Layout Nos.");

        "No." := NoSeriesMngment.GetNextNo(NavAppSetup."Layout Nos.", Today, true);

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
