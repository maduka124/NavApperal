tableextension 50102 DimValues extends "Dimension Value"
{
    fields
    {
        field(50100; "No. Series - PO"; Code[20])
        {
            Caption = 'Purchase Order No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50101; "No. Series - Shipping"; Code[20])
        {
            Caption = 'Sales Order Shipping No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50102; "No. Series - Invoicing"; Code[20])
        {
            Caption = 'Sales Order Invoicing No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50103; "Receiving No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
}
