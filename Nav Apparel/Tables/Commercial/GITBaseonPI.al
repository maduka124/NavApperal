
table 50531 "GITBaseonPI"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "GITPINo."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Suppler No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Suppler Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor.Name;
            ValidateTableRelation = false;
        }

        field(4; "Invoice No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Invoice Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Original Doc. Recv. Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "GRN Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(8; "Invoice Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(9; "Mode of Ship"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Sea,Air,"Sea-Air","Air-Sea","By Road";
            OptionCaption = 'Sea,Air,"Sea-Air","Air-Sea","By Road"';
        }

        field(10; "BL/AWB NO"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(11; "BL Date"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Container No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Carrier Name"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(14; "Agent"; Code[20])
        {
            DataClassification = ToBeClassified;
        }


        field(15; "M. Vessel Name"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(16; "M. Vessel ETD"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(17; "F. Vessel Name"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(18; "F. Vessel ETA"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(19; "F. Vessel ETD"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(20; "N.N Docs DT"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(21; "Original to C&F"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(22; "Good inhouse"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(23; "Bill of entry"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(24; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(25; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(26; "AssignedAccNo"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "GITPINo.")
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
        NavAppSetup.TestField("GITPI Nos.");

        "GITPINo." := NoSeriesMngment.GetNextNo(NavAppSetup."GITPI Nos.", Today, true);

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
