
table 50457 "New Breakdown"
{
    DataClassification = ToBeClassified;
    LookupPageId = "New Breakdown";
    DrillDownPageId = "New Breakdown";

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Style No."; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Style Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master"."Style No.";
            ValidateTableRelation = false;
        }

        field(4; "Season No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Season Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Buyer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Buyer Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Garment Type No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Garment Type Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Description"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Item Type No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Item Type Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Type"."Item Type Name";
            ValidateTableRelation = false;
        }

        field(14; "Garment Part No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Garment Part Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = GarmentPart.Description where("Item Type No." = field("Item Type No."));
            ValidateTableRelation = false;
        }

        field(16; "Total SMV"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(17; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(18; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(19; "Style Stage"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(20; Machine; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(21; Manual; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(22; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(23; "Front"; Media)
        {
            DataClassification = ToBeClassified;
        }

        field(24; "Back"; Media)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "CostingSMV"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }
        field(26; "ProductionSMV"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }
        field(27; "PlanningSMV"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }
    }


    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }


    trigger OnInsert()
    var
        UserRec: Record User;
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        UserRec.Reset();
        UserRec.Get(UserSecurityId());

        "Created Date" := WorkDate();
        "Created User" := UserId;
        // "Merchandiser Code" := UserId;
        // "Merchandiser Name" := UserRec."Full Name";

        NavAppSetup.Get('0001');
        NavAppSetup.TestField("NEWBR Nos.");

        "No." := NoSeriesMngment.GetNextNo(NavAppSetup."NEWBR Nos.", Today, true);
    end;

}
