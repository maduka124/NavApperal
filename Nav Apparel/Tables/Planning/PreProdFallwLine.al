table 50833 PreProductionFollowUpline
{
    DataClassification = ToBeClassified;
    // LookupPageId = PreProductionFallowLineL;
    // DrillDownPageId = PreProductionFallowLineL;

    fields
    {
        field(1; Factory; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Buyer"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Style"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Order Qty"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Ship Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "PP SAMPLE RECEVIED DATE"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Patten received date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Fabric received date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Shrinkage report received date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Fabric relax date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Size set marker date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "size set cutting date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "size set sewing date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Size set wash  send date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Size set wash  received date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Size set QC Report"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Pilot cutting date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Pilot Sewing date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Pilot wash send date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Pilot wash received date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Pilot Report"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Bulk cutting date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Line layout date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Remarks"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(27; "Create User"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(28; "production file received date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(29; "Factory Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(30; "Buyer No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(31; "Style No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK1; Factory)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}