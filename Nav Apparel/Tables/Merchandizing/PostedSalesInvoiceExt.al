tableextension 50920 "PostedSales Invoice Extension" extends "Sales Invoice Header"
{
    fields
    {
        field(71012581; "Style No"; Code[20])
        {
        }

        field(71012582; "Style Name"; text[50])
        {
        }

        field(71012583; "PO No"; Code[20])
        {
        }

        field(71012584; "Lot"; Code[20])
        {
        }

        field(71012585; "EntryType"; Option)
        {
            OptionCaption = 'FG,Sample,Washing';
            OptionMembers = FG,Sample,Washing;
        }

        field(71012586; "BankRefNo"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012587; "AssignedBankRefNo"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012588; "Select"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

    }
}


