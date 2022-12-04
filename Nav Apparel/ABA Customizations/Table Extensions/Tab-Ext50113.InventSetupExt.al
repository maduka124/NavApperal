tableextension 50113 InventSetupExt extends "Inventory Setup"
{
    fields
    {
        field(50100; "Gen. Issue Template"; Code[20])
        {
            Caption = 'Gen. Issue Template';
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Template" where(Type = filter(Item), Recurring = filter(false));
        }
        field(50101; "Gen. Issue Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
}
