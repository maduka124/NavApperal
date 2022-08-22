
table 50333 "Learning Curve"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Learning Curve";
    DrillDownPageId = "Learning Curve";

    fields
    {
        field(1; "No."; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Day1"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Day2"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Day3"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Day4"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Day5"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Day6"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Day7"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Created Date"; Date)
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
        fieldgroup(DropDown; "No.", Day1, Day2, Day3, Day4, Day5, Day6, Day7)
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
        NavAppPlLineRec: Record "NavApp Planning Lines";
        NavAppPRLineRec: Record "NavApp Prod Plans Details";
        NavAppPlQRec: Record "Planning Queue";
    begin

        //Check for Exsistance
        NavAppPlLineRec.Reset();
        NavAppPlLineRec.SetRange("Learning Curve No.", "No.");
        if NavAppPlLineRec.FindSet() then
            Error('Learning Curve : %1 already used in planning. Cannot delete.', "No.");

        NavAppPRLineRec.Reset();
        NavAppPRLineRec.SetRange("Learning Curve No.", "No.");
        if NavAppPRLineRec.FindSet() then
            Error('Learning Curve : %1 already used in planning. Cannot delete.', "No.");

        NavAppPlQRec.Reset();
        NavAppPlQRec.SetRange("Learning Curve No.", "No.");
        if NavAppPlQRec.FindSet() then
            Error('Learning Curve : %1 already used in planning. Cannot delete.', "No.");


    end;


    trigger OnRename()
    begin

    end;

}
