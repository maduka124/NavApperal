
table 50659 CuttingProgressHeader
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "CutProNo."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "LaySheetNo"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = LaySheetHeader."LaySheetNo.";
        }

        field(3; "FabReqNo."; Code[20])
        {
            DataClassification = ToBeClassified;
            // TableRelation = LaySheetHeader."FabReqNo." where("LaySheetNo." = field(LaySheetNo));
            // ValidateTableRelation = false;
        }

        field(4; "Item No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Item Name"; text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Cut No."; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Created User"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Marker Name"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Marker Length"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "UOM Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(12; UOM; Text[50])
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

        field(15; "PO No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(16; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "CutProNo.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "CutProNo.", LaySheetNo, "FabReqNo.", "Item Name")
        {
        }
    }


    trigger OnInsert()
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        NavAppSetup.TestField("CutPro Nos.");

        "CutProNo." := NoSeriesMngment.GetNextNo(NavAppSetup."CutPro Nos.", Today, true);

        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}
