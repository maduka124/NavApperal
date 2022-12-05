
table 51096 "Garment Type"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Garment Type List";
    DrillDownPageId = "Garment Type List";

    fields
    {
        field(71012581; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Single,Set;
            OptionCaption = 'Single,Set';
        }

        field(71012582; "No."; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012583; Code; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012584; "Garment Type Description"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012585; Category; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012586; Selected; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(71012587; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012588; "Created Date"; Date)
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
        fieldgroup(DropDown; "No.", "Garment Type Description")
        {

        }
    }

    trigger OnInsert()
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        NavAppSetup.TestField("Garment Type Nos.");

        "No." := NoSeriesMngment.GetNextNo(NavAppSetup."Garment Type Nos.", Today, true);

        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    var
        StyleRec: Record "Style Master";
    begin
        //Check for Exsistance
        StyleRec.Reset();
        StyleRec.SetRange("Garment Type No.", "No.");
        if StyleRec.FindSet() then
            Error('Garment Type : %1 already used in style. Cannot delete.', StyleRec."Style No.");
    end;

    trigger OnRename()
    begin

    end;

}