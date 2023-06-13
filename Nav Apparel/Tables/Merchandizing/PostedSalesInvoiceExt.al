tableextension 50920 "PostedSales Invoice Extension" extends "Sales Invoice Header"
{

    fields
    {
        field(50001; "Style No"; Code[20])
        {
        }

        field(50002; "Style Name"; text[50])
        {
        }

        field(50003; "PO No"; Code[20])
        {
        }

        field(50004; "Lot"; Code[20])
        {
        }

        field(50005; "EntryType"; Option)
        {
            OptionCaption = 'FG,Sample,Washing';
            OptionMembers = FG,Sample,Washing;
        }

        field(50006; "BankRefNo"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50007; "AssignedBankRefNo"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50008; "Select"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50009; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        //Done by maduka on 17/1/2023
        field(50010; "Merchandizer Group Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        //Done by maduka on 8/2/2023
        field(50011; "No of Cartons"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50012; "CBM"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50013; "Exp No"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(50014; "Exp Date"; date)
        {
            DataClassification = ToBeClassified;
        }

        field(50015; "UD No"; code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50016; "Export Ref No."; code[50])
        {
            DataClassification = ToBeClassified;
        }

        modify("Your Reference")
        {
            Caption = 'Factory Inv. No';
        }
        field(50017; "External Doc No Sales"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Payment Due Date"; date)
        {
            DataClassification = ToBeClassified;
        }

    }

    fieldgroups
    {
        addlast(DropDown; "Order No.", "Your Reference")
        { }
    }

}

