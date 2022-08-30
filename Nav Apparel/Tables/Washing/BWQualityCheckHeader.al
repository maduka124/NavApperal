table 50738 BWQualityCheckHeader
{
    DataClassification = ToBeClassified;
    LookupPageId = BWQualityCheck;
    DrillDownPageId = BWQualityCheck;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Sample Req No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Washing Sample Requsition Line"."No.";
        }

        field(3; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "BW QC Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Pending","Posted";
            OptionCaption = 'Pending,Posted';
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
        NavAppSetup.TestField("BW Wash Quality");
        "No." := NoSeriesMngment.GetNextNo(NavAppSetup."BW Wash Quality", Today, true);
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

   
    trigger OnDelete()

    var
        BWQualityCheckRec: Record BWQualityLine2;
    begin
        BWQualityCheckRec.Reset();
        BWQualityCheckRec.SetRange("No", "No.");
        if BWQualityCheckRec.FindSet() then
            BWQualityCheckRec.DeleteAll();
    end;    

}