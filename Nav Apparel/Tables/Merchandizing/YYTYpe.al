
table 50941 "YY Type"
{
    DataClassification = ToBeClassified;
    LookupPageId = "YY Type List";
    DrillDownPageId = "YY Type List";

    fields
    {
        field(71012581; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "YY Type Desc"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012583; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012584; "Created Date"; Date)
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
        fieldgroup(DropDown; "No.", "YY Type Desc")
        {

        }
    }

    trigger OnInsert()
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    var
        YYRec: Record "YY Requsition Line";
    begin

        //Check for Exsistance
        YYRec.Reset();
        YYRec.SetRange("YY Type No.", "No.");
        if YYRec.FindSet() then
            Error('YY Type : %1 already used in YY Requsition. Cannot delete.', "YY Type Desc");

    end;

    trigger OnRename()
    begin

    end;

}
