table 50681 RTCAWHeader
{
    DataClassification = ToBeClassified;
    LookupPageId = RTCAWHeaderList;
    DrillDownPageId = RTCAWHeaderList;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "JoB Card No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = JobCreationLine."Job Card (Prod Order)";
            ValidateTableRelation = false;
        }

        field(3; CustomerCode; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Req Date"; Date)
        {
            DataClassification = ToBeClassified;

        }

        field(5; "Gate Pass No"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Line No"; Integer)
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

        field(9; "Req No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Washing Sample Header"."No.";
        }

        field(10; "Gate Pass"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Slipt No"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Pending","Posted";
            OptionCaption = 'Pending,Posted';
        }

        field(13; CustomerName; Text[200])
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
        "No." := NoSeriesMngment.GetNextNo(NavAppSetup."RTC AW No", Today, true);
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;


    trigger OnDelete()
    var
        ReturntoCustomerHeadeeRec: Record RTCAWLine;
    begin
        ReturntoCustomerHeadeeRec.Reset();
        ReturntoCustomerHeadeeRec.SetRange("No.", "No.");
        if ReturntoCustomerHeadeeRec.FindSet() then
            ReturntoCustomerHeadeeRec.DeleteAll();
    end;
}