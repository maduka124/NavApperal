
table 50526 "GITBaseonLC"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "GITLCNo."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Suppler No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Suppler Name"; text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor.Name;
            ValidateTableRelation = false;
        }

        field(4; "B2B LC No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "B2B LC Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(6; "ContractLC No"; Code[200])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Invoice No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Invoice Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Original Doc. Recv. Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "B2B LC Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(11; "GRN Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(12; "Invoice Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(13; "Mode of Ship"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Sea,Air,"Sea-Air","Air-Sea","By Road";
            OptionCaption = 'Sea,Air,"Sea-Air","Air-Sea","By Road"';
        }

        field(14; "BL/AWB NO"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(15; "BL Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(16; "Container No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(17; "Carrier Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(18; "Agent"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(19; "M. Vessel Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(20; "M. Vessel ETD"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(21; "F. Vessel Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(22; "F. Vessel ETA"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(23; "F. Vessel ETD"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(24; "N.N Docs DT"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(25; "Original to C&F"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(26; "Good inhouse"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(27; "Bill of entry"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(28; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(29; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(30; "B2B LC No. (System)"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = B2BLCMaster."No." where(Beneficiary = field("Suppler No."));
        }

        field(31; "AssignedAccNo"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(32; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(33; "Remarks"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "GITLCNo.")
        {
            Clustered = true;
        }

        key(SK; "B2B LC No.", "ContractLC No")
        {
        }
    }


    trigger OnInsert()
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        NavAppSetup.TestField("GITLC Nos.");
        "GITLCNo." := NoSeriesMngment.GetNextNo(NavAppSetup."GITLC Nos.", Today, true);
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

}
