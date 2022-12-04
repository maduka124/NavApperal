tableextension 50912 "GRNLine Extension" extends "Purch. Rcpt. Line"
{
    fields
    {
        field(50001; "StyleNo"; Code[20])
        {
        }

        field(50002; "StyleName"; Text[50])
        {
            TableRelation = "Style Master"."Style No." where(Type = filter(Costing), "Buyer No." = field("Buyer No."));
            ValidateTableRelation = false;
        }

        field(50003; "PONo"; code[20])
        {
        }

        field(50004; "Lot"; Text[50])
        {
        }

        field(50005; "Color No."; Code[50])
        {
        }

        field(50006; "Color Name"; Text[50])
        {
        }

        field(50007; "EntryType"; Option)
        {
            OptionCaption = 'FG,Sample,Washing,"Central Purchasing"';
            OptionMembers = FG,Sample,Washing,"Central Purchasing";
        }

        field(50008; "CP Req No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50009; "Buyer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50010; "Buyer Name"; text[50])
        {
            TableRelation = Customer.Name;
            ValidateTableRelation = false;
        }
    }
}

