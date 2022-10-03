
table 71012720 "Sample Requsition Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(71012581; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Line No."; BigInteger)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(71012583; "Sample No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012584; "Sample Name"; text[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sample Type Buyer"."Sample Type Name" where("Buyer No." = field("Buyer No."));
            ValidateTableRelation = false;
        }

        field(71012585; "Fabrication No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012586; "Fabrication Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item.Description where("Main Category Name" = filter('FABRIC'));
            ValidateTableRelation = false;
        }

        field(71012587; "Color No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012588; "Color Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Colour."Colour Name";
            ValidateTableRelation = false;
        }

        field(71012589; "Qty"; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(71012590; "Size"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012591; "Req Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012592; "Comment"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(71012593; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012594; "Created User"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012595; "Plan Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012596; "Plan End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012597; Status; Option)
        {
            DataClassification = ToBeClassified;

            OptionCaption = 'Yes,No,Reject';
            OptionMembers = Yes,No,Reject;
        }

        field(71012598; "Complete Qty"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(71012599; "Reject Qty"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(71012600; "Reject Comment"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(71012601; "Buyer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012602; "Pattern Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012603; "Cutting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012604; "Sewing Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012605; "Send Wash Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012606; "Received Wash Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012607; "Group Head"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012608; "Buyer Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012609; "Style No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012610; "Style Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012611; "SalesOrder No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012612; "Pattern Hours"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(71012613; "Pattern Maker"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }

        field(71012614; "Cutter"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }

        field(71012615; "Sewing Operator"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }

        field(71012616; "Wash Sender"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }

        field(71012617; "Wash Receiver"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }

        field(71012618; "FG Code"; Code[20])  //For sample production purpose
        {
            DataClassification = ToBeClassified;
        }

        field(71012619; "Routing Code"; Code[20])  //For sample production purpose
        {
            DataClassification = ToBeClassified;
        }

        field(71012620; "Pattern Work center Code"; Code[20])  //For sample production purpose
        {
            DataClassification = ToBeClassified;
        }

        field(71012621; "Pattern Work center Name"; text[200])  //For sample production purpose
        {
            DataClassification = ToBeClassified;
            TableRelation = "Routing Line".Description where("Routing No." = field("Routing Code"));
            ValidateTableRelation = false;
        }

        field(71012622; "Cuting Hours"; Decimal)//For sample production purpose
        {
            DataClassification = ToBeClassified;
        }

        field(71012623; "Sewing Hours"; Decimal)//For sample production purpose
        {
            DataClassification = ToBeClassified;
        }

        field(71012624; "Wash Send Hours"; Decimal)//For sample production purpose
        {
            DataClassification = ToBeClassified;
        }

        field(71012625; "Wash Receive Hours"; Decimal)//For sample production purpose
        {
            DataClassification = ToBeClassified;
        }

        field(71012626; "Cut Work center Code"; Code[20])  //For sample production purpose
        {
            DataClassification = ToBeClassified;
        }

        field(71012627; "Cut Work center Name"; text[200])  //For sample production purpose
        {
            DataClassification = ToBeClassified;
            TableRelation = "Routing Line".Description where("Routing No." = field("Routing Code"));
            ValidateTableRelation = false;
        }

        field(71012628; "Sew Work center Code"; Code[20])  //For sample production purpose
        {
            DataClassification = ToBeClassified;
        }

        field(71012629; "Sew Work center Name"; text[200])  //For sample production purpose
        {
            DataClassification = ToBeClassified;
            TableRelation = "Routing Line".Description where("Routing No." = field("Routing Code"));
            ValidateTableRelation = false;
        }

        field(71012630; "Wash Send Work center Code"; Code[20])  //For sample production purpose
        {
            DataClassification = ToBeClassified;
        }

        field(71012631; "Wash Send Work center Name"; text[200])  //For sample production purpose
        {
            DataClassification = ToBeClassified;
            TableRelation = "Routing Line".Description where("Routing No." = field("Routing Code"));
            ValidateTableRelation = false;
        }

        field(71012632; "Wash Receive Work center Code"; Code[20])  //For sample production purpose
        {
            DataClassification = ToBeClassified;
        }

        field(71012633; "Wash Receive Work center Name"; text[200])  //For sample production purpose
        {
            DataClassification = ToBeClassified;
            TableRelation = "Routing Line".Description where("Routing No." = field("Routing Code"));
            ValidateTableRelation = false;
        }
    }

    keys
    {
        key(PK; "No.", "Line No.")
        {
            Clustered = true;
        }
    }


    trigger OnInsert()
    var
        SampleReqRec: Record "Sample Requsition Header";
        CustomerRec: Record Customer;
        StyleRec: Record "Style Master";
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;

        SampleReqRec.Reset();
        SampleReqRec.SetRange("No.", "No.");
        SampleReqRec.FindSet();
        "Buyer No." := SampleReqRec."Buyer No.";

        CustomerRec.Reset();
        CustomerRec.SetRange("No.", SampleReqRec."Buyer No.");
        CustomerRec.FindSet();

        "Buyer Name" := CustomerRec.Name;

        StyleRec.Reset();
        StyleRec.SetRange("No.", SampleReqRec."Style No.");
        StyleRec.FindSet();

        "Style No." := SampleReqRec."Style No.";
        "Style Name" := StyleRec."Style No.";

    end;

}
