table 50723 IntermediateTable
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Split No"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(4; "FG No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "SO No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Po No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Wash Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Split Qty"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "AW QC Pass Qty "; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "AW QC Fail Qty"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Return Qty (AW)"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Dispatch Qty"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Unite Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(14; "FG Item Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(16; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(pk; No, "Line No", "Split No")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

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