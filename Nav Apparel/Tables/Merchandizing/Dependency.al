
table 50901 "Dependency"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Dependency Card";
    DrillDownPageId = "Dependency Card";

    fields
    {
        field(71012581; "No."; BigInteger)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(71012582; "Buyer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012583; "Dependency No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012584; "Dependency"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dependency Group"."Dependency Group";
            ValidateTableRelation = false;
        }

        field(71012585; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012586; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012587; "Buyer Name."; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer.Name where("Group Name" = field("Merchandizer Group Name"));
            ValidateTableRelation = false;
        }

        field(71012588; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012589; "Merchandizer Group Name"; Text[200])
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
        UserSetupRec: Record "User Setup";
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;

        UserSetupRec.Reset();
        UserSetupRec.SetRange("User ID", UserId);
        if UserSetupRec.FindSet() then begin

            if UserSetupRec."Merchandizer Group Name" = '' then
                Error('Merchandizer Group not setup in the User Setup.');

            "Merchandizer Group Name" := UserSetupRec."Merchandizer Group Name";
        end
        else
            Error('Merchandizer Group not setup in the User Setup.');
    end;

}
