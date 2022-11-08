tableextension 71012756 "GRNLine Extension" extends "Purch. Rcpt. Line"
{
    fields
    {
        field(71012581; "StyleNo"; Code[20])
        {
        }

        field(71012582; "StyleName"; Text[50])
        {
            TableRelation = "Style Master"."Style No." where(Type = filter(Costing), "Buyer No." = field("Buyer No."));
            ValidateTableRelation = false;
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

        field(71012596; "Buyer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012597; "Buyer Name"; text[50])
        {
            TableRelation = Customer.Name;
            ValidateTableRelation = false;
        }
    }
}

