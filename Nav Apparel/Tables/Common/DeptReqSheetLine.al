table 50820 DeptReqSheetLine
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Req No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(3; "Item No"; Code[60])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item."No." where("EstimateBOM Item" = filter(false));
            ValidateTableRelation = false;
        }

        field(4; "Item Name"; text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "UOM"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure".Description;
            ValidateTableRelation = false;
        }

        field(7; "Remarks"; text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Req No", "Line No")
        {
            Clustered = true;
        }
    }
}