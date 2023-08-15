page 50968 "Nav Apperal Role Center"
{
    PageType = RoleCenter;
    Caption = 'Nav Apperal Role Center';
    ApplicationArea = all;
    UsageCategory = Lists;

    layout
    {
        area(RoleCenter)
        {
            group(Group1)
            {
                part(Control97; "Cue Activities 1")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Activities';
                }

                // part(Control98; "Power BI Report Spinner Part")
                // {
                //     AccessByPermission = TableData "Power BI User Configuration" = I;
                //     ApplicationArea = Basic, Suite;
                //     Enabled = false;
                // }
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

                action("Chemical Type")
                {
                    Caption = 'Chemical Type';
                    RunObject = Page ChemicalTypeList;
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

                action("Department/Categories")
                {
                    Caption = 'Department/Categories';
                    RunObject = Page Dept_CategoriesList2;
                    ApplicationArea = all;
                }

                action("Dimension Width")
                {
                    Caption = 'Dimension Width';
                    RunObject = Page "Dimension Width";
                    ApplicationArea = all;
                }

                action("Description List")
                {
                    Caption = 'Description';
                    Enabled = true;
                    RunObject = page "Description List";
                    ApplicationArea = all;
                }

                action("External Locations")
                {
                    Caption = 'External Locations';
                    RunObject = Page ExternalLocationsList;
                    ApplicationArea = all;
                }

                action("Factory Wise CPM")
                {
                    Caption = 'Factory Wise CPM';
                    RunObject = Page "Factory CPM List";
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

                action("Learning Curve")
                {
                    Caption = 'Learning Curve';
                    RunObject = Page "Learning Curve";
                    ApplicationArea = all;
                }

                action("Location")
                {
                    Caption = 'Location';
                    RunObject = Page "Location List";
                    ApplicationArea = all;
                }

                action("Model")
                {
                    Caption = 'Model';
                    RunObject = Page ModelList;
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

                action("Qty Wise Extra % For Cutting")
                {
                    Caption = 'Qty Wise Extra % For Cutting';
                    RunObject = Page ExtraPercentageForCuttingList;
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

                action("Workers")
                {
                    Caption = 'Workers';
                    RunObject = Page "Workers List";
                    ApplicationArea = all;
                }
                action("Style Master Master")
                {
                    Caption = 'WIP Order QTY Change';
                    RunObject = Page "WIP Order QTY Change List";
                    ApplicationArea = all;
                }
            }

            //Merchandizing Group
            group("Merchandizing Group")
            {
                Caption = 'Merchandising';
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

                //Done By Sachith 23/02/23
                action("Buyer/Style/VendorPO Details")
                {
                    Caption = 'Buyer/Style/Vendor PO Details';
                    RunObject = page "Buyer Style PO Search List";
                    ApplicationArea = All;
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

                action("ContractLC")
                {
                    Caption = 'Contract/Master LC';
                    RunObject = Page "Contract/LC List";
                    ApplicationArea = all;
                }

                action("Contract BBLC Summary List1")
                {
                    Caption = 'Contract BBLC Summary List';
                    RunObject = Page "Contract BBLC Summary List";
                    ApplicationArea = all;
                }

                action("Capacity Utilization By SAH1")
                {
                    Caption = 'Capacity Utilization By SAH';
                    RunObject = Page SAH_CapacityAllocationList;
                    ApplicationArea = all;
                }

                group("Capacity By Pcs")
                {
                    Caption = 'Capacity By Pcs';

                    action("Buyer Wise Order Booking")
                    {
                        Caption = 'Buyer Wise Order Booking';
                        RunObject = Page BuyerWiseOrderBookingList;
                        ApplicationArea = all;
                    }
                }

                action("Copy BOM")
                {
                    Caption = 'Copy BOM';
                    //Enabled = true;
                    RunObject = Page "Copy BOM Card";
                    ApplicationArea = all;
                }

                //Done By Sachith on 24/04/23
                action("Copy Sample Requisition")
                {
                    Caption = 'Copy Sample Requisition';
                    RunObject = Page "Copy Sample Requisition Card";
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
                action("Fabric Code Merchandizing")
                {
                    Caption = 'Fabric Code';
                    RunObject = Page FabricCodeList;
                    ApplicationArea = all;
                }

                action("My Task")
                {
                    Caption = 'My Task';
                    RunObject = Page "MyTask Card";
                    ApplicationArea = all;
                }

                action("MerchandizingGroup")
                {
                    Caption = 'Merchandising Group';
                    RunObject = Page MerchandizingGroupPage;
                    ApplicationArea = all;
                }
                action("OMS Merchandizing")
                {
                    Caption = 'OMS List';
                    RunObject = Page OMSList;
                    ApplicationArea = all;
                }
                action("StockSummary")
                {
                    Caption = 'Stock Summary';
                    RunObject = Page StockSummary;
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
                    RunObject = Page "PO List Merchand";
                    ApplicationArea = all;
                }

                action("Style Transfers")
                {
                    RunObject = page "Style transfer List";
                    ApplicationArea = All;
                }
                action("Style Transfer Approvals")
                {
                    RunObject = page "Style transfer Approvals";
                    ApplicationArea = All;
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

                action("Sample Requisition")
                {
                    Caption = 'Sample Requisition';
                    RunObject = Page "Sample Request";
                    ApplicationArea = all;
                }

                action("Sample Status List1")
                {
                    Caption = 'Sample Status List';
                    RunObject = Page "Sample Status List";
                    ApplicationArea = all;
                }

                action("T & A Style")
                {
                    Caption = 'T & A Style';
                    RunObject = Page "Dependency Style";
                    ApplicationArea = all;
                }

                action("Washing Requisition")
                {
                    Caption = ' Washing Requisition';
                    RunObject = Page WashingSampleHistryMerchand;
                    ApplicationArea = all;
                }

                action("YY Requsition")
                {
                    Caption = 'YY Requisition';
                    RunObject = Page "YY Requsition List";
                    ApplicationArea = all;
                }

                action("SampleWashingRequestsWIP1")
                {
                    RunObject = page SampleWashingRequestsWIP;
                    ApplicationArea = All;
                    Caption = 'Washing Requests WIP';
                }

                group("Merchandizing Reports")
                {
                    Caption = 'Merchandising Reports';

                    action("Accessory Status")
                    {
                        Caption = 'Accessory Status Report';
                        Enabled = true;
                        RunObject = report AccessoriesStatusReportNew;
                        ApplicationArea = all;
                    }

                    // action(Barcode)
                    // {
                    //     Caption = 'Barcode Report';
                    //     Enabled = true;
                    //     RunObject = report TestBarcode;
                    //     ApplicationArea = all;
                    // }

                    group("Capacity By Pcs Reports")
                    {
                        action("Month Wise Order Booking Report")
                        {
                            Caption = 'Month Wise Order Booking Report';
                            Enabled = true;
                            RunObject = report CapacityByPcsAllBookingReport;
                            ApplicationArea = all;
                        }

                        action("Month Wise Sewing Balance Report")
                        {
                            Caption = 'Month Wise Sewing Balance Report';
                            Enabled = true;
                            RunObject = report CapacityByPcsBalToSewingReport;
                            ApplicationArea = all;
                        }

                        action("Month Wise Ship Balance Report")
                        {
                            Caption = 'Month Wise Ship Balance Report';
                            Enabled = true;
                            RunObject = report CapacityByPcsBalToShipReport;
                            ApplicationArea = all;
                        }

                        action("Month Wise Merchant Group Report")
                        {
                            Caption = 'Month Wise Merchant Group Booking Report';
                            Enabled = true;
                            RunObject = report CapacityByPcsGroupWiseReport;
                            ApplicationArea = all;
                        }
                    }

                    action("Delivery Details")
                    {
                        Caption = 'Delivery Details';
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
                    action("Export Summary Report Merchandizing")
                    {
                        Caption = 'Export Summary Report';
                        Enabled = true;
                        RunObject = report ExportSummartReport;
                        ApplicationArea = all;
                    }

                    action("Fabric & Trims requiremts - Marchandizingn")
                    {
                        Caption = 'Fabric & Trims Requirements Report';
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
                    action("Hourly Production Report Merchandizing")
                    {
                        Caption = 'Hourly Production Report';
                        Enabled = true;
                        RunObject = report HourlyProductionReport;
                        ApplicationArea = all;
                    }
                    action("Order Completion Report")
                    {
                        Caption = 'Order Completion Report';
                        Enabled = true;
                        RunObject = report OCR;
                        ApplicationArea = all;
                    }

                    //Done By Sachith on 06/05/23
                    action("OMS Report Merchant")
                    {
                        Caption = 'OMS Report';
                        Enabled = true;
                        RunObject = report OMSReport;
                        ApplicationArea = all;
                    }

                    action("Purchase Order Report")
                    {
                        Caption = 'Purchase Order Report';
                        Enabled = true;
                        RunObject = report PurchaseOrderReport;
                        ApplicationArea = all;
                    }

                    action("Production Plan Report1")
                    {
                        Caption = 'Production Plan Report';
                        Enabled = true;
                        RunObject = report ProductionPlanReport;
                        ApplicationArea = all;
                    }

                    action("Style Transfer Report")
                    {
                        Caption = 'Style Transfer Report';
                        Enabled = true;
                        RunObject = report StyleTransferReport;
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
                        Caption = 'Sample Requisition Report';
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
                    action("WIP")
                    {
                        Caption = 'WIP Report';
                        Enabled = true;
                        RunObject = report WIPReport;
                        ApplicationArea = all;
                    }

                }
            }

            //Planning 
            group("Planning")
            {
                Caption = 'Planning';

                action("Capacity Utilization By SAH")
                {
                    Caption = 'Capacity Utilization By SAH';
                    RunObject = Page SAH_CapacityAllocationList;
                    ApplicationArea = all;
                }

                //Done By Sachith on 13/02/23
                group("Capacity By Pcs2")
                {
                    Caption = 'Capacity By Pcs';

                    action("Buyer Wise Order Booking2")
                    {
                        Caption = 'Buyer Wise Order Booking';
                        RunObject = Page BuyerWiseOrderBookingList;
                        ApplicationArea = all;
                    }
                }

                action("Capacity Dashboard (Group/Factory Wise/Line Wise) Planning")
                {
                    Caption = 'Capacity Dashboard (Group/Factory Wise/Line Wise)';
                    RunObject = Page CapacityDashboardList;
                    ApplicationArea = all;
                }

                action("Factory Wise Production Planning")
                {
                    RunObject = Page FacWiseProductplaningHdrList;
                    ApplicationArea = all;
                }

                action("Hourly Production Planning")
                {
                    Caption = 'Hourly Production';
                    RunObject = Page "Hourly Production Plan list";
                    ApplicationArea = all;
                }
                action("OMS Planning")
                {
                    Caption = 'OMS List';
                    RunObject = Page OMSList;
                    ApplicationArea = all;
                }
                action("Pre-Production Follow Up")
                {
                    RunObject = page PreProductionfollowupList;
                    ApplicationArea = all;
                }

                action("Production File Release")
                {
                    RunObject = page ProductionFileReleaseCard;
                    ApplicationArea = all;
                }

                action("PO Complete")
                {
                    RunObject = page "PO Complete List";
                    ApplicationArea = all;
                }

                action("Style Change")
                {
                    Caption = 'Style Change';
                    RunObject = Page StyleChangeCard;
                    ApplicationArea = all;
                }

                action("Sales Order List1")
                {
                    Caption = 'Sales Orders';
                    RunObject = Page "Sales Order List";
                    ApplicationArea = all;
                }

                action("Shop Calenders")
                {
                    Caption = 'Shop Calenders';
                    RunObject = Page "Shop Calendars";
                    ApplicationArea = all;
                }

                action("Visual Planning")
                {
                    Caption = 'Visual Planning';
                    RunObject = Page NETRONICVSDevToolDemoAppPage;
                    ApplicationArea = all;
                }

                action("Wastage")
                {
                    Caption = 'Quantity Wise Extra %';
                    RunObject = Page Wastage;
                    ApplicationArea = all;
                }

                action("Work Center Plan")
                {
                    Caption = 'Work Center';
                    RunObject = Page "Work Center List";
                    ApplicationArea = all;
                }

                group("Planning Reports")
                {
                    Caption = 'Planning Reports';

                    action("Accessory Status Planning")
                    {
                        Caption = 'Accessory Status Report';
                        Enabled = true;
                        RunObject = report AccessoriesStatusReportNew;
                        ApplicationArea = all;
                    }

                    group("Capacity By Pcs Reports1")
                    {
                        Caption = 'Capacity By Pcs Reports';

                        action("Month Wise Order Booking Report1")
                        {
                            Caption = 'Month Wise Order Booking Report';
                            Enabled = true;
                            RunObject = report CapacityByPcsAllBookingReport;
                            ApplicationArea = all;
                        }

                        action("Month Wise Sewing Balance Repor1")
                        {
                            Caption = 'Month Wise Sewing Balance Report';
                            Enabled = true;
                            RunObject = report CapacityByPcsBalToSewingReport;
                            ApplicationArea = all;
                        }

                        action("Month Wise Ship Balance Report1")
                        {
                            Caption = 'Month Wise Ship Balance Report';
                            Enabled = true;
                            RunObject = report CapacityByPcsBalToShipReport;
                            ApplicationArea = all;
                        }

                        action("Month Wise Merchant Group Report1")
                        {
                            Caption = 'Month Wise Merchant Group Booking Report';
                            Enabled = true;
                            RunObject = report CapacityByPcsGroupWiseReport;
                            ApplicationArea = all;
                        }
                    }

                    action("Capacity Gap Details Report")
                    {
                        Caption = 'Capacity Gap Details Report';
                        Enabled = true;
                        RunObject = report CapacityGapDetailsReport;
                        ApplicationArea = all;
                    }

                    action("Day Wise Sewing Target")
                    {
                        Caption = 'Day Wise Sewing Target Report';
                        Enabled = true;
                        RunObject = report DayWiseSewingTarget;
                        ApplicationArea = all;
                    }
                    action("Export Summary Report Planning")
                    {
                        Caption = 'Export Summary Report';
                        Enabled = true;
                        RunObject = report ExportSummartReport;
                        ApplicationArea = all;
                    }
                    action("Day Wise Production Report")
                    {
                        Caption = 'Day Wise Production Report';
                        Enabled = true;
                        RunObject = report DayWiseProductionReport;
                        ApplicationArea = all;
                    }

                    //Done By Sachith 14/02/23
                    action("Delivery Details 2")
                    {
                        Caption = 'Delivery Details';
                        Enabled = true;
                        RunObject = report DeliveryInfoProductReport;
                        ApplicationArea = all;
                    }
                    action("Finishing Production Report Planning")
                    {
                        Caption = 'Hourly Finishing Production Report';
                        Enabled = true;
                        RunObject = report FinishingProductionReport;
                        ApplicationArea = all;
                    }
                    action("Hourly Production Report Planning")
                    {
                        Caption = 'Hourly Production Report';
                        Enabled = true;
                        RunObject = report HourlyProductionReport;
                        ApplicationArea = all;
                    }

                    //Done By Sachith on 08/03/23
                    action("Line in Out Report Planning")
                    {
                        Caption = 'Line In & Out Report';
                        Enabled = true;
                        RunObject = report lineinoutReport;
                        ApplicationArea = All;
                    }

                    //Done By Sachith on 06/05/23
                    action("OMS Report Planning")
                    {
                        Caption = 'OMS Report';
                        Enabled = true;
                        RunObject = report OMSReport;
                        ApplicationArea = all;
                    }

                    action("Production Plan Report")
                    {
                        Caption = 'Production Plan Report';
                        Enabled = true;
                        RunObject = report ProductionPlanReport;
                        ApplicationArea = all;
                    }

                    action("Production Status Report")
                    {
                        Caption = 'Production Status Report';
                        Enabled = true;
                        RunObject = report ProductionStatus;
                        ApplicationArea = all;
                    }

                    action("Planning Efficiency Dashboard")
                    {
                        Caption = 'Planning Efficiency Dashboard';
                        RunObject = Page "Planning Efficiency Dashboard1";
                        ApplicationArea = all;
                    }

                    action("Production and Shipment Details Report")
                    {
                        Caption = 'Production and Shipment Details Report';
                        Enabled = true;
                        RunObject = report ProductionAndShipmentDetails;
                        ApplicationArea = all;
                    }

                    action("Sewing Production Details")
                    {
                        Caption = 'Sewing Production Details';
                        Enabled = true;
                        RunObject = report SewingProductionDetails;
                        ApplicationArea = all;
                    }

                    action("Target Sheet Report")
                    {
                        Caption = 'Target Sheet Report';
                        Enabled = true;
                        RunObject = report TargetSheetReport;
                        ApplicationArea = all;
                    }

                    action("Weekly Order Booking")
                    {
                        Caption = 'Weekly Order Booking';
                        Enabled = true;
                        RunObject = report WeeklyOrderBookingStatus;
                        ApplicationArea = all;
                    }

                    action("WIP1")
                    {
                        Caption = 'WIP Report';
                        Enabled = true;
                        RunObject = report WIPReport;
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
                action("OMS CAD")
                {
                    Caption = 'OMS List';
                    RunObject = Page OMSList;
                    ApplicationArea = all;
                }
                action("Ratio Creation")
                {
                    Caption = 'Ratio Creation';
                    RunObject = Page "Ratio Creation";
                    ApplicationArea = all;
                }

                action("YY Requsition CAD")
                {
                    Caption = 'YY Requisition';
                    RunObject = Page "YY Requsition List";
                    ApplicationArea = all;
                }
                group("CAD Reports")
                {
                    action("Hourly Production Report CAD")
                    {
                        Caption = 'Hourly Production Report';
                        Enabled = true;
                        RunObject = report HourlyProductionReport;
                        ApplicationArea = all;
                    }
                }

            }

            group("Common")
            {
                action("Department Requisition Sheet")
                {
                    Caption = 'Department Requisition Sheet';
                    RunObject = page "Department Requisition Sheet";
                    ApplicationArea = All;
                }

                action("General Item Requisitions")
                {
                    ApplicationArea = All;
                    Caption = 'General Item Requisition';
                    RunObject = page "General Issue List";
                    RunPageView = where(Status = filter(Open | "Pending Approval"));
                }

                action("Gate Pass1")
                {
                    Caption = 'Gate Pass';
                    RunObject = Page "Gate Pass List";
                    ApplicationArea = all;
                }
                action("OMS Common")
                {
                    Caption = 'OMS List';
                    RunObject = Page OMSList;
                    ApplicationArea = all;
                }
                action("Purchase Orders2")
                {
                    Caption = 'Purchase Orders';
                    RunObject = Page "PO List Not Merchand";
                    ApplicationArea = all;
                }

                action("Raw Material Issue")
                {
                    Caption = 'Raw Material Requisition (Not Approved)';
                    ApplicationArea = All;
                    RunObject = page "Daily Consumption List ";
                    RunPageView = where(Status = filter(Open | "Pending Approval"));
                }

                action("Raw Material Issue- Approved")
                {
                    Caption = 'Raw Material Requisition List (Approved)';
                    ApplicationArea = All;
                    RunObject = page "Daily Consumption List Appro";
                    RunPageView = where(Status = filter("Approved"));
                }

                group("Common Reports")
                {
                    action("DepartmentRequisitionReport")
                    {
                        Caption = 'Department Requisition Report';
                        Enabled = true;
                        RunObject = report DepartmentRequisitionReport;
                        ApplicationArea = All;
                    }
                    action("Hourly Production Report Common")
                    {
                        Caption = 'Hourly Production Report';
                        Enabled = true;
                        RunObject = report HourlyProductionReport;
                        ApplicationArea = all;
                    }

                    action("Garment Wise Raw Material Request & Issue Report - common")
                    {
                        Caption = 'Garment Wise Raw Material Request & Issue Report';
                        Enabled = true;
                        RunObject = report GarmentWiseRawMaterialRequest;
                        ApplicationArea = All;
                    }

                    action("Material Issue Report Common")
                    {
                        Enabled = true;
                        Caption = 'Raw Material Requisition Status Report';
                        RunObject = report MaterialIssueRequitionCommon;
                        ApplicationArea = All;
                    }

                }

            }

            group("Procurement")
            {
                Caption = 'Procurement';
                // Done By Sachith on 03/02/23
                action("OMS Procurment")
                {
                    Caption = 'OMS List';
                    RunObject = Page OMSList;
                    ApplicationArea = all;
                }
                action("Posted Purchase Receipts2")
                {
                    Caption = 'Good Receipts';
                    RunObject = Page "Posted Purchase Receipts";
                    ApplicationArea = all;
                }

                action("Purchase Orders3")
                {
                    Caption = 'Purchase Orders';
                    RunObject = Page "PO List Not Merchand";
                    ApplicationArea = all;
                }

                action("Requisition Worksheet")
                {
                    Caption = 'Requisition Worksheet';
                    RunObject = Page "Req. Worksheet";
                    ApplicationArea = all;
                }

                // Done By Sachith on 03/02/23
                group("Procurement Reports")
                {
                    Caption = 'Procurement Reports';

                    action("Detail GRN Report ")
                    {
                        Enabled = true;
                        RunObject = report DetailGRNReport;
                        ApplicationArea = All;
                    }

                    action("Good Reciept Report2")
                    {
                        Caption = 'Good Reciept Report';
                        Enabled = true;
                        RunObject = report GrnReport;
                        ApplicationArea = All;
                    }
                    action("Vendor - Summary Aging")
                    {
                        Caption = 'Vendor - Summary Aging';
                        Enabled = true;
                        RunObject = report VendorSummaryAging;
                        ApplicationArea = All;
                    }
                    action("Hourly Production Report Procurement")
                    {
                        Caption = 'Hourly Production Report';
                        Enabled = true;
                        RunObject = report HourlyProductionReport;
                        ApplicationArea = all;
                    }
                }

            }

            group("Store")
            {
                Caption = 'Store';

                action("Approved General Issuance")
                {
                    ApplicationArea = All;
                    Caption = 'General Item Requisition';
                    RunObject = page "Approved General Issue List";
                    RunPageView = where(Status = filter(Approved));
                }

                action("Approved Raw Material Issue")
                {
                    Caption = 'Raw Material Requisition';
                    ApplicationArea = All;
                    RunObject = page "Approved Daily Consump. List";
                    RunPageView = where(Status = filter(Approved));
                }

                action("Bin Card")
                {
                    Caption = 'Bin Card';
                    ApplicationArea = All;
                    RunObject = page "Item Ledger Entries";
                }

                //Done By Sachith 22/03/23
                action("Buyer/Style/VendorPO Details Store")
                {
                    Caption = 'Buyer/Style/Vendor PO Details';
                    RunObject = page "Buyer Style PO Search List";
                    ApplicationArea = All;
                }

                action("Consumption Journal")
                {
                    Caption = 'Consumption Journal';
                    RunObject = Page "Consumption Journal";
                    ApplicationArea = all;
                }

                action("Contract/Style Allocation")
                {
                    Caption = 'Contract/Style Allocation';
                    RunObject = Page "StyleContract Allocations List";
                    ApplicationArea = all;
                }

                action("Item1")
                {
                    Caption = 'Item';
                    RunObject = Page "Item List";
                    ApplicationArea = all;
                }
                action("GroupWiseStockBalance")
                {
                    Caption = 'Group Wise Stock Balance';
                    RunObject = Page GroupWiseStockBalance;
                    ApplicationArea = all;
                }

                // action("General Issuing")
                // {
                //     Caption = 'General Issuing';
                //     RunObject = Page "Item Journal";
                //     RunPageView = where("Journal Template Name" = const('GEN-ISSUE'));
                //     ApplicationArea = all;
                // }

                action("OMS Store")
                {
                    Caption = 'OMS List';
                    RunObject = Page OMSList;
                    ApplicationArea = all;
                }
                action("Posted Purchase Receipts")
                {
                    Caption = 'Good Receipts';
                    RunObject = Page "Posted Purchase Receipts";
                    ApplicationArea = all;
                }

                action("Posted Material Requests")
                {
                    Caption = 'Posted Raw Material Requisition';
                    ApplicationArea = All;
                    RunObject = page "Daily Consumption List";
                    RunPageView = where(Status = filter(Approved), "Issued UserID" = filter(<> ''));
                }

                action("Pre-Production Follow Up- Store")
                {
                    Caption = 'Pre-Production Follow Up';
                    RunPageMode = View;
                    RunObject = page PreProductionfollowupdtoreList;
                    ApplicationArea = all;
                }


                action("Purchase Orders")
                {
                    Caption = 'Approved Purchase Orders';
                    RunObject = Page "Purchase Order List";
                    RunPageView = order(ascending) where(Status = filter(Released));
                    ApplicationArea = all;
                }

                action("Roll Picking")
                {
                    Caption = 'Roll Picking';
                    RunObject = Page "Role Issuing Note List";
                    ApplicationArea = all;
                }

                action("SS Transfers")
                {
                    RunObject = page "Style transfer List";
                    RunPageView = where(Status = filter(Approved));
                    ApplicationArea = All;
                }

                action("Transfer Orders")
                {
                    Caption = 'Transfer Orders';
                    RunObject = Page "Transfer Orders";
                    ApplicationArea = all;
                }

                group("Store Reports")
                {
                    Caption = 'Store Reports';

                    //EnventoryDayBook
                    action("Accessory Status ")
                    {
                        Caption = 'Accessory Status Report';
                        Enabled = true;
                        RunObject = report AccessoriesStatusReportNew;
                        ApplicationArea = all;
                    }

                    action("Detail GRN Report")
                    {
                        Enabled = true;
                        RunObject = report DetailGRNReport;
                        ApplicationArea = All;
                    }

                    action("Fabric & Trims requiremts - Marchandizingn ")
                    {
                        Caption = 'Fabric & Trims requiremts Report';
                        Enabled = true;
                        RunObject = report FabricAndTrimsRequiremts;
                        ApplicationArea = all;
                    }

                    action("Garment Wise Raw Material Request & Issue Report")
                    {
                        Caption = 'Garment Wise Raw Material Request & Issue Report';
                        Enabled = true;
                        RunObject = report GarmentWiseRawMaterialRequest;
                        ApplicationArea = All;
                    }

                    action("General Issue Note Report")
                    {
                        Caption = 'General Issue Note Report';
                        Enabled = true;
                        RunObject = report GeneralIssueReport;
                        ApplicationArea = all;
                    }
                    action("General Items Report")
                    {
                        Caption = 'General Item Report';
                        Enabled = true;
                        RunObject = report GeneralItemesReport;
                        ApplicationArea = all;
                    }

                    action("Good Reciept Report")
                    {
                        Enabled = true;
                        RunObject = report GrnReport;
                        ApplicationArea = All;
                    }

                    action("Hourly Production Report Warehouse")
                    {
                        Caption = 'Hourly Production Report';
                        Enabled = true;
                        RunObject = report HourlyProductionReport;
                        ApplicationArea = all;
                    }

                    action("Inventory Valuation Report")
                    {
                        Enabled = true;
                        RunObject = Report "Inventory Valuation";
                        ApplicationArea = All;
                    }
                    action("Inventory Balance Report")
                    {
                        Caption = 'Inventory Balance Report';
                        Enabled = true;
                        RunObject = report InventotyBalanceReport;
                        ApplicationArea = All;
                    }

                    action("EnventoryDayBook")
                    {
                        Enabled = true;
                        Caption = 'Inventory Day Book';
                        RunObject = report EnventoryDayBook;
                        ApplicationArea = All;
                    }

                    action("Material Issue Report")
                    {
                        Enabled = true;
                        Caption = 'Raw Material Issue Report';
                        RunObject = report MaterialIssueRequition;
                        ApplicationArea = All;
                    }

                    //Done By Sachith on 06/05/23
                    action("OMS Report Store")
                    {
                        Caption = 'OMS Report';
                        Enabled = true;
                        RunObject = report OMSReport;
                        ApplicationArea = all;
                    }

                    action("Phys. Inventory List Report")
                    {
                        Enabled = true;
                        RunObject = report "Phys. Inventory List";
                        ApplicationArea = All;
                    }

                    action("Roll Issuing Report")
                    {
                        Caption = 'Roll Issuing Report';
                        Enabled = true;
                        RunObject = report IssueNoteReport;
                        ApplicationArea = all;
                    }

                    action("Size Colour Wise Quantity Breakdown Report ")
                    {
                        Caption = 'Size Colour Wise Quantity Breakdown';
                        Enabled = true;
                        RunObject = report SizeColourwiseQuantity;
                        ApplicationArea = all;
                    }

                    action("Transfer Order Report")
                    {
                        Caption = 'Transfer Order Report';
                        Enabled = true;
                        RunObject = report TransferOrder;
                        ApplicationArea = all;
                    }

                    action("WIP2")
                    {
                        Caption = 'WIP Report';
                        Enabled = true;
                        RunObject = report WIPReport;
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

                action("Bundle Card")
                {
                    Caption = 'Bundle Card';
                    RunObject = Page "Bundle Card List";
                    ApplicationArea = all;
                }

                action("Bundle GMT Part")
                {
                    Caption = 'Garment Parts - Bundle Card';
                    RunObject = Page "Garment Parts - Bundle Card";
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
                    Caption = 'Daily Cutting In/Out';
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
                action("OMS Cutting")
                {
                    Caption = 'OMS List';
                    RunObject = Page OMSList;
                    ApplicationArea = all;
                }
                action("Roll Picking Cutting")
                {
                    Caption = 'Roll Picking';
                    RunObject = Page "Role Issuing Note List";
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
                    Caption = 'Cutting Table Planning';
                    RunObject = Page "Table Creation";
                    ApplicationArea = all;
                }

                group("Cutting Reports")
                {
                    Caption = 'Cutting Reports';

                    //Done By Sachith on 20/02/23
                    action("Accessory Status Cutting")
                    {
                        Caption = 'Accessory Status Report';
                        Enabled = true;
                        RunObject = report AccessoriesStatusReportNew;
                        ApplicationArea = all;
                    }

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
                    action("Daily Cutting Report")
                    {
                        Caption = 'Daily Cutting Production Report';
                        Enabled = true;
                        RunObject = report DailyCuttingReport;
                        ApplicationArea = All;
                    }
                    action("Fabric Requistion Report")
                    {
                        Caption = 'Fabric Requistion Report';
                        Enabled = true;
                        RunObject = report FabricRequisitionNote;
                        ApplicationArea = all;
                    }
                    action("Hourly Production Report Cutting")
                    {
                        Caption = 'Hourly Production Report';
                        Enabled = true;
                        RunObject = report HourlyProductionReport;
                        ApplicationArea = all;
                    }

                    //Done By Sachith on 08/03/23
                    action("Line in Out Report Cutting")
                    {
                        Caption = 'Line In & Out Report';
                        Enabled = true;
                        RunObject = report lineinoutReport;
                        ApplicationArea = All;
                    }

                    //Done By Sachith on 06/05/23
                    action("OMS Report Cutting")
                    {
                        Caption = 'OMS Report';
                        Enabled = true;
                        RunObject = report OMSReport;
                        ApplicationArea = all;
                    }

                    action("Production Plan Report2")
                    {
                        Caption = 'Production Plan Report';
                        Enabled = true;
                        RunObject = report ProductionPlanReport;
                        ApplicationArea = all;
                    }

                    //Done By Sachith on 20/02/23
                    action("Size Colour Wise Quantity Breakdown Report Cutting")
                    {
                        Caption = 'Size Colour Wise Quantity Breakdown';
                        Enabled = true;
                        RunObject = report SizeColourwiseQuantity;
                        ApplicationArea = all;
                    }

                    //Done By Sachith on 20/02/23
                    action("WIP Cuting")
                    {
                        Caption = 'WIP Report';
                        Enabled = true;
                        RunObject = report WIPReport;
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


                action("OMS Sewing")
                {
                    Caption = 'OMS List';
                    RunObject = Page OMSList;
                    ApplicationArea = all;
                }
                action(" Washing Requisition")
                {
                    Caption = ' Washing Requisition';
                    RunObject = Page WashingSampleHistry;
                    ApplicationArea = all;
                }
                group("Sewing Reports")
                {

                    //Done By Sachith on 08/03/23
                    action("Line in Out Report Sewing")
                    {
                        Caption = 'Line In & Out Report';
                        Enabled = true;
                        RunObject = report lineinoutReport;
                        ApplicationArea = All;
                    }

                    action("Hourly Production Report Sewing")
                    {
                        Caption = 'Hourly Production Report';
                        Enabled = true;
                        RunObject = report HourlyProductionReport;
                        ApplicationArea = all;
                    }

                    //Done By Sachith on 06/05/23
                    action("OMS Report Sewing")
                    {
                        Caption = 'OMS Report';
                        Enabled = true;
                        RunObject = report OMSReport;
                        ApplicationArea = all;
                    }

                    //Done By Sachith on 22/02/23
                    action("Production Plan Report Sewing")
                    {
                        Caption = 'Production Plan Report';
                        Enabled = true;
                        RunObject = report ProductionPlanReport;
                        ApplicationArea = all;
                    }

                    //Done By Sachith on 22/02/23
                    action("Size Colour Wise Quantity Breakdown Report Sewing")
                    {
                        Caption = 'Size Colour Wise Quantity Breakdown';
                        Enabled = true;
                        RunObject = report SizeColourwiseQuantity;
                        ApplicationArea = all;
                    }

                    //Done By Sachith on 22/02/23
                    action("WIP Sewing")
                    {
                        Caption = 'WIP Report';
                        Enabled = true;
                        RunObject = report WIPReport;
                        ApplicationArea = all;
                    }
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
                action("Hourly Finishing")
                {
                    Caption = 'Hourly Finishing';
                    RunObject = Page "Hourly Finishing List";
                    ApplicationArea = all;
                }

                action("OMS Finishing")
                {
                    Caption = 'OMS List';
                    RunObject = Page OMSList;
                    ApplicationArea = all;
                }
                action("Output Journal")
                {
                    Caption = 'Output Journal';
                    RunObject = Page "Output Journal";
                    ApplicationArea = all;
                }

                group("Finishing Reports")
                {
                    Caption = 'Finishing Reports';

                    // action("Weekly Order Booking")
                    // {
                    //     Caption = 'Weekly Order Booking';
                    //     Enabled = true;
                    //     RunObject = report WeeklyOrderBookingStatus;
                    //     ApplicationArea = all;
                    // }

                    //Done By Sachith on 22/02/23
                    action("Accessory Finishing")
                    {
                        Caption = 'Accessory Status Report';
                        Enabled = true;
                        RunObject = report AccessoriesStatusReportNew;
                        ApplicationArea = all;
                    }

                    action("Finishing Out Report")
                    {
                        Caption = 'Finishing Out Report';
                        Enabled = true;
                        RunObject = report FinishingOutReport;
                        ApplicationArea = all;
                    }

                    action("Finishing Production Report")
                    {
                        Caption = 'Hourly Finishing Production Report';
                        Enabled = true;
                        RunObject = report FinishingProductionReport;
                        ApplicationArea = all;
                    }
                    action("Hourly Production Report Finishing")
                    {
                        Caption = 'Hourly Production Report';
                        Enabled = true;
                        RunObject = report HourlyProductionReport;
                        ApplicationArea = all;
                    }


                    //Done By Sachith on 08/03/23
                    action("Line in Out Report Finishing")
                    {
                        Caption = 'Line In & Out Report';
                        Enabled = true;
                        RunObject = report lineinoutReport;
                        ApplicationArea = All;
                    }

                    //Done By Sachith on 06/05/23
                    action("OMS Report Finishing")
                    {
                        Caption = 'OMS Report';
                        Enabled = true;
                        RunObject = report OMSReport;
                        ApplicationArea = all;
                    }

                    action("Production Plan Report3")
                    {
                        Caption = 'Production Plan Report';
                        Enabled = true;
                        RunObject = report ProductionPlanReport;
                        ApplicationArea = all;
                    }

                    action("Ship Out Report")
                    {
                        Caption = 'Ship Out Report';
                        Enabled = true;
                        RunObject = report ShipOutReport;
                        ApplicationArea = all;
                    }

                    //Done By Sachith on 22/02/23
                    action("Size Colour Wise Quantity Breakdown Report Finishing")
                    {
                        Caption = 'Size Colour Wise Quantity Breakdown';
                        Enabled = true;
                        RunObject = report SizeColourwiseQuantity;
                        ApplicationArea = all;
                    }

                    //Done By Sachith on 22/02/23
                    action("WIP Finishing")
                    {
                        Caption = 'WIP Report';
                        Enabled = true;
                        RunObject = report WIPReport;
                        ApplicationArea = all;
                    }
                }
            }

            group("Samples")
            {
                Caption = 'Samples';

                // action("Sample Request1")
                // {
                //     Caption = 'Sample Request';
                //     RunObject = Page "Sample Request";
                //     ApplicationArea = all;
                // }
                action("OMS Sample")
                {
                    Caption = 'OMS List';
                    RunObject = Page OMSList;
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

                action("YY Requsition samples")
                {
                    Caption = 'YY Requisition';
                    RunObject = Page "YY Requsition List";
                    ApplicationArea = all;
                }
                group("Sample Reports")
                {
                    // action("Hourly Production Report Sample")
                    // {
                    //     Caption = 'Hourly Production Report';
                    //     Enabled = true;
                    //     RunObject = report HourlyProductionReport;
                    //     ApplicationArea = all;
                    // }

                    action("Sample Request Report - sample")
                    {
                        Caption = 'Sample Requisition Report';
                        Enabled = true;
                        RunObject = report SampleRequest;
                        ApplicationArea = all;
                    }

                    action("Sample Requirement Details Report")
                    {
                        Caption = 'Sample Requirement Details Report';
                        Enabled = true;
                        RunObject = report SampleRequirementDetails;
                        ApplicationArea = all;
                    }
                    action("Pattern Report")
                    {
                        Caption = 'Pattern Report';
                        Enabled = true;
                        RunObject = report PatternReport;
                        ApplicationArea = all;
                    }
                    action("Pattern Cutting Report")
                    {
                        Caption = 'Pattern Cutting Report';
                        Enabled = true;
                        RunObject = report PatternCuttingReport;
                        ApplicationArea = all;
                    }
                    action("Fabric Cutting Report")
                    {
                        Caption = 'Fabric Cutting Report';
                        Enabled = true;
                        RunObject = report FabricCuttingReport;
                        ApplicationArea = all;
                    }
                    action("Sewing Report")
                    {
                        Caption = 'Sewing Report';
                        Enabled = true;
                        RunObject = report SewingReport;
                        ApplicationArea = all;
                    }
                    action("Quality Checking Report")
                    {
                        Caption = 'Quality Checking Report';
                        Enabled = true;
                        RunObject = report QualityCheckingReport;
                        ApplicationArea = all;
                    }
                    action("Send Merchant for Washing Report")
                    {
                        Caption = 'Send For Washing Report';
                        Enabled = true;
                        RunObject = report SendWashingReport;
                        ApplicationArea = all;
                    }
                    action("Receieve from Washing Report")
                    {
                        Caption = 'Received From Washing Report';
                        Enabled = true;
                        RunObject = report ReceieveFromWashingReport;
                        ApplicationArea = all;
                    }
                    action("Sample Finishing Report")
                    {
                        Caption = 'Sample Finishing Report';
                        Enabled = true;
                        RunObject = report SampleFinishingReport;
                        ApplicationArea = all;
                    }
                    action("Finishing Quality Report")
                    {
                        Caption = 'Finishing Quality Report';
                        Enabled = true;
                        RunObject = report FinishingQualityReport;
                        ApplicationArea = all;
                    }

                }
            }

            //Industrial Engineering
            group("Industrial Engineering")
            {
                Caption = 'Industrial Engineering';

                action("Copy Breakdown")
                {
                    Caption = 'Copy Breakdown';
                    RunObject = Page "Copy Breakdown Card";
                    ApplicationArea = all;
                }

                action("Costing Planning Para List")
                {
                    Caption = 'Costing And Planning Parameters';
                    RunObject = page "Costing Planning Para Card";

                    ApplicationArea = all;
                }

                action("Factory Manpower Budget Vs Actual")
                {
                    Caption = 'Factory Manpower Budget Vs Actual';
                    RunObject = Page "Factory Manpower Budget List";
                    ApplicationArea = all;
                }

                action("Planed Machine Requirment")
                {
                    Caption = 'Planed Machine Requirment';
                    RunObject = Page FactoryAndMachineReq;
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
                action("OMS IE")
                {
                    Caption = 'OMS List';
                    RunObject = Page OMSList;
                    ApplicationArea = all;
                }

                action("Style Change IE")
                {
                    Caption = 'Style Change';
                    RunObject = Page StyleChangeCard;
                    ApplicationArea = all;
                }

                action("Style Wise Machine Req")
                {
                    Caption = 'Style Wise Machine Requirement';
                    RunObject = Page MachineRequestList;
                    ApplicationArea = all;
                }

                action("Style SMV Pending List")
                {
                    Caption = 'SMV Pending Style List';
                    RunObject = Page "Style SMV Pending List";
                    ApplicationArea = all;
                }

                group("Workstudy Reports")
                {
                    Caption = 'Workstudy Reports';
                    action("Hourly Production Report WorkStudy")
                    {
                        Caption = 'Hourly Production Report';
                        Enabled = true;
                        RunObject = report HourlyProductionReport;
                        ApplicationArea = all;
                    }
                    action("Manning Level Report")
                    {
                        Caption = 'Manning Level Report';
                        Enabled = true;
                        RunObject = report ManningLevelsReport;
                        ApplicationArea = all;
                    }

                    action("Machine Layout Report")
                    {
                        Caption = 'Machine Layout Report';
                        Enabled = true;
                        RunObject = report MachineLayoutReport;
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

                    action("Style Analysis Report")
                    {
                        Caption = 'Style Analysis Report';
                        Enabled = true;
                        RunObject = report StyleAnalysis;
                        ApplicationArea = all;
                    }

                    // action("Summary of Worker Manpower Report")
                    // {
                    //     Caption = 'Summary of Worker Manpower Report';
                    //     Enabled = true;
                    //     RunObject = report ManpowerBudgetReport;
                    //     ApplicationArea = all;
                    // }
                }
            }

            group("Washing")
            {
                Caption = 'Washing';

                action("OMS Washing")
                {
                    Caption = 'OMS List';
                    RunObject = Page OMSList;
                    ApplicationArea = all;
                }
                action("Sample Requests")
                {
                    Caption = ' Washing Requisition';
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

                action("SampleWashingRequestsWIP")
                {
                    RunObject = page SampleWashingRequestsWIP;
                    ApplicationArea = All;
                    Caption = 'Washing Requests WIP';
                }

                group("Washing Reports")
                {
                    Caption = 'Washing Reports';

                    action("AW QC Report")
                    {
                        Caption = 'AW QC Report';
                        Enabled = true;
                        RunObject = report AWQCReport;
                        ApplicationArea = all;
                    }

                    action("BW QC Report")
                    {
                        Caption = 'BW QC Report';
                        Enabled = true;
                        RunObject = report BWQCReport;
                        ApplicationArea = all;
                    }

                    //Done By Sachith 10/03/23
                    action("Delivery Details Washing")
                    {
                        Caption = 'Delivery Details';
                        Enabled = true;
                        RunObject = report DeliveryInfoProductReport;
                        ApplicationArea = all;
                    }

                    action("Job Card Report")
                    {
                        Caption = 'Job Card Report';
                        Enabled = true;
                        RunObject = report JobCardReport;
                        ApplicationArea = all;
                    }

                    //Done By Sachith 10/03/23
                    action("Production Plan Report Washing")
                    {
                        Caption = 'Production Plan Report';
                        Enabled = true;
                        RunObject = report ProductionPlanReport;
                        ApplicationArea = all;
                    }

                    action("Size Colour Wise Quantity Breakdown Report Finishing6")
                    {
                        Caption = 'Size Colour Wise Quantity Breakdown';
                        Enabled = true;
                        RunObject = report SizeColourwiseQuantity;
                        ApplicationArea = all;
                    }

                    action("Washing Requisition Report")
                    {
                        Caption = 'Washing Requisition Report';
                        Enabled = true;
                        RunObject = report WashSampleReqReport;
                        ApplicationArea = all;
                    }

                    action("Washing Send & Received Report")
                    {
                        Caption = 'Washing Send & Received Report';
                        Enabled = true;
                        RunObject = report WashingSendReceiveReport;
                        ApplicationArea = all;
                    }


                    action("WIP3")
                    {
                        Caption = 'WIP Report';
                        Enabled = true;
                        RunObject = report WIPReport;
                        ApplicationArea = all;
                    }
                }
            }

            group("Service Mgt")
            {
                Caption = 'Service Mgt';

                action("OMS Service")
                {
                    Caption = 'OMS List';
                    RunObject = Page OMSList;
                    ApplicationArea = all;
                }
                action("Item2")
                {
                    Caption = 'Item';
                    RunObject = Page "Item List";
                    ApplicationArea = all;
                }

                action("Service Machine Master")
                {
                    Caption = 'Service Machine Master';
                    RunObject = Page "Service Item List";
                    ApplicationArea = all;
                }

                // action("Standard Service Codes")
                // {
                //     Caption = 'Standard Service Codes';
                //     RunObject = Page "Standard Service Codes";
                //     ApplicationArea = all;
                // }

                action("Service Schedule")
                {
                    Caption = 'Service Schedule';
                    RunObject = Page ServiceScheduleList;
                    ApplicationArea = all;
                }

                action("Service Worksheet")
                {
                    Caption = 'Service Worksheet';
                    RunObject = Page "Service Wrks List";
                    ApplicationArea = all;
                }

                action(Technician)
                {
                    Caption = 'Technician';
                    RunObject = Page TechnicianList;
                    ApplicationArea = all;
                }

                // action("Gate Pass")
                // {
                //     Caption = 'Gate Pass';
                //     RunObject = page "Gate Pass List";
                //     ApplicationArea = All;
                // }
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

                action("ContractLC1")
                {
                    Caption = 'Contract/Master LC';
                    RunObject = Page "Contract/LC List";
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

                action("Export Reference List")
                {
                    Caption = 'Export Reference List';
                    RunObject = Page "Export Reference List";
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
                action("LC Master")
                {
                    Caption = 'Master LC';
                    RunObject = Page "LC Master List";
                    ApplicationArea = all;
                }
                action("OMS")
                {
                    Caption = 'OMS List';
                    RunObject = Page OMSList;
                    ApplicationArea = all;
                }
                action("Order Shipping Export List")
                {
                    Caption = 'Order Shipping Export List';
                    RunObject = Page OrderShippingList;
                    ApplicationArea = all;
                }

                action("Sales Order List")
                {
                    Caption = 'Sales Orders';
                    RunObject = Page "Sales Order List";
                    ApplicationArea = all;
                }

                action("Sales Invoices")
                {
                    Caption = 'Posted Sales Invoices';
                    RunObject = Page "Posted Sales Invoices";
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

                action("Contract BBLC Summary List")
                {
                    Caption = 'Contract BBLC Summary List';
                    RunObject = Page "Contract BBLC Summary List";
                    ApplicationArea = all;
                }

                action("Utilization Declaration (UD)")
                {
                    Caption = 'Utilization Declaration (UD) List';
                    RunObject = Page "UD List";
                    ApplicationArea = all;
                }
                action("Sales Invoice Header Temp")
                {
                    Caption = 'Sales Invoice Header Temp';
                    RunObject = Page PostedSalesInvoiceTemp;
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

                    //Done By Sachith 13/03/23
                    action("Estimate Costing Report Commercial")
                    {
                        Caption = 'Estimate Costing Report';
                        Enabled = true;
                        RunObject = report EstimateCostSheetReport;
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

                    //Done By Sachith on 06/05/23
                    action("OMS Report Commercial")
                    {
                        Caption = 'OMS Report';
                        Enabled = true;
                        RunObject = report OMSReport;
                        ApplicationArea = all;
                    }

                    action("Shipment Summary Report")
                    {
                        Caption = 'Shipment Summary As Per SC/UD';
                        Enabled = true;
                        RunObject = report ShipementSummaryReport;
                        ApplicationArea = all;
                    }

                    action("Sales Contract Report")
                    {
                        Caption = 'Sales Contract Report';
                        Enabled = true;
                        RunObject = report SalesContractReport;
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
                action("OMS Quality")
                {
                    Caption = 'OMS List';
                    RunObject = Page OMSList;
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
                    action("Fabric Inspection Report")
                    {
                        Caption = 'Fabric Inspection Report';
                        Enabled = true;
                        RunObject = report FabricInspectionReportQuality;
                        ApplicationArea = all;
                    }
                    action("Hourly Production Report Quality")
                    {
                        Caption = 'Hourly Production Report';
                        Enabled = true;
                        RunObject = report HourlyProductionReport;
                        ApplicationArea = all;
                    }

                    //Done By Sachith on 06/05/23
                    action("OMS Report Quality")
                    {
                        Caption = 'OMS Report';
                        Enabled = true;
                        RunObject = report OMSReport;
                        ApplicationArea = all;
                    }

                    action("Size Colour Wise Quantity Breakdown Report Finishing7")
                    {
                        Caption = 'Size Colour Wise Quantity Breakdown';
                        Enabled = true;
                        RunObject = report SizeColourwiseQuantity;
                        ApplicationArea = all;
                    }
                    action("Trim Inspection Report")
                    {
                        Caption = 'Trim Inspection Report';
                        Enabled = true;
                        RunObject = report TrimInspectionReport;
                        ApplicationArea = all;
                    }
                    action("WIP4")
                    {
                        Caption = 'WIP Report';
                        Enabled = true;
                        RunObject = report WIPReport;
                        ApplicationArea = all;
                    }
                }
            }

            // group("Finance")
            // {
            //     Caption = 'Finance';

            //     action("General Journals")
            //     {
            //         Caption = 'General Journals';
            //         RunObject = Page "General Journal";
            //         ApplicationArea = all;
            //     }

            //     action("Chart Of Accounts")
            //     {
            //         Caption = 'Chart Of Accounts';
            //         RunObject = Page "Chart of Accounts";
            //         ApplicationArea = all;
            //     }

            //     action("GL Account Categories")
            //     {
            //         Caption = 'GL Account Categories';
            //         RunObject = Page "G/L Account Categories";
            //         ApplicationArea = all;
            //     }

            //     action("GL Budgets")
            //     {
            //         Caption = 'GL Budgets';
            //         RunObject = Page "G/L Budget Entries";
            //         ApplicationArea = all;
            //     }

            //     action("Fixed Assets")
            //     {
            //         Caption = 'Fixed Assets';
            //         RunObject = Page "Fixed Asset List";
            //         ApplicationArea = all;
            //     }

            //     action("Account Schedules")
            //     {
            //         Caption = 'Account Schedules';
            //         RunObject = Page "Account Schedule";
            //         ApplicationArea = all;
            //     }

            //     action("Intrastat Journals")
            //     {
            //         Caption = 'Intrastat Journals';
            //         RunObject = Page "Intrastat Journal";
            //         ApplicationArea = all;
            //     }

            //     action("Sales Budgets")
            //     {
            //         Caption = 'Sales Budgets';
            //         RunObject = Page "Sales Budget Overview";
            //         ApplicationArea = all;
            //     }

            //     action("Purchase Budgets")
            //     {
            //         Caption = 'Purchase Budgets';
            //         RunObject = Page "Purchase Budget Overview";
            //         ApplicationArea = all;
            //     }

            //     action("Sales Analysis Reports")
            //     {
            //         Caption = 'Sales Analysis Reports';
            //         RunObject = Page "Sales Analysis Report";
            //         ApplicationArea = all;
            //     }

            //     action("Purchase Analysis Reports")
            //     {
            //         Caption = 'Purchase Analysis Reports';
            //         RunObject = Page "Purchase Analysis Report";
            //         ApplicationArea = all;
            //     }

            //     action("Inventory Analysis Reports")
            //     {
            //         Caption = 'Inventory Analysis Reports';
            //         RunObject = Page "Inventory Analysis Report";
            //         ApplicationArea = all;
            //     }

            //     action("VAT Returns")
            //     {
            //         Caption = 'VAT Returns';
            //         RunObject = Page "VAT Return Period List";
            //         ApplicationArea = all;
            //     }

            //     action("Currencies")
            //     {
            //         Caption = 'Currencies';
            //         RunObject = Page Currencies;
            //         ApplicationArea = all;
            //     }

            //     action("Employees")
            //     {
            //         Caption = 'Employees';
            //         RunObject = Page "Employee List";
            //         ApplicationArea = all;
            //     }

            //     action("VAT Statements")
            //     {
            //         Caption = 'VAT Statements';
            //         RunObject = Page "VAT Statement";
            //         ApplicationArea = all;
            //     }

            //     action("Dimensions")
            //     {
            //         Caption = 'Dimensions';
            //         RunObject = Page "Dimension List";
            //         ApplicationArea = all;
            //     }

            //     action("Posted General Journals")
            //     {
            //         Caption = 'Posted General Journals';
            //         RunObject = Page "Posted General Journal";
            //         ApplicationArea = all;
            //     }

            //     group("Finance Reports")
            //     {
            //         Caption = 'Finance Reports';

            //         action("Statement Of Net Margin")
            //         {
            //             Caption = 'Statement Of Net Margin Report';
            //             Enabled = true;
            //             RunObject = report StatementOfNetMargin;
            //             ApplicationArea = all;
            //         }
            //     }
            // }

            // group("Purchasing")
            // {
            //     Caption = 'Purchasing';

            //     action("Vendors")
            //     {
            //         Caption = 'Vendors';
            //         RunObject = Page "Vendor List";
            //         ApplicationArea = all;
            //     }

            //     action("Incoming Documents")
            //     {
            //         Caption = 'Incoming Documents';
            //         RunObject = Page "Incoming Documents";
            //         ApplicationArea = all;
            //     }

            //     action("Item Charges")
            //     {
            //         Caption = 'Item Charges';
            //         RunObject = Page "Item Charges";
            //         ApplicationArea = all;
            //     }

            //     action("Purchase Quotes")
            //     {
            //         Caption = 'Purchase Quotes';
            //         RunObject = Page "Purchase Quotes";
            //         ApplicationArea = all;
            //     }

            //     action("Purchase Orders")
            //     {
            //         Caption = 'Purchase Orders';
            //         RunObject = Page "Purchase Order List";
            //         ApplicationArea = all;
            //     }

            //     action("Blanket Purchase Orders")
            //     {
            //         Caption = 'Blanket Purchase Orders';
            //         RunObject = Page "Blanket Purchase Orders";
            //         ApplicationArea = all;
            //     }

            //     action("Purchase Invoices")
            //     {
            //         Caption = 'Purchase Invoices';
            //         RunObject = Page "Purchase Invoices";
            //         ApplicationArea = all;
            //     }

            //     action("Purchase Credit Memos")
            //     {
            //         Caption = 'Purchase Credit Memos';
            //         RunObject = Page "Purchase Credit Memos";
            //         ApplicationArea = all;
            //     }

            //     action("Purchase Return Orders")
            //     {
            //         Caption = 'Purchase Return Orders';
            //         RunObject = Page "Purchase Return Orders";
            //         ApplicationArea = all;
            //     }

            //     action("Posted Purchase Invoices")
            //     {
            //         Caption = 'Posted Purchase Invoices';
            //         RunObject = Page "Posted Purchase Invoices";
            //         ApplicationArea = all;
            //     }

            //     action("Posted Purchase Credit Memo")
            //     {
            //         Caption = 'Posted Purchase Credit Memo';
            //         RunObject = Page "Posted Purchase Credit Memos";
            //         ApplicationArea = all;
            //     }

            //     action("Posted Purchase Receipts")
            //     {
            //         Caption = 'Posted Purchase Receipts';
            //         RunObject = Page "Posted Purchase Receipts";
            //         ApplicationArea = all;
            //     }

            //     action("Posted Purchase Return Shipments")
            //     {
            //         Caption = 'Posted Purchase Return Shipments';
            //         RunObject = Page "Posted Return Shipments";
            //         ApplicationArea = all;
            //     }

            //     group("Purchasing Reports")
            //     {
            //         Caption = 'Purchasing Reports';

            //         action("Bin Card Report")
            //         {
            //             Caption = 'Bin Card Report';
            //             Enabled = true;
            //             RunObject = report BinCardReport;
            //             ApplicationArea = all;
            //         }

            //         action("Goods Received Note1")
            //         {
            //             Caption = 'Goods Received Note';
            //             Enabled = true;
            //             RunObject = report GrnReport;
            //             ApplicationArea = all;
            //         }
            //     }
            // }

            // group("Sales")
            // {
            //     Caption = 'Sales';

            //     action("Item Chargess")
            //     {
            //         Caption = 'Item Charges';
            //         RunObject = Page "Item Charges";
            //         ApplicationArea = all;
            //     }

            //     action("Sales Quotes")
            //     {
            //         Caption = 'Sales Quotes';
            //         RunObject = Page "Sales Quotes";
            //         ApplicationArea = all;
            //     }

            //     action("Sales Orders")
            //     {
            //         Caption = 'Sales Orders';
            //         RunObject = Page "Sales Order list";
            //         ApplicationArea = all;
            //     }

            //     action("Blanket Sales Orders")
            //     {
            //         Caption = 'Blanket Sales Orders';
            //         RunObject = Page "Blanket Sales Orders";
            //         ApplicationArea = all;
            //     }

            //     action("Sales Invoices")
            //     {
            //         Caption = 'Sales Invoices';
            //         RunObject = Page "Sales Invoice List";
            //         ApplicationArea = all;
            //     }

            //     action("Sales Credit Memos")
            //     {
            //         Caption = 'Sales Credit Memos';
            //         RunObject = Page "Sales Credit Memos";
            //         ApplicationArea = all;
            //     }

            //     action("Sales Return Orders")
            //     {
            //         Caption = 'Sales Return Orders';
            //         RunObject = Page "Sales Return Orders";
            //         ApplicationArea = all;
            //     }

            //     action("Reminders")
            //     {
            //         Caption = 'Reminders';
            //         RunObject = Page "Reminder List";
            //         ApplicationArea = all;
            //     }

            //     action("Finance Charge Memo")
            //     {
            //         Caption = 'Finance Charge Memo';
            //         RunObject = Page "Finance Charge Memo List";
            //         ApplicationArea = all;
            //     }

            //     action("Posted Sales Invoices")
            //     {
            //         Caption = 'Posted Sales Invoices';
            //         RunObject = Page "Posted Sales Invoices";
            //         ApplicationArea = all;
            //     }

            //     action("Posted Sales Credit Memos")
            //     {
            //         Caption = 'Posted Sales Credit Memos';
            //         RunObject = Page "Posted Sales Credit Memos";
            //         ApplicationArea = all;
            //     }

            //     action("Posted Sales Shipments")
            //     {
            //         Caption = 'Posted Sales Shipments';
            //         RunObject = Page "Posted Sales Shipments";
            //         ApplicationArea = all;
            //     }

            //     action("Posted Sales Return Receipts")
            //     {
            //         Caption = 'Posted Sales Return Receipts';
            //         RunObject = Page "Posted Return Receipts";
            //         ApplicationArea = all;
            //     }

            //     action("Issued Reminders")
            //     {
            //         Caption = 'Issued Reminders';
            //         RunObject = Page "Issued Reminder List";
            //         ApplicationArea = all;
            //     }

            //     action("Issued Finance Charge Memo")
            //     {
            //         Caption = 'Issued Finance Charge Memo';
            //         RunObject = Page "Issued Fin. Charge Memo List";
            //         ApplicationArea = all;
            //     }

            //     action("Transfer Orders")
            //     {
            //         Caption = 'Transfer Orders';
            //         RunObject = Page "Transfer Orders";
            //         ApplicationArea = all;
            //     }
            // }

            group("Admin")
            {
                Caption = 'Admin';

                action("Create User")
                {
                    Caption = 'Create User';
                    RunObject = Page "User List";
                    ApplicationArea = all;
                }

                // Done By Sachith On 16/01/23
                action("User Roles")
                {
                    Caption = 'Worker Type';
                    RunObject = Page "Users Role List";
                    ApplicationArea = all;
                }

                action("Nav Apperal Setup")
                {
                    Caption = 'Apperal Setup';
                    RunObject = Page "NavApp Setup Card";
                    ApplicationArea = all;
                }
            }

            group("Dashboard")
            {
                Caption = 'Dashboard';

                group("Capacity By Pcs1")
                {
                    Caption = 'Capacity By Pcs';

                    action("Buyer Wise Order Booking1")
                    {
                        Caption = 'Buyer Wise Order Booking';
                        RunObject = Page BuyerWiseOrderBookingList;
                        ApplicationArea = all;
                    }
                }

                action("Capacity Utilization By SAH ")
                {
                    Caption = 'Capacity Utilization By SAH';
                    RunObject = Page SAH_CapacityAllocationList;
                    ApplicationArea = all;
                }

                action("Capacity Dashboard (Group/Factory Wise/Line Wise)")
                {
                    Caption = 'Capacity Dashboard (Group/Factory Wise/Line Wise)';
                    RunObject = Page CapacityDashboardList;
                    ApplicationArea = all;
                }

                action("Factory Wise Production Planning1")
                {
                    Caption = 'Factory Wise Production Planning';
                    RunObject = Page FacWiseProductplaningHdrList;
                    ApplicationArea = all;
                }
                action("GroupWiseStockBalanceDashboard")
                {
                    Caption = 'Group Wise Stock Balance';
                    RunObject = Page GroupWiseStockBalance;
                    ApplicationArea = all;
                }

                action("Style ChangeDashboard")
                {
                    Caption = 'Style Change';
                    RunObject = Page StyleChangeCard;
                    ApplicationArea = all;
                }

                action("MerchantWiseStockBalanceDashboard")
                {
                    Caption = 'Stock Summary';
                    RunObject = Page StockSummary;
                    ApplicationArea = all;
                }
                action("Planning Efficiency Dashboard1")
                {
                    Caption = 'Planning Efficiency Dashboard';
                    RunObject = Page "Planning Efficiency Dashboard1";
                    ApplicationArea = all;
                }
                group("Dashboard Reports")
                {
                    action("Finishing Production Report Dashboard")
                    {
                        Caption = 'Hourly Finishing Production Report';
                        Enabled = true;
                        RunObject = report FinishingProductionReport;
                        ApplicationArea = all;
                    }
                    action("Hourly Production Report Dashboard")
                    {
                        Caption = 'Hourly Production Report';
                        Enabled = true;
                        RunObject = report HourlyProductionReport;
                        ApplicationArea = all;
                    }

                }
            }

        }

        // area(Creation)
        // {
        //     action("Visual Planning")
        //     {
        //         Caption = 'Visual Planning';
        //         RunObject = Page NETRONICVSDevToolDemoAppPage;
        //         ApplicationArea = all;
        //     }
        // }
    }

    var

        PreProdfollowup: Page PreProductionfollowup;

}


profile NAVAPP
{
    ProfileDescription = 'Nav Apperal Profile';
    RoleCenter = "Nav Apperal Role Center";
    Caption = 'NAVAPP Profile Admin';
}

