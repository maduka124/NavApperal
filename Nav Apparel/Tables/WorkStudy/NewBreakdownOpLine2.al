
table 50465 "New Breakdown Op Line2"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Line No."; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Item Type No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Item Type Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Garment Part No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Garment Part Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Description"; text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Machine No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Machine Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Machine Master"."Machine Description";
            ValidateTableRelation = false;
        }

        field(11; "SMV"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Target Per Hour"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Grade"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = D,A,S;
            OptionCaption = 'D,A,S';
        }

        field(14; "Department No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Department Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Department."Department Name";
            ValidateTableRelation = false;
        }

        field(16; "Barcode"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Yes,No;
            OptionCaption = 'Yes,No';
        }

        field(17; "Attachment"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Folder Detail"."No.";
        }

        field(18; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(19; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(20; "LineType"; Text[10])
        {
            DataClassification = ToBeClassified;
        }

        field(21; "MachineType"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(22; "Line Position"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(23; "RefGPartName"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(24; "GPart Position"; Integer)
        {
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(PK; "No.", "Line No.")
        {
            Clustered = true;
        }

        key(SK; "Line Position")
        {
        }

        key(SK1; "GPart Position", "Line Position")
        {
        }
    }


    trigger OnInsert()
    var
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
        // "Line Position" := FindLastLinePosition() + 1;
    end;

    // procedure FindLastLinePosition(): Integer
    // var
    //     NewBRLine: Record "New Breakdown Op Line2";
    // begin
    //     NewBRLine.Reset();
    //     NewBRLine.SetRange("No.", "No.");
    //     NewBRLine.SetCurrentKey("Line Position");
    //     NewBRLine.Ascending(true);
    //     if NewBRLine.FindLast() then
    //         exit(NewBRLine."Line Position")
    //     else
    //         exit(0);
    // end;

}
