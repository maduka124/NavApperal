
table 50692 "FabShadeHeader"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "FabShadeNo."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Buyer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Buyer Name."; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer.Name;
            ValidateTableRelation = false;
        }

        field(4; "Style No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Style Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master"."Style No." where("Buyer No." = field("Buyer No."));
            ValidateTableRelation = false;
        }

        field(6; "PO No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "GRN"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Color No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Color Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Item No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Item Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Fabric Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = FabricCodeMaster.FabricCode;
        }

        field(13; "Supplier Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(14; Composition; text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(15; Construction; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(1167; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(17; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(18; "No of Roll"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "FabShadeNo.")
        {
            Clustered = true;
        }
    }


    trigger OnInsert()
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        NavAppSetup.TestField("FabShad Nos.");

        "FabShadeNo." := NoSeriesMngment.GetNextNo(NavAppSetup."FabShad Nos.", Today, true);

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
