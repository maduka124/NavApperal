tableextension 50937 TransferOrderHeaderExt extends "Transfer Header"
{
    fields
    {
        field(50001; "Style No."; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50002; "Style Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50003; PO; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master PO"."PO No." where("Style No." = field("Style No."));
            ValidateTableRelation = false;
        }

        field(50004; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50005; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    trigger OnAfterInsert()
    var
    begin
        "Created User" := UserId;
    end;
}