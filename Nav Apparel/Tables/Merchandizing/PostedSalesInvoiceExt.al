tableextension 50920 "PostedSales Invoice Extension" extends "Sales Invoice Header"
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

    }
}


