
table 50553 FabricInspection
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "InsNo."; Code[20])
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

        field(4; "Style No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Style Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master"."Style No." where("Buyer No." = field("Buyer No."));
            ValidateTableRelation = false;
        }

        field(6; "Color No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Color"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = StyleColor.Color;
            ValidateTableRelation = false;
        }

        field(8; "Scale"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = YDS,Meters;
            OptionCaption = 'YDS,Meters';
        }

        field(9; "Inspection Stage No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Inspection Stage"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "InspectionStage"."Inspection Stage";
            ValidateTableRelation = false;
        }

        field(11; "Total Fab. Rec. YDS"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Roll No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Batch No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(14; "TKT Length"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(15; "Actual Length"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(16; "TKT Width"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(17; "Actual Width"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(18; "Face Seal Start"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(19; "Face Seal End"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(20; "Length Wise Colour Shading"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(21; "Width Wise Colour Shading"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(22; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(23; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(24; "1 Point (Up to 3 inches)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(25; "2 Point (Up to 3-6 inches)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(26; "3 Point (Up to 6-9 inches)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(27; "4 Point (Above 9 inches) "; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(28; "1 Point"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(29; "2 Point"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(30; "3 Point "; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(31; "4 Point"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(32; "Remarks"; Text[500])
        {
            DataClassification = ToBeClassified;
        }

        field(33; "Status"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(34; "Points per 100 SQ Yds 1"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(35; "Points per 100 SQ Yds 2"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "InsNo.")
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
        NavAppSetup.TestField("Ins Nos.");

        "InsNo." := NoSeriesMngment.GetNextNo(NavAppSetup."Ins Nos.", Today, true);

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
