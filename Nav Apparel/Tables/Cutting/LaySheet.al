
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

        // field(3; "Cut No."; Integer)
        // {
        //     DataClassification = ToBeClassified;
        //     InitValue = 0;
        // }

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
            TableRelation = AssortmentDetails."Colour Name" where("Style No." = field("Style No."), "PO No." = field("PO No."), Type = filter(1));
            ValidateTableRelation = false;
        }

        field(11; "Component Group Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Component Group Name"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = MarkerCategory."Marker Category";
            ValidateTableRelation = false;
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
            TableRelation = "Style Master PO"."PO No." where("Style No." = field("Style No."));
            ValidateTableRelation = false;
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

        field(30; "Buyer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(31; "Buyer Name"; text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer.Name;
            ValidateTableRelation = false;
        }

        field(32; "Cut No New"; Text[20])
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
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
        UserRec: Record "User Setup";
    begin
        NavAppSetup.Get('0001');
        NavAppSetup.TestField("LaySheet Nos.");
        "LaySheetNo." := NoSeriesMngment.GetNextNo(NavAppSetup."LaySheet Nos.", Today, true);

        UserRec.Reset();
        UserRec.Get(UserId);

        if UserRec."Factory Code" <> '' then
            Rec."Factory Code" := UserRec."Factory Code"
        else
            Error('Factory not assigned for the user.');

        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

}
