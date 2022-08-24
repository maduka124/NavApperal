page 71012740 "Nav Apperal Role Center"
{
    PageType = RoleCenter;
    Caption = 'Nav Apperal Role Center';
    ApplicationArea = all;
    UsageCategory = Lists;

    layout
    {
        area(RoleCenter)
        {
            // part(Headline; "Acc. Payables Activities")
            // {
            // }

            part(Control98; "Power BI Report Spinner Part")
            {
                AccessByPermission = TableData "Power BI User Configuration" = I;
                ApplicationArea = Basic, Suite;
                Enabled = false;
            }
        }
    }


    actions
    {
        area(Sections)
        {
            //Master files
            group("Master Files")
            {
                Caption = 'Master Files';
                Image = Marketing;

                action("Article")
                {
                    Caption = 'Article';
                    RunObject = Page Article;
                    ApplicationArea = all;
                }

                action("AQL")
                {
                    Caption = 'AQL';
                    RunObject = Page AQL;
                    ApplicationArea = all;
                }

                action("Brand")
                {
                    Caption = 'Brand';
                    RunObject = Page Brand;
                    ApplicationArea = all;
                }

                action("Color")
                {
                    Caption = 'Color';
                    RunObject = Page Colour;
                    ApplicationArea = all;
                }

                action("Customer")
                {
                    Caption = 'Customer';
                    RunObject = Page "Customer List";
                    ApplicationArea = all;
                }

                action("Country")
                {
                    Caption = 'Country';
                    RunObject = Page "Countries/Regions";
                    ApplicationArea = all;
                }

                action("Defects")
                {
                    Caption = 'Defects';
                    RunObject = Page "Defects List";
                    ApplicationArea = all;
                }

                action("Department Style")
                {
                    Caption = 'Department Style';
                    RunObject = Page "Department (Style)";
                    ApplicationArea = all;
                }

                action("Department")
                {
                    Caption = 'Department';
                    RunObject = Page Department;
                    ApplicationArea = all;
                }

                action("Dimension Width")
                {
                    Caption = 'Dimension Width';
                    RunObject = Page "Dimension Width";
                    ApplicationArea = all;
                }

                action("Fabric Code")
                {
                    Caption = 'Fabric Code';
                    RunObject = Page FabricCodeList;
                    ApplicationArea = all;
                }

                action("Garment Type")
                {
                    Caption = 'Garment Type';
                    RunObject = Page "Garment Type List";
                    ApplicationArea = all;
                }

                action("Garment Store")
                {
                    Caption = 'Garment Store';
                    RunObject = Page "Garment Store";
                    ApplicationArea = all;
                }

                action("Inspection Stages")
                {
                    Caption = 'Inspection Stages';
                    RunObject = Page "Inspection Stage List";
                    ApplicationArea = all;
                }

                action("Item")
                {
                    Caption = 'Item';
                    RunObject = Page "Item List";
                    ApplicationArea = all;
                }

                action("Location")
                {
                    Caption = 'Location';
                    RunObject = Page "Location List";
                    ApplicationArea = all;
                }

                action("Master Category")
                {
                    Caption = 'Master Category';
                    RunObject = Page "Master Category List";
                    ApplicationArea = all;
                }

                action("Marker Category")
                {
                    Caption = 'Marker Category';
                    RunObject = Page "Marker Category List";
                    ApplicationArea = all;
                }

                action("Main Category")
                {
                    Caption = 'Main Category';
                    RunObject = Page "Main Category List";
                    ApplicationArea = all;
                }

                action("Plant Type")
                {
                    Caption = 'Plant Type';
                    RunObject = Page "Plant Type List";
                    ApplicationArea = all;
                }

                action("Pack")
                {
                    Caption = 'Pack';
                    RunObject = Page "Pack List";
                    ApplicationArea = all;
                }

                action("Print Type")
                {
                    Caption = 'Print Type';
                    RunObject = Page "Print Type List";
                    ApplicationArea = all;
                }

                action("Router")
                {
                    Caption = 'Router';
                    RunObject = Page "Routing List";
                    ApplicationArea = all;
                }

                action("Router Link")
                {
                    Caption = 'Router Link';
                    RunObject = Page "Routing Links";
                    ApplicationArea = all;
                }

                action("Season")
                {
                    Caption = 'Season';
                    RunObject = Page "Seasons List";
                    ApplicationArea = all;
                }

                action("Stich Garment")
                {
                    Caption = 'Stich Garment';
                    RunObject = Page "Stich Gmt";
                    ApplicationArea = all;
                }

                action("Special Operation")
                {
                    Caption = 'Special Operation';
                    RunObject = Page "Special Operation";
                    ApplicationArea = all;
                }

                action("Size Range")
                {
                    Caption = 'Size Range';
                    RunObject = Page SizeRange;
                    ApplicationArea = all;
                }

                action("Sub Category")
                {
                    Caption = 'Sub Category';
                    RunObject = Page "Sub Category";
                    ApplicationArea = all;
                }

                action("Shade")
                {
                    Caption = 'Shade';
                    RunObject = Page Shade;
                    ApplicationArea = all;
                }

                action("Tables")
                {
                    Caption = 'Cutting Tables';
                    RunObject = Page TableList;
                    ApplicationArea = all;
                }


                action("Units of Measure")
                {
                    Caption = 'Units of Measure';
                    RunObject = Page "Units of Measure";
                    ApplicationArea = all;
                }

                action("Vendor")
                {
                    Caption = 'Vendor';
                    RunObject = Page "Vendor List";
                    ApplicationArea = all;
                }

                action("YY Type")
                {
                    Caption = 'YY Type';
                    RunObject = Page "YY Type List";
                    ApplicationArea = all;
                }

                action("Wash Type")
                {
                    Caption = 'Wash Type';
                    RunObject = Page "Wash Type";
                    ApplicationArea = all;
                }

                action("Work Center")
                {
                    Caption = 'Work Center';
                    RunObject = Page "Work Center List";
                    ApplicationArea = all;
                }
            }

            //Merchandizing Group
            group("Merchandizing Group")
            {
                Caption = 'Merchandizing';
                Image = Marketing;

                action("Action Type")
                {
                    Caption = 'Action Type';
                    RunObject = Page "Action Type List";
                    ApplicationArea = all;
                }

                action("Assortment Details")
                {
                    Caption = 'Assortment Details';
                    RunObject = Page "Assortment Details";
                    ApplicationArea = all;
                }

                action("Buyer T & A")
                {
                    Caption = 'Buyer T & A';
                    RunObject = Page "Dependency";
                    ApplicationArea = all;
                }

                action("BOM")
                {
                    Caption = 'BOM';
                    RunObject = Page BOM;
                    ApplicationArea = all;
                }

                action("Copy BOM")
                {
                    Caption = 'Copy BOM';
                    //Enabled = true;
                    RunObject = Page "Copy BOM Card";
                    ApplicationArea = all;
                }

                action("Estimate Costing")
                {
                    Caption = 'Estimate Costing';
                    RunObject = Page "BOM Estimate Cost";
                    ApplicationArea = all;
                }

                action("Estimate Costing (Approval)")
                {
                    Caption = 'Estimate Costing (Approval)';
                    RunObject = Page "BOM Estimate Cost (Approval)";
                    ApplicationArea = all;
                }

                action("Dependency Parameters")
                {
                    Caption = 'Dependency Parameters';
                    RunObject = Page "Dependency Parameters";
                    ApplicationArea = all;
                }

                action("Dependency Group")
                {
                    Caption = 'Dependency Group';
                    RunObject = Page "Dependency Group";
                    ApplicationArea = all;
                }

                action("Estimate BOM")
                {
                    Caption = 'Estimate BOM';
                    RunObject = Page "Estimate BOM";
                    ApplicationArea = all;
                }

                action("My Task")
                {
                    Caption = 'My Task';
                    RunObject = Page "MyTask Card";
                    ApplicationArea = all;
                }

                action("Planning Worksheet")
                {
                    Caption = 'Planning Worksheet';
                    RunObject = Page "Planning Worksheet";
                    ApplicationArea = all;
                }

                action("Proforma Invoice Details")
                {
                    Caption = 'Proforma Invoice Details';
                    RunObject = Page "Proforma Invoice Details List";
                    ApplicationArea = all;
                }

                action("Production BOM")
                {
                    Caption = 'Production BOM';
                    RunObject = Page "Production BOM List";
                    ApplicationArea = all;
                }

                action("Purchase Orders1")
                {
                    Caption = 'Purchase Orders';
                    RunObject = Page "Purchase Order List";
                    ApplicationArea = all;
                }

                action("Sales Orders1")
                {
                    Caption = 'Sales Orders';
                    RunObject = Page "sales Order List";
                    ApplicationArea = all;
                }

                action("Style Inquiry")
                {
                    Caption = 'Style Inquiry';
                    RunObject = Page "Style Inquiry";
                    ApplicationArea = all;
                    //RunPageView = where("Template Type" = const(General),
                    //            Recurring = const(false));
                }

                action("Style Master")
                {
                    Caption = 'Style Master';
                    RunObject = Page "Style Master";
                    ApplicationArea = all;
                }

                action("Style Allocation")
                {
                    Caption = 'Style Allocation';
                    RunObject = Page "Style Allocation";
                    ApplicationArea = all;
                }

                action("Sample Request")
                {
                    Caption = 'Sample Request';
                    RunObject = Page "Sample Request";
                    ApplicationArea = all;
                }

                action("T & A Style")
                {
                    Caption = 'T & A Style';
                    RunObject = Page "Dependency Style";
                    ApplicationArea = all;
                }

                action("YY Requsition")
                {
                    Caption = 'YY Requisition';
                    RunObject = Page "YY Requsition List";
                    ApplicationArea = all;
                }

                action("ContractLC")
                {
                    Caption = 'Contract LC Master';
                    RunObject = Page "Contract/LC List";
                    ApplicationArea = all;
                }


                group("Merchandizing Reports")
                {
                    Caption = 'Merchandizing Reports';

                    action("Accessory Status")
                    {
                        Caption = 'Accessory Status Report';
                        Enabled = true;
                        RunObject = report AccessoriesStatusReport;
                        ApplicationArea = all;
                    }

                    // action(Barcode)
                    // {
                    //     Caption = 'Barcode Report';
                    //     Enabled = true;
                    //     RunObject = report TestBarcode;
                    //     ApplicationArea = all;
                    // }

                    action("Delivery Information - Production")
                    {
                        Caption = 'Delivery Information - Production Report';
                        Enabled = true;
                        RunObject = report DeliveryInfoProductReport;
                        ApplicationArea = all;
                    }

                    action("Estimate Costing Report")
                    {
                        Caption = 'Estimate Costing Report';
                        Enabled = true;
                        RunObject = report EstimateCostSheetReport;
                        ApplicationArea = all;
                    }

                    action("Fabric & Trims requiremts - Marchandizingn")
                    {
                        Caption = 'Fabric & Trims requiremts Report';
                        Enabled = true;
                        RunObject = report FabricAndTrimsRequiremts;
                        ApplicationArea = all;
                    }

                    action("Goods Received Note")
                    {
                        Caption = 'Goods Received Note';
                        Enabled = true;
                        RunObject = report GrnReport;
                        ApplicationArea = all;
                    }

                    action("Order Completion Report")
                    {
                        Caption = 'Order Completion Report';
                        Enabled = true;
                        RunObject = report OCR;
                        ApplicationArea = all;
                    }

                    action("Purchase Order Report")
                    {
                        Caption = 'Purchase Order Report';
                        Enabled = true;
                        RunObject = report PurchaseOrderReport;
                        ApplicationArea = all;
                    }

                    action("Size Colour Wise Quantity Breakdown Report")
                    {
                        Caption = 'Size Colour Wise Quantity Breakdown';
                        Enabled = true;
                        RunObject = report SizeColourwiseQuantity;
                        ApplicationArea = all;
                    }

                    action("Sample Request Report")
                    {
                        Caption = 'Sample Request Report';
                        Enabled = true;
                        RunObject = report SampleRequest;
                        ApplicationArea = all;
                    }

                    action("T & A Plan")
                    {
                        Caption = 'T & A Plan Report';
                        Enabled = true;
                        RunObject = report TnAStyleMerchandizing;
                        ApplicationArea = all;
                    }
                }
            }

            //Planning 
            group("Planning")
            {
                Caption = 'Planning';

                action("Learning Curve")
                {
                    Caption = 'Learning Curve';
                    RunObject = Page "Learning Curve";
                    ApplicationArea = all;
                }

                action("Wastage")
                {
                    Caption = 'Wastage';
                    RunObject = Page Wastage;
                    ApplicationArea = all;
                }

                group("Planning Reports")
                {
                    Caption = 'Planning Reports';

                    action("Capacity Gap Details Report")
                    {
                        Caption = 'Capacity Gap Details Report';
                        Enabled = true;
                        RunObject = report CapacityGapDetailsReport;
                        ApplicationArea = all;
                    }

                    action("Production Plan Report")
                    {
                        Caption = 'Production Plan Report';
                        Enabled = true;
                        RunObject = report ProductionPlanReport;
                        ApplicationArea = all;
                    }

                    action("Target Sheet Report")
                    {
                        Caption = 'Target Sheet Report';
                        Enabled = true;
                        RunObject = report TargetSheetReport;
                        ApplicationArea = all;
                    }
                }
            }

            //Prodcution
            group("Production")
            {
                Caption = 'Production';

                group("Production Reports")
                {
                    Caption = 'Production Reports';

                    action("Production Status Report")
                    {
                        Caption = 'Production Status Report';
                        Enabled = true;
                        RunObject = report ProductionStatus;
                        ApplicationArea = all;
                    }

                    action("Day Wise Production Report")
                    {
                        Caption = 'Day Wise Production Report';
                        Enabled = true;
                        RunObject = report DayWiseProductionReport;
                        ApplicationArea = all;
                    }

                    action("Production Plan Report Report")
                    {
                        Caption = 'Production Plan Report';
                        Enabled = true;
                        RunObject = report ProductionPlanReport;
                        ApplicationArea = all;
                    }

                    action("Production and Shipment Details Report")
                    {
                        Caption = 'Production and Shipment Details Report';
                        Enabled = true;
                        RunObject = report ProductionAndShipmentDetails;
                        ApplicationArea = all;
                    }
                }
            }

            group("CAD")
            {
                Caption = 'CAD';

                action("Fabric Mapping")
                {
                    Caption = 'Fabric Mapping';
                    RunObject = Page FabricMappingList;
                    ApplicationArea = all;
                }

                action("Ratio Creation")
                {
                    Caption = 'Ratio Creation';
                    RunObject = Page "Ratio Creation";
                    ApplicationArea = all;
                }

            }

            group("Warehouse")
            {
                Caption = 'Warehouse';

                action("Roll Picking")
                {
                    Caption = 'Roll Picking';
                    RunObject = Page "Role Issuing Note List";
                    ApplicationArea = all;
                }

                group("Warehouse Reports")
                {
                    Caption = 'Warehouse Reports';

                    action("Roll Issuing Report")
                    {
                        Caption = 'Roll Issuing Report';
                        Enabled = true;
                        RunObject = report IssueNoteReport;
                        ApplicationArea = all;
                    }
                }

            }

            //Cutting
            group("Cutting")
            {
                Caption = 'Cutting';

                action("Bundle Guide")
                {
                    Caption = 'Bundle Guide';
                    RunObject = Page "Bundle Guide List";
                    ApplicationArea = all;
                }

                action("Cutting Progress")
                {
                    Caption = 'Cutting Progress';
                    RunObject = Page "Cutting Progress List";
                    ApplicationArea = all;
                }

                action("Cut Creation")
                {
                    Caption = 'Cut Creation';
                    RunObject = Page "Cut Creation";
                    ApplicationArea = all;
                }

                action("Daily Embroidary In/Out")
                {
                    Caption = 'Daily Embroidary In/Out';
                    RunObject = Page "Daily Embroidary In/Out";
                    ApplicationArea = all;
                }

                action("Daily Cutting Out")
                {
                    Caption = 'Daily Cutting Out';
                    RunObject = Page "Daily Cutting Out";
                    ApplicationArea = all;
                }

                action("Daily Printing In/Out")
                {
                    Caption = 'Daily Printing In/Out';
                    RunObject = Page "Daily Printing In/Out";
                    ApplicationArea = all;
                }

                action("Fabric Requisition")
                {
                    Caption = 'Fabric Requisition';
                    RunObject = Page FabricRequisitionList;
                    ApplicationArea = all;
                }

                action("Lay Sheet")
                {
                    Caption = 'Lay Sheet';
                    RunObject = Page "Lay Sheet List";
                    ApplicationArea = all;
                }

                action("Sewing Job Creation")
                {
                    Caption = 'Sewing Job Creation';
                    RunObject = Page "Sewing Job Creation";
                    ApplicationArea = all;
                }

                action("Table Creation")
                {
                    Caption = 'Cutting Table Creation';
                    RunObject = Page "Table Creation";
                    ApplicationArea = all;
                }

                group("Cutting Reports")
                {
                    Caption = 'Cutting Reports';

                    action("Bundle Guide Report")
                    {
                        Caption = 'Bundle Guide Report';
                        Enabled = true;
                        RunObject = report BundleGuideReport;
                        ApplicationArea = all;
                    }

                    action("Cutting Chart Report")
                    {
                        Caption = 'Cutting Chart Report';
                        Enabled = true;
                        RunObject = report CuttingChartReport;
                        ApplicationArea = all;
                    }

                    action("Fabric Requistion Report")
                    {
                        Caption = 'Fabric Requistion Report';
                        Enabled = true;
                        RunObject = report FabricRequisitionNote;
                        ApplicationArea = all;
                    }
                }
            }

            //sewing
            group("Sewing")
            {
                Caption = 'Sewing';

                action("Daily Sewing In/Out")
                {
                    Caption = 'Daily Sewing In/Out';
                    RunObject = Page "Daily Sewing In/Out";
                    ApplicationArea = all;
                }

                action("Hourly Production")
                {
                    Caption = 'Hourly Production';
                    RunObject = Page "Hourly Production list";
                    ApplicationArea = all;
                }
            }

            group("Finishing")
            {
                Caption = 'Finishing';

                action("Daily Washing In/Out")
                {
                    Caption = 'Daily Washing In/Out';
                    RunObject = Page "Daily Washing In/Out";
                    ApplicationArea = all;
                }

                action("Daily Finishing In/Out")
                {
                    Caption = 'Daily Finishing In/Out';
                    RunObject = Page "Daily Finishing Out";
                    ApplicationArea = all;
                }

                action("Daily Shipping In/Out")
                {
                    Caption = 'Daily Shipping In/Out';
                    RunObject = Page "Daily Shipping Out";
                    ApplicationArea = all;
                }

                group("Fnishing Reports")
                {
                    Caption = 'Fnishing Reports';

                    action("Weekly Order Booking")
                    {
                        Caption = 'Weekly Order Booking';
                        Enabled = true;
                        RunObject = report WeeklyOrderBookingStatus;
                        ApplicationArea = all;
                    }
                }
            }

            group("Samples")
            {
                Caption = 'Samples';

                action("Sample Request1")
                {
                    Caption = 'Sample Request';
                    RunObject = Page "Sample Request";
                    ApplicationArea = all;
                }

                action("Sample Production")
                {
                    Caption = 'Sample Production';
                    RunObject = Page "Sample Production";
                    ApplicationArea = all;
                }

                action("Sample WIP")
                {
                    Caption = 'Sample WIP';
                    RunObject = Page "Sample WIP Card";
                    ApplicationArea = all;
                }

                action("Sample Status List")
                {
                    Caption = 'Sample Status List';
                    RunObject = Page "Sample Status List";
                    ApplicationArea = all;
                }

                action("Sample Type")
                {
                    Caption = 'Sample Type';
                    RunObject = Page "Sample Type";
                    ApplicationArea = all;
                }

                action("Sample Room")
                {
                    Caption = 'Sample Room';
                    RunObject = Page "Sample Room List";
                    ApplicationArea = all;
                }

                action("Upload Document Type")
                {
                    Caption = 'Upload Document Type';
                    RunObject = Page "Upload Document Type";
                    ApplicationArea = all;
                }
            }

            //Work Study
            group("Work Study")
            {
                Caption = 'Work Study';

                action("Style SMV Pending List")
                {
                    Caption = 'SMV Pending Style List';
                    RunObject = Page "Style SMV Pending List";
                    ApplicationArea = all;
                }

                action("Copy Breakdown")
                {
                    Caption = 'Copy Breakdown';
                    RunObject = Page "Copy Breakdown Card";
                    ApplicationArea = all;
                }

                action("Folder Details")
                {
                    Caption = 'Folder Details';
                    RunObject = Page "Folder Detail List";
                    ApplicationArea = all;
                }

                action("Garment Part")
                {
                    Caption = 'Garment Part';
                    RunObject = Page "Garment Part List";
                    ApplicationArea = all;
                }

                action("Item Type")
                {
                    Caption = 'Item Type';
                    RunObject = Page "Item Type List";
                    ApplicationArea = all;
                }

                action("Machine Category")
                {
                    Caption = 'Machine Category';
                    RunObject = Page "Machine Category List";
                    ApplicationArea = all;
                }

                action("Machine Master")
                {
                    Caption = 'Machine Master';
                    RunObject = Page "Machine Master";
                    ApplicationArea = all;
                }

                action("Maning Levels")
                {
                    Caption = 'Maning Levels';
                    RunObject = Page "Maning Level List";
                    ApplicationArea = all;
                }

                action("Machine Layout")
                {
                    Caption = 'Machine Layout';
                    RunObject = Page "Machine Layout List";
                    ApplicationArea = all;
                }

                action("Needle Type")
                {
                    Caption = 'Needle Type';
                    RunObject = Page "Needle Type List";
                    ApplicationArea = all;
                }

                action("New Operation")
                {
                    Caption = 'New Operation';
                    RunObject = Page "New Operation";
                    ApplicationArea = all;
                }

                action("New Breakdown")
                {
                    Caption = 'New Breakdown';
                    RunObject = Page "New Breakdown";
                    ApplicationArea = all;
                }

                group("Workstudy Reports")
                {
                    Caption = 'Workstudy Reports';

                    action("Manning Level Report")
                    {
                        Caption = 'Manning Level Report';
                        Enabled = true;
                        RunObject = report ManningLevelsReport;
                        ApplicationArea = all;
                    }

                    action("Style Analysis Report")
                    {
                        Caption = 'Style Analysis Report';
                        Enabled = true;
                        RunObject = report StyleAnalysis;
                        ApplicationArea = all;
                    }

                    action("Process Layout Report")
                    {
                        Caption = 'Process Layout Report';
                        Enabled = true;
                        RunObject = report ProcessLayoutReport;
                        ApplicationArea = all;
                    }

                    action("PendingStyleSMV")
                    {
                        Caption = 'Pending Style SMV Report';
                        Enabled = true;
                        RunObject = report PendingStyleSMV;
                        ApplicationArea = all;
                    }
                }
            }

            group("Washing")
            {
                Caption = 'Washing';

                action("Sample Requests")
                {
                    Caption = ' Sample Requests';
                    RunObject = Page WashingSampleHistry;
                    ApplicationArea = all;
                }

                action("BW Quality Check")
                {
                    RunObject = page BWQualityCheckList;
                    Caption = ' Quality Check (Before Wash)';
                    ApplicationArea = all;
                }

                action("Return To Customer BW")
                {
                    RunObject = page RTCBWList;
                    Caption = 'Return To Customer (Before Wash)';
                    ApplicationArea = All;
                }

                action("Split Sample Requests")
                {
                    RunObject = page "Split Sample Requests List";
                    ApplicationArea = all;
                    Caption = 'Job Creation';
                }

                action("Washing BOM")
                {
                    RunObject = page WashingBOMList;
                    Caption = 'Recipe';
                    ApplicationArea = all;
                }

                action("Washing JobCard")
                {
                    RunObject = page JobCardList;
                    Caption = 'Job Card';
                    ApplicationArea = all;
                }

                action("Quality Check AW")
                {
                    RunObject = page AWQualityCheck;
                    ApplicationArea = All;
                    Caption = ' Quality Check (After Wash)';
                }

                action("Return To Customer AW")
                {
                    RunObject = page RTCAWHeaderList;
                    ApplicationArea = All;
                    Caption = 'Return To Customer (After Wash)';
                }

                action("Machine Types")
                {
                    RunObject = page WashingMachineTypeList;
                    ApplicationArea = All;
                    Caption = 'Machine Types';
                }

                group("Washing Reports")
                {
                    Caption = 'Washing Reports';

                    action("Job Card Report")
                    {
                        Caption = 'Job Card Report';
                        Enabled = true;
                        RunObject = report JobCardReport;
                        ApplicationArea = all;
                    }
                }
            }

            group("Service Mgt")
            {
                Caption = 'Service Mgt';

                action("Service Items")
                {
                    Caption = 'Service Items';
                    RunObject = Page "Service Item List";
                    ApplicationArea = all;
                }

                action("Standard Service Codes")
                {
                    Caption = 'Standard Service Codes';
                    RunObject = Page "Standard Service Codes";
                    ApplicationArea = all;
                }

                action("Service Worksheet")
                {
                    Caption = 'Service Worksheet';
                    RunObject = Page "Service Worksheet Card";
                    ApplicationArea = all;
                }
            }

            group("Commercial")
            {
                Caption = 'Commercial';
                Image = Marketing;

                action("Acceptance")
                {
                    Caption = 'Acceptance';
                    RunObject = Page "Acceptance List";
                    ApplicationArea = all;
                }

                action("B2B LC")
                {
                    Caption = 'B2B LC';
                    RunObject = Page "B2B LC List";
                    ApplicationArea = all;
                }

                action("Bank Reference List")
                {
                    Caption = 'Export Bank Reference List';
                    RunObject = Page "Bank Reference List";
                    ApplicationArea = all;
                }

                action("Bank Reference Collection List")
                {
                    Caption = 'Export Bank Ref. Collection List';
                    RunObject = Page "Bank Ref Collection List";
                    ApplicationArea = all;
                }

                action("GIT Base On LC")
                {
                    Caption = 'GIT Base On LC';
                    RunObject = Page "GIT Baseon LC List";
                    ApplicationArea = all;
                }

                action("GIT Base On PI")
                {
                    Caption = 'GIT Base On PI';
                    RunObject = Page "GIT Baseon PI List";
                    ApplicationArea = all;
                }

                action("Paybale Chart")
                {
                    Caption = 'Paybale Chart';
                    RunObject = Page "Payable Chart - Approved";
                    ApplicationArea = all;
                }

                action("Paid Chart")
                {
                    Caption = 'Paid Chart';
                    RunObject = Page "Paid Chart - Approved";
                    ApplicationArea = all;
                }

                action("Supplier Wise Payment List")
                {
                    Caption = 'Supplier Wise Payment List';
                    RunObject = Page SupplierPaymentList;
                    ApplicationArea = all;
                }

                group("Commercial Reports")
                {
                    Caption = 'Commercial Reports';

                    action("Contract Export Status Report")
                    {
                        Caption = 'Contract Export Status Report';
                        Enabled = true;
                        RunObject = report ContractExportStatus;
                        ApplicationArea = all;
                    }

                    action("Export Status Report")
                    {
                        Caption = 'Contract Master LC/BBLC & Export Status Report';
                        Enabled = true;
                        RunObject = report ExportStatusReport1;
                        ApplicationArea = all;
                    }

                    action("Export Summary Report")
                    {
                        Caption = 'Export Summary Report';
                        Enabled = true;
                        RunObject = report ExportSummartReport;
                        ApplicationArea = all;
                    }

                    action("Export LC Utilized Report")
                    {
                        Caption = 'Export LC Utilized Report';
                        Enabled = true;
                        RunObject = report ExportLcUtilizationReport;
                        ApplicationArea = all;
                    }
                }
            }

            group("Quality")
            {
                Caption = 'Quality';

                action("Fabric Inspection")
                {
                    Caption = 'Fabric Inspection';
                    RunObject = Page "Fabric Inspection List";
                    ApplicationArea = all;
                }

                action("Fabric Processing")
                {
                    Caption = 'Fabric Processing';
                    RunObject = Page FabricProceList;
                    ApplicationArea = all;
                }

                action("Fabric Shrinkage Test")
                {
                    Caption = 'Fabric Shrinkage Test';
                    RunObject = Page FabShrinkageTestList;
                    ApplicationArea = all;
                }

                action("Fabric Twist Test")
                {
                    Caption = 'Fabric Twist/Skewness Test';
                    RunObject = Page FabTwistList;
                    ApplicationArea = all;
                }

                action("Fabric Shade")
                {
                    Caption = 'Fabric Shade';
                    RunObject = Page FabShadeList;
                    ApplicationArea = all;
                }

                action("Fabric Shade / Shrinkage")
                {
                    Caption = 'Fabric Shade / Shrinkage';
                    RunObject = Page FabShadeShrinkageList;
                    ApplicationArea = all;
                }

                action("Trim Inspection")
                {
                    Caption = 'Trim Inspection';
                    RunObject = Page "Trim Inspection List";
                    ApplicationArea = all;
                }

                group("Quality Reports")
                {
                    Caption = 'Quality Reports';

                    action("Fabric Shade Band and Shrinkage Report")
                    {
                        Caption = 'Fabric Shade Band and Shrinkage Report';
                        Enabled = true;
                        RunObject = report FabricShadeBandandShrinkage;
                        ApplicationArea = all;
                    }

                    action("Fabric Shade Band and Shrinkage Test Report")
                    {
                        Caption = 'Fabric Shade Band and Shrinkage Test Report';
                        Enabled = true;
                        RunObject = report FabricShadeBandShrinkageReport;
                        ApplicationArea = all;
                    }

                    action("Fabric Shrinkage Test Report")
                    {
                        Caption = 'Fabric Shrinkage Test Report';
                        Enabled = true;
                        RunObject = report FabricShrinkageTestReport;
                        ApplicationArea = all;
                    }

                    action("Fabric Shade Report")
                    {
                        Caption = 'Fabric Shade Report';
                        Enabled = true;
                        RunObject = report FabricShadeReport;
                        ApplicationArea = all;
                    }

                    action("Fabric Twist Report")
                    {
                        Caption = 'Fabric Twist Report';
                        Enabled = true;
                        RunObject = report FabricTwistReport;
                        ApplicationArea = all;
                    }
                }

            }

            group("Finance")
            {
                Caption = 'Finance';

                action("General Journals")
                {
                    Caption = 'General Journals';
                    RunObject = Page "General Journal";
                    ApplicationArea = all;
                }

                action("Chart Of Accounts")
                {
                    Caption = 'Chart Of Accounts';
                    RunObject = Page "Chart of Accounts";
                    ApplicationArea = all;
                }

                action("GL Account Categories")
                {
                    Caption = 'GL Account Categories';
                    RunObject = Page "G/L Account Categories";
                    ApplicationArea = all;
                }

                action("GL Budgets")
                {
                    Caption = 'GL Budgets';
                    RunObject = Page "G/L Budget Entries";
                    ApplicationArea = all;
                }

                action("Fixed Assets")
                {
                    Caption = 'Fixed Assets';
                    RunObject = Page "Fixed Asset List";
                    ApplicationArea = all;
                }

                action("Account Schedules")
                {
                    Caption = 'Account Schedules';
                    RunObject = Page "Account Schedule";
                    ApplicationArea = all;
                }

                action("Intrastat Journals")
                {
                    Caption = 'Intrastat Journals';
                    RunObject = Page "Intrastat Journal";
                    ApplicationArea = all;
                }

                action("Sales Budgets")
                {
                    Caption = 'Sales Budgets';
                    RunObject = Page "Sales Budget Overview";
                    ApplicationArea = all;
                }

                action("Purchase Budgets")
                {
                    Caption = 'Purchase Budgets';
                    RunObject = Page "Purchase Budget Overview";
                    ApplicationArea = all;
                }

                action("Sales Analysis Reports")
                {
                    Caption = 'Sales Analysis Reports';
                    RunObject = Page "Sales Analysis Report";
                    ApplicationArea = all;
                }

                action("Purchase Analysis Reports")
                {
                    Caption = 'Purchase Analysis Reports';
                    RunObject = Page "Purchase Analysis Report";
                    ApplicationArea = all;
                }

                action("Inventory Analysis Reports")
                {
                    Caption = 'Inventory Analysis Reports';
                    RunObject = Page "Inventory Analysis Report";
                    ApplicationArea = all;
                }

                action("VAT Returns")
                {
                    Caption = 'VAT Returns';
                    RunObject = Page "VAT Return Period List";
                    ApplicationArea = all;
                }

                action("Currencies")
                {
                    Caption = 'Currencies';
                    RunObject = Page Currencies;
                    ApplicationArea = all;
                }

                action("Employees")
                {
                    Caption = 'Employees';
                    RunObject = Page "Employee List";
                    ApplicationArea = all;
                }

                action("VAT Statements")
                {
                    Caption = 'VAT Statements';
                    RunObject = Page "VAT Statement";
                    ApplicationArea = all;
                }

                action("Dimensions")
                {
                    Caption = 'Dimensions';
                    RunObject = Page "Dimension List";
                    ApplicationArea = all;
                }

                action("Posted General Journals")
                {
                    Caption = 'Posted General Journals';
                    RunObject = Page "Posted General Journal";
                    ApplicationArea = all;
                }

                group("Finance Reports")
                {
                    Caption = 'Finance Reports';

                    action("Statement Of Net Margin")
                    {
                        Caption = 'Statement Of Net Margin Report';
                        Enabled = true;
                        RunObject = report StatementOfNetMargin;
                        ApplicationArea = all;
                    }
                }
            }

            group("Purchasing")
            {
                Caption = 'Purchasing';

                action("Vendors")
                {
                    Caption = 'Vendors';
                    RunObject = Page "Vendor List";
                    ApplicationArea = all;
                }

                action("Incoming Documents")
                {
                    Caption = 'Incoming Documents';
                    RunObject = Page "Incoming Documents";
                    ApplicationArea = all;
                }

                action("Item Charges")
                {
                    Caption = 'Item Charges';
                    RunObject = Page "Item Charges";
                    ApplicationArea = all;
                }

                action("Purchase Quotes")
                {
                    Caption = 'Purchase Quotes';
                    RunObject = Page "Purchase Quotes";
                    ApplicationArea = all;
                }

                action("Purchase Orders")
                {
                    Caption = 'Purchase Orders';
                    RunObject = Page "Purchase Order List";
                    ApplicationArea = all;
                }

                action("Blanket Purchase Orders")
                {
                    Caption = 'Blanket Purchase Orders';
                    RunObject = Page "Blanket Purchase Orders";
                    ApplicationArea = all;
                }

                action("Purchase Invoices")
                {
                    Caption = 'Purchase Invoices';
                    RunObject = Page "Purchase Invoices";
                    ApplicationArea = all;
                }

                action("Purchase Credit Memos")
                {
                    Caption = 'Purchase Credit Memos';
                    RunObject = Page "Purchase Credit Memos";
                    ApplicationArea = all;
                }

                action("Purchase Return Orders")
                {
                    Caption = 'Purchase Return Orders';
                    RunObject = Page "Purchase Return Orders";
                    ApplicationArea = all;
                }

                action("Posted Purchase Invoices")
                {
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                    ApplicationArea = all;
                }

                action("Posted Purchase Credit Memo")
                {
                    Caption = 'Posted Purchase Credit Memo';
                    RunObject = Page "Posted Purchase Credit Memos";
                    ApplicationArea = all;
                }

                action("Posted Purchase Receipts")
                {
                    Caption = 'Posted Purchase Receipts';
                    RunObject = Page "Posted Purchase Receipts";
                    ApplicationArea = all;
                }

                action("Posted Purchase Return Shipments")
                {
                    Caption = 'Posted Purchase Return Shipments';
                    RunObject = Page "Posted Return Shipments";
                    ApplicationArea = all;
                }

                group("Purchasing Reports")
                {
                    Caption = 'Purchasing Reports';

                    action("Bin Card Report")
                    {
                        Caption = 'Bin Card Report';
                        Enabled = true;
                        RunObject = report BinCardReport;
                        ApplicationArea = all;
                    }

                    action("Goods Received Note1")
                    {
                        Caption = 'Goods Received Note';
                        Enabled = true;
                        RunObject = report GrnReport;
                        ApplicationArea = all;
                    }
                }
            }

            group("Sales")
            {
                Caption = 'Sales';

                action("Item Chargess")
                {
                    Caption = 'Item Charges';
                    RunObject = Page "Item Charges";
                    ApplicationArea = all;
                }

                action("Sales Quotes")
                {
                    Caption = 'Sales Quotes';
                    RunObject = Page "Sales Quotes";
                    ApplicationArea = all;
                }

                action("Sales Orders")
                {
                    Caption = 'Sales Orders';
                    RunObject = Page "Sales Order list";
                    ApplicationArea = all;
                }

                action("Blanket Sales Orders")
                {
                    Caption = 'Blanket Sales Orders';
                    RunObject = Page "Blanket Sales Orders";
                    ApplicationArea = all;
                }

                action("Sales Invoices")
                {
                    Caption = 'Sales Invoices';
                    RunObject = Page "Sales Invoice List";
                    ApplicationArea = all;
                }

                action("Sales Credit Memos")
                {
                    Caption = 'Sales Credit Memos';
                    RunObject = Page "Sales Credit Memos";
                    ApplicationArea = all;
                }

                action("Sales Return Orders")
                {
                    Caption = 'Sales Return Orders';
                    RunObject = Page "Sales Return Orders";
                    ApplicationArea = all;
                }

                action("Reminders")
                {
                    Caption = 'Reminders';
                    RunObject = Page "Reminder List";
                    ApplicationArea = all;
                }

                action("Finance Charge Memo")
                {
                    Caption = 'Finance Charge Memo';
                    RunObject = Page "Finance Charge Memo List";
                    ApplicationArea = all;
                }

                action("Posted Sales Invoices")
                {
                    Caption = 'Posted Sales Invoices';
                    RunObject = Page "Posted Sales Invoices";
                    ApplicationArea = all;
                }

                action("Posted Sales Credit Memos")
                {
                    Caption = 'Posted Sales Credit Memos';
                    RunObject = Page "Posted Sales Credit Memos";
                    ApplicationArea = all;
                }

                action("Posted Sales Shipments")
                {
                    Caption = 'Posted Sales Shipments';
                    RunObject = Page "Posted Sales Shipments";
                    ApplicationArea = all;
                }

                action("Posted Sales Return Receipts")
                {
                    Caption = 'Posted Sales Return Receipts';
                    RunObject = Page "Posted Return Receipts";
                    ApplicationArea = all;
                }

                action("Issued Reminders")
                {
                    Caption = 'Issued Reminders';
                    RunObject = Page "Issued Reminder List";
                    ApplicationArea = all;
                }

                action("Issued Finance Charge Memo")
                {
                    Caption = 'Issued Finance Charge Memo';
                    RunObject = Page "Issued Fin. Charge Memo List";
                    ApplicationArea = all;
                }

                action("Transfer Orders")
                {
                    Caption = 'Transfer Orders';
                    RunObject = Page "Transfer Orders";
                    ApplicationArea = all;
                }
            }

            group("Admin")
            {
                Caption = 'Admin';

                action("Create User")
                {
                    Caption = 'Create User';
                    RunObject = Page "Create User Card";
                    ApplicationArea = all;
                }

                action("Nav Apperal Setup")
                {
                    Caption = 'Apperal Setup';
                    RunObject = Page "NavApp Setup Card";
                    ApplicationArea = all;
                }
            }
        }

        area(Creation)
        {
            action("Visual Planning")
            {
                Caption = 'Visual Planning';
                RunObject = Page NETRONICVSDevToolDemoAppPage;
                ApplicationArea = all;
            }
        }
    }
}

profile NAVAPP
{
    ProfileDescription = 'Nav Apperal Profile';
    RoleCenter = "Nav Apperal Role Center";
    Caption = 'NAVAPP profile';
}

