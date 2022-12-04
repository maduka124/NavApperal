tableextension 50924 "PurchaseInvoiceLine Extension" extends "Purch. Inv. Line"
{
    fields
    {
        field(50001; "StyleNo"; Code[20])
        {
        }

        field(50002; "StyleName"; Text[50])
        {
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
            OptionCaption = 'FG,Sample,Washing';
            OptionMembers = FG,Sample,Washing;
        }
    }
}

