tableextension 50661 ProductionOderHeadExt extends "Production Order"
{
    fields
    {
        field(50001; Editeble; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50002; Buyer; text[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer.Name;
            ValidateTableRelation = false;
        }

        field(50003; BuyerCode; Code[20])
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

        field(50004; "Style Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master"."Style No." where("Buyer No." = field(BuyerCode));
            ValidateTableRelation = false;
        }

        field(50005; "Style No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master"."No.";
        }

        field(50006; PO; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master PO"."PO No." where("Style No." = field("Style No."));
            ValidateTableRelation = false;
        }

        field(50007; Color; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = StyleColor.Color;
            ValidateTableRelation = false;
        }

        field(50008; ColorCode; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50009; "Wash Type"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Wash Type"."Wash Type Name";
            ValidateTableRelation = false;
        }

        field(50010; Fabric; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50011; "Gament Type"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Garment Type"."Garment Type Description";
            ValidateTableRelation = false;
        }

        field(50012; "Sample/Bulk"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Sample","Bulk";
            OptionCaption = 'Sample,Bulk';
        }

        field(50013; "Hydro Extractor (Minutes)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50014; "Hot Dryer (Temp 'C)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50015; "Cool Dry"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Yes","No";
            OptionCaption = 'Yes,No';
        }

        field(50016; "Machine Type"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = WashingMachineType.Description;
            ValidateTableRelation = false;
        }

        field(50017; "Machine Type Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50018; "Load Weight (Kg)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50019; "Piece Weight (g)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50020; "Remarks Job Card"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(50021; "Total Water Ltrs:"; Decimal)
        {
            DataClassification = ToBeClassified;
            // FieldClass = FlowField;
            // CalcFormula = Sum("Prod. Order Line".Water WHERE("Prod. Order No." = Field("No."), Status = Field(Status)));
        }

        field(50022; "Process Time:"; Decimal)
        {
            DataClassification = ToBeClassified;
            // FieldClass = FlowField;
            // CalcFormula = Sum("Prod. Order Line"."Time(Min)" WHERE("Prod. Order No." = Field("No."), Status = Field(Status)));
        }

        field(50023; "BarCode"; Code[100])
        {
            DataClassification = ToBeClassified;
        }

        field(50024; "Wash Type Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50025; "Gament Type Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50026; "Prod Order Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Bulk","Samples","Washing";
            OptionCaption = 'Bulk,Samples,Washing';
        }

        field(50027; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

    }

    fieldgroups
    {
        addlast(DropDown; PO)
        { }
    }
}