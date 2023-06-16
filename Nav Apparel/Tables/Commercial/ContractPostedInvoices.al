
table 51219 ContractPostedInvoices
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "LC/Contract No."; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "AssignedBankRefNo"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Select"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Inv No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Inv Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "BankRefNo"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Inv Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Order No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Factory Inv No"; text[35])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Style No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Style Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; BankRefNo, "LC/Contract No.", "Inv No.")
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
