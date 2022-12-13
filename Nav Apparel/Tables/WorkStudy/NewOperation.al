
table 50454 "New Operation"
{
    DataClassification = ToBeClassified;
    LookupPageId = "New Operation";
    DrillDownPageId = "New Operation";

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Item Type No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Item Type Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Type"."Item Type Name";
            ValidateTableRelation = false;
        }

        field(4; "Garment Part No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Garment Part Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = GarmentPart.Description where("Item Type No." = field("Item Type No."));
            ValidateTableRelation = false;
        }

        field(6; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Description"; text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "SMV"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Target Per Hour"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Seam Length"; Decimal)
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
            TableRelation = Department."Department Name" where("Show in New Operations" = filter(1));
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

        field(18; "Code1"; Code[10])
        {
            DataClassification = ToBeClassified;
        }

        field(19; "Code2"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(20; "Video"; Text[10])
        {
            DataClassification = ToBeClassified;
        }

        field(21; "NEWBRNO"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(22; "Secondary UserID"; Code[20])
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
        fieldgroup(DropDown; "No.", Description)
        {

        }
    }

    trigger OnInsert()
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        NavAppSetup.TestField("NEWOP Nos.");

        "No." := NoSeriesMngment.GetNextNo(NavAppSetup."NEWOP Nos.", Today, true);

        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

}
