
table 50540 AcceptanceHeader
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50001; "AccNo."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50002; "Suppler No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50003; "Suppler Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor.Name;
            ValidateTableRelation = false;
        }

        field(50004; "B2BLC No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50005; "B2BLC No (System)"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = B2BLCMaster."No." where(Beneficiary = field("Suppler No."));
        }

        field(50006; "Accept Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(50007; "Accept Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(50008; "Acceptance S/N"; Code[20])
        {
            DataClassification = ToBeClassified;

        }

        field(50009; "Maturity Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(50010; "Payment Mode"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method".Code;
        }

        field(50011; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50012; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(50013; "Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Based On B2B LC","TT or Cash";
            OptionCaption = 'Based On B2B LC,TT or Cash';
        }

        field(50014; "Approved"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50015; "Paid"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50016; "PaidDate"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(50017; "ApproveDate"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(50018; "LC Issue Bank No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50019; "LC Issue Bank"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50020; "Acceptance S/N 2"; BigInteger)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(50021; "Bank Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "AccNo.")
        {
            Clustered = true;
        }
    }


    trigger OnInsert()
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        NavAppSetup.TestField("Acc Nos.");

        "AccNo." := NoSeriesMngment.GetNextNo(NavAppSetup."Acc Nos.", Today, true);

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
