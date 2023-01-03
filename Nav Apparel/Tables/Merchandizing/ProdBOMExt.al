tableextension 50922 "ProdBOM Extension" extends "Production BOM Header"
{
    fields
    {
        field(50001; "EntryType"; Option)
        {
            OptionCaption = 'FG,Sample,Washing';
            OptionMembers = FG,Sample,Washing;
        }

        field(50002; "Wash Type"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Wash Type"."Wash Type Name";
            ValidateTableRelation = false;
        }

        field(50003; "Wash Type No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50004; "Machine Type"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = WashingMachineType.Description;
            ValidateTableRelation = false;
        }

        field(50005; "Lot Size (Kg)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50006; "Bulk/Sample"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Bulk","Sample";
            OptionCaption = 'Bulk,Sample';
        }

        field(50007; "BOM Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Bulk","Samples","Washing";
            OptionCaption = 'Bulk,Samples,Washing';
        }

        field(50008; "Style Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master"."Style No.";
            ValidateTableRelation = false;
        }

        field(50009; "Style No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50010; "Lot"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master PO"."Lot No." where("Style No." = field("Style No."));
            ValidateTableRelation = false;
        }

        field(50011; "Color"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Colour."Colour Name";
            ValidateTableRelation = false;
        }

        field(50012; "ColorCode"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50013; "Editeble"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50014; "Machine Type Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50015; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50016; "Merchandizer Group Name"; Text[200])
        {

        }
    }


    trigger OnInsert()
    var
        UserSetupRec: Record "User Setup";
    begin

        UserSetupRec.Reset();
        UserSetupRec.SetRange("User ID", UserId);
        if UserSetupRec.FindSet() then
            rec."Merchandizer Group Name" := UserSetupRec."Merchandizer Group Name";
    end;
}


