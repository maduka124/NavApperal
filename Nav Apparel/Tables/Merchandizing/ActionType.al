
table 71012661 "Action Type"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Action Type List";
    DrillDownPageId = "Action Type List";

    fields
    {
        field(71012581; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Action Type"; text[50])
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

        field(71012585; "Barcode"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        // field(71012586; "BarcodeImage"; Blob)
        // {
        //     DataClassification = CustomerContent;
        //     Subtype = Bitmap;
        // }

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
        fieldgroup(DropDown; "No.", "Action Type")
        {

        }
    }

    trigger OnInsert()
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;


    trigger OnDelete()
    var
        DependencyRec: Record "Dependency Buyer Para";
        DependencyParaRec: Record "Dependency Parameters";
    begin

        //Check for Exsistance
        DependencyRec.Reset();
        DependencyRec.SetRange("Action Type No.", "No.");
        if DependencyRec.FindSet() then
            Error('Action Type : %1 already used in operations. Cannot delete.', "Action Type");

        DependencyParaRec.Reset();
        DependencyParaRec.SetRange("Action Type No.", "No.");
        if DependencyParaRec.FindSet() then
            Error('Action Type : %1 already used in operations. Cannot delete.', "Action Type");

    end;
}
