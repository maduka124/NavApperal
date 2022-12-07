
table 50934 "Style Master"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Style Inquiry";
    DrillDownPageId = "Style Inquiry";

    fields
    {
        field(71012581; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Store No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012583; "Store Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Garment Store"."Store Name";
            ValidateTableRelation = false;
        }

        field(71012584; "Season No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012585; "Season Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Seasons."Season Name";
            ValidateTableRelation = false;
        }

        field(71012586; "Brand No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012587; "Brand Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Brand."Brand Name";
            ValidateTableRelation = false;
        }

        field(71012588; "Department No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012589; "Department Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Department Style"."Department Name";
            ValidateTableRelation = false;
        }

        field(71012590; "Buyer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012591; "Buyer Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer.Name;
            ValidateTableRelation = false;
        }

        field(71012592; "Style No."; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012593; "Garment Type No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012594; "Garment Type Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Garment Type"."Garment Type Description";
            ValidateTableRelation = false;
        }

        field(71012595; "Size Range No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012596; "Size Range Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = SizeRange."Size Range";
            ValidateTableRelation = false;
        }

        field(71012597; "Order Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(71012598; "Lead Time"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Ship Date" := Today + "Lead Time";
            end;
        }

        field(71012599; "Ship Date"; Date)
        {
            DataClassification = ToBeClassified;
            //MinValue = Today;
        }

        field(71012600; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012601; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012602; "Active"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(71012603; "SMV"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(71012604; "Front"; Media)
        {
            DataClassification = ToBeClassified;
        }

        field(71012605; "Back"; Media)
        {
            DataClassification = ToBeClassified;
        }

        field(71012606; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Confirmed,Rejected;
            OptionCaption = 'Open,Confirmed,Rejected';
        }

        field(71012607; "CM Price (Doz)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(71012608; "Plan Efficiency %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(71012609; "BPCD"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012610; "LC No/Contract"; Text[50])
        {
            DataClassification = ToBeClassified;

        }

        field(71012611; "PO Total"; BigInteger)
        {
            DataClassification = ToBeClassified;

        }

        field(71012612; "Merchandiser Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";  //Load only Merchandiser category     
        }

        field(71012613; "Merchandiser Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012614; "Factory Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012615; "Factory Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Name;   //Factory = location
            ValidateTableRelation = false;
        }

        field(71012616; "PO No"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master PO"."PO No." where("Style No." = field("No."));
            ValidateTableRelation = false;
        }

        field(71012617; "Pack No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Pack."No.";
        }

        // field(71012618; "Item No"; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        // }

        field(71012619; "EstimateBOM"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012620; "Select"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(71012621; "ContractNo"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012623; "AssignedContractNo"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012624; "Lot No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012625; "LoggedBy"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012626; "FrontURL"; Text[500])
        {
            DataClassification = ToBeClassified;
        }

        field(71012627; "BackURL"; Text[500])
        {
            DataClassification = ToBeClassified;
        }

        field(71012628; "PictureFront"; MediaSet)
        {
            DataClassification = ToBeClassified;
        }

        field(71012629; "PictureBack"; MediaSet)
        {
            DataClassification = ToBeClassified;
        }

        field(71012630; "CostingSMV"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(71012631; "ProductionSMV"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(71012632; "PlanningSMV"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(71012633; "Global Dimension Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1), Blocked = CONST(false));
        }

        field(71012634; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Sample,Costing;
            OptionCaption = 'Sample,Costing';
        }

        field(71012635; "Production File Handover Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012636; "Style Display Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012637; "Secondary UserID"; Code[20])
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
        fieldgroup(DropDown; "Style No.", "Buyer Name", "Garment Type Name")
        {

        }
    }

    trigger OnInsert()
    var
        UserRec: Record User;
        UserSetupRec: Record "User Setup";
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
        LoginDetails: Record LoginDetails;
    begin

        // //Assign logged user
        // LoginDetails.Reset();
        // LoginDetails.SetRange(SessionID, SessionId());
        // if LoginDetails.FindSet() then begin
        //     LoggedBy := LoginDetails.UserID;
        // end
        // else
        //     Error('Invalid SessionID');

        UserSetupRec.Reset();
        UserSetupRec.SetRange("User ID", UserId);

        if UserSetupRec.FindSet() then
            "Global Dimension Code" := UserSetupRec."Global Dimension Code";

        UserRec.Reset();
        UserRec.Get(UserSecurityId());
        "Created Date" := WorkDate();
        "Created User" := UserId;
        "Merchandiser Code" := UserId;
        "Merchandiser Name" := UserRec."Full Name";
        NavAppSetup.Get('0001');
        NavAppSetup.TestField("Style Nos.");
        "No." := NoSeriesMngment.GetNextNo(NavAppSetup."Style Nos.", Today, true);
    end;


    trigger OnDelete()
    var
        BOMRec: Record BOM;
        BOMEstRec: Record "BOM Estimate";
    begin
        //Check for Exsistance
        BOMRec.Reset();
        BOMRec.SetRange("Style No.", "No.");
        if BOMRec.FindSet() then
            Error('Style : %1 already used in BOM. Cannot delete.', "Style No.");

        BOMEstRec.Reset();
        BOMEstRec.SetRange("Style No.", "No.");
        if BOMEstRec.FindSet() then
            Error('Style : %1 already used in BOM. Cannot delete.', "Style No.");

    end;

}
