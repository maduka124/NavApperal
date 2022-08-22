
table 71012678 "BOM"
{
    DataClassification = ToBeClassified;
    LookupPageId = BOM;
    DrillDownPageId = BOM;

    fields
    {
        field(71012581; "No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Style No."; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012583; "Store No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012584; "Store Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Garment Store"."Store Name";
            ValidateTableRelation = false;
        }

        field(71012585; "Brand No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012586; "Brand Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Brand."Brand Name";
            ValidateTableRelation = false;
        }

        field(71012587; "Buyer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012588; "Buyer Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer.Name;
            ValidateTableRelation = false;
        }

        field(71012589; "Season No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012590; "Season Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Seasons."Season Name";
            ValidateTableRelation = false;
        }

        field(71012591; "Department No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012592; "Department Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Department Style"."Department Name";
            ValidateTableRelation = false;
        }

        field(71012593; "Garment Type No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012594; "Garment Type Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Garment Type"."Garment Type Description";
            ValidateTableRelation = false;
        }

        field(71012595; "Main Category No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012596; "Main Category Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Main Category"."Main Category Name" where("Main Category Name" = filter(<> 'All Categories'));
            ValidateTableRelation = false;
        }

        field(71012597; "Revision"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(71012598; "Quantity"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(71012599; "Currency No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency.Code;
        }

        field(71012600; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012601; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012602; "Style Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master"."Style No.";
            ValidateTableRelation = false;
        }
    }

    keys
    {
        key(PK; "No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No", "Style No.", "Style Name")
        {

        }
    }

    trigger OnInsert()
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        NavAppSetup.TestField("BOM1 Nos.");

        "No" := NoSeriesMngment.GetNextNo(NavAppSetup."BOM1 Nos.", Today, true);

        "Created Date" := WorkDate();
        "Created User" := UserId;
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
