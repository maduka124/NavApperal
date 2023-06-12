page 50964 "NavApp Setup Card"
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
                field("Primary Key"; rec."Primary Key")
                {
                    ApplicationArea = All;
                }

                field("Garment Type Nos."; rec."Garment Type Nos.")
                {
                    ApplicationArea = All;
                    TableRelation = "No. Series".Code;
                }

                field("Style Nos."; rec."Style Nos.")
                {
                    ApplicationArea = All;
                    TableRelation = "No. Series".Code;
                }

                field("BOM Estimate Nos."; rec."BOM Nos.")
                {
                    ApplicationArea = All;
                    TableRelation = "No. Series".Code;
                    Caption = 'BOM Estimate Nos';
                }

                field("BOM Cost Nos."; rec."BOM Cost Nos.")
                {
                    ApplicationArea = All;
                    TableRelation = "No. Series".Code;
                }

                field("BOM Nos."; rec."BOM1 Nos.")
                {
                    ApplicationArea = All;
                    TableRelation = "No. Series".Code;
                    Caption = 'BOM Nos';
                }

                field("NEWOP Nos."; rec."NEWOP Nos.")
                {
                    ApplicationArea = All;
                    TableRelation = "No. Series".Code;
                }

                field("NEWBR Nos."; rec."NEWBR Nos.")
                {
                    ApplicationArea = All;
                    TableRelation = "No. Series".Code;
                }

                field(Routing; rec.Routing)
                {
                    ApplicationArea = All;
                    Caption = 'FG Routing';
                }

                field("FG Item Nos."; rec."FG Item Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Bulk FG Item Nos';
                }

                field("FG SO Nos."; rec."FG SO Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Bulk FG SO Nos';
                }

                field("FG ProdBOM Nos."; rec."FG ProdBOM Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Bulk FG ProdBOM Nos';
                }

                field("Gen Posting Group-FG"; rec."Gen Posting Group-FG")
                {
                    ApplicationArea = All;
                    Caption = 'Bulk FG-Gen Posting Group';
                }

                field("Inventory Posting Group-FG"; rec."Inventory Posting Group-FG")
                {
                    ApplicationArea = All;
                    Caption = 'Bulk FG-Inv. Posting Group';
                }

                // field("Start Time"; "Start Time")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Planning Start Time';
                // }

                // field("Finish Time"; "Finish Time")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Planning Finish Time';
                // }

                field("Worksheet Template Name"; rec."Worksheet Template Name")
                {
                    ApplicationArea = All;
                    Caption = 'Planning. Wksh. Template Name';
                    TableRelation = "Req. Wksh. Template";
                }

                field("Journal Batch Name"; rec."Journal Batch Name")
                {
                    ApplicationArea = All;
                    Caption = 'Planning Wksh. Batch Name';
                    TableRelation = "Requisition Wksh. Name".Name WHERE("Worksheet Template Name" = FIELD("Worksheet Template Name"));
                }

                //RM
                field("RM Nos."; rec."RM Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Bulk RM Nos';
                }

                // field("Gen Posting Group-RM"; "Gen Posting Group-RM")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Bulk RM-Gen Posting Group';
                // }

                // field("Inventory Posting Group-RM"; "Inventory Posting Group-RM")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Bulk RM-Inv. Posting Group';
                // }

                //Samples
                field("SAMPLE Nos."; rec."SAMPLE Nos.")
                {
                    ApplicationArea = All;
                    TableRelation = "No. Series".Code;
                    Caption = 'Sample Req Nos.';
                }

                field("Sample SO Nos."; rec."Sample SO Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Sample SO Nos.';
                }

                field("Sample ProdBOM Nos."; rec."Sample ProdBOM Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Sample ProdBOM Nos';
                }

                // field("Sample Non Wash Route Nos."; "Sample Non Wash Route Nos.")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Sample Without Wash Route Nos.';
                // }

                // field("Sample Wash Route Nos."; "Sample Wash Route Nos.")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Sample With Wash Route Nos.';
                // }

                field("Sample YY Nos."; rec."Sample YY Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Sample YY Nos.';
                }

                field("Sample Item Nos."; rec."Sample Item Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Sample FG Item Nos.';
                }

                field("Gen Posting Group-SM"; rec."Gen Posting Group-SM")
                {
                    ApplicationArea = All;
                    Caption = 'Sample FG Item - Gen Posting Group';
                }

                field("Inventory Posting Group-SM"; rec."Inventory Posting Group-SM")
                {
                    ApplicationArea = All;
                    Caption = 'Sample FG Item - Inv. Posting Group';
                }

                field("Sample RM Nos."; rec."Sample RM Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Sample RM Item Nos.';
                }

                // field("Gen Post Group-RM Sample"; "Gen Post Group-RM Sample")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Sample RM Item- Gen Posting Group';
                // }

                // field("Inventory Post Group-RM Sample"; "Inventory Post Group-RM Sample")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Sample RM Item - Inv. Posting Group';
                // }

                field("Cutting Finished"; rec."Cutting Finished")
                {
                    ApplicationArea = All;
                }

                field("Sewing Finished"; rec."Sewing Finished")
                {
                    ApplicationArea = All;
                }

                field("Packing Finished"; rec."Packing Finished")
                {
                    ApplicationArea = All;
                }

                field("Manning Nos."; rec."Manning Nos.")
                {
                    ApplicationArea = All;
                }

                field("Layout Nos."; rec."Layout Nos.")
                {
                    ApplicationArea = All;
                }

                field("PI Nos."; rec."PI Nos.")
                {
                    ApplicationArea = All;
                }

                field("ContractLC Nos."; rec."ContractLC Nos.")
                {
                    ApplicationArea = All;
                }

                field(TaxGroupCode; rec.TaxGroupCode)
                {
                    ApplicationArea = All;
                    Caption = 'Tax Group Code';
                }

                field("B2BLC Nos."; rec."B2BLC Nos.")
                {
                    ApplicationArea = All;
                }

                field("GITLC Nos."; rec."GITLC Nos.")
                {
                    ApplicationArea = All;
                }

                field("GITPI Nos."; rec."GITPI Nos.")
                {
                    ApplicationArea = All;
                }


                field("BankRef Nos."; rec."BankRef Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Bank Ref, No';
                }

                field("Acc Nos."; rec."Acc Nos.")
                {
                    ApplicationArea = All;
                }

                field("Ins Nos."; rec."Ins Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Fabric Inspection';
                }

                field("SJC Nos."; rec."SJC Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Sewing Job Creation';
                }

                field("CutCre Nos."; rec."CutCre Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Cut Creation';
                }

                field("RatioCre Nos."; rec."RatioCre Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Ratio Creation';
                }

                field("TableCre Nos."; rec."TableCre Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Table Creation';
                }

                field("FabReqNo Nos."; rec."FabReqNo Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Fabric Requisition Creation';
                }

                field("LOTTracking Nos."; rec."LOTTracking Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'LOT Tracking Nos. (RM)';
                }

                field("LOT Tracking Code"; rec."LOT Tracking Code")
                {
                    ApplicationArea = All;
                    Caption = 'LOT Tracking Code (RM)';
                }

                field("RoleIssu Nos."; rec."RoleIssu Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Role Issuing';
                }

                field("CutPro Nos."; rec."CutPro Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Cutting Progress';
                }

                field("BundleGuide Nos."; rec."BundleGuide Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Bundle Guide';
                }

                field("MainCat Nos."; rec."MainCat Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Main Category';
                }

                field("FabricProce Nos."; rec."FabricProce Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Fabric Processing';
                }

                field("FabShrTest Nos."; rec."FabShrTest Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Fabric Shrinkage Test';
                }

                field("FabTwist Nos."; rec."FabTwist Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Fabric Twist';
                }

                field("FabShad Nos."; rec."FabShad Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Fabric Shade';
                }

                field("FabShadShri Nos."; rec."FabShadShri Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Fabric Shade/Shinkage';
                }

                field("FabMap Nos."; rec."FabMap Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Fabric Mapping';
                }

                field("Wash SO Nos."; rec."Wash SO Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Wash Sales Order';
                }

                field("WS SMItem Nos."; rec."WS SMItem Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Wash Sample Items';
                }

                field("BW Wash Quality"; rec."BW Wash Quality")
                {
                    ApplicationArea = All;
                    Caption = 'BW Quality Check';
                }

                field("QC AW No"; rec."QC AW No")
                {
                    ApplicationArea = All;
                    Caption = 'AW Quality Check';
                }

                field("Wash Sample Nos."; rec."Wash Sample Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Wash Sample';
                }

                field("Wash Purchase Nos."; rec."Wash Purchase Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Wash Purchase';
                }

                field("Wash GRN Nos."; rec."Wash GRN Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Wash GRN';
                }

                field("Wash PO Vendor"; rec."Wash PO Vendor")
                {
                    ApplicationArea = All;
                    Caption = 'Washing PO Vendor';
                }

                field("TRCBW No"; rec."TRCBW No")
                {
                    ApplicationArea = All;
                    Caption = 'Return To Cust. BW';
                }

                field("TRCAW No"; rec."TRCAW No")
                {
                    ApplicationArea = All;
                    Caption = 'Return To Cust. AW';
                }

                field("Gen Posting Group-WashSample"; rec."Gen Posting Group-WashSample")
                {
                    ApplicationArea = All;
                    Caption = 'Washing-Gen Posting Group';
                }

                field(InventoryPostingGroupWashSampl; rec.InventoryPostingGroupWashSampl)
                {
                    ApplicationArea = All;
                    Caption = 'Washing-Inventory Posting Group';
                }

                field("Gen Journal Template Name"; rec."Gen Journal Template Name")
                {
                    ApplicationArea = All;
                    TableRelation = "Gen. Journal Template";
                    Caption = 'Service Journal Template Name';
                }

                field("Gen Journal Batch Name"; rec."Gen Journal Batch Name")
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

                field("Service Doc Nos."; rec."Service Doc Nos.")
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

                field("Risk Factor"; rec."Risk Factor")
                {
                    ApplicationArea = All;
                    Caption = 'Risk Factor (%)';
                }

                field(TAX; rec.TAX)
                {
                    ApplicationArea = All;
                    Caption = 'TAX (%)';
                }

                field("ABA Sourcing"; rec."ABA Sourcing")
                {
                    ApplicationArea = All;
                    Caption = 'Sourcing (%)';
                }

                field("Comm. Cost percentage"; rec."Comm. Cost percentage")
                {
                    ApplicationArea = All;
                }

                field("Gatepass Nos."; rec."Gatepass Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Gate Pass No';
                }

                field("ManBudget Nos."; rec."ManBudget Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Man Power Budget No';
                }

                field("Pay. Gen. Jrn. Template Name"; rec."Pay. Gen. Jrn. Template Name")
                {
                    ApplicationArea = All;
                    TableRelation = "Gen. Journal Template" where(Type = const(Payments));
                    Caption = 'Payment Journal Template Name';
                }

                field("Pay. Gen. Jrn. Batch Name"; rec."Pay. Gen. Jrn. Batch Name")
                {
                    ApplicationArea = All;
                    TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Pay. Gen. Jrn. Template Name"));
                    Caption = 'Payment Journal Batch Name';
                }

                field("Account No"; rec."Account No")
                {
                    ApplicationArea = All;
                    TableRelation = "G/L Account"."No." where("Account Type" = filter(Posting));
                }

                field("Bal Account No"; rec."Bal Account No")
                {
                    ApplicationArea = All;
                    TableRelation = "G/L Account"."No." where("Account Type" = filter(Posting));
                }

                field("DepReq No"; rec."DepReq No")
                {
                    ApplicationArea = All;
                }

                // field("Req Worksheet Template Name"; rec."Req Worksheet Template Name")
                // {
                //     ApplicationArea = All;
                //     TableRelation = "Req. Wksh. Template";
                // }

                // field("Req Journal Batch Name"; rec."Req Journal Batch Name")
                // {
                //     ApplicationArea = All;
                //     TableRelation = "Requisition Wksh. Name".Name WHERE("Worksheet Template Name" = FIELD("Req Worksheet Template Name"));
                // }

                field("MISCITEM Nos."; rec."MISCITEM Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Other Item Nos.';
                }

                field("Main Category Nos."; rec."Main Category Nos.")
                {
                    ApplicationArea = All;
                }

                field("Main Category 2 Nos."; rec."Main Category 2 Nos.")
                {
                    ApplicationArea = all;
                    Caption = 'Main Category 2 Nos.';
                }

                field("Poly bag Nos."; rec."Poly bag Nos.")
                {
                    ApplicationArea = All;
                }

                field("Learning Curve Type"; rec."Learning Curve Type")
                {
                    ApplicationArea = All;
                }

                field("BPCD To Ship Date"; rec."BPCD To Ship Date")
                {
                    ApplicationArea = All;
                }

                field("CP PO Nos."; rec."CP PO Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Central Purchasig No';
                }

                field("Bank Ref. Template Name"; rec."Bank Ref. Template Name")
                {
                    ApplicationArea = All;
                    Caption = 'Bank Re. Cash Receipts Template';
                    TableRelation = "Gen. Journal Template" where(Type = const("Cash Receipts"));
                }

                field("Bank Ref. Template Name1"; rec."Bank Ref. Template Name1")
                {
                    ApplicationArea = All;
                    Caption = 'Bank Ref. Gen. Journal Template';
                    TableRelation = "Gen. Journal Template" where(Type = const(General));
                }

                field("UD Nos."; rec."UD Nos.")
                {
                    ApplicationArea = All;
                    TableRelation = "No. Series".Code;
                }

                field("Base Efficiency"; rec."Base Efficiency")
                {
                    ApplicationArea = All;
                }

                field("ExpoRef Nos."; rec."ExpoRef Nos.")
                {
                    ApplicationArea = All;
                    TableRelation = "No. Series".Code;
                }
                field("BundleGuideCard Nos."; Rec."BundleGuideCard Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Bundle Card Nos.';
                    TableRelation = "No. Series".Code;
                }
                field("BundleCardGMTType Nos."; Rec."BundleCardGMTType Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'GMT Parts - Bundle Card';
                    TableRelation = "No. Series".Code;
                }

                field("LaySheetNo."; Rec."LaySheet Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'LaySheet Nos';
                    TableRelation = "No. Series".Code;
                }
            }
        }
    }
}