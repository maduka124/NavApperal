
table 50762 BankReferenceInvoice
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Invoice No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Ship Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Select"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.", "Invoice No")
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
}
