
table 51350 LCMaster
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Season No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Season"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Seasons."Season Name";
            ValidateTableRelation = false;
        }

        field(4; "Buyer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Buyer"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer.Name;
            ValidateTableRelation = false;
        }

        field(6; "Factory No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Factory"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Name;
            ValidateTableRelation = false;
        }

        field(8; "Contract No"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Contract/LCMaster"."Contract No" where("Buyer No." = field("Buyer No."), "Factory No." = field("Factory No."), "Status of LC" = filter(Active));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                ContractRec: Record "Contract/LCMaster";
            begin
                ContractRec.Reset();
                ContractRec.SetRange("Contract No", Rec."Contract No");
                if ContractRec.FindSet() then begin
                    Rec.Contract := ContractRec."No.";
                end;
            end;
        }

        field(9; "AMD"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Issue Bank No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Issue Bank"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account".Name;
            ValidateTableRelation = false;
        }

        field(12; "Receive Bank No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Receive Bank"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account".Name;
            ValidateTableRelation = false;
        }

        field(14; "Nego Bank No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Nego Bank"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account".Name;
            ValidateTableRelation = false;
        }

        field(16; "BBLC"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(17; "B2B Payment Type No."; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(18; "B2B Payment Type"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method".Description;
            ValidateTableRelation = false;
        }

        field(19; "Shipment Mode"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Sea,Air,"Sea-Air","Air-Sea","By Road";
            OptionCaption = 'Sea,Air,"Sea-Air","Air-Sea","By Road"';
        }

        field(20; "Opening Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(21; "Amend Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(22; "Last Shipment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(23; "Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(24; "Currency No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(25; "Currency"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency.Description;
            ValidateTableRelation = false;
        }

        field(26; "UD Version"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(27; "Freight Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(29; "UD No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(30; "Insurance Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(31; "Partial Shipment"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Yes,No';
            OptionMembers = Yes,No;
        }

        field(32; "Payment Terms (Days) No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(33; "Payment Terms (Days)"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Terms".Description;
            ValidateTableRelation = false;
        }

        field(34; "Status of LC"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Active,Cancel,Complete';
            OptionMembers = Active,Cancel,Complete;
        }

        field(35; "File No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(36; "Quantity (Pcs)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(37; "Contract Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(38; "Total Commission"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(39; "Auto Calculate Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(40; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(41; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(42; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(43; "Merchandizer Group Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(44; "Global Dimension Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1), Blocked = CONST(false));
        }
        field(45; "Contract"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(46; "LC No"; Text[35])
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
        fieldgroup(DropDown; "LC No", "Contract Value", Buyer)
        {

        }
    }

    trigger OnInsert()
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
        UserSetupRec: Record "User Setup";
    begin
        NavAppSetup.Get('0001');
        NavAppSetup.TestField("LC Master Nos.");
        "No." := NoSeriesMngment.GetNextNo(NavAppSetup."LC Master Nos.", Today, true);
        "Created Date" := WorkDate();
        "Created User" := UserId;

        UserSetupRec.Reset();
        UserSetupRec.SetRange("User ID", UserId);
        if UserSetupRec.FindSet() then begin
            "Merchandizer Group Name" := UserSetupRec."Merchandizer Group Name";
        end;
    end;


    trigger OnDelete()
    var
        B2BLCMasterRec: Record "B2BLCMaster";
    begin

        //Check for Exsistance
        // B2BLCMasterRec.Reset();
        // B2BLCMasterRec.SetRange("LC/Contract No.", "Contract No");
        // if B2BLCMasterRec.FindSet() then
        //     Error('LC/Contract : %1 already used in B2B LC. Cannot delete.', "Contract No");

    end;

}
