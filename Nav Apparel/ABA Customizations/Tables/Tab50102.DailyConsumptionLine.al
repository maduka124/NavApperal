table 50102 "Daily Consumption Line"
{
    Caption = 'Daily Consumption Line';
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
        field(3; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
            DataClassification = ToBeClassified;
        }
        field(4; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
            TableRelation = Item;
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(6; "Order Quantity"; Decimal)
        {
            Caption = 'Order Quantity';
            DataClassification = ToBeClassified;
        }
        field(7; "Daily Consumption"; Decimal)
        {
            Caption = 'Daily Consumption';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "Daily Consumption" > "Balance Quantity" then
                    Error('Required Qty. must not be greater than balance qty.');
            end;
        }
        field(8; "prod. Order Line No."; Integer)
        {
            Caption = 'Order Line No.';
            DataClassification = ToBeClassified;
        }
        field(9; "Issued Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Balance Quantity"; Decimal)
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
    }
}
