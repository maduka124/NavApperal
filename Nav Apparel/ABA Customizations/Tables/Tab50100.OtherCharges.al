table 50100 "Other Charges"
{
    Caption = 'Other Charges';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Item Charge No."; Code[20])
        {
            Caption = 'Item Charge No.';
            DataClassification = ToBeClassified;
            TableRelation = "Item Charge";
            trigger OnValidate()
            var
                ItemChargeRec: Record "Item Charge";
            begin
                Description := '';
                if "Item Charge No." <> '' then
                    ItemChargeRec.Get("Item Charge No.");
                Description := ItemChargeRec.Description;
                "Bank Charge" := ItemChargeRec."Bank Charge";
            end;
        }
        field(4; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(5; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(6; "Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
            trigger OnValidate()
            var
                VendRec: Record Vendor;
            begin
                "Vendor Name" := '';
                if "Vendor No." <> '' then
                    VendRec.Get("Vendor No.");
                "Vendor Name" := VendRec.Name;
            end;
        }
        field(7; "Vendor Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Bank Charge"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Process Completed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(SK; "Document No.", "Bank Charge")
        {

        }
    }
}
