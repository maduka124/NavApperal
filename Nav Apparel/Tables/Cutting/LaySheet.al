
table 50645 LaySheetHeader
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "LaySheetNo."; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = RoleIssuingNoteHeader."RoleIssuNo.";
        }

        field(2; "FabReqNo."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = RoleIssuingNoteHeader."Req No." where("RoleIssuNo." = field("LaySheetNo."));
            ValidateTableRelation = false;
        }

        field(3; "Cut No."; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(4; "Plan Date"; date)
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Style No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Style Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Group ID"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Consumption"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Color No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Color"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Component Group Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Component Group Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(14; "Item Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Marker Name"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(16; "Fab Direction"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(17; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(18; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(19; "Remarks 1"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(20; "Remarks 2"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(21; "Remarks 3"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(22; "Remarks 4"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(23; "Act Con"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(24; "Saving %"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(25; "Reason"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(26; "Approved"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(27; "PO No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(28; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        //Done By Sachith on 06/04/23
        field(29; "Factory Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "LaySheetNo.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "LaySheetNo.", "FabReqNo.", "Style Name")
        {

        }
    }


    trigger OnInsert()
    var
    // NavAppSetup: Record "NavApp Setup";
    // NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        // NavAppSetup.Get('0001');
        // NavAppSetup.TestField("LaySheet Nos.");

        // "LaySheetNo." := NoSeriesMngment.GetNextNo(NavAppSetup."LaySheet Nos.", Today, true);

        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

}
