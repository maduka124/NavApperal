
table 50761 BankReferenceHeader
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "BankRefNo."; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "AirwayBillNo"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Maturity Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Reference Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Airway Bill Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Remarks"; text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Total"; Decimal)
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
        fieldgroup(DropDown; "No.", "BankRefNo.", "Reference Date", AirwayBillNo, "Airway Bill Date", "Maturity Date")
        {

        }
    }

    trigger OnInsert()
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        NavAppSetup.TestField("BankRef Nos.");
        "No." := NoSeriesMngment.GetNextNo(NavAppSetup."BankRef Nos.", Today, true);
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;


    // trigger OnDelete()
    // var
    //     B2BLCMasterRec: Record "B2BLCMaster";
    // begin

    //     //Check for Exsistance
    //     B2BLCMasterRec.Reset();
    //     B2BLCMasterRec.SetRange("LC/Contract No.", "Contract No");
    //     if B2BLCMasterRec.FindSet() then
    //         Error('LC/Contract : %1 already used in B2B LC. Cannot delete.', "Contract No");

    // end;
}
