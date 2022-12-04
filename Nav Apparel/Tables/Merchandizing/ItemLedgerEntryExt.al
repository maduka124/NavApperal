tableextension 71012763 "ItemLedgerEntryExt" extends "Item Ledger Entry"
{
    fields
    {
        field(71012581; "Supplier Batch No."; Code[50])
        {
        }

        field(71012582; "Shade No"; Code[20])
        {
            TableRelation = Shade."No.";
        }

        field(71012583; "Shade"; Text[20])
        {
        }

        field(71012584; "Length Tag"; Decimal)
        {
            InitValue = 0;
        }

        field(71012585; "Length Act"; Decimal)
        {
            InitValue = 0;
        }

        field(71012586; "Width Tag"; Decimal)
        {
            InitValue = 0;
        }

        field(71012587; "Width Act"; Decimal)
        {
            InitValue = 0;
        }

        field(71012588; "Selected"; Boolean)
        {

        }

        field(71012589; "InvoiceNo"; Code[20])
        {

        }

        field(71012590; "Color No"; Code[20])
        {

        }

        field(71012591; "Color"; Code[20])
        {

        }

        field(71012593; "Style No."; Code[20])
        {

        }

        field(71012594; "Style Name"; text[50])
        {

        }

        field(71012595; "CP Req No"; Code[20])
        {

        }

        field(50100; "Quantity Approved"; Boolean)
        {
            Caption = 'Quantity Approved';
            DataClassification = ToBeClassified;
        }
        field(50101; "Qty. Approved UserID"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50102; "Qty. Approved Date/Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50103; "Transfer Order Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        // field(50104; "Style Name"; text[50])
        // {
        //     DataClassification = ToBeClassified;
        // }

        // field(50105; "Style No."; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        //     TableRelation = "Style Master"."No.";
        // }

        field(50106; PO; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Style Master PO"."PO No." where("Style No." = field("Style No."));
            //ValidateTableRelation = false;
        }
        field(50107; "Daily Consumption Doc. No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50108; "Posted Daily Output"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50109; "Invent. Posting Grp."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50110; "Style Transfer Doc. No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style transfer Header" where(Status = filter(Approved));
        }
        field(50111; "Line Approved"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50112; "Line Approved UserID"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50113; "Line Approved DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50114; "Main Category Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Main Category"."Main Category Name" where("General Issuing" = filter(true));
            ValidateTableRelation = false;
        }
        field(50115; "Requsting Department Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Department."Department Name";
            ValidateTableRelation = false;
        }
        field(50116; "Original Daily Requirement"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50117; "Gen. Issue Doc. No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    fieldgroups
    {
        addlast(DropDown; "Lot No.")
        {

        }
    }

}
pageextension 50641 ItemLedPage extends "Item Ledger Entries"
{
    layout
    {
        modify("Lot No.")
        {
            ApplicationArea = All;
            Visible = true;
        }
    }
}

