
table 51239 ExportReferenceHeader
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Buyer No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Buyer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer.Name;
            ValidateTableRelation = false;
        }

        field(4; "Invoice No"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sales Invoice Header"."No." where("Sell-to Customer No." = field("Buyer No"), "Export Ref No." = filter(''));
        }

        field(5; "BL No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "BL Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "DOC Sub Buyer Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "DOC Sub Bank Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Created Date"; Date)
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


    trigger OnInsert()
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        NavAppSetup.TestField("ExpoRef Nos.");
        "No." := NoSeriesMngment.GetNextNo(NavAppSetup."ExpoRef Nos.", Today, true);
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

}
