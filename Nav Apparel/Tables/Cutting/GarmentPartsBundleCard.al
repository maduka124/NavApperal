table 51276 GarmentPartsBundleCard
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; BundleCardNo; code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(3; Select; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(4; Description; Text[200])
        {
            DataClassification = ToBeClassified;

        }
        field(5; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(6; "Created User"; Text[200])
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }

        key(SK; Description)
        {
        }
    }


    trigger OnInsert()
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        NavAppSetup.TestField("BundleGuideCard Nos.");
        No := NoSeriesMngment.GetNextNo(NavAppSetup."BundleGuideCard Nos.", Today, true);
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

}