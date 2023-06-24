
table 50935 "Style Master PO"
{
    DataClassification = ToBeClassified;
    // LookupPageId = "Style Master PO List";
    // DrillDownPageId = "Style Master PO List";

    fields
    {
        field(71012581; "Style No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Lot No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012583; "PO No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012584; Qty; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(71012585; Mode; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Sea,Air,"Sea-Air","Air-Sea","By Road";
            OptionCaption = 'Sea,Air,"Sea-Air","Air-Sea","By Road"';
        }

        field(71012586; "Ship Date"; Date)
        {
            DataClassification = ToBeClassified;
        }


        field(71012587; "SID"; Text[50])  //Ship ID
        {
            DataClassification = ToBeClassified;
        }

        field(71012588; "Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(71012589; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Confirm,Projection,"Projection Confirm";
            OptionCaption = 'Confirm,Projection,Projection Confirm';
        }

        field(71012590; "Confirm Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012591; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012592; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012593; PlannedQty; BigInteger)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(71012594; "OutputQty"; BigInteger)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(71012595; "PlannedStatus"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(71012596; "QueueQty"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(71012597; "Waistage"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(71012598; "Cut Out Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(71012599; "Cut In Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(71012600; "Sawing In Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(71012601; "Sawing Out Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(71012602; "Wash In Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(71012603; "Wash Out Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(71012604; "Poly Bag"; BigInteger)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(71012605; "Dispatch"; BigInteger)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(71012606; "Emb In Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(71012607; "Emb Out Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(71012608; "Print In Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(71012609; "Print Out Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(71012610; "Finish Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(71012611; "Shipped Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(71012612; "select"; Boolean)
        {
            DataClassification = ToBeClassified;
            InitValue = false;
        }

        field(71012613; "PI No."; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012614; "BPCD"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012615; "Style Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012616; "Sew Factory No"; Code[20])  //This is sewing factory not LC factory 
        {
            DataClassification = ToBeClassified;
        }

        field(71012617; "Sew Factory Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012618; "PO Complete"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Style No.", "Lot No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "PO No.", "Lot No.", Qty)
        {

        }
    }


    trigger OnInsert()

    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;


    // trigger OnDelete()
    // var
    //     StyleMasterRec: Record "Style Master";
    //     StyleMasterPORec: Record "Style Master PO";
    //     Tot: BigInteger;
    // begin

    //     StyleMasterPORec.Reset();
    //     StyleMasterPORec.SetRange("Style No.", "Style No.");
    //     StyleMasterPORec.FindSet();

    //     repeat
    //         Tot += StyleMasterPORec.Qty;
    //     until StyleMasterPORec.Next() = 0;

    //     StyleMasterRec.Reset();
    //     StyleMasterRec.SetRange("No.", "Style No.");
    //     if StyleMasterRec.FindSet() then
    //         StyleMasterRec.ModifyAll("PO Total", Tot)

    // end;


}
