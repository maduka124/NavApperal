tableextension 50832 TransShipHedd extends "Transfer Shipment Header"
{
    fields
    {
        field(50100; "Style Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50101; PO; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Style Master PO"."PO No." where("Style No." = field("Style No."));
            //ValidateTableRelation = false;
        }
        field(50102; "Style No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master"."No.";
        }

        field(50103; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

    }
}
