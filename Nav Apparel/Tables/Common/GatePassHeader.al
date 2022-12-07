
table 51080 "Gate Pass Header"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Gate Pass List";
    DrillDownPageId = "Gate Pass List";

    fields
    {
        field(71012581; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Vehicle No."; code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012583; "Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Internal,External;
            OptionCaption = 'Internal,External';
        }

        field(71012584; "Transfer From Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012585; "Transfer From Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012586; "Transfer To Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012587; "Transfer To Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation =
            if (Type = CONST(Internal)) Location.Name
            else
            if (Type = CONST(External)) ExternalLocations."Location Name";

            ValidateTableRelation = false;
        }

        field(71012590; "Transfer Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012591; "Expected Return Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012592; "Sent By"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012593; "Approved By"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012595; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = New,"Pending Approval",Approved,Rejected;
            OptionCaption = 'New,Pending Approval,Approved,Rejected';
        }

        field(71012596; "Remarks"; text[500])
        {
            DataClassification = ToBeClassified;
        }

        field(71012597; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012598; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012599; "Approved Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012600; FromToFactoryCodes; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012601; "Barcode"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012602; ApprovalSentToUser; code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012603; Select; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(71012604; "Secondary UserID"; Code[20])
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
        fieldgroup(DropDown; "No.", "No.", "Transfer Date", "Vehicle No.", Type, "Transfer From Name", "Transfer To Name")
        {

        }
    }

    trigger OnInsert()
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
        UserRec: Record "User Setup";
        LocationRec: Record Location;

        BarcodeString: Text;
        BarcodeSymbology: Enum "Barcode Symbology";
        BarcodeFontProvider: Interface "Barcode Font Provider";
        GTPassRec: Record "Gate Pass Header";
        Temp: Text;
        GatePassReport: Report GatePassReport;
        str: Text[500];
    begin
        NavAppSetup.Get('0001');
        NavAppSetup.TestField("Gatepass Nos.");
        "No." := NoSeriesMngment.GetNextNo(NavAppSetup."Gatepass Nos.", Today, true);
        "Created Date" := WorkDate();
        "Created User" := UserId;
        "Sent By" := UserId;
        "Transfer Date" := WorkDate();

        UserRec.Reset();
        UserRec.SetRange("User ID", UserId);
        if UserRec.FindSet() then
            "Transfer From Code" := UserRec."Factory Code";

        LocationRec.Reset();
        LocationRec.SetRange("Code", UserRec."Factory Code");
        if LocationRec.FindSet() then
            "Transfer From Name" := LocationRec.Name;

        FromToFactoryCodes := "Transfer From Code" + '/';

        //generate Barcode
        BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
        BarcodeSymbology := Enum::"Barcode Symbology"::Code39;
        BarcodeString := "No.";
        BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);
        EncodedText := BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology);
        Temp := EncodedText.Replace('(', '');
        Barcode := Temp.Replace(')', '');

    end;

    var
        EncodedText: Text;

}
