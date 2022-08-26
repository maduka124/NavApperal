table 50707 "Wash Sample Job Creation"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Seq No."; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(17; " GRN No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(18; "Gate Pass No"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "From"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Sample","Bulk";
            OptionCaption = 'Sample,Bulk';
        }

        field(4; Buyer; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Style"; Code[100])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "PO"; Code[100])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Color"; Code[100])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Order Qty"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Gament Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Sample Type"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Wash Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Wash Type"."No.";
        }
        field(13; Size; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Qty; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Req Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(16; "REC Qty"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(19; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(20; "Factory Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(21; "Factory Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(22; "Style Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(23; "Color Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(24; SampleType; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(25; " Req Qty"; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(26; "Sample Item Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(27; "GRN No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(28; "Option"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(29; "Remark"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(30; "Style No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(31; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(32; "Sample No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(33; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(34; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(pk; "No.", "Line No", "Seq No.")
        {
            Clustered = true;
        }
    }


    trigger OnInsert()
    var
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