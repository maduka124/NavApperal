
table 71012825 "Gate Pass Header"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Gate Pass List";
    DrillDownPageId = "Gate Pass List";

    fields
    {
        field(71012581; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Vehicle No."; code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012583; "Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Internal,External;
            OptionCaption = 'Internal,External';
        }

        field(71012584; "Transfer From Code"; code[20])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Garment Store"."Store Name";
            // ValidateTableRelation = false;
        }

        field(71012585; "Transfer From Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012586; "Transfer To Code"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Brand."Brand Name";
            ValidateTableRelation = false;
        }

        field(71012587; "Transfer To Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012588; "Consignment Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Inventory,"Fixed Assets",Other;
            OptionCaption = 'Inventory,Fixed Assets,Other';
        }
        field(71012589; "Description"; text[500])
        {
            DataClassification = ToBeClassified;          
        }

        field(71012590; "Transfer Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012591; "Expected Return Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012592; "Sent By"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012593; "Approved By"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(710125914; "Approved"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = No,Yes;
            OptionCaption = 'No,Yes';
        }

        field(71012595; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Pending,Completed;
            OptionCaption = 'Pending,Completed';
        }

        field(71012596; "Remarks"; text[500])
        {
            DataClassification = ToBeClassified;
        }

        field(71012597; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012598; "Created Date"; Date)
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
        fieldgroup(DropDown; "No.", "No.", "Transfer Date", "Vehicle No.", Type, "Transfer From Name", "Transfer To Name")
        {

        }
    }

    trigger OnInsert()
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        NavAppSetup.TestField("Gatepass Nos.");

        "No." := NoSeriesMngment.GetNextNo(NavAppSetup."Gatepass Nos.", Today, true);

        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

}
