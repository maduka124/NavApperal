
table 50843 PlanEffDashboardReportTable
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Year; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(2; MonthName; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(3; MonthNo; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Factory No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Factory Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Line No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Line Name"; Text[100])
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

        field(10; "Factory Eff."; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Line Eff."; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Style Eff."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; Year, MonthNo, "Factory No.", "Line No.", "Style No.")
        {
            Clustered = true;
        }
    }
}
