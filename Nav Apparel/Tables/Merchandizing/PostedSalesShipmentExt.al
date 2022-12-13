tableextension 50921 "PostedSales Shipment Extension" extends "Sales Shipment Header"
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

        field(50006; "LC/Contract No."; Code[20])
        {
        }

        field(50007; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
}


