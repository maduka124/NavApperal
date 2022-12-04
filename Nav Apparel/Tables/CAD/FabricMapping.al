
table 50624 FabricMapping
{
    DataClassification = ToBeClassified;
   

    fields
    {
        field(50001; "No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50002; "Style No."; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50003; "Style Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master"."Style No.";
            ValidateTableRelation = false;
        }

        field(50004; "Colour No"; code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50005; "Colour Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50006; "Component Group"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50007; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50008; "Item Name"; Text[200])
        {
            DataClassification = ToBeClassified;
            // TableRelation = Item.Description;
            // ValidateTableRelation = false;
        }

        field(50009; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50010; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(50011; "Main Category No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50012; "Main Category Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Main Category"."Main Category Name" where(SewingJobOnly = filter(1), "Main Category Name" = filter(<> 'ALL CATEGORIES'), "Style Related" = filter(1));
            ValidateTableRelation = false;
        }
    }

    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Style Name", "Colour Name", "Component Group", "Item Name")
        {

        }
    }


    trigger OnInsert()
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        NavAppSetup.TestField("FabMap Nos.");
        "No" := NoSeriesMngment.GetNextNo(NavAppSetup."FabMap Nos.", Today, true);
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

}
