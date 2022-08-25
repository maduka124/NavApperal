
table 50705 "Washing Sample Requsition Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Sample No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; SampleType; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sample Type"."Sample Type Name";
            ValidateTableRelation = false;
        }

        field(4; "Wash Type No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Wash Type"."No.";
        }

        field(5; "Wash Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Wash Type"."Wash Type Name";
            ValidateTableRelation = false;
        }

        field(6; "Fabric Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item.Description where("Main Category Name" = filter('FABRIC'));
            ValidateTableRelation = false;
        }

        field(7; "Fabrication No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(17; "Color Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Color Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = StyleColor.Color;
            ValidateTableRelation = false;
        }

        field(9; "Req Qty"; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(58; "Req Qty BW QC Pass"; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }
        field(60; "Req Qty BW QC Fail"; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(61; "BW QC Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Size"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = AssortmentDetailsInseam."GMT Size" where("Style No." = field("Style No."));
            ValidateTableRelation = false;
        }

        field(11; "Req Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(12; "RemarkLine"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Style No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Style Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(16; "Line no."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(20; "GRN Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Pending,Completed;
            OptionCaption = 'Pending,Completed';
        }

        field(21; From; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(22; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Sample","Bulk";
            OptionCaption = 'Sample,Bulk';
        }

        field(23; PO; code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master PO"."PO No." where("Style No." = field("Style No."));
            ValidateTableRelation = false;
        }

        field(24; "Order Qty"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(26; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(28; "Factory Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(31; Buyer; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(33; "Gament Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(35; "Wash Plant Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(36; "REC Qty"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(37; "GRN No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(38; "Gate Pass No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(39; "Washing Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Pending","Completed";
            OptionCaption = 'Pending,Completed';
        }

        field(40; "Select"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(41; "Create Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Create User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(43; "PO No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(44; "Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(45; "Unite Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(46; "Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(47; Slect; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(48; "Sales Oder No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(49; "Split Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "No","Yes";
            OptionCaption = 'No,Yes';
        }

        field(50; "FG Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "No","Yes";
            OptionCaption = 'No,Yes';
        }

        field(51; "SO Satatus"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "No","Yes";
            OptionCaption = 'No,Yes';
        }

        field(52; "PO Satatus"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "No","Yes";
            OptionCaption = 'No,Yes';
        }

        field(53; "Buyer No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(54; "Select Item"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(55; Editeble; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Yes","No";
            OptionCaption = 'Yes,No';
        }

        field(56; "Return Qty (BW)"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(59; "Return Qty (AW)"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(64; "QC Date (AW)"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(62; "QC Pass Qty (AW)"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(63; "QC Fail Qty (AW)"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(57; "Dispatch Qty"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.", "Line no.")
        {
            Clustered = true;
        }

        key(Sortkey; "Split Status")
        {

        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Fabric Description")
        {

        }
    }

    trigger OnInsert()
    begin
        "Create Date" := WorkDate();
        "Create User" := UserId;
    end;



}
