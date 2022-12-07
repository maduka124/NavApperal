
table 51135 TableMaster
{
    DataClassification = ToBeClassified;
    LookupPageId = TableList;
    DrillDownPageId = TableList;

    fields
    {
        field(71012581; "Table No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Table Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012583; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012584; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012585; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Table No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Table No.", "Table Name")
        {

        }
    }

    trigger OnInsert()
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    var
        FabricReqRec: Record "FabricRequsition";
        TableCreationRec: Record "TableCreation";
    begin
        //Check for Exsistance
        FabricReqRec.Reset();
        FabricReqRec.SetRange("Table No.", "Table No.");
        if FabricReqRec.FindSet() then
            Error('Table : %1 already used in operations. Cannot delete.', "Table Name");

        TableCreationRec.Reset();
        TableCreationRec.SetRange("Table No.", "Table No.");
        if TableCreationRec.FindSet() then
            Error('Table : %1 already used in operations. Cannot delete.', "Table Name");

    end;

    trigger OnRename()
    begin

    end;

}
