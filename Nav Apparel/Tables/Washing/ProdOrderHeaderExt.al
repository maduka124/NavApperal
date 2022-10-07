tableextension 50661 ProductionOderHeadExt extends "Production Order"
{
    fields
    {
        field(115; Editeble; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(116; Buyer; text[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer.Name;
            ValidateTableRelation = false;
        }

        field(117; BuyerCode; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                CustomerRec: Record Customer;
            begin
                CustomerRec.Reset();
                CustomerRec.SetRange("No.", BuyerCode);
                if CustomerRec.FindSet() then
                    Buyer := CustomerRec.Name;
            end;
        }

        field(118; "Style Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master"."Style No." where("Buyer No." = field(BuyerCode));
            ValidateTableRelation = false;
        }

        field(119; "Style No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master"."No.";
        }

        field(120; PO; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master PO"."PO No." where("Style No." = field("Style No."));
            ValidateTableRelation = false;
        }

        field(121; Color; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = StyleColor.Color;
            ValidateTableRelation = false;
        }

        field(122; ColorCode; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(123; "Wash Type"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Wash Type"."Wash Type Name";
            ValidateTableRelation = false;
        }

        field(124; Fabric; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(125; "Gament Type"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Garment Type"."Garment Type Description";
            ValidateTableRelation = false;
        }

        field(126; "Sample/Bulk"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Sample","Bulk";
            OptionCaption = 'Sample,Bulk';
        }

        field(127; "Hydro Extractor (Minutes)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(128; "Hot Dryer (Temp 'C)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(129; "Cool Dry"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Yes","No";
            OptionCaption = 'Yes,No';
        }

        field(130; "Machine Type"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = WashingMachineType.Description;
            ValidateTableRelation = false;
        }

        field(131; "Machine Type Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(132; "Load Weight (Kg)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(133; "Piece Weight (g)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(134; "Remarks Job Card"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(135; "Total Water Ltrs:"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(136; "Process Time:"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(137; "BarCode"; Code[100])
        {
            DataClassification = ToBeClassified;
        }

        field(138; "Wash Type Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(139; "Gament Type Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(140; "Prod Order Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Bulk","Samples","Washing";
            OptionCaption = 'Bulk,Samples,Washing';
        }
    }
}