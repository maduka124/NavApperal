tableextension 50656 WashingBOMLineExt extends "Production BOM Line"
{
    fields
    {
        field(46; Step; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "WashingStep".Description;
            ValidateTableRelation = false;
        }

        field(47; "Water(L)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(48; "Temperature"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(49; Time; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50; "Weight(Kg)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(60; "Remark"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
}