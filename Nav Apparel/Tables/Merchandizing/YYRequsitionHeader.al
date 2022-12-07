
table 50939 "YY Requsition Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(71012581; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Buyer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012583; "Buyer Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer.Name;
            ValidateTableRelation = false;
        }

        field(71012584; "Style No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012585; "Style Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master"."Style No." where("Buyer No." = field("Buyer No."));
            ValidateTableRelation = false;
        }

        field(71012586; "Garment Type No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012587; "Garment Type Name"; text[50])
        {
            // DataClassification = ToBeClassified;
            // TableRelation = "Garment Type"."Garment Type Description";
            // ValidateTableRelation = false;
        }

        field(71012588; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012589; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012590; "Remarks"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(71012591; "Secondary UserID"; Code[20])
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

    trigger OnInsert()
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        NavAppSetup.TestField("Sample YY Nos.");
        "No." := NoSeriesMngment.GetNextNo(NavAppSetup."Sample YY Nos.", Today, true);
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

}
