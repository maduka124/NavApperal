
table 50930 "Sample Requsition Header"
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
            TableRelation = if ("Merchandizer Group Name" = filter(''))
                    Customer.Name
            else
            Customer.Name where("Group Name" = field("Merchandizer Group Name"));

            ValidateTableRelation = false;
        }

        field(71012584; "Style No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012585; "Style Name"; text[50])
        {
            DataClassification = ToBeClassified;

            TableRelation = if ("Merchandizer Group Name" = filter(''))
                    "Style Master"."Style No."
            else
            "Style Master"."Style No." where("Buyer No." = field("Buyer No."), "Merchandizer Group Name" = field("Merchandizer Group Name"));

            //TableRelation = "Style Master"."Style No." where("Buyer No." = field("Buyer No."), "Merchandizer Group Name" = field("Merchandizer Group Name"));
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

        field(71012603; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012604; "Merchandizer Group Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        //Done By Sachith on 13/01/23
        field(71012605; "Brand Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012606; "Brand No"; Code[20])
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
        fieldgroup(DropDown; "No.", "Style Name")
        {

        }
    }

    trigger OnInsert()
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
        MerchandGrpname: Record MerchandizingGroupTable;
        UserSetupRec: Record "User Setup";
    begin
        NavAppSetup.Get('0001');
        //NavAppSetup.TestField("SAMPLE Nos.");
        "No." := NoSeriesMngment.GetNextNo(NavAppSetup."SAMPLE Nos.", Today, true);
        "Created Date" := WorkDate();
        "Created User" := UserId;

        UserSetupRec.Reset();
        UserSetupRec.SetRange("User ID", UserId);
        if UserSetupRec.FindSet() then begin

            if UserSetupRec."Merchandizer Group Name" = '' then
                Error('Merchandizer Group not setup in the User Setup.');

            "Merchandizer Group Name" := UserSetupRec."Merchandizer Group Name";

            //get Merchand group head
            MerchandGrpname.Reset();
            MerchandGrpname.SetRange("Group Name", UserSetupRec."Merchandizer Group Name");
            if MerchandGrpname.FindSet() then
                rec."Group HD" := MerchandGrpname."Group Head";

        end
        else
            Error('Merchandizer Group not setup in the User Setup.');
    end;

}
