
table 50670 "FabricProceHeader"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "FabricProceNo."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Style No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Style Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master"."Style No." where("Buyer No." = field("Buyer No."));
            ValidateTableRelation = false;
        }

        field(4; "PO No."; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Purchase Line"."Document No." where(StyleNo = field("Style No."));
            //TableRelation = "Purch. Rcpt. Line"."Order No." where(StyleNo = field("Style No."));
            //ValidateTableRelation = false;
        }

        field(6; "No of Roll"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Buyer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Buyer Name."; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer.Name;
            ValidateTableRelation = false;
        }

        field(9; "GRN"; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Purch. Rcpt. Line"."Document No." where("Order No." = field("PO No."), StyleNo = field("Style No."));
            //ValidateTableRelation = false;
        }

        field(10; "Color No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Color Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item."Color Name" where("No." = field("Item No"));
            ValidateTableRelation = false;
            //TableRelation = AssorColorSizeRatio."Colour Name" where("Style No." = field("Style No."), "Colour Name" = filter('<> *'));
        }

        field(12; "Item No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Item Name"; Text[200])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Purch. Rcpt. Line".Description where("Document No." = field(GRN), "Color No." = field("Color No"));
            //ValidateTableRelation = false;
        }

        field(14; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "FabricProceNo.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(Dropdown; "FabricProceNo.", "Style No.", "Style Name")
        {

        }
    }


    trigger OnInsert()
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        NavAppSetup.TestField("FabricProce Nos.");

        "FabricProceNo." := NoSeriesMngment.GetNextNo(NavAppSetup."FabricProce Nos.", Today, true);

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
