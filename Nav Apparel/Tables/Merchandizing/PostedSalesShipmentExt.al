tableextension 71012812 "PostedSales Shipment Extension" extends "Sales Shipment Header"
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

        field(71012589; "LC/Contract No."; Code[20])
        {
        }
    }
}


