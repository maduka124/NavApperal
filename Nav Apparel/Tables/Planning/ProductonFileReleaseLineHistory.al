
table 51223 ProductnFileReleaseLineHistory
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Seq No"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Sew Factory No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Sew Factory"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Resource No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Resource Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Buyer No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Buyer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Style No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Style Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Order Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Plan Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Input Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Days After"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(14; "Merchandiser"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Status"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(16; "BPCD"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(17; "Ship Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(18; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(19; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(20; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(21; "Merchandizer Group Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(22; "LCFactory No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(23; "LCFactory Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(24; "Select"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "Seq No")
        {
            Clustered = true;
        }
    }

    // fieldgroups
    // {
    //     fieldgroup(DropDown; "Resource No.", "Resource Name")
    //     {
    //     }
    // }


    trigger OnInsert()
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

}
