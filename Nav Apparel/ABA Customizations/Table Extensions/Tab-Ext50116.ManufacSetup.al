tableextension 50116 Manufac_Setup extends "Manufacturing Setup"
{
    fields
    {
        field(50100; "Daily Consumption Nos."; Code[20])
        {
            Caption = 'Daily Consumption Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50101; "Style Transfer Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50102; "Posted Daily Consumption Nos."; Code[20])
        {
            Caption = 'Posted Daily Consumption Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
}
