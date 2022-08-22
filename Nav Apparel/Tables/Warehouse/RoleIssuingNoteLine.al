
table 50637 RoleIssuingNoteLine
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "RoleIssuNo."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(3; "Location No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Location Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Name;
            ValidateTableRelation = false;
        }

        field(5; "Role ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = RoleIDDetails."Role ID" where("Item No" = field("Item No"), "Location No" = field("Location No"), Qty = filter(<> 0));
            ValidateTableRelation = false;
        }

        field(6; "Item No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Supplier Batch No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Shade No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Shade"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Length Tag"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Length Act"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Width Tag"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Width Act"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(14; "Selected"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(15; "InvoiceNo"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(16; "Length Allocated"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "RoleIssuNo.", "Line No.")
        {
            Clustered = true;
        }
    }


    trigger OnInsert()
    var
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
