tableextension 71012757 TransferOrderHeaderExt extends "Transfer Header"
{
    fields
    {
        field(71012581; "Style No."; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Style Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012583; PO; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master PO"."PO No." where("Style No." = field("Style No."));
            ValidateTableRelation = false;
        }
    }
}