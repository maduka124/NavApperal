
table 50540 AcceptanceHeader
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "AccNo."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Suppler No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Suppler Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor.Name;
            ValidateTableRelation = false;
        }

        field(4; "B2BLC No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "B2BLC No (System)"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = B2BLCMaster."No." where(Beneficiary = field("Suppler No."));
        }

        field(6; "Accept Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Accept Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(8; "Acceptance S/N"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Maturity Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Payment Mode"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method".Code;
        }

        field(11; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Based On B2B LC","TT or Cash";
            OptionCaption = 'Based On B2B LC,TT or Cash';
        }

        field(14; "Approved"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Paid"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(16; "PaidDate"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(17; "ApproveDate"; Date)
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
