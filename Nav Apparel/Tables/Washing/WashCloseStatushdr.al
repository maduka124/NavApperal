table 51459 WashCloseHrd
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Close Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Factory Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Factory Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Buyer Name"; Text[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = WashingMaster."Buyer Name";
            ValidateTableRelation = false;
        }

        field(6; "Buyer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Style No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Style Name"; text[200])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Style Master"."Style No." where("Buyer Name" = field("Buyer Name"));
            TableRelation = WashingMaster."Style Name" where("Buyer Name" = field("Buyer Name"));
            ValidateTableRelation = false;
        }

        field(9; "PO No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Lot No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = WashingMaster.Lot where("Style No" = field("Style No."));
            ValidateTableRelation = false;
        }

        field(11; "Color Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Color Name"; text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = WashingMaster."Color Name" where("Style No" = field("Style No."), Lot = field("Lot No"), "PO No" = field("PO No"));
            ValidateTableRelation = false;
        }

        field(13; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(14; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Secondary UserID"; Code[20])
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

    fieldgroups
    {
        // Add changes to field groups here
    }

    trigger OnInsert()
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
        UserSetupRec: Record "User Setup";
    begin
        NavAppSetup.Get('0001');
        NavAppSetup.TestField("Wash Colse Nos.");
        No := NoSeriesMngment.GetNextNo(NavAppSetup."Wash Colse Nos.", Today, true);
        "Created Date" := WorkDate();
        "Created User" := UserId;

        // UserSetupRec.Reset();
        // UserSetupRec.SetRange("User ID", UserId);

        // if UserSetupRec.FindSet() then
        //     "Merchandizer Group Name" := UserSetupRec."Merchandizer Group Name";

    end;

}