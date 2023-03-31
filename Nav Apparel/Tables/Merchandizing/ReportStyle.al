table 51280 StyleReport
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Style No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Style Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Buyer No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Secondary UserID", "Style No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Style No", "Style Name")
        {

        }
    }

    // trigger OnInitReport()
    // var
    //     StyleMasterRec: Record "Style Master";
    //     UserSetupRec: Record "User Setup";
    //     StyleReportRec: Record StyleReport;
    // begin

    //     StyleReportRec.Reset();
    //     StyleReportRec.FindSet();
    //     StyleReportRec.DeleteAll();

    //     UserSetupRec.Reset();
    //     UserSetupRec.get(UserId);

    //     StyleMasterRec.Reset();
    //     StyleMasterRec.SetRange("Merchandizer Group Name", UserSetupRec."Merchandizer Group Name");

    //     if StyleMasterRec.FindSet() then begin
    //         repeat

    //             StyleReportRec.Reset();
    //             StyleReportRec.SetRange("Style No", StyleMasterRec."No.");

    //             if not StyleReportRec.FindSet() then begin

    //                 StyleReportRec.Init();
    //                 StyleReportRec."Secondary UserID" := StyleMasterRec."Secondary UserID";
    //                 StyleReportRec."Style Name" := StyleMasterRec."Style No.";
    //                 StyleReportRec."Style No" := StyleMasterRec."No.";
    //                 StyleReportRec.Insert()

    //             end;
    //         until StyleMasterRec.Next() = 0;
    //     end;
    // end;


}