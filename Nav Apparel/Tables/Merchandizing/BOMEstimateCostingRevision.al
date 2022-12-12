
table 50892 "BOM Estimate Cost Revision"
{
    DataClassification = ToBeClassified;
    LookupPageId = "BOM Estimate Cost";
    DrillDownPageId = "BOM Estimate Cost";

    fields
    {
        field(71012581; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "BOM No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "BOM Estimate"."No.";
        }

        field(71012583; "Style No."; text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(71012584; "Store No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012585; "Store Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Garment Store"."Store Name";
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

        field(71012588; "Buyer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012589; "Buyer Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer.Name;
            ValidateTableRelation = false;
        }
        field(71012590; "Season No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012591; "Season Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Seasons."Season Name";
            ValidateTableRelation = false;
        }

        field(71012592; "Department No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012593; "Department Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Department Style"."Department Name";
            ValidateTableRelation = false;
        }

        field(71012594; "Garment Type No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012595; "Garment Type Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Garment Type"."Garment Type Description";
            ValidateTableRelation = false;
        }

        field(71012596; "Quantity"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(71012597; "Currency No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency.Code;
        }
        field(71012598; "Raw Material (Dz.)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(71012599; "Embroidery (Dz.)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(71012600; "Printing (Dz.)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(71012601; "Washing (Dz.)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(71012602; "Others (Dz.)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(71012603; "Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(71012604; "Stich Gmt Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Stich Gmt"."Stich Gmt Name";
            ValidateTableRelation = false;
        }

        field(71012605; "Print Type Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Print Type"."Print Type Name";
            ValidateTableRelation = false;
        }

        field(71012606; "Wash Type Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Wash Type"."Wash Type Name";
            ValidateTableRelation = false;
        }

        field(71012607; "Sub Total (Dz.)%"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012608; "Sub Total (Dz.) Pcs"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012609; "Sub Total (Dz.) Dz."; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012610; "Sub Total (Dz.) Total"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }
        field(71012611; "FOB %"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012612; "FOB Pcs"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012613; "FOB Dz."; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012614; "FOB Total"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012615; "Gross CM With Commission %"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012616; "Gross CM With Commission Pcs"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012617; "Gross CM With Commission Dz."; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012618; "Gross CM With Commission Total"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012619; "MFG Cost %"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012620; "MFG Cost Pcs"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012621; "MFG Cost Dz."; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012622; "MFG Cost Total"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012623; "Overhead %"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012624; "Overhead Pcs"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012625; "Overhead Dz."; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012626; "Overhead Total"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012627; "Commission %"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012628; "Commission Pcs"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012629; "Commission Dz."; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012630; "Commission Total"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012631; "Commercial %"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012632; "Commercial Pcs"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012633; "Commercial Dz."; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012634; "Commercial Total"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012635; "Deferred Payment %"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012636; "Deferred Payment Pcs"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012637; "Deferred Payment Dz."; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012638; "Deferred Payment Total"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012639; "Total Cost %"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012640; "Total Cost Pcs"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012641; "Total Cost Dz."; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012642; "Total Cost Total"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012643; "Profit Margin %"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012644; "Profit Margin Pcs"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012645; "Profit Margin Dz."; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012646; "Profit Margin Total"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012647; "Gross CM Less Commission"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012648; "SMV"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012649; "CPM"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012650; "EPM"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012651; "Project Efficiency."; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012652; "CM Doz"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012653; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
            OptionCaption = 'Open,"Pending Approval",Approved,Rejected';
        }

        field(71012654; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012655; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012656; "Style Name"; text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(71012657; "Risk factor %"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012658; "Risk factor Pcs"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012659; "Risk factor Dz."; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012660; "Risk factor Total"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012661; "TAX %"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012662; "TAX Pcs"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012663; "TAX Dz."; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012664; "TAX Total"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012665; "ABA Sourcing %"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012666; "ABA Sourcing Pcs"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012667; "ABA Sourcing Dz."; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012668; "ABA Sourcing Total"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }

        field(71012669; "Factory Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012670; "Factory Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Name where("Sewing Unit" = filter(1));
            ValidateTableRelation = false;
        }

        field(71012671; "Stich Gmt"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012672; "Print Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012673; "Wash Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012674; "Revision"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(71012675; "Revised Date"; Date)
        {
            DataClassification = ToBeClassified;
        }


        field(71012676; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.", Revision)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Style Name", Revision)
        {

        }
    }

}
