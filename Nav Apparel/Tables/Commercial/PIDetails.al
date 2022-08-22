
table 71012714 "PI Details Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(71012581; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Style No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012583; "Style Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master"."Style No.";
            ValidateTableRelation = false;
        }

        field(71012584; "Season No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012585; "Season Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012586; "Store No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012587; "Store Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012588; "Supplier No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012589; "Supplier Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor.Name;
            ValidateTableRelation = false;
        }

        field(71012590; "PI No"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012591; "PI Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012592; "Payment Mode"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012593; "Payment Mode Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method".Description;
            ValidateTableRelation = false;
        }

        field(71012594; "Shipment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012595; "Currency Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012596; "Currency"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency.Description;
            ValidateTableRelation = false;
        }

        field(71012597; "PI Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(71012598; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012599; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012600; "Select"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(71012601; "AssignedB2BNo"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012602; "B2BNo"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012603; "AssignedGITPINo"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012604; "GITPINo"; Code[20])
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
        UserRec: Record User;
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        UserRec.Reset();
        UserRec.Get(UserSecurityId());

        "Created Date" := WorkDate();
        "Created User" := UserId;

        NavAppSetup.Get('0001');
        NavAppSetup.TestField("NEWBR Nos.");

        "No." := NoSeriesMngment.GetNextNo(NavAppSetup."PI Nos.", Today, true);
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
