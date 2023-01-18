
table 50931 "Sample Requsition Line"
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

            OptionCaption = 'No,Yes,Reject';
            OptionMembers = No,Yes,Reject;
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
            TableRelation = Workers."Worker Name" where("Worker Type" = const('PATTERN MAKER'), Status = filter(Active));
            ValidateTableRelation = false;
        }

        field(71012614; "Pattern Work center Code"; Code[20])  //For sample production purpose
        {
            DataClassification = ToBeClassified;
        }

        field(71012615; "Pattern Work center Name"; text[200])  //For sample production purpose
        {
            DataClassification = ToBeClassified;
            TableRelation = "Routing Line".Description where(Description = filter('SM-PATTERN'));
            ValidateTableRelation = false;
        }

        field(71012616; "Cuting Hours"; Decimal)//For sample production purpose
        {
            DataClassification = ToBeClassified;
        }

        field(71012617; "Cutter"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Workers."Worker Name" where("Worker Type" = const('CUTTER'), Status = filter(Active));
            ValidateTableRelation = false;
        }

        field(71012618; "Cut Work center Code"; Code[20])  //For sample production purpose
        {
            DataClassification = ToBeClassified;
        }

        field(71012619; "Cut Work center Name"; text[200])  //For sample production purpose
        {
            DataClassification = ToBeClassified;
            TableRelation = "Routing Line".Description where(Description = filter('SM-CUTTING'));
            ValidateTableRelation = false;
        }

        field(71012620; "Sewing Hours"; Decimal)//For sample production purpose
        {
            DataClassification = ToBeClassified;
        }

        field(71012621; "Sewing Operator"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Workers."Worker Name" where("Worker Type" = const('SEWING OPERATOR'), Status = filter(Active));
            ValidateTableRelation = false;
        }

        field(71012622; "Sew Work center Code"; Code[20])  //For sample production purpose
        {
            DataClassification = ToBeClassified;
        }

        field(71012623; "Sew Work center Name"; text[200])  //For sample production purpose
        {
            DataClassification = ToBeClassified;
            TableRelation = "Routing Line".Description where(Description = filter('SM-SEWING'));
            ValidateTableRelation = false;
        }

        field(71012624; "Wash Sender"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Workers."Worker Name" where("Worker Type" = const('WASH SENDER'), Status = filter(Active));
            ValidateTableRelation = false;
        }

        field(710126125; "Wash Receiver"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Workers."Worker Name" where("Worker Type" = const('WASH RECEIVER'), Status = filter(Active));
            ValidateTableRelation = false;
        }

        field(71012626; "FG Code"; Code[20])  //For sample production purpose
        {
            DataClassification = ToBeClassified;
        }

        field(71012627; "Routing Code"; Code[20])  //For sample production purpose
        {
            DataClassification = ToBeClassified;
        }

        field(71012628; "Finishing Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012629; "Finishing Hours"; Decimal)//For sample production purpose
        {
            DataClassification = ToBeClassified;
        }

        field(71012630; "Finishing Operator"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Workers."Worker Name" where("Worker Type" = const('FINISHING OPERATOR'), Status = filter(Active));
            ValidateTableRelation = false;
        }

        field(71012631; "Finishing Work center Code"; Code[20])  //For sample production purpose
        {
            DataClassification = ToBeClassified;
        }

        field(71012632; "Finishing Work center Name"; text[200])  //For sample production purpose
        {
            DataClassification = ToBeClassified;
            TableRelation = "Routing Line".Description where(Description = filter('SM-FINISHING'));
            ValidateTableRelation = false;
        }

        field(71012633; "Merchandizer Group Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }


        // field(71012624; "Wash Send Hours"; Decimal)//For sample production purpose
        // {
        //     DataClassification = ToBeClassified;
        // }

        // field(71012625; "Wash Receive Hours"; Decimal)//For sample production purpose
        // {
        //     DataClassification = ToBeClassified;
        // }

        // field(71012630; "Wash Send Work center Code"; Code[20])  //For sample production purpose
        // {
        //     DataClassification = ToBeClassified;
        // }

        // field(71012631; "Wash Send Work center Name"; text[200])  //For sample production purpose
        // {
        //     DataClassification = ToBeClassified;
        //     TableRelation = "Routing Line".Description where("Routing No." = filter('WASH SEND'));
        //     ValidateTableRelation = false;
        // }

        // field(71012632; "Wash Receive Work center Code"; Code[20])  //For sample production purpose
        // {
        //     DataClassification = ToBeClassified;
        // }

        // field(71012633; "Wash Receive Work center Name"; text[200])  //For sample production purpose
        // {
        //     DataClassification = ToBeClassified;
        //     TableRelation = "Routing Line".Description where("Routing No." = filter('WASH RECEIVE'));
        //     ValidateTableRelation = false;
        // }

        field(71012634; "Pattern/Cutting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012635; "QC Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012636; "QC/Finishing Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012637; "Pattern Cuting Hours"; Decimal)//For sample production purpose
        {
            DataClassification = ToBeClassified;
        }

        field(71012638; "Pattern Cutter"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Workers."Worker Name" where("Worker Type" = const('PATTERN CUTTER'), Status = filter(Active));
            ValidateTableRelation = false;
        }

        field(71012639; "QC Hours"; Decimal)//For sample production purpose
        {
            DataClassification = ToBeClassified;
        }

        field(71012640; "Quality Checker"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Workers."Worker Name" where("Worker Type" = const('QUALITY CHECKER'), Status = filter(Active));
            ValidateTableRelation = false;
        }

        field(71012641; "QC Finish Hours"; Decimal)//For sample production purpose
        {
            DataClassification = ToBeClassified;
        }

        field(71012642; "Quality Finish Checker"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Workers."Worker Name" where("Worker Type" = const('QUALITY FINISH CHECKER'), Status = filter(Active));
            ValidateTableRelation = false;
        }

        // Done By Sachith On 18/01/23
        field(71012643; "Garment Type"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        // Done By Sachith On 18/01/23
        field(71012644; "Garment Type No"; Code[20])
        {
            DataClassification = ToBeClassified;
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
        UserSetupRec: Record "User Setup";
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

        UserSetupRec.Reset();
        UserSetupRec.SetRange("User ID", UserId);

        if UserSetupRec.FindSet() then
            "Merchandizer Group Name" := UserSetupRec."Merchandizer Group Name";

    end;

}
