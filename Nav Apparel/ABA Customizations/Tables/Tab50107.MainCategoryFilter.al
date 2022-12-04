table 50107 "Main Category Filter"
{
    Caption = 'Main Category Filter';
    DataClassification = ToBeClassified;
    LookupPageId = 50118;
    DrillDownPageId = 50118;
    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
            TableRelation = "Main Category";
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
