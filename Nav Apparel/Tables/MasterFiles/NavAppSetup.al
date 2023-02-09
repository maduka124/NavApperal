
table 51139 "NavApp Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(7101259; "Primary Key"; Code[10])
        {
        }

        field(7101260; "Garment Type Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(7101261; "Style Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012584; "BOM Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012585; "BOM Cost Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012586; "BOM1 Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012587; "SAMPLE Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        // field(71012588; "Start Time"; Time)
        // {
        //     DataClassification = ToBeClassified;
        // }

        // field(71012589; "Finish Time"; Time)
        // {
        //     DataClassification = ToBeClassified;
        // }

        field(71012590; "Worksheet Template Name"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012591; "Journal Batch Name"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012592; "Cutting Finished"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(71012593; "Sewing Finished"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(71012594; "Packing Finished"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(71012595; "NEWOP Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012596; "NEWBR Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012597; "Manning Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012598; "Layout Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012599; "PI Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012600; "ContractLC Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        // field(71012601; "Gen Posting Group-RM"; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        //     TableRelation = "Gen. Product Posting Group".Code;
        // }

        // field(71012602; "Inventory Posting Group-RM"; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        //     TableRelation = "Inventory Posting Group".Code;
        // }

        field(71012603; "Gen Posting Group-FG"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Product Posting Group".Code;
        }

        field(71012604; "Inventory Posting Group-FG"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Inventory Posting Group".Code;
        }

        field(71012605; "TaxGroupCode"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Tax Group".Code;
        }

        field(71012606; "B2BLC Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012607; "GITLC Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(71012608; "GITPI Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012609; "Acc Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012610; "Ins Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012611; "Routing"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Routing Header"."No.";
        }

        field(71012612; "SJC Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012613; "CutCre Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012614; "RatioCre Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012615; "TableCre Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012616; "FabReqNo Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012617; "LOTTracking Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012618; "RoleIssu Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
            Caption = 'Roll Issue No';
        }

        field(71012619; "CutPro Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012620; "BundleGuide Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012621; "MainCat Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012622; "FabricProce Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012623; "FabShrTest Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012624; "FabTwist Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012625; "FabShad Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012626; "FabShadShri Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012627; "FabShadShrink Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012628; "FabMap Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012629; "Sample Item Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012630; "Sample SO Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012631; "Gen Posting Group-SM"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Product Posting Group".Code;
        }

        field(71012632; "Inventory Posting Group-SM"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Inventory Posting Group".Code;
        }

        field(71012633; "FG Item Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012634; "RM Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012635; "FG SO Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012636; "FG ProdBOM Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012640; "Gen Posting Group-WashSample"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Product Posting Group".Code;
        }

        field(71012641; "InventoryPostingGroupWashSampl"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Inventory Posting Group".Code;
        }

        field(71012642; "Sample ProdBOM Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        // field(71012643; "Sample Wash Route Nos."; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        //     TableRelation = "Routing Header"."No.";
        // }

        // field(71012644; "Sample Non Wash Route Nos."; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        //     TableRelation = "Routing Header"."No.";
        // }

        field(71012645; "Sample YY Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012646; "Gen Journal Template Name"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012647; "Gen Journal Batch Name"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        // field(71012648; "Item Journal Template Name"; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        // }

        // field(71012649; "Item Journal Batch Name"; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        // }

        field(71012650; "Service Doc Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        // field(71012651; "Resource Journal Template Name"; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        // }

        // field(71012652; "Resource Journal Batch Name"; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        // }

        field(71012653; "Risk Factor"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(71012654; TAX; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(71012655; "ABA Sourcing"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(71012656; "BW Wash Quality"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012657; "BW GRN No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012658; "RTC AW No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012659; "QC AW No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012660; "Wash GRN Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012661; "Wash Purchase Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012662; "Wash Sample Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012663; "Wash SO Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012664; "Wash PO Vendor"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
        }

        field(71012665; "TRCBW No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012666; "TRCAW No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012667; "WS SMItem Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012668; "BankRef Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012669; "Gatepass Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012670; "Sample RM Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        // field(71012671; "Gen Post Group-RM Sample"; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        //     TableRelation = "Gen. Product Posting Group".Code;
        // }

        // field(71012672; "Inventory Post Group-RM Sample"; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        //     TableRelation = "Inventory Posting Group".Code;
        // }

        field(71012671; "Pay. Gen. Jrn. Template Name"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012672; "Pay. Gen. Jrn. Batch Name"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012673; "Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012674; "Bal Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012675; "LOT Tracking Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Tracking Code".Code;
        }

        field(71012676; "ManBudget Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012677; "DepReq No"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012678; "Req Worksheet Template Name"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012679; "Req Journal Batch Name"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012680; "MISCITEM Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012681; "Main Category Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012682; "Main Category 2 Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012683; "Poly bag Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012684; "Learning Curve Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Hourly,"Efficiency Wise";
            OptionCaption = 'Hourly,Efficiency Wise';
        }

        field(71012685; "Comm. Cost percentage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(71012686; "BPCD To Ship Date"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(71012687; "CP PO Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(71012688; "Bank Ref. Template Name"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012689; "Bank Ref. Template Name1"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012690; "Cash Rec. Batch Name"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012691; "Gen. Jrnl. Batch Name"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012692; "UD Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012693; "Base Efficiency"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(71012694; "ExpoRef Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

}