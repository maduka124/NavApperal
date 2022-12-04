
table 50898 "BOMPOSelection"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(71012581; "BOM No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Style No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012583; "Lot No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012584; "PO No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012585; Qty; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(71012586; Mode; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Sea,Air,"Sea-Air","Air-Sea","By Road";
            OptionCaption = 'Sea,Air,"Sea-Air","Air-Sea","By Road"';
        }

        field(71012587; "Ship Date"; Date)
        {
            DataClassification = ToBeClassified;
        }


        field(71012588; "Selection"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(71012589; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012590; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "BOM No.", "Style No.", "Lot No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()

    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;
}
