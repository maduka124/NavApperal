table 51253 BuyerStylePOSearchHeader
{
    DataClassification = ToBeClassified;
    LookupPageId = "Buyer Style PO Search List";
    DrillDownPageId = "Buyer Style PO Search List";

    fields
    {
        field(1; "No."; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Buyer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Buyer Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Group Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Goup Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Style Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master"."Style Display Name" where("Buyer No." = field("Buyer Code"));
            ValidateTableRelation = false;
        }

        field(7; "Style No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(8; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(9; Status; Enum "Purchase Document Status")
        {
            DataClassification = ToBeClassified;
        }
    }
}