page 71012769 "BOM Estimate Cost Card"
{
    PageType = Card;
    SourceTable = "BOM Estimate Cost";
    Caption = 'Estimate Costing';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")   //This is Cost Sheet No
                {
                    ApplicationArea = All;
                    Caption = 'Cost Sheet No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("BOM No."; "BOM No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Estimate BOM No';

                    trigger OnValidate()
                    var
                        BOMRec: Record "BOM Estimate";
                        CustomerRec: Record Customer;
                        BOMEstCostRec: Record "BOM Estimate Cost";
                        StyleRec: Record "Style Master";
                        NavAppSetup: Record "NavApp Setup";
                        CostPlanParaLineRec: Record CostingPlanningParaLine;
                    begin

                        if "FOB Pcs" = 0 then
                            "FOB Pcs" := 1;

                        //Check for duplicates
                        BOMEstCostRec.Reset();
                        BOMEstCostRec.SetRange("BOM No.", "BOM No.");
                        if BOMEstCostRec.FindSet() then
                            Error('Estimate BOM : %1 already used to create a Estimate Cost Sheet', BOMEstCostRec."BOM No.");

                        NavAppSetup.Get('0001');
                        "Risk factor %" := NavAppSetup."Risk Factor";
                        "TAX %" := NavAppSetup.TAX;
                        "ABA Sourcing %" := NavAppSetup."ABA Sourcing";

                        BOMRec.get("BOM No.");
                        "Style No." := BOMRec."Style No.";
                        "Style Name" := BOMRec."Style Name";
                        "Store No." := BOMRec."Store No.";
                        "Brand No." := BOMRec."Brand No.";
                        "Buyer No." := BOMRec."Buyer No.";
                        "Season No." := BOMRec."Season No.";
                        "Department No." := BOMRec."Department No.";
                        "Garment Type No." := BOMRec."Garment Type No.";

                        "Store Name" := BOMRec."Store Name";
                        "Brand Name" := BOMRec."Brand Name";
                        "Buyer Name" := BOMRec."Buyer Name";
                        "Season Name" := BOMRec."Season Name";
                        "Department Name" := BOMRec."Department Name";
                        "Garment Type Name" := BOMRec."Garment Type Name";
                        Quantity := BOMRec.Quantity;

                        CustomerRec.get("Buyer No.");
                        "Currency No." := CustomerRec."Currency Code";

                        LoadCategoryDetails();
                        CalRawMat();

                        //Get Costing SMV
                        StyleRec.Reset();
                        StyleRec.SetRange("No.", BOMRec."Style No.");
                        StyleRec.FindSet();

                        if StyleRec.CostingSMV = 0 then
                            Error('Costing SMV is zero')
                        else begin
                            SMV := StyleRec.CostingSMV;

                            //Get Project efficiency                          
                            CostPlanParaLineRec.Reset();
                            CostPlanParaLineRec.SetFilter("From SMV", '<=%1', SMV);
                            CostPlanParaLineRec.SetFilter("To SMV", '>=%1', SMV);
                            CostPlanParaLineRec.SetFilter("From Qty", '<=%1', Quantity);
                            CostPlanParaLineRec.SetFilter("To Qty", '>=%1', Quantity);
                            if CostPlanParaLineRec.FindSet() then
                                "Project Efficiency." := CostPlanParaLineRec."Costing Eff%"
                            else
                                Error('Project efficiency is not setup in the Costing/Planning Parameter');
                        end;

                        CalMFGCost();
                        CalTotalCost();

                    end;
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Style';
                }

                field("Store Name"; "Store Name")
                {
                    ApplicationArea = All;
                    Caption = 'Store';
                    Editable = false;

                    trigger OnValidate()
                    var
                        GarmentStoreRec: Record "Garment Store";
                    begin
                        GarmentStoreRec.Reset();
                        GarmentStoreRec.SetRange("Store Name", "Store Name");
                        if GarmentStoreRec.FindSet() then
                            "Store No." := GarmentStoreRec."No.";
                    end;
                }

                field("Brand Name"; "Brand Name")
                {
                    ApplicationArea = All;
                    Caption = 'Brand';
                    Editable = false;

                    trigger OnValidate()
                    var
                        BrandRec: Record "Brand";
                    begin
                        BrandRec.Reset();
                        BrandRec.SetRange("Brand Name", "Brand Name");
                        if BrandRec.FindSet() then
                            "Brand No." := BrandRec."No.";
                    end;
                }

                field("Buyer Name"; "Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                    Editable = false;

                    trigger OnValidate()
                    var
                        BuyerRec: Record Customer;
                    begin
                        BuyerRec.Reset();
                        BuyerRec.SetRange(Name, "Buyer Name");
                        if BuyerRec.FindSet() then begin
                            "Buyer No." := BuyerRec."No.";
                            "Currency No." := BuyerRec."Currency Code";
                        end;
                    end;
                }

                field("Season Name"; "Season Name")
                {
                    ApplicationArea = All;
                    Caption = 'Season';
                    Editable = false;

                    trigger OnValidate()
                    var
                        SeasonsRec: Record "Seasons";
                    begin
                        SeasonsRec.Reset();
                        SeasonsRec.SetRange("Season Name", "Season Name");
                        if SeasonsRec.FindSet() then
                            "Season No." := SeasonsRec."No.";
                    end;
                }

                field("Department Name"; "Department Name")
                {
                    ApplicationArea = All;
                    Caption = 'Department';
                    Editable = false;

                    trigger OnValidate()
                    var
                        DepartmentRec: Record "Department Style";
                    begin
                        DepartmentRec.Reset();
                        DepartmentRec.SetRange("Department Name", "Department Name");
                        if DepartmentRec.FindSet() then
                            "Department No." := DepartmentRec."No.";
                    end;

                }

                field("Garment Type Name"; "Garment Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Garment Type';
                    Editable = false;

                    trigger OnValidate()
                    var
                        GarmentTypeRec: Record "Garment Type";
                    begin
                        GarmentTypeRec.Reset();
                        GarmentTypeRec.SetRange("Garment Type Description", "Garment Type Name");
                        if GarmentTypeRec.FindSet() then
                            "Garment Type No." := GarmentTypeRec."No.";
                    end;
                }

                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Currency No."; "Currency No.")
                {
                    ApplicationArea = All;
                    Caption = 'Currency';
                    Editable = false;
                }
            }

            group("Base on BOM")
            {
                part("BOM EstimateCost Line Listpart"; "BOM EstimateCost Line Listpart")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "No." = field("No."), "BOM No." = field("BOM No.");
                }
            }

            group("Cost")
            {
                field("Raw Material (Dz.)"; "Raw Material (Dz.)")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var

                    begin
                        "Sub Total (Dz.) Dz." := "Raw Material (Dz.)" + "Embroidery (Dz.)" + "Printing (Dz.)" + "Washing (Dz.)" + "Others (Dz.)";
                        "Sub Total (Dz.) Pcs" := "Sub Total (Dz.) Dz." / 12;
                        "Sub Total (Dz.) Total" := "Sub Total (Dz.) Pcs" * Quantity;

                        "Gross CM With Commission Dz." := "FOB Dz." - "Sub Total (Dz.) Dz." - "Commission Dz." - "Deferred Payment Dz.";
                        "Gross CM With Commission Pcs" := "Gross CM With Commission Dz." / 12;

                        if "FOB Pcs" = 0 then
                            "Gross CM With Commission %" := 0
                        else
                            "Gross CM With Commission %" := ("Gross CM With Commission Pcs" / "FOB Pcs") * 100;

                        "Gross CM With Commission Total" := "Gross CM With Commission Pcs" * Quantity;

                        CalTotalCost();
                    end;
                }

                field("Embroidery (Dz.)"; "Embroidery (Dz.)")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var

                    begin
                        "Sub Total (Dz.) Dz." := "Raw Material (Dz.)" + "Embroidery (Dz.)" + "Printing (Dz.)" + "Washing (Dz.)" + "Others (Dz.)";
                        "Sub Total (Dz.) Pcs" := "Sub Total (Dz.) Dz." / 12;
                        "Sub Total (Dz.) Total" := "Sub Total (Dz.) Pcs" * Quantity;

                        "Gross CM With Commission Dz." := "FOB Dz." - "Sub Total (Dz.) Dz." - "Commission Dz." - "Deferred Payment Dz.";
                        "Gross CM With Commission Pcs" := "Gross CM With Commission Dz." / 12;

                        if "FOB Pcs" = 0 then
                            "Gross CM With Commission %" := 0
                        else
                            "Gross CM With Commission %" := ("Gross CM With Commission Pcs" / "FOB Pcs") * 100;

                        "Gross CM With Commission Total" := "Gross CM With Commission Pcs" * Quantity;

                        CalTotalCost();
                    end;
                }

                field("Printing (Dz.)"; "Printing (Dz.)")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var

                    begin
                        "Sub Total (Dz.) Dz." := "Raw Material (Dz.)" + "Embroidery (Dz.)" + "Printing (Dz.)" + "Washing (Dz.)" + "Others (Dz.)";
                        "Sub Total (Dz.) Pcs" := "Sub Total (Dz.) Dz." / 12;
                        "Sub Total (Dz.) Total" := "Sub Total (Dz.) Pcs" * Quantity;

                        "Gross CM With Commission Dz." := "FOB Dz." - "Sub Total (Dz.) Dz." - "Commission Dz." - "Deferred Payment Dz.";
                        "Gross CM With Commission Pcs" := "Gross CM With Commission Dz." / 12;

                        if "FOB Pcs" = 0 then
                            "Gross CM With Commission %" := 0
                        else
                            "Gross CM With Commission %" := ("Gross CM With Commission Pcs" / "FOB Pcs") * 100;


                        "Gross CM With Commission Total" := "Gross CM With Commission Pcs" * Quantity;

                        CalTotalCost();
                    end;
                }

                field("Washing (Dz.)"; "Washing (Dz.)")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var

                    begin
                        "Sub Total (Dz.) Dz." := "Raw Material (Dz.)" + "Embroidery (Dz.)" + "Printing (Dz.)" + "Washing (Dz.)" + "Others (Dz.)";
                        "Sub Total (Dz.) Pcs" := "Sub Total (Dz.) Dz." / 12;
                        "Sub Total (Dz.) Total" := "Sub Total (Dz.) Pcs" * Quantity;

                        "Gross CM With Commission Dz." := "FOB Dz." - "Sub Total (Dz.) Dz." - "Commission Dz." - "Deferred Payment Dz.";
                        "Gross CM With Commission Pcs" := "Gross CM With Commission Dz." / 12;

                        if "FOB Pcs" = 0 then
                            "Gross CM With Commission %" := 0
                        else
                            "Gross CM With Commission %" := ("Gross CM With Commission Pcs" / "FOB Pcs") * 100;

                        "Gross CM With Commission Total" := "Gross CM With Commission Pcs" * Quantity;

                        CalTotalCost();
                    end;
                }

                field("Others (Dz.)"; "Others (Dz.)")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var

                    begin
                        "Sub Total (Dz.) Dz." := "Raw Material (Dz.)" + "Embroidery (Dz.)" + "Printing (Dz.)" + "Washing (Dz.)" + "Others (Dz.)";
                        "Sub Total (Dz.) Pcs" := "Sub Total (Dz.) Dz." / 12;
                        "Sub Total (Dz.) Total" := "Sub Total (Dz.) Pcs" * Quantity;

                        "Gross CM With Commission Dz." := "FOB Dz." - "Sub Total (Dz.) Dz." - "Commission Dz." - "Deferred Payment Dz.";
                        "Gross CM With Commission Pcs" := "Gross CM With Commission Dz." / 12;

                        if "FOB Pcs" = 0 then
                            "Gross CM With Commission %" := 0
                        else
                            "Gross CM With Commission %" := ("Gross CM With Commission Pcs" / "FOB Pcs") * 100;

                        "Gross CM With Commission Total" := "Gross CM With Commission Pcs" * Quantity;

                        CalTotalCost();
                    end;
                }

                field(Rate; Rate)
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Stich Gmt Name"; "Stich Gmt Name")
                {
                    ApplicationArea = All;
                    Caption = 'Stich Gmt';

                    trigger OnValidate()
                    var
                        StRec: Record "Stich Gmt";
                    begin

                        StRec.Reset();
                        StRec.SetRange("Stich Gmt Name", "Stich Gmt Name");
                        if StRec.FindSet() then
                            "Stich Gmt" := StRec."No.";

                    end;
                }

                field("Print Type Name"; "Print Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Print Type';

                    trigger OnValidate()
                    var
                        PTRec: Record "Print Type";
                    begin

                        PTRec.Reset();
                        PTRec.SetRange("Print Type Name", "Print Type Name");
                        if PTRec.FindSet() then
                            "Print Type" := PTRec."No.";

                    end;
                }

                field("Wash Type Name"; "Wash Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Wash Type';

                    trigger OnValidate()
                    var
                        WTRec: Record "Wash Type";
                    begin

                        WTRec.Reset();
                        WTRec.SetRange("Wash Type Name", "Wash Type Name");
                        if WTRec.FindSet() then
                            "Wash Type" := WTRec."No.";

                    end;
                }

            }

            group("CM Calculation")
            {
                field("Factory Name"; "Factory Name")
                {
                    ApplicationArea = All;
                    Caption = 'Factory';

                    trigger OnValidate()
                    var
                        Locationrec: Record Location;
                        FacCPMRec: Record "Factory CPM";
                        LineNo: Integer;
                    begin
                        Locationrec.Reset();
                        Locationrec.SetRange(Name, "Factory Name");
                        if Locationrec.FindSet() then
                            "Factory Code" := Locationrec.Code;

                        //Get Max line no
                        FacCPMRec.Reset();
                        FacCPMRec.SetRange("Factory Code", Locationrec.Code);

                        if FacCPMRec.FindLast() then begin
                            CPM := FacCPMRec.CPM;
                            CurrPage.Update();
                            CalMFGCost();
                            CalTotalCost();
                        end
                        else
                            Error('CPM is not setup for the factory : %1', "Factory Name");

                        CurrPage.Update();
                    end;
                }

                field(SMV; SMV)
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnValidate()
                    var
                    begin
                        CalMFGCost();
                        CalTotalCost();
                    end;
                }

                field(CPM; CPM)
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnValidate()
                    var
                    begin
                        CalMFGCost();
                        CalTotalCost();
                    end;
                }

                field("Project Efficiency."; "Project Efficiency.")
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnValidate()
                    var
                    begin
                        CalMFGCost();
                        CalTotalCost();
                    end;
                }

                field(EPM; EPM)   //Margin
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalMFGCost();
                        CalTotalCost();
                    end;
                }


                field("CM Doz"; "CM Doz")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Status; Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                    caption = 'Status';
                }
            }

            group("  ")
            {
                grid("")
                {
                    GridLayout = Rows;
                    group("Sub Total (Dz.)")
                    {
                        field("Sub Total (Dz.)%"; "Sub Total (Dz.)%")
                        {
                            ApplicationArea = All;
                            Caption = '%';
                            Editable = false;
                        }

                        field("Sub Total (Dz.) Pcs"; "Sub Total (Dz.) Pcs")
                        {
                            ApplicationArea = All;
                            Caption = 'Pcs';
                            Editable = false;
                        }

                        field("Sub Total (Dz.) Dz."; "Sub Total (Dz.) Dz.")
                        {
                            ApplicationArea = All;
                            Caption = 'Dz.';
                            Editable = false;
                        }

                        field("Sub Total (Dz.) Total"; "Sub Total (Dz.) Total")
                        {
                            ApplicationArea = All;
                            Caption = 'Total';
                            Editable = false;
                        }
                    }
                    group("FOB")
                    {
                        field("FOB %"; "FOB %")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("FOB Pcs"; "FOB Pcs")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            StyleExpr = 'StrongAccent';

                            trigger OnValidate()
                            var

                            begin
                                FOB_Change();
                            end;
                        }

                        field("FOB Dz."; "FOB Dz.")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("FOB Total"; "FOB Total")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }
                    }

                    group("Gross CM With Commission ")
                    {
                        field("Gross CM With Commission %"; "Gross CM With Commission %")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("Gross CM With Commission Pcs"; "Gross CM With Commission Pcs")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("Gross CM With Commission Dz."; "Gross CM With Commission Dz.")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("Gross CM With Commission Total"; "Gross CM With Commission Total")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }
                    }

                    group("MFG Cost")
                    {
                        field("MFG Cost %"; "MFG Cost %")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("MFG Cost Pcs"; "MFG Cost Pcs")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("MFG Cost Dz."; "MFG Cost Dz.")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            StyleExpr = 'StrongAccent';

                            trigger OnValidate()
                            var

                            begin
                                "MFG Cost Pcs" := "MFG Cost Dz." / 12;
                                "MFG Cost Total" := "MFG Cost Pcs" * Quantity;

                                if "FOB Pcs" <> 0 then
                                    "MFG Cost %" := ("MFG Cost Pcs" * 100 / "FOB Pcs");

                                // "Commercial Pcs" := ("Commercial %" * "FOB Pcs") / 100;
                                // "Commercial Dz." := "Commercial Pcs" * 12;
                                // "Commercial Total" := "Commercial Pcs" * Quantity;

                                CalTotalCost();
                            end;
                        }

                        field("MFG Cost Total"; "MFG Cost Total")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;

                        }
                    }

                    group("Overhead")
                    {
                        field("Overhead %"; "Overhead %")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            StyleExpr = 'StrongAccent';

                            trigger OnValidate()
                            var

                            begin
                                "Overhead Pcs" := ("Overhead %" * "FOB Pcs") / 100;
                                "Overhead Dz." := "Overhead Pcs" * 12;
                                "Overhead Total" := "Overhead Pcs" * Quantity;

                                "Deferred Payment Pcs" := ("Deferred Payment %" * "Overhead Pcs") / 100;
                                "Deferred Payment Dz." := "Deferred Payment Pcs" * 12;
                                "Deferred Payment Total" := "Deferred Payment Pcs" * Quantity;

                                CalTotalCost();
                            end;
                        }

                        field("Overhead Pcs"; "Overhead Pcs")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("Overhead Dz."; "Overhead Dz.")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("Overhead Total"; "Overhead Total")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }
                    }

                    group("Commission")
                    {
                        field("Commission %"; "Commission %")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            StyleExpr = 'StrongAccent';

                            trigger OnValidate()
                            var
                            begin
                                "Commission Pcs" := ("Commission %" * "FOB Pcs") / 100;
                                "Commission Dz." := "Commission Pcs" * 12;
                                "Commission Total" := "Commission Pcs" * Quantity;

                                "Gross CM With Commission Dz." := "FOB Dz." - "Sub Total (Dz.) Dz." - "Commission Dz." - "Deferred Payment Dz.";
                                "Gross CM With Commission Pcs" := "Gross CM With Commission Dz." / 12;
                                "Gross CM With Commission %" := ("Gross CM With Commission Pcs" / "FOB Pcs") * 100;
                                "Gross CM With Commission Total" := "Gross CM With Commission Pcs" * Quantity;

                                CalTotalCost();
                            end;
                        }

                        field("Commission Pcs"; "Commission Pcs")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("Commission Dz."; "Commission Dz.")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("Commission Total"; "Commission Total")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }
                    }

                    group("Commercial Cost")
                    {
                        field("Commercial %"; "Commercial %")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            StyleExpr = 'StrongAccent';

                            trigger OnValidate()
                            var
                            begin
                                "Commercial Pcs" := ("Commercial %" * "FOB Pcs") / 100;
                                "Commercial Dz." := "Commercial Pcs" * 12;
                                "Commercial Total" := "Commercial Pcs" * Quantity;

                                CalTotalCost();
                            end;
                        }

                        field("Commercial Pcs"; "Commercial Pcs")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("Commercial Dz."; "Commercial Dz.")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("Commercial Total"; "Commercial Total")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }
                    }

                    group("Deferred Payment")
                    {
                        field("Deferred Payment %"; "Deferred Payment %")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            StyleExpr = 'StrongAccent';

                            trigger OnValidate()
                            var

                            begin
                                "Deferred Payment Pcs" := ("Deferred Payment %" * "FOB Pcs") / 100;
                                "Deferred Payment Dz." := "Deferred Payment Pcs" * 12;
                                "Deferred Payment Total" := "Deferred Payment Pcs" * Quantity;

                                CalTotalCost();
                            end;
                        }

                        field("Deferred Payment Pcs"; "Deferred Payment Pcs")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("Deferred Payment Dz."; "Deferred Payment Dz.")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("Deferred Payment Total"; "Deferred Payment Total")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }
                    }

                    group("Risk Factor")
                    {
                        field("Risk factor %"; "Risk factor %")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            StyleExpr = 'Favorable';
                            Editable = false;

                            // trigger OnValidate()
                            // var
                            // begin
                            //     "Risk factor Pcs" := ("Risk factor %" * "FOB Pcs") / 100;
                            //     "Risk factor Dz." := "Risk factor Pcs" * 12;
                            //     "Risk factor Total" := "Risk factor Pcs" * Quantity;

                            //     CalTotalCost();
                            // end;
                        }

                        field("Risk factor Pcs"; "Risk factor Pcs")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("Risk factor Dz."; "Risk factor Dz.")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("Risk factor Total"; "Risk factor Total")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }
                    }

                    group("TAX")
                    {
                        field("TAX %"; "TAX %")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            StyleExpr = 'Favorable';
                            Editable = false;

                            // trigger OnValidate()
                            // var
                            // begin
                            //     "TAX Pcs" := ("TAX %" * "FOB Pcs") / 100;
                            //     "TAX Dz." := "TAX Pcs" * 12;
                            //     "TAX Total" := "TAX Pcs" * Quantity;

                            //     CalTotalCost();
                            // end;
                        }

                        field("TAX Pcs"; "TAX Pcs")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("TAX Dz."; "TAX Dz.")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("TAX Total"; "TAX Total")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }
                    }

                    group("Sourcing")
                    {
                        field("Sourcing %"; "ABA Sourcing %")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            StyleExpr = 'Favorable';
                            Editable = false;

                            // trigger OnValidate()
                            // var
                            // begin
                            //     "ABA Sourcing Pcs" := ("ABA Sourcing %" * "FOB Pcs") / 100;
                            //     "ABA Sourcing Dz." := "ABA Sourcing Pcs" * 12;
                            //     "ABA Sourcing Total" := "ABA Sourcing Pcs" * Quantity;

                            //     CalTotalCost();
                            // end;
                        }

                        field("ABA Sourcing Pcs"; "ABA Sourcing Pcs")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("ABA Sourcing Dz."; "ABA Sourcing Dz.")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("ABA Sourcing Total"; "ABA Sourcing Total")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }
                    }

                    group("Total Cost")
                    {
                        field("Total Cost %"; "Total Cost %")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("Total Cost Pcs"; "Total Cost Pcs")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("Total Cost Dz."; "Total Cost Dz.")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("Total Cost Total"; "Total Cost Total")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;

                        }
                    }

                    group("Profit Margin")
                    {
                        field("Profit Margin %"; "Profit Margin %")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            StyleExpr = 'StrongAccent';

                            trigger OnValidate()
                            var
                                Total1: Decimal;
                                Total2: Decimal;
                                Total3: Decimal;
                                Total4: Decimal;
                            begin
                                Total1 := "Commission %" + "Overhead %" + "Profit Margin %" + "Deferred Payment %" + "Commercial %" + "Risk factor %" + "ABA Sourcing %" + "TAX %";
                                Total2 := Total1 / (100 - Total1);
                                Total3 := "Sub Total (Dz.) Pcs" + "MFG Cost Pcs";
                                Total4 := Total2 * Total3;
                                "FOB Pcs" := Total3 + Total4;
                                FOB_Change();
                            end;
                        }

                        field("Profit Margin Pcs"; "Profit Margin Pcs")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("Profit Margin Dz."; "Profit Margin Dz.")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("Profit Margin Total"; "Profit Margin Total")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;

                        }
                    }

                    group("Gross CM Less Commission ")
                    {
                        field("Gross CM Less Commission"; "Gross CM Less Commission")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }
                    }
                }
            }

        }

        area(FactBoxes)
        {
            part(MyFactBox; "BOM Picture FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("Style No.");
                Caption = ' ';
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Send To Approve")
            {
                Image = SendApprovalRequest;
                ApplicationArea = All;

                trigger OnAction()
                var
                begin
                    if Status = Status::Approved then begin
                        Message('This BOM Costing is already approved');
                    end
                    else begin
                        Status := Status::"Pending Approval";
                        CurrPage.Update();
                        Message('BOM Costing sent to approvel');
                    end;
                end;
            }

            action(Approve)
            {
                Image = Approve;
                ApplicationArea = All;

                trigger OnAction()
                var
                    BOMCostHeaderRec: Record "BOM Estimate Cost";
                    BOMCostLineRec: Record "BOM Estimate Costing Line";
                    BOMCostReviHeaderRec: Record "BOM Estimate Cost Revision";
                    BOMCostReviLineRec: Record "BOM Estima Cost Line Revision";
                    Revision: Integer;
                begin
                    Status := Status::Approved;
                    "Approved Date" := WorkDate();
                    "Rejected Date" := 0D;
                    CurrPage.Update();

                    //Get max revision no
                    BOMCostReviHeaderRec.Reset();
                    BOMCostReviHeaderRec.SetRange("No.", "No.");

                    if not BOMCostReviHeaderRec.FindSet() then
                        Revision := 1
                    else
                        Revision := BOMCostReviHeaderRec.Count + 1;

                    //Write to Revision table
                    BOMCostReviHeaderRec.Init();
                    BOMCostReviHeaderRec."No." := "No.";
                    BOMCostReviHeaderRec.Revision := Revision;
                    BOMCostReviHeaderRec."ABA Sourcing %" := "ABA Sourcing %";
                    BOMCostReviHeaderRec."ABA Sourcing Dz." := "ABA Sourcing Dz.";
                    BOMCostReviHeaderRec."ABA Sourcing Pcs" := "ABA Sourcing Pcs";
                    BOMCostReviHeaderRec."ABA Sourcing Total" := "ABA Sourcing Total";
                    BOMCostReviHeaderRec."BOM No." := "BOM No.";
                    BOMCostReviHeaderRec."Brand Name" := "Brand Name";
                    BOMCostReviHeaderRec."Brand No." := "Brand No.";
                    BOMCostReviHeaderRec."Buyer Name" := "Buyer Name";
                    BOMCostReviHeaderRec."Buyer No." := "Buyer No.";
                    BOMCostReviHeaderRec."CM Doz" := "CM Doz";
                    BOMCostReviHeaderRec."Commercial %" := "Commercial %";
                    BOMCostReviHeaderRec."Commercial Dz." := "Commercial Dz.";
                    BOMCostReviHeaderRec."Commercial Pcs" := "Commercial Pcs";
                    BOMCostReviHeaderRec."Commercial Total" := "Commercial Total";
                    BOMCostReviHeaderRec."Commission %" := "Commission %";
                    BOMCostReviHeaderRec."Commission Dz." := "Commission Dz.";
                    BOMCostReviHeaderRec."Commercial Pcs" := "Commission Pcs";
                    BOMCostReviHeaderRec."Commercial Total" := "Commission Total";
                    BOMCostReviHeaderRec.CPM := CPM;
                    BOMCostReviHeaderRec."Created Date" := "Created Date";
                    BOMCostReviHeaderRec."Created User" := "Created User";
                    BOMCostReviHeaderRec."Currency No." := "Currency No.";
                    BOMCostReviHeaderRec."Deferred Payment %" := "Deferred Payment %";
                    BOMCostReviHeaderRec."Deferred Payment Dz." := "Deferred Payment Dz.";
                    BOMCostReviHeaderRec."Deferred Payment Pcs" := "Deferred Payment Pcs";
                    BOMCostReviHeaderRec."Deferred Payment Total" := "Deferred Payment Total";
                    BOMCostReviHeaderRec."Department Name" := "Department Name";
                    BOMCostReviHeaderRec."Department No." := "Department No.";
                    BOMCostReviHeaderRec."Embroidery (Dz.)" := "Embroidery (Dz.)";
                    BOMCostReviHeaderRec.EPM := EPM;
                    BOMCostReviHeaderRec."Factory Code" := "Factory Code";
                    BOMCostReviHeaderRec."Factory Name" := "Factory Name";
                    BOMCostReviHeaderRec."FOB %" := "FOB %";
                    BOMCostReviHeaderRec."FOB Dz." := "FOB Dz.";
                    BOMCostReviHeaderRec."FOB Pcs" := "FOB Pcs";
                    BOMCostReviHeaderRec."FOB Total" := "FOB Total";
                    BOMCostReviHeaderRec."Garment Type Name" := "Garment Type Name";
                    BOMCostReviHeaderRec."Garment Type No." := "Garment Type No.";
                    BOMCostReviHeaderRec."Gross CM Less Commission" := "Gross CM Less Commission";
                    BOMCostReviHeaderRec."Gross CM With Commission %" := "Gross CM With Commission %";
                    BOMCostReviHeaderRec."Gross CM With Commission Dz." := "Gross CM With Commission Dz.";
                    BOMCostReviHeaderRec."Gross CM With Commission Pcs" := "Gross CM With Commission Pcs";
                    BOMCostReviHeaderRec."Gross CM With Commission Total" := "Gross CM With Commission Total";
                    BOMCostReviHeaderRec."MFG Cost %" := "MFG Cost %";
                    BOMCostReviHeaderRec."MFG Cost Dz." := "MFG Cost Dz.";
                    BOMCostReviHeaderRec."MFG Cost Pcs" := "MFG Cost Pcs";
                    BOMCostReviHeaderRec."MFG Cost Total" := "MFG Cost Total";
                    BOMCostReviHeaderRec."Others (Dz.)" := "Others (Dz.)";
                    BOMCostReviHeaderRec."Overhead %" := "Overhead %";
                    BOMCostReviHeaderRec."Overhead Dz." := "Overhead Dz.";
                    BOMCostReviHeaderRec."Overhead Pcs" := "Overhead Pcs";
                    BOMCostReviHeaderRec."Overhead Total" := "Overhead Total";
                    BOMCostReviHeaderRec."Print Type" := "Print Type";
                    BOMCostReviHeaderRec."Print Type Name" := "Print Type Name";
                    BOMCostReviHeaderRec."Printing (Dz.)" := "Printing (Dz.)";
                    BOMCostReviHeaderRec."Profit Margin %" := "Profit Margin %";
                    BOMCostReviHeaderRec."Profit Margin Dz." := "Profit Margin Dz.";
                    BOMCostReviHeaderRec."Profit Margin Pcs" := "Profit Margin Pcs";
                    BOMCostReviHeaderRec."Profit Margin Total" := "Profit Margin Total";
                    BOMCostReviHeaderRec."Project Efficiency." := "Project Efficiency.";
                    BOMCostReviHeaderRec.Quantity := Quantity;
                    BOMCostReviHeaderRec.Rate := Rate;
                    BOMCostReviHeaderRec."Raw Material (Dz.)" := "Raw Material (Dz.)";
                    BOMCostReviHeaderRec."Revised Date" := WorkDate();
                    BOMCostReviHeaderRec."Risk factor %" := "Risk factor %";
                    BOMCostReviHeaderRec."Risk factor Dz." := "Risk factor Dz.";
                    BOMCostReviHeaderRec."Risk factor Pcs" := "Risk factor Pcs";
                    BOMCostReviHeaderRec."Risk factor Total" := "Risk factor Total";
                    BOMCostReviHeaderRec."Season Name" := "Season Name";
                    BOMCostReviHeaderRec."Season No." := "Season No.";
                    BOMCostReviHeaderRec.SMV := SMV;
                    BOMCostReviHeaderRec.Status := Status;
                    BOMCostReviHeaderRec."Stich Gmt" := "Stich Gmt";
                    BOMCostReviHeaderRec."Stich Gmt Name" := "Stich Gmt Name";
                    BOMCostReviHeaderRec."Store Name" := "Store Name";
                    BOMCostReviHeaderRec."Store No." := "Store No.";
                    BOMCostReviHeaderRec."Style Name" := "Style Name";
                    BOMCostReviHeaderRec."Style No." := "Style No.";
                    BOMCostReviHeaderRec."Sub Total (Dz.) Dz." := "Sub Total (Dz.) Dz.";
                    BOMCostReviHeaderRec."Sub Total (Dz.) Pcs" := "Sub Total (Dz.) Pcs";
                    BOMCostReviHeaderRec."Sub Total (Dz.) Total" := "Sub Total (Dz.) Total";
                    BOMCostReviHeaderRec."Sub Total (Dz.)%" := "Sub Total (Dz.)%";
                    BOMCostReviHeaderRec."TAX %" := "TAX %";
                    BOMCostReviHeaderRec."TAX Dz." := "TAX Dz.";
                    BOMCostReviHeaderRec."TAX Pcs" := "TAX Pcs";
                    BOMCostReviHeaderRec."TAX Total" := "TAX Total";
                    BOMCostReviHeaderRec."Total Cost %" := "Total Cost %";
                    BOMCostReviHeaderRec."Total Cost Dz." := "Total Cost Dz.";
                    BOMCostReviHeaderRec."Total Cost Pcs" := "Total Cost Pcs";
                    BOMCostReviHeaderRec."Total Cost Total" := "Total Cost Total";
                    BOMCostReviHeaderRec."Wash Type" := "Wash Type";
                    BOMCostReviHeaderRec."Wash Type Name" := "Wash Type Name";
                    BOMCostReviHeaderRec."Washing (Dz.)" := "Washing (Dz.)";
                    BOMCostReviHeaderRec.Insert();

                    //Write to line table
                    BOMCostLineRec.Reset();
                    BOMCostLineRec.SetRange("No.", "No.");

                    if BOMCostLineRec.FindSet() then begin
                        repeat
                            BOMCostReviLineRec.Init();
                            BOMCostReviLineRec."No." := "No.";
                            BOMCostReviLineRec.Revision := Revision;
                            BOMCostReviLineRec."BOM No." := BOMCostLineRec."BOM No.";
                            BOMCostReviLineRec."Created User" := BOMCostLineRec."Created User";
                            BOMCostReviLineRec."Created Date" := BOMCostLineRec."Created Date";
                            BOMCostReviLineRec."Doz Cost" := BOMCostLineRec."Doz Cost";
                            BOMCostReviLineRec.Value := BOMCostLineRec.Value;
                            BOMCostReviLineRec."Master Category No." := BOMCostLineRec."Master Category No.";
                            BOMCostReviLineRec."Master Category Name" := BOMCostLineRec."Master Category Name";
                            BOMCostReviLineRec.Insert();
                        until BOMCostLineRec.Next() = 0;
                    end;

                    Message('BOM Costing Approved');
                end;
            }

            action(Reject)
            {
                Image = Reject;
                ApplicationArea = All;

                trigger OnAction()
                var
                begin
                    Status := Status::Rejected;
                    "Rejected Date" := WorkDate();
                    "Approved Date" := 0D;
                    CurrPage.Update();
                    Message('BOM Costing Rejected');
                end;
            }
        }
    }

    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."BOM Cost Nos.", xRec."No.", "No.") THEN BEGIN
            NoSeriesMngment.SetSeries("No.");
            EXIT(TRUE);
        END;
    end;


    procedure CalRawMat()
    var
        BOMEstCostLineRec: Record "BOM Estimate Costing Line";
        RawMaterialCost: Decimal;
    begin

        BOMEstCostLineRec.Reset();
        BOMEstCostLineRec.SetCurrentKey("No.", "BOM No.");
        BOMEstCostLineRec.SetRange("No.", "No.");
        BOMEstCostLineRec.SetRange("BOM No.", "BOM No.");

        IF (BOMEstCostLineRec.FINDSET) THEN begin
            repeat

                RawMaterialCost += BOMEstCostLineRec."Doz Cost";
                "Raw Material (Dz.)" := RawMaterialCost;

            until BOMEstCostLineRec.Next() = 0;
        end;
    end;


    procedure LoadCategoryDetails()
    var
        BOMEstimateLineRec: Record "BOM Estimate Line";
        BOMEstimateCostLineRec: Record "BOM Estimate Costing Line";
        "MasterCategoryNo.": code[20];
        "MasterCategoryName.": text[50];
        MasterCat: Code[20];
        Value: Decimal;
    begin

        BOMEstimateCostLineRec.SetRange("No.", "No.");
        BOMEstimateCostLineRec.DeleteAll();

        BOMEstimateLineRec.reset;
        BOMEstimateLineRec.SetCurrentKey("Master Category No.");
        BOMEstimateLineRec.SetRange("No.", "BOM No.");
        BOMEstimateLineRec.FindSet();

        repeat

            if MasterCat = BOMEstimateLineRec."Master Category No." then begin
                Value += BOMEstimateLineRec.Value;
                "MasterCategoryNo." := BOMEstimateLineRec."Master Category No.";
                "MasterCategoryName." := BOMEstimateLineRec."Master Category Name";
            end
            else begin
                if MasterCat = '' then begin
                    MasterCat := BOMEstimateLineRec."Master Category No.";
                    "MasterCategoryNo." := BOMEstimateLineRec."Master Category No.";
                    "MasterCategoryName." := BOMEstimateLineRec."Master Category Name";
                    Value += BOMEstimateLineRec.Value;
                end
                else begin
                    BOMEstimateCostLineRec.Init();
                    BOMEstimateCostLineRec."No." := "No.";
                    BOMEstimateCostLineRec."Master Category No." := "MasterCategoryNo.";
                    BOMEstimateCostLineRec."Master Category Name" := "MasterCategoryName.";
                    BOMEstimateCostLineRec."BOM No." := BOMEstimateLineRec."No.";
                    BOMEstimateCostLineRec.Value := Value;
                    BOMEstimateCostLineRec."Doz Cost" := (Value / Quantity) * 12;
                    BOMEstimateCostLineRec.Insert();
                    Value := 0;

                    Value += BOMEstimateLineRec.Value;
                    MasterCat := BOMEstimateLineRec."Master Category No.";
                    "MasterCategoryNo." := BOMEstimateLineRec."Master Category No.";
                    "MasterCategoryName." := BOMEstimateLineRec."Master Category Name";
                end;
            end;

        until BOMEstimateLineRec.Next() = 0;

        BOMEstimateCostLineRec.Init();
        BOMEstimateCostLineRec."No." := "No.";
        BOMEstimateCostLineRec."Master Category No." := "MasterCategoryNo.";
        BOMEstimateCostLineRec."Master Category Name" := "MasterCategoryName.";
        BOMEstimateCostLineRec."BOM No." := "BOM No.";
        BOMEstimateCostLineRec.Value := Value;
        BOMEstimateCostLineRec."Doz Cost" := (Value / Quantity) * 12;
        BOMEstimateCostLineRec.Insert();

    end;

    procedure CalMFGCost()
    var

    begin
        "CM Doz" := ((smv + (100 - "Project Efficiency.") / 100 * SMV) * CPM + ((SMV + (100 - "Project Efficiency.") / 100 * SMV) * CPM) * EPM / 100) * 12;
        "MFG Cost Dz." := "CM Doz";
        "MFG Cost Pcs" := "MFG Cost Dz." / 12;
        "MFG Cost Total" := "MFG Cost Pcs" * Quantity;

        if "FOB Pcs" <> 0 then
            "MFG Cost %" := ("MFG Cost Pcs" * 100 / "FOB Pcs");

        // "Commercial Pcs" := ("Commercial %" * "FOB Pcs") / 100;
        // "Commercial Dz." := "Commercial Pcs" * 12;
        // "Commercial Total" := "Commercial Pcs" * Quantity;

    end;

    procedure CalTotalCost()
    var
    begin
        "Total Cost Dz." := "Sub Total (Dz.) Dz." + "MFG Cost Dz." + "Overhead Dz." + "Commission Dz." + "Commercial Dz." + "Deferred Payment Dz." + "TAX Dz." + "ABA Sourcing Dz." + "Risk factor Dz.";
        "Total Cost Pcs" := "Total Cost Dz." / 12;
        "Total Cost Total" := "Total Cost Pcs" * Quantity;
        "Total Cost %" := ("Total Cost Pcs" * 100) / "FOB Pcs";

        CalProfitMargin();
    end;

    procedure CalProfitMargin()
    var
    begin
        "Profit Margin Pcs" := "FOB Pcs" - "Total Cost Pcs";
        "Profit Margin Dz." := "Profit Margin Pcs" * 12;
        "Profit Margin Total" := "Profit Margin Pcs" * Quantity;
        "Profit Margin %" := ("Profit Margin Pcs" * 100) / "FOB Pcs";

        "Gross CM Less Commission" := "Gross CM With Commission Dz." - "Commission Dz." - "Deferred Payment Dz.";
    end;


    procedure FOB_Change()
    var
    begin

        if "FOB Pcs" <> 0 then begin
            "FOB Dz." := "FOB Pcs" * 12;
            "FOB %" := 100;
            "FOB Total" := "FOB Pcs" * Quantity;

            "Sub Total (Dz.)%" := ("Sub Total (Dz.) Pcs" * 100) / "FOB Pcs";
            "Gross CM With Commission Dz." := "FOB Dz." - "Sub Total (Dz.) Dz." - "Commission Dz." - "Deferred Payment Dz.";
            "Gross CM With Commission Pcs" := "Gross CM With Commission Dz." / 12;
            "Gross CM With Commission %" := ("Gross CM With Commission Pcs" / "FOB Pcs") * 100;
            "Gross CM With Commission Total" := "Gross CM With Commission Pcs" * Quantity;

            "MFG Cost %" := ("MFG Cost Pcs" * 100 / "FOB Pcs");

            "Overhead Pcs" := ("Overhead %" * "FOB Pcs") / 100;
            "Overhead Dz." := "Overhead Pcs" * 12;
            "Overhead Total" := "Overhead Pcs" * Quantity;

            "Commission Pcs" := ("Commission %" * "FOB Pcs") / 100;
            "Commission Dz." := "Commission Pcs" * 12;
            "Commission Total" := "Commission Pcs" * Quantity;

            "Commercial Pcs" := ("Commercial %" * "FOB Pcs") / 100;
            "Commercial Dz." := "Commercial Pcs" * 12;
            "Commercial Total" := "Commercial Pcs" * Quantity;

            "Deferred Payment Pcs" := ("Deferred Payment %" * "FOB Pcs") / 100;
            "Deferred Payment Dz." := "Deferred Payment Pcs" * 12;
            "Deferred Payment Total" := "Deferred Payment Pcs" * Quantity;

            "Risk factor Pcs" := ("Risk factor %" * "FOB Pcs") / 100;
            "Risk factor Dz." := "Risk factor Pcs" * 12;
            "Risk factor Total" := "Risk factor Pcs" * Quantity;

            "TAX Pcs" := ("TAX %" * "FOB Pcs") / 100;
            "TAX Dz." := "TAX Pcs" * 12;
            "TAX Total" := "TAX Pcs" * Quantity;

            "ABA Sourcing Pcs" := ("ABA Sourcing %" * "FOB Pcs") / 100;
            "ABA Sourcing Dz." := "ABA Sourcing Pcs" * 12;
            "ABA Sourcing Total" := "ABA Sourcing Pcs" * Quantity;

            if "FOB Pcs" <> 0 then
                "Total Cost %" := ("Total Cost Pcs" * 100 / "FOB Pcs");

            CalTotalCost();

            //Running for the second time
            "FOB Dz." := "FOB Pcs" * 12;
            "FOB %" := 100;
            "FOB Total" := "FOB Pcs" * Quantity;

            "Sub Total (Dz.)%" := ("Sub Total (Dz.) Pcs" * 100) / "FOB Pcs";
            "Gross CM With Commission Dz." := "FOB Dz." - "Sub Total (Dz.) Dz." - "Commission Dz." - "Deferred Payment Dz.";
            "Gross CM With Commission Pcs" := "Gross CM With Commission Dz." / 12;
            "Gross CM With Commission %" := ("Gross CM With Commission Pcs" / "FOB Pcs") * 100;
            "Gross CM With Commission Total" := "Gross CM With Commission Pcs" * Quantity;

            "MFG Cost %" := ("MFG Cost Pcs" * 100 / "FOB Pcs");

            "Overhead Pcs" := ("Overhead %" * "FOB Pcs") / 100;
            "Overhead Dz." := "Overhead Pcs" * 12;
            "Overhead Total" := "Overhead Pcs" * Quantity;

            "Commission Pcs" := ("Commission %" * "FOB Pcs") / 100;
            "Commission Dz." := "Commission Pcs" * 12;
            "Commission Total" := "Commission Pcs" * Quantity;

            "Commercial Pcs" := ("Commercial %" * "FOB Pcs") / 100;
            "Commercial Dz." := "Commercial Pcs" * 12;
            "Commercial Total" := "Commercial Pcs" * Quantity;

            "Deferred Payment Pcs" := ("Deferred Payment %" * "FOB Pcs") / 100;
            "Deferred Payment Dz." := "Deferred Payment Pcs" * 12;
            "Deferred Payment Total" := "Deferred Payment Pcs" * Quantity;

            "Risk factor Pcs" := ("Risk factor %" * "FOB Pcs") / 100;
            "Risk factor Dz." := "Risk factor Pcs" * 12;
            "Risk factor Total" := "Risk factor Pcs" * Quantity;

            "TAX Pcs" := ("TAX %" * "FOB Pcs") / 100;
            "TAX Dz." := "TAX Pcs" * 12;
            "TAX Total" := "TAX Pcs" * Quantity;

            "ABA Sourcing Pcs" := ("ABA Sourcing %" * "FOB Pcs") / 100;
            "ABA Sourcing Dz." := "ABA Sourcing Pcs" * 12;
            "ABA Sourcing Total" := "ABA Sourcing Pcs" * Quantity;


            if "FOB Pcs" <> 0 then
                "Total Cost %" := ("Total Cost Pcs" * 100 / "FOB Pcs");

            CalTotalCost();

        end;

    end;


    trigger OnDeleteRecord(): Boolean
    var
        BOMEstimateCostRec: Record "BOM Estimate Cost";
        BOMEstCostLineRec: Record "BOM Estimate Costing Line";
    begin
        BOMEstimateCostRec.SetRange("No.", "No.");
        BOMEstimateCostRec.DeleteAll();

        BOMEstCostLineRec.SetRange("No.", "No.");
        BOMEstCostLineRec.DeleteAll();
    end;


    trigger OnOpenPage()
    var
        NavAppSetup: Record "NavApp Setup";
    begin
        NavAppSetup.Get('0001');
        "Risk factor %" := NavAppSetup."Risk Factor";
        "TAX %" := NavAppSetup.TAX;
        "ABA Sourcing %" := NavAppSetup."ABA Sourcing";

        if "FOB Pcs" = 0 then
            "FOB Pcs" := 1;

        CurrPage.Update();
    end;

}