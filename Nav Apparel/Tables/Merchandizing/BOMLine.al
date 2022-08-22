
table 71012688 "BOM Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(71012581; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Type"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(71012583; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(71012584; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012585; "Item Name"; Text[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item.Description where("Main Category No." = field("Main Category No."));
            ValidateTableRelation = false;
        }

        field(71012586; "Main Category No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012587; "Main Category Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Main Category"."Main Category Name" where("Main Category Name" = filter(<> 'All Categories'));
            ValidateTableRelation = false;
        }

        field(71012588; "GMT Color No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012589; "GMT Color Name."; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Colour."Colour Name";
            ValidateTableRelation = false;
        }

        field(71012590; "Construction No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012591; "Construction Name."; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Article.Article;
            ValidateTableRelation = false;
        }

        field(71012592; "Dimension No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012593; "Dimension Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = DimensionWidth."Dimension Width" where("Main Category No." = field("Main Category No."));
            ValidateTableRelation = false;
        }

        field(71012594; "Item Color No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012595; "Item Color Name."; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Colour."Colour Name";
            ValidateTableRelation = false;
        }

        field(71012596; "Placement"; Text[50])
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

        field(71012599; "GMR Size No."; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012600; "GMR Size Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012601; "Main Cat size No."; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012602; "Main Cat size Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012603; "Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(71012604; "WST"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(71012605; Percentage; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(71012606; "Country Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012607; "Country Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012608; "Select"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(71012609; "Lot No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012610; "PO No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.", Type, "Line No")
        {
            Clustered = true;
        }
    }


    trigger OnInsert()
    begin
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
