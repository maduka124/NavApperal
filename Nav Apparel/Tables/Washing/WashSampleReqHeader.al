
table 50741 "Washing Sample Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Buyer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Buyer Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer.Name;
            ValidateTableRelation = false;
        }

        field(4; "Style No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Style Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master"."Style No." where("Buyer Name" = field("Buyer Name"));
            ValidateTableRelation = false;
        }

        field(6; "Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Development,Confirm;
            OptionCaption = 'Development,Confirm';
            TableRelation = "Wash Type"."Wash Type Name";
        }

        // field(7; "Wash Type No."; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        // }

        // field(8; "Wash Type Name"; text[50])
        // {
        //     DataClassification = ToBeClassified;
        //     TableRelation = "Wash Type"."Wash Type Name";
        //     ValidateTableRelation = false;
        // }

        field(9; "Wash Plant No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Wash Plant Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Name where("Plant Type Name" = filter('WASHING UNIT'));
            ValidateTableRelation = false;
        }

        field(11; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(16; "Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(18; "Status"; Text[10])
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Garment Type No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Garment Type"."No.";
        }

        field(14; "Garment Type Name"; text[50])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Garment Type"."Garment Type Description";
            // ValidateTableRelation = false;
        }

        field(15; LineNo; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(17; "PictureFront"; MediaSet)
        {
            DataClassification = ToBeClassified;
        }

        field(19; "PictureBack"; MediaSet)
        {
            DataClassification = ToBeClassified;
        }

        field(20; "Front"; Media)
        {
            DataClassification = ToBeClassified;
        }

        field(25; "Back"; Media)
        {
            DataClassification = ToBeClassified;
        }

        field(26; "FrontURL"; Text[500])
        {
            DataClassification = ToBeClassified;
        }

        field(27; "BackURL"; Text[500])
        {
            DataClassification = ToBeClassified;
        }

        field(28; Comment; code[200])
        {
            DataClassification = ToBeClassified;
        }

        field(29; "Req Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(30; "Washing Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Pending","Completed";
            OptionCaption = 'Pending,Completed';
        }

        field(31; "Sample/Bulk"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Sample","Bulk","Rewash";
            OptionCaption = 'Sample,Bulk,Rewash';
        }

        field(33; Editeble; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Yes","No";
            OptionCaption = 'Yes,No';
        }

        field(34; "Request From"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(36; "PO No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master PO"."PO No." where("Style No." = field("Style No."));
            ValidateTableRelation = false;
        }
    }

    keys
    {
        key(PK; "No.", LineNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Req Date", "Buyer Name", "Style Name", "Garment Type Name")
        {
        }
    }


    trigger OnInsert()
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        NavAppSetup.TestField("Wash Sample Nos.");

        "No." := NoSeriesMngment.GetNextNo(NavAppSetup."Wash Sample Nos.", Today, true);

        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

    trigger OnDelete()
    var
        SampleReqLineRec: Record "Washing Sample Requsition Line";
    begin
        SampleReqLineRec.Reset();
        SampleReqLineRec.SetRange("No.", "No.");
        if SampleReqLineRec.FindSet() then
            SampleReqLineRec.DeleteAll();
    end;

}
