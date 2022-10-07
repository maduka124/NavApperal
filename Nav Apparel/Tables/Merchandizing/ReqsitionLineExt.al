tableextension 71012759 "ReqLine Extension" extends "Requisition Line"
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
            OptionCaption = 'FG,Sample';
            OptionMembers = FG,Sample;
        }

        field(71012588; "Main Category"; Text[50])
        {
            TableRelation = "Main Category"."Main Category Name";
            ValidateTableRelation = false;
        }
    }
}

