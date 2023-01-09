table 50105 "General Issue Header"
{
    Caption = 'General Issue Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = ToBeClassified;
        }
        field(4; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionMembers = Open,"Pending Approval",Approved;
            OptionCaption = 'Open,Pending Approval,Approved';
        }
        field(5; "Created UserID"; Code[50])
        {
            Caption = 'Created UserID';
            DataClassification = ToBeClassified;
        }
        field(6; "Approved UserID"; Code[50])
        {
            Caption = 'Approved UserID';
            DataClassification = ToBeClassified;
        }
        field(7; "Approved Date/Time"; DateTime)
        {
            Caption = 'Approved Date/Time';
            DataClassification = ToBeClassified;
        }
        field(8; "Journal Template Name"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Journal Batch Name"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"));
        }
        field(10; "Approver UserID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Department Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Department."Department Name";
            ValidateTableRelation = false;
        }
        field(12; "Issued Date/Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Issued UserID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }       
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Department Name", "Journal Batch Name")
        {
        }
    }
    trigger OnInsert()
    var
        ManufacSetup: Record "Inventory Setup";
        NosMangmnet: Codeunit NoSeriesManagement;
    begin
        if "No." = '' then begin
            ManufacSetup.Get();
            ManufacSetup.TestField("Gen. Issue Nos.");
            "No." := NosMangmnet.GetNextNo(ManufacSetup."Gen. Issue Nos.", WorkDate(), true);
            "Document Date" := WorkDate();

            "Journal Template Name" := ManufacSetup."Gen. Issue Template";
            "Created UserID" := UserId;
        end;
    end;

    procedure AssistEdit(OldDailyConsumpHedd: Record "General Issue Header"): Boolean
    var
        DailyConsumHedd2: Record "General Issue Header";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ManuSetup: Record "Inventory Setup";
    begin
        COPY(Rec);
        ManuSetup.Get();
        ManuSetup.TestField("Gen. Issue Nos.");

        IF NoSeriesMgt.SelectSeries(ManuSetup."Gen. Issue Nos.", OldDailyConsumpHedd."No.", "No.") THEN BEGIN
            NoSeriesMgt.SetSeries("No.");
            IF DailyConsumHedd2.GET("No.") THEN
                EXIT(TRUE);
        END;
    end;
}
