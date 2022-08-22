
table 50546 "AcceptanceInv1"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "B2BLC No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "B2BLC No. (System)"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Based On B2B LC","TT or Cash";
            OptionCaption = 'Based On B2B LC,TT or Cash';
        }

        field(4; "Inv No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Inv Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Inv Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Select"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "AccNo."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(11; "AssignedAccNo."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(12; "GITNo."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    // keys
    // {
    //     key(PK; "AccNo.", "Inv No.")
    //     {
    //         Clustered = true;
    //     }
    // }


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
