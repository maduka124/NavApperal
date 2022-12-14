
table 50611 TableCreation
{
    DataClassification = ToBeClassified;
    LookupPageId = "Table Creation";
    DrillDownPageId = "Table Creation";

    fields
    {
        field(1; "TableCreNo"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Table No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Table Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "TableMaster"."Table Name";
            ValidateTableRelation = false;
        }

        field(4; "Plan Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(18; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(19; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; TableCreNo)
        {
            Clustered = true;
        }
    }

    // fieldgroups
    // {
    //     fieldgroup(DropDown; "No", "Style No.", "Style Name")
    //     {

    //     }
    // }

    trigger OnInsert()
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        NavAppSetup.TestField("TableCre Nos.");

        TableCreNo := NoSeriesMngment.GetNextNo(NavAppSetup."TableCre Nos.", Today, true);

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
