
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

        field(6; "GRN"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purch. Rcpt. Line"."Document No." where(StyleName = field("Style Name"));
            ValidateTableRelation = false;
        }

        field(7; "Item No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Item Name"; Text[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purch. Rcpt. Line".Description where("Document No." = field(GRN));
            ValidateTableRelation = false;
        }

        field(9; "Color No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Color"; Text[50])
        {
            DataClassification = ToBeClassified;
            // TableRelation = Item."Color Name" where("No." = field("Item No"));
            // ValidateTableRelation = false;
        }

        field(11; "Roll No"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Ledger Entry"."Lot No." where("Document No." = field(GRN), "Item No." = field("Item No"));
            ValidateTableRelation = false;
        }

        field(12; "Batch No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(13; "TKT Length"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(14; "Actual Length"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(15; "TKT Width"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(16; "Actual Width"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(17; "Face Seal Start"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(18; "Face Seal End"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(19; "Length Wise Colour Shading"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(20; "Width Wise Colour Shading"; Boolean)
        {
            DataClassification = ToBeClassified;
        }


        field(21; "Scale"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = YDS,Meters;
            OptionCaption = 'YDS,Meters';
        }

        field(22; "Inspection Stage No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(23; "Inspection Stage"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "InspectionStage"."Inspection Stage";
            ValidateTableRelation = false;
        }

        field(24; "Total Fab. Rec. YDS"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(25; "1 Point (Up to 3 inches)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(26; "2 Point (Up to 3-6 inches)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(27; "3 Point (Up to 6-9 inches)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(28; "4 Point (Above 9 inches) "; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(29; "1 Point"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(30; "2 Point"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(31; "3 Point "; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(32; "4 Point"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(33; "Remarks"; Text[500])
        {
            DataClassification = ToBeClassified;
        }

        field(34; "Status"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(35; "Points per 100 SQ Yds 1"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(36; "Points per 100 SQ Yds 2"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(37; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(38; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        // field(39; "Length Wise Colour Shading No"; Boolean)
        // {
        //     DataClassification = ToBeClassified;
        // }

        // field(40; "Width Wise Colour Shading No"; Boolean)
        // {
        //     DataClassification = ToBeClassified;s
        // }
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
