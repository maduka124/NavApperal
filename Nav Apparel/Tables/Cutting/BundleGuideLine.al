
table 50668 BundleGuideLine
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "BundleGuideNo."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Line No"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Bundle No"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Cut No"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(5; "SJCNo"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Color No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Color Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Shade No"; Code[20])
        {
            DataClassification = ToBeClassified;

        }

        field(9; "Shade Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Shade.Shade;
        }


        field(10; "Sticker Sequence"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Size"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(14; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Bundle Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Normal,"Roll Wise";
            OptionCaption = 'Normal,Roll Wise';
        }

        field(16; "Role ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(17; "Style No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(18; "Style Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(19; "Lot"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(20; "PO"; text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Barcode"; text[50])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "BundleGuideNo.", "Line No")
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
