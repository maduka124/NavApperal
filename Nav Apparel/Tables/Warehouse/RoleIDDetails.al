
table 50643 RoleIDDetails
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "EntryNo."; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Role ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Location No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Location Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Item No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Item Name"; Text[200])
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

        field(14; "Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(15; "InvoiceNo"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(16; "Length Allocated"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(17; "Role ID Filter User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "EntryNo.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Role ID", "Supplier Batch No.", Shade, Qty, "Width Tag", "Width Act", "Length Tag", "Length Act")
        {

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
