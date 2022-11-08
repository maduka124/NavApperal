
table 71012719 "Sample Requsition Header"
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

        field(71012586; "Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Development,Confirm;
            OptionCaption = 'Development,Confirm';
        }

        field(71012587; "Wash Type No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012588; "Wash Type Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Wash Type"."Wash Type Name";
            ValidateTableRelation = false;
        }

        field(71012589; "Wash Plant No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012590; "Wash Plant Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Name where("Plant Type Name" = filter('WASHING UNIT'));
            ValidateTableRelation = false;
        }

        field(71012591; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012592; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012593; "Sample Room No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012594; "Sample Room Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sample Room"."Sample Room Name";
            ValidateTableRelation = false;
        }

        field(71012595; "Remarks"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(71012596; "Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(71012597; "Group HD"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012598; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Pending,Posted;
            OptionCaption = 'Pending,Posted';
        }

        field(71012599; "WriteToMRPStatus"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(71012600; "Garment Type No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012601; "Garment Type Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(71012602; "Global Dimension Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1), Blocked = CONST(false));
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
        fieldgroup(DropDown; "No.", "Style Name")
        {

        }
    }

    trigger OnInsert()
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        //NavAppSetup.TestField("SAMPLE Nos.");
        "No." := NoSeriesMngment.GetNextNo(NavAppSetup."SAMPLE Nos.", Today, true);
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

}
