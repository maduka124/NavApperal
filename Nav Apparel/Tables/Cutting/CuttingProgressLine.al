
table 50660 CuttingProgressLine
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "CutProNo."; Code[20])
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
            TableRelation = Location.Code;
        }

        field(4; "Location Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Role ID"; Code[20])
        {
            DataClassification = ToBeClassified;
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

        field(14; "InvoiceNo"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Length Allocated"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(16; "Planned Plies"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(17; "Actual Plies"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "CutProNo.", "Line No.")
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
