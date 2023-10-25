table 51444 WashSequenceSMVHeader
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Buyer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Buyer Name"; text[50])
        {
            DataClassification = ToBeClassified;
            // TableRelation = Customer.Name;
            TableRelation = WashingMaster."Buyer Name";
            ValidateTableRelation = false;
        }

        field(4; "Style No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Style Name"; text[50])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Style Master"."Style No." where("Buyer Name" = field("Buyer Name"));
            TableRelation = WashingMaster."Style Name" where("Buyer Name" = field("Buyer Name"));
            ValidateTableRelation = false;
        }

        field(7; "PO No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Lot No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = WashingMaster.Lot where("Style No" = field("Style No."));
            ValidateTableRelation = false;
        }

        field(9; "Color Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Color Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = WashingMaster."Color Name" where("Style No" = field("Style No."), Lot = field("Lot No"), "PO No" = field("PO No"));
            ValidateTableRelation = false;
        }
        field(11; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(14; "Factory Name"; text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Factory code"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(16; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(17; Posting; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(18; WashMasterNoTemp; Integer)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
        UserSetupRec: Record "User Setup";
    begin
        NavAppSetup.Get('0001');
        NavAppSetup.TestField("Wash Sequence SMV Nos.");
        No := NoSeriesMngment.GetNextNo(NavAppSetup."Wash Sequence SMV Nos.", Today, true);
        "Created Date" := WorkDate();
        "Created User" := UserId;

    end;

}