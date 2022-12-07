table 50678 RTCBWHeader
{
    DataClassification = ToBeClassified;
    LookupPageId = RTCBWList;
    DrillDownPageId = RTCBWList;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Req No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Washing Sample Header"."No.";
            ValidateTableRelation = false;
        }

        field(3; "CusTomer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Req Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Gate Pass"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Req Line"; Integer)
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

        field(9; "CusTomer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Secondary UserID"; Code[20])
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
        "No." := NoSeriesMngment.GetNextNo(NavAppSetup."TRCBW No", Today, true);
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;


    trigger OnDelete()
    var
        ReturntoCustomerHeadeeRec: Record RTCBWHeader;
    begin
        ReturntoCustomerHeadeeRec.Reset();
        ReturntoCustomerHeadeeRec.SetRange("No.", "No.");
        if ReturntoCustomerHeadeeRec.FindSet() then
            ReturntoCustomerHeadeeRec.DeleteAll();
    end;
}