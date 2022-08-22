tableextension 71012814 "ProdBOM Extension" extends "Production BOM Header"
{
    fields
    {
        field(71012581; "EntryType"; Option)
        {
            OptionCaption = 'FG,Sample,Washing';
            OptionMembers = FG,Sample,Washing;
        }

        field(71012582; "Wash Type"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Wash Type"."Wash Type Name";
            ValidateTableRelation = false;
        }

        field(71012583; "Wash Type No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012584; "Machine Type"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = WashingMachineType.Description;
            ValidateTableRelation = false;
        }

        field(71012585; "Lot Size (Kg)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(71012586; "Bulk/Sample"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Bulk","Sample";
            OptionCaption = 'Bulk,Sample';
        }

        field(71012587; "BOM Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Finished Goods","Samples","Washing";
            OptionCaption = 'Finished Goods,Samples,Washing';
        }

        field(71012588; "Style Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master"."Style No.";
            ValidateTableRelation = false;
        }

        field(71012589; "Style No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012590; "Lot"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master PO"."Lot No." where("Style No." = field("Style No."));
            ValidateTableRelation = false;
        }

        field(71012592; "Color"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Colour."Colour Name";
            ValidateTableRelation = false;
        }

        field(71012593; "ColorCode"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012594; "Editeble"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(71012595; "Machine Type Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
}


