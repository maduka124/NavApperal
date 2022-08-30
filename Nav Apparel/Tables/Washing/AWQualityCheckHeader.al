table 50686 AWQualityCheckHeader
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Job Card No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = JobCreationLine."Job Card (Prod Order)";
            ValidateTableRelation = false;
        }

        field(3; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(4; CustomerCode; code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Req date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Sample Req No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Split No"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "QC AW Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(12; CustomerName; text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Pending","Posted";
            OptionCaption = 'Pending,Posted';
        }

        field(15; "Pass Qty"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(16; "Fail Qty"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(17; Remarks; Text[200])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(pk; "No.")
        {
            Clustered = true;
        }
    }


    trigger OnInsert()
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        NavAppSetup.TestField("QC AW No");
        "No." := NoSeriesMngment.GetNextNo(NavAppSetup."QC AW No", Today, true);
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

    trigger OnDelete()
    var
        AWQualityCheckLineRec: Record AWQualityCheckLine;
    begin

        AWQualityCheckLineRec.Reset();
        AWQualityCheckLineRec.SetRange(No, "No.");

        if AWQualityCheckLineRec.FindSet() then
            AWQualityCheckLineRec.DeleteAll();
    end;

}