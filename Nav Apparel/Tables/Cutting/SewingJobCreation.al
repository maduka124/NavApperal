
table 50585 SewingJobCreation
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "SJCNo"; Code[20])
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
            TableRelation = Customer.Name;
            ValidateTableRelation = false;
        }

        field(4; "Style No."; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Style Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master"."Style No." where("Buyer No." = field("Buyer No."));
            ValidateTableRelation = false;
        }

        field(6; MarkerCatNo; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "MarkerCatName"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = MarkerCategory."Marker Category";
            ValidateTableRelation = false;
        }

        field(8; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Group ID"; BigInteger)
        {
            DataClassification = ToBeClassified;
            TableRelation = SewingJobCreationLine4."Group ID" where("SJCNo." = field(SJCNo), "Group ID" = filter(<> 0));
            ValidateTableRelation = false;
        }

        field(11; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Factory Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Factory Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Name;
            ValidateTableRelation = false;
        }
    }

    keys
    {
        key(PK; SJCNo)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
        UserSetupRec: Record "User Setup";
        LocationRec: Record Location;
    begin

        UserSetupRec.Reset();
        UserSetupRec.SetRange("User ID", UserId);

        if UserSetupRec.FindSet() then begin
            if UserSetupRec."Factory Code" = '' then
                Error('Factory not setup in the User Setup.');

            LocationRec.Reset();
            LocationRec.SetRange(code, UserSetupRec."Factory Code");

            if LocationRec.FindSet() then begin
                "Factory Code" := UserSetupRec."Factory Code";
                "Factory Name" := LocationRec.Name;
            end
            else
                Error('Factory not setup in the locatons card.');
        end
        else
            Error('User ID not setup in the User Setup.');

        NavAppSetup.Get('0001');
        NavAppSetup.TestField("SJC Nos.");
        SJCNo := NoSeriesMngment.GetNextNo(NavAppSetup."SJC Nos.", Today, true);
        "Created Date" := WorkDate();
        "Created User" := UserId;

    end;

}
