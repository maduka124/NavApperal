
table 50636 RoleIssuingNoteHeader
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "RoleIssuNo."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Req No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = FabricRequsition."FabReqNo.";
        }

        field(3; "Item No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Item Name"; text[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = FabricMapping."Item Name" where("Style No." = field("Style No."), "Colour No" = field("Colour No"));
            ValidateTableRelation = false;
        }

        field(5; "OnHandQty"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(6; "Required Width"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(7; "Required Length"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(8; "Selected Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(9; "UOM Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(10; UOM; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Created User"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Style No."; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(14; "Style Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Colour No"; code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(16; "Colour Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(17; "GRN No"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purch. Rcpt. Header"."No.";
        }
    }

    keys
    {
        key(PK; "RoleIssuNo.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "RoleIssuNo.", "Req No.")
        {


        }
    }




    trigger OnInsert()
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        NavAppSetup.TestField("RoleIssu Nos.");

        "RoleIssuNo." := NoSeriesMngment.GetNextNo(NavAppSetup."RoleIssu Nos.", Today, true);

        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    var
        LaySheetHeaderRec: Record "LaySheetHeader";
    begin

        //Check for Exsistance
        LaySheetHeaderRec.Reset();
        LaySheetHeaderRec.SetRange("FabReqNo.", "Req No.");
        if LaySheetHeaderRec.FindSet() then
            Error('Fabric Requsition No : %1 already used in Laysheet. Cannot delete.', "Req No.");

    end;

    trigger OnRename()
    begin

    end;

}
