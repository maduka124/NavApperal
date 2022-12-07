
table 50473 "Maning Level"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Maning Level List";
    DrillDownPageId = "Maning Level List";

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

        field(5; "Total SMV"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(6; "Sewing SMV"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(7; "Manual SMV"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(8; "Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Based on Machine Operator","Based on Output";
            OptionCaption = 'Based on Machine Operator, Based on Output';
        }

        field(9; "Val"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Eff"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "BPT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(12; "Mac Operator"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(13; "Expected Target"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(14; "Layout Eff %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(15; "MOTheo"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(16; "MOAct"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(17; "MODiff"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(18; "MOBil"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            DecimalPlaces = 1 : 5;
        }

        field(19; "HPTheo"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(20; "HPAct"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(21; "HPODiff"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(22; "HPBil"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            DecimalPlaces = 1 : 5;
        }

        field(23; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(24; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(25; "Work Center Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Work Center".Name;
            ValidateTableRelation = false;
        }

        field(26; "Secondary UserID"; Code[20])
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

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Line No.")
        {

        }
    }

    trigger OnInsert()
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        NavAppSetup.TestField("Manning Nos.");

        "No." := NoSeriesMngment.GetNextNo(NavAppSetup."Manning Nos.", Today, true);

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
