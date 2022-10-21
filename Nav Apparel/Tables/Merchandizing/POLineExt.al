tableextension 71012716 "POLine Extension" extends "Purchase Line"
{
    fields
    {
        field(71012581; "StyleNo"; Code[20])
        {
        }

        field(71012582; "StyleName"; Text[50])
        {
        }

        field(71012583; "PONo"; code[20])
        {
        }

        field(71012584; "Lot"; Text[50])
        {
        }

        field(71012585; "Color No."; Code[50])
        {
        }

        field(71012586; "Color Name"; Text[50])
        {
        }

        field(71012587; "EntryType"; Option)
        {
            OptionCaption = 'FG,Sample,Washing,"Central Purchasing"';
            OptionMembers = FG,Sample,Washing,"Central Purchasing";
        }

        field(71012595; "CP Req No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
}

