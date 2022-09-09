page 71012751 "NavApp Setup Card"
{
    PageType = Card;
    SourceTable = "NavApp Setup";
    UsageCategory = Administration;
    Caption = 'NavApp Setup';

    layout
    {
        area(Content)
        {
            group("No Series")
            {
                field("Primary Key"; "Primary Key")
                {
                    ApplicationArea = All;
                }

                field("Garment Type Nos."; "Garment Type Nos.")
                {
                    ApplicationArea = All;
                    TableRelation = "No. Series".Code;
                }

                field("Style Nos."; "Style Nos.")
                {
                    ApplicationArea = All;
                    TableRelation = "No. Series".Code;
                }

                field("BOM Estimate Nos."; "BOM Nos.")
                {
                    ApplicationArea = All;
                    TableRelation = "No. Series".Code;
                    Caption = 'BOM Estimate Nos';
                }

                field("BOM Cost Nos."; "BOM Cost Nos.")
                {
                    ApplicationArea = All;
                    TableRelation = "No. Series".Code;
                }

                field("BOM Nos."; "BOM1 Nos.")
                {
                    ApplicationArea = All;
                    TableRelation = "No. Series".Code;
                    Caption = 'BOM Nos';
                }

                field("NEWOP Nos."; "NEWOP Nos.")
                {
                    ApplicationArea = All;
                    TableRelation = "No. Series".Code;
                }

                field("NEWBR Nos."; "NEWBR Nos.")
                {
                    ApplicationArea = All;
                    TableRelation = "No. Series".Code;
                }

                field(Routing; Routing)
                {
                    ApplicationArea = All;
                    Caption = 'FG Routing';
                }

                field("FG Item Nos."; "FG Item Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'FG Item Nos';
                }

                field("FG SO Nos."; "FG SO Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'FG SO Nos';
                }

                field("FG ProdBOM Nos."; "FG ProdBOM Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'FG ProdBOM Nos';
                }

                field("Gen Posting Group-FG"; "Gen Posting Group-FG")
                {
                    ApplicationArea = All;
                    Caption = 'FG-Gen Posting Group';
                }

                field("Inventory Posting Group-FG"; "Inventory Posting Group-FG")
                {
                    ApplicationArea = All;
                    Caption = 'FG-Inventory Posting Group';
                }

                field("Start Time"; "Start Time")
                {
                    ApplicationArea = All;
                    Caption = 'Planning Start Time';
                }

                field("Finish Time"; "Finish Time")
                {
                    ApplicationArea = All;
                    Caption = 'Planning Finish Time';
                }

                field("Worksheet Template Name"; "Worksheet Template Name")
                {
                    ApplicationArea = All;
                    TableRelation = "Req. Wksh. Template";
                }

                field("Journal Batch Name"; "Journal Batch Name")
                {
                    ApplicationArea = All;
                    TableRelation = "Requisition Wksh. Name".Name WHERE("Worksheet Template Name" = FIELD("Worksheet Template Name"));
                }

                //RM
                field("RM Nos."; "RM Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'RM Nos';
                }

                field("Gen Posting Group-RM"; "Gen Posting Group-RM")
                {
                    ApplicationArea = All;
                    Caption = 'RM-Gen Posting Group';
                }

                field("Inventory Posting Group-RM"; "Inventory Posting Group-RM")
                {
                    ApplicationArea = All;
                    Caption = 'RM-Inventory Posting Group';
                }

                //Samples
                field("Sample Item Nos."; "Sample Item Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Sample FG Item Nos.';
                }

                field("SAMPLE Nos."; "SAMPLE Nos.")
                {
                    ApplicationArea = All;
                    TableRelation = "No. Series".Code;
                }

                field("Sample SO Nos."; "Sample SO Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Sample SO Nos.';
                }

                field("Sample ProdBOM Nos."; "Sample ProdBOM Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Sample ProdBOM Nos';
                }

                field("Sample Non Wash Route Nos."; "Sample Non Wash Route Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Sample Without Wash Route Nos.';
                }

                field("Sample Wash Route Nos."; "Sample Wash Route Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Sample With Wash Route Nos.';
                }

                field("Sample YY Nos."; "Sample YY Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Sample YY Nos.';
                }

                field("Gen Posting Group-SM"; "Gen Posting Group-SM")
                {
                    ApplicationArea = All;
                    Caption = 'Sample - Gen Posting Group';
                }

                field("Inventory Posting Group-SM"; "Inventory Posting Group-SM")
                {
                    ApplicationArea = All;
                    Caption = 'Sample - Inventory Posting Group';
                }

                field("Cutting Finished"; "Cutting Finished")
                {
                    ApplicationArea = All;
                }

                field("Sewing Finished"; "Sewing Finished")
                {
                    ApplicationArea = All;
                }

                field("Packing Finished"; "Packing Finished")
                {
                    ApplicationArea = All;
                }

                field("Manning Nos."; "Manning Nos.")
                {
                    ApplicationArea = All;
                }

                field("Layout Nos."; "Layout Nos.")
                {
                    ApplicationArea = All;
                }

                field("PI Nos."; "PI Nos.")
                {
                    ApplicationArea = All;
                }

                field("ContractLC Nos."; "ContractLC Nos.")
                {
                    ApplicationArea = All;
                }

                field(TaxGroupCode; TaxGroupCode)
                {
                    ApplicationArea = All;
                    Caption = 'Tax Group Code';
                }

                field("B2BLC Nos."; "B2BLC Nos.")
                {
                    ApplicationArea = All;
                }

                field("GITLC Nos."; "GITLC Nos.")
                {
                    ApplicationArea = All;
                }

                field("GITPI Nos."; "GITPI Nos.")
                {
                    ApplicationArea = All;
                }


                field("BankRef Nos."; "BankRef Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Bank Ref, No';
                }

                field("Acc Nos."; "Acc Nos.")
                {
                    ApplicationArea = All;
                }

                field("Ins Nos."; "Ins Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Fabric Inspection';
                }

                field("SJC Nos."; "SJC Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Sewing Job Creation';
                }

                field("CutCre Nos."; "CutCre Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Cut Creation';
                }

                field("RatioCre Nos."; "RatioCre Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Ratio Creation';
                }

                field("TableCre Nos."; "TableCre Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Table Creation';
                }

                field("FabReqNo Nos."; "FabReqNo Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Fabric Requisition Creation';
                }

                field("LOTTracking Nos."; "LOTTracking Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'LOT Tracking (RM)';
                }

                field("RoleIssu Nos."; "RoleIssu Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Role Issuing';
                }

                field("CutPro Nos."; "CutPro Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Cutting Progress';
                }

                field("BundleGuide Nos."; "BundleGuide Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Bundle Guide';
                }

                field("MainCat Nos."; "MainCat Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Main Category';
                }

                field("FabricProce Nos."; "FabricProce Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Fabric Processing';
                }

                field("FabShrTest Nos."; "FabShrTest Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Fabric Shrinkage Test';
                }

                field("FabTwist Nos."; "FabTwist Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Fabric Twist';
                }

                field("FabShad Nos."; "FabShad Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Fabric Shade';
                }

                field("FabShadShri Nos."; "FabShadShri Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Fabric Shade/Shinkage';
                }

                field("FabMap Nos."; "FabMap Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Fabric Mapping';
                }

                field("Wash SO Nos."; "Wash SO Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Wash Sales Order';
                }

                field("WS SMItem Nos."; "WS SMItem Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Wash Sample Items';
                }

                field("BW Wash Quality"; "BW Wash Quality")
                {
                    ApplicationArea = All;
                    Caption = 'BW Quality Check';
                }

                field("QC AW No"; "QC AW No")
                {
                    ApplicationArea = All;
                    Caption = 'AW Quality Check';
                }

                field("Wash Sample Nos."; "Wash Sample Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Wash Sample';
                }

                field("Wash Purchase Nos."; "Wash Purchase Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Wash Purchase';
                }

                field("Wash GRN Nos."; "Wash GRN Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Wash GRN';
                }

                field("Wash PO Vendor"; "Wash PO Vendor")
                {
                    ApplicationArea = All;
                    Caption = 'Washing PO Vendor';
                }

                field("TRCBW No"; "TRCBW No")
                {
                    ApplicationArea = All;
                    Caption = 'Return To Cust. BW';
                }

                field("TRCAW No"; "TRCAW No")
                {
                    ApplicationArea = All;
                    Caption = 'Return To Cust. AW';
                }

                field("Gen Posting Group-WashSample"; "Gen Posting Group-WashSample")
                {
                    ApplicationArea = All;
                    Caption = 'Washing-Gen Posting Group';
                }

                field(InventoryPostingGroupWashSampl; InventoryPostingGroupWashSampl)
                {
                    ApplicationArea = All;
                    Caption = 'Washing-Inventory Posting Group';
                }

                field("Gen Journal Template Name"; "Gen Journal Template Name")
                {
                    ApplicationArea = All;
                    TableRelation = "Gen. Journal Template";
                    Caption = 'Service Journal Template Name';
                }

                field("Gen Journal Batch Name"; "Gen Journal Batch Name")
                {
                    ApplicationArea = All;
                    TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Gen Journal Template Name"));
                    Caption = 'Service Journal Batch Name';
                }

                // field("Item Journal Template Name"; "Item Journal Template Name")
                // {
                //     ApplicationArea = All;
                //     TableRelation = "Item Journal Template";
                // }

                // field("Item Journal Batch Name"; "Item Journal Batch Name")
                // {
                //     ApplicationArea = All;
                //     TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("Item Journal Template Name"));
                // }

                field("Service Doc Nos."; "Service Doc Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Service Document No';
                }

                // field("Resource Journal Template Name"; "Resource Journal Template Name")
                // {
                //     ApplicationArea = All;
                //     TableRelation = "Res. Journal Template";
                // }

                // field("Resource Journal Batch Name"; "Resource Journal Batch Name")
                // {
                //     ApplicationArea = All;
                //     TableRelation = "Res. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Resource Journal Template Name"));
                // }

                field("Risk Factor"; "Risk Factor")
                {
                    ApplicationArea = All;
                    Caption = 'Risk Factor (%)';
                }

                field(TAX; TAX)
                {
                    ApplicationArea = All;
                    Caption = 'TAX (%)';
                }

                field("ABA Sourcing"; "ABA Sourcing")
                {
                    ApplicationArea = All;
                    Caption = 'Sourcing (%)';
                }

                field("Gatepass Nos."; "Gatepass Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Gate Pass No';
                }
            }
        }
    }
}