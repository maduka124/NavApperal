table 50819 DeptReqSheetHeader
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Req No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Factory Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Factory Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Department Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Department Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Department."Department Name";
            ValidateTableRelation = false;
        }

        field(6; "Request Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Remarks"; text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Completely Received"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = No,Yes;
            OptionCaption = 'No,Yes';
        }

        field(9; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Global Dimension Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1), Blocked = CONST(false));
        }

        field(12; "Approved Date"; Date)
        {
            DataClassification = ToBeClassified;
        }


        field(13; "Approved By"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(14; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = New,"Pending Approval",Approved,Rejected;
            OptionCaption = 'New,Pending Approval,Approved,Rejected';
        }

        field(15; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
           field(16; "Copy";Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Req No")
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
        NavAppSetup.TestField("DepReq No");
        "Req No" := NoSeriesMngment.GetNextNo(NavAppSetup."DepReq No", Today, true);
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;
}