tableextension 50566 "SalesOrder Extension" extends "Sales Header"
{
    fields
    {
        field(50001; "Style No"; Code[20])
        {
        }

        field(50002; "Style Name"; text[50])
        {
        }

        field(50003; "PO No"; Code[20])
        {
        }

        field(50004; "Lot"; Code[20])
        {
        }

        field(50005; "EntryType"; Option)
        {
            OptionCaption = 'FG,Sample,Washing';
            OptionMembers = FG,Sample,Washing;
        }


        //Newly added by maduka on 17/1/2023
        field(50006; "BankRefNo"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50007; "AssignedBankRefNo"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50008; "Select"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50009; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50010; "Merchandizer Group Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }


        // field(50006; "Secondary UserID"; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        // }

        // field(50007; "Merchandizer Group Name"; Text[200])
        // {

        // }
    }


    trigger OnInsert()
    var
        UserSetupRec: Record "User Setup";
    begin

        UserSetupRec.Reset();
        UserSetupRec.SetRange("User ID", UserId);
        if UserSetupRec.FindSet() then
            rec."Merchandizer Group Name" := UserSetupRec."Merchandizer Group Name";
    end;
}


