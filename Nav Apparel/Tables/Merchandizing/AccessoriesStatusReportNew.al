
table 51263 "AccessoriesStatusReportNew"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(71012581; "PONo."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Item No"; code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012583; "Item Desc"; text[250])
        {
            DataClassification = ToBeClassified;
        }

        field(71012584; "Size"; text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(71012585; "Color"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(71012586; "Article"; Text[200])
        {
            DataClassification = CustomerContent;
        }

        field(71012587; "Dimension"; text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(71012588; "Unit"; text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(71012589; "PO Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(71012590; "GRN Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(71012591; "Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(71012592; "Issue Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(71012593; "Stock Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(71012594; "StyleNo"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012595; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012596; "SeqNo"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(71012597; "FromPOLine"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(71012598; "Master Category Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "SeqNo")
        {
            Clustered = true;
        }

        key(SK; "Item Desc")
        {

        }
    }
}
