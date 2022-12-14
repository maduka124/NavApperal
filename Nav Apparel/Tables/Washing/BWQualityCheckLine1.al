table 50673 BWQualityLine1
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;

            // trigger OnValidate()
            // var
            //     Heaad: Record BWQualityCheck;
            // begin
            //     Heaad.Get(No);

            //     Heaad.Modify();
            // end;
        }

        field(2; "Sample Req No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Fabric Description"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(4; Qty; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Pk; No, "Line No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
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