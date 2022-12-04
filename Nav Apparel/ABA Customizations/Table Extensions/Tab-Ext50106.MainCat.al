tableextension 50106 MainCat extends "Main Category"
{
    fields
    {
        field(50100; "Routing Link Code"; Code[10])
        {
            Caption = 'Routing Link Code';
            DataClassification = ToBeClassified;
            TableRelation = "Routing Link";
        }
        field(50101; "General Issuing"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
}
