
table 50546 "AcceptanceInv1"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50001; "B2BLC No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50002; "B2BLC No. (System)"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50003; "Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Based On B2B LC","TT or Cash";
            OptionCaption = 'Based On B2B LC,TT or Cash';
        }

        field(50004; "Inv No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50005; "Inv Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50006; "Inv Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(50007; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50008; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(50009; "Select"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50010; "AccNo."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50011; "AssignedAccNo."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50012; "GITNo."; Code[20])
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
