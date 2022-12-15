
table 50520 "B2BLCMaster"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Season No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Season"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Seasons."Season Name";
            ValidateTableRelation = false;
        }

        field(4; "Buyer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Buyer"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer.Name;
            ValidateTableRelation = false;
        }

        field(6; "LC/Contract No."; Text[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Contract/LCMaster"."Contract No" where("Buyer No." = field("Buyer No."), "Status of LC" = filter(Active));
            ValidateTableRelation = false;
        }

        field(7; "LC Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(8; "B2B LC Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(9; "B2B LC No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(10; "B2B LC Opened (Value)"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(11; "B2B LC Opened (%)"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(12; "Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(13; "AMD"; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(14; "AMD Date"; date)
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Opening Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(16; "Last Shipment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(17; "Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(18; "B2B LC Duration (Days)"; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(19; "Beneficiary"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(20; "Beneficiary Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor.Name;
            ValidateTableRelation = false;
        }

        field(21; "Payment Terms (Days) No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(22; "Payment Terms (Days)"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Terms".Description;
            ValidateTableRelation = false;
        }

        field(23; "Interest%"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(24; "Currency No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(25; "Currency"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency.Description;
            ValidateTableRelation = false;
        }

        field(26; "B2B LC Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(27; "LC Issue Bank No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(28; "Issue Bank"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account".Name;
            ValidateTableRelation = false;
        }

        field(29; "LC Receive Bank No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(30; "LC Receive Bank"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account".Name;
            ValidateTableRelation = false;
        }

        field(31; "Tolerence (%)"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(32; "Bank Charges"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(33; "B2B LC Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Active,Cancel,Complete';
            OptionMembers = Active,Cancel,Complete;
        }

        field(34; "Remarks"; Text[500])
        {
            DataClassification = ToBeClassified;
        }

        field(35; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(36; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(37; "Global Dimension Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1), Blocked = CONST(false));
        }

        field(38; "Secondary UserID"; Code[20])
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
        fieldgroup(DropDown; "No.", "B2B LC No", "B2B LC Value")
        {

        }
    }

    trigger OnInsert()
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        NavAppSetup.TestField("B2BLC Nos.");

        "No." := NoSeriesMngment.GetNextNo(NavAppSetup."B2BLC Nos.", Today, true);

        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;


    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    var
        AcceHeadRec: Record "AcceptanceHeader";
        GITBaseonLCRec: Record "GITBaseonLC";
    begin

        //Check for Exsistance
        AcceHeadRec.Reset();
        AcceHeadRec.SetRange("B2BLC No (System)", "No.");
        if AcceHeadRec.FindSet() then
            Error('B2B LC No : %1 already used in Acceptance. Cannot delete.', "B2B LC No");

        GITBaseonLCRec.Reset();
        GITBaseonLCRec.SetRange("B2B LC No. (System)", "No.");
        if GITBaseonLCRec.FindSet() then
            Error('B2B LC No : %1 already used in GIT Base on LC. Cannot delete.', "B2B LC No");

    end;

    trigger OnRename()
    begin

    end;

}
