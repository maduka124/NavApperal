page 50986 "BOM Estimate Cost Card"
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
                field("No."; rec."No.")   //This is Cost Sheet No
                {
                    ApplicationArea = All;
                    Caption = 'Cost Sheet No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("BOM No."; rec."BOM No.")
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
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin

                        //Check whether user logged in or not
                        LoginSessionsRec.Reset();
                        LoginSessionsRec.SetRange(SessionID, SessionId());

                        if not LoginSessionsRec.FindSet() then begin  //not logged in
                            Clear(LoginRec);
                            LoginRec.LookupMode(true);
                            LoginRec.RunModal();

                            LoginSessionsRec.Reset();
                            LoginSessionsRec.SetRange(SessionID, SessionId());
                            if LoginSessionsRec.FindSet() then
                                rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end
                        else begin   //logged in
                            rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end;


                        if rec."FOB Pcs" = 0 then
                            rec."FOB Pcs" := 1;

                        //Check for duplicates
                        BOMEstCostRec.Reset();
                        BOMEstCostRec.SetRange("BOM No.", rec."BOM No.");
                        if BOMEstCostRec.FindSet() then
                            Error('Estimate BOM : %1 already used to create a Estimate Cost Sheet', BOMEstCostRec."BOM No.");

                        NavAppSetup.Get('0001');
                        rec."Risk factor %" := NavAppSetup."Risk Factor";
                        rec."TAX %" := NavAppSetup.TAX;
                        rec."ABA Sourcing %" := NavAppSetup."ABA Sourcing";

                        BOMRec.get(rec."BOM No.");
                        rec."Style No." := BOMRec."Style No.";
                        rec."Style Name" := BOMRec."Style Name";
                        rec."Store No." := BOMRec."Store No.";
                        rec."Brand No." := BOMRec."Brand No.";
                        rec."Buyer No." := BOMRec."Buyer No.";
                        rec."Season No." := BOMRec."Season No.";
                        rec."Department No." := BOMRec."Department No.";
                        rec."Garment Type No." := BOMRec."Garment Type No.";

                        rec."Store Name" := BOMRec."Store Name";
                        rec."Brand Name" := BOMRec."Brand Name";
                        rec."Buyer Name" := BOMRec."Buyer Name";
                        rec."Season Name" := BOMRec."Season Name";
                        rec."Department Name" := BOMRec."Department Name";
                        rec."Garment Type Name" := BOMRec."Garment Type Name";
                        rec.Quantity := BOMRec.Quantity;

                        //CustomerRec.get(rec."Buyer No.");
                        rec."Currency No." := BOMRec."Currency No.";

                        LoadCategoryDetails();
                        CalRawMat();

                        //Get Costing SMV
                        StyleRec.Reset();
                        StyleRec.SetRange("No.", BOMRec."Style No.");
                        StyleRec.FindSet();

                        if StyleRec.CostingSMV = 0 then
                            Error('Costing SMV is zero')
                        else begin
                            rec.SMV := StyleRec.CostingSMV;

                            //Get Project efficiency                          
                            CostPlanParaLineRec.Reset();
                            CostPlanParaLineRec.SetFilter("From SMV", '<=%1', rec.SMV);
                            CostPlanParaLineRec.SetFilter("To SMV", '>=%1', rec.SMV);
                            CostPlanParaLineRec.SetFilter("From Qty", '<=%1', rec.Quantity);
                            CostPlanParaLineRec.SetFilter("To Qty", '>=%1', rec.Quantity);
                            if CostPlanParaLineRec.FindSet() then
                                rec."Project Efficiency." := CostPlanParaLineRec."Costing Eff%"
                            else
                                Error('Project efficiency is not setup in the Costing/Planning Parameter');
                        end;

                        CalMFGCost();
                        CalTotalCost();

                    end;
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Style';
                }

                field("Store Name"; rec."Store Name")
                {
                    ApplicationArea = All;
                    Caption = 'Store';
                    Editable = false;

                    trigger OnValidate()
                    var
                        GarmentStoreRec: Record "Garment Store";
                    begin
                        GarmentStoreRec.Reset();
                        GarmentStoreRec.SetRange("Store Name", rec."Store Name");
                        if GarmentStoreRec.FindSet() then
                            rec."Store No." := GarmentStoreRec."No.";
                    end;
                }

                field("Brand Name"; rec."Brand Name")
                {
                    ApplicationArea = All;
                    Caption = 'Brand';
                    Editable = false;

                    trigger OnValidate()
                    var
                        BrandRec: Record "Brand";
                    begin
                        BrandRec.Reset();
                        BrandRec.SetRange("Brand Name", rec."Brand Name");
                        if BrandRec.FindSet() then
                            rec."Brand No." := BrandRec."No.";
                    end;
                }

                field("Buyer Name"; rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                    Editable = false;

                    trigger OnValidate()
                    var
                        BuyerRec: Record Customer;
                    begin
                        BuyerRec.Reset();
                        BuyerRec.SetRange(Name, rec."Buyer Name");
                        if BuyerRec.FindSet() then begin
                            rec."Buyer No." := BuyerRec."No.";
                            rec."Currency No." := BuyerRec."Currency Code";
                        end;
                    end;
                }

                field("Season Name"; rec."Season Name")
                {
                    ApplicationArea = All;
                    Caption = 'Season';
                    Editable = false;

                    trigger OnValidate()
                    var
                        SeasonsRec: Record "Seasons";
                    begin
                        SeasonsRec.Reset();
                        SeasonsRec.SetRange("Season Name", rec."Season Name");
                        if SeasonsRec.FindSet() then
                            rec."Season No." := SeasonsRec."No.";
                    end;
                }

                field("Department Name"; rec."Department Name")
                {
                    ApplicationArea = All;
                    Caption = 'Department';
                    Editable = false;

                    trigger OnValidate()
                    var
                        DepartmentRec: Record "Department Style";
                    begin
                        DepartmentRec.Reset();
                        DepartmentRec.SetRange("Department Name", rec."Department Name");
                        if DepartmentRec.FindSet() then
                            rec."Department No." := DepartmentRec."No.";
                    end;

                }

                field("Garment Type Name"; rec."Garment Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Garment Type';
                    Editable = false;

                    trigger OnValidate()
                    var
                        GarmentTypeRec: Record "Garment Type";
                    begin
                        GarmentTypeRec.Reset();
                        GarmentTypeRec.SetRange("Garment Type Description", rec."Garment Type Name");
                        if GarmentTypeRec.FindSet() then
                            rec."Garment Type No." := GarmentTypeRec."No.";
                    end;
                }

                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Currency No."; rec."Currency No.")
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
                field("Raw Material (Dz.)"; rec."Raw Material (Dz.)")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var

                    begin
                        rec."Sub Total (Dz.) Dz." := rec."Raw Material (Dz.)" + rec."Embroidery (Dz.)" + rec."Printing (Dz.)" + rec."Washing (Dz.)" + rec."Others (Dz.)";
                        rec."Sub Total (Dz.) Pcs" := rec."Sub Total (Dz.) Dz." / 12;
                        rec."Sub Total (Dz.) Total" := rec."Sub Total (Dz.) Pcs" * rec.Quantity;

                        rec."Gross CM With Commission Dz." := rec."FOB Dz." - rec."Sub Total (Dz.) Dz." - rec."Commission Dz." - rec."Deferred Payment Dz.";
                        rec."Gross CM With Commission Pcs" := rec."Gross CM With Commission Dz." / 12;

                        if rec."FOB Pcs" = 0 then
                            rec."Gross CM With Commission %" := 0
                        else
                            rec."Gross CM With Commission %" := (rec."Gross CM With Commission Pcs" / rec."FOB Pcs") * 100;

                        rec."Gross CM With Commission Total" := rec."Gross CM With Commission Pcs" * rec.Quantity;

                        CalTotalCost();
                    end;
                }

                field("Embroidery (Dz.)"; rec."Embroidery (Dz.)")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var

                    begin
                        rec."Sub Total (Dz.) Dz." := rec."Raw Material (Dz.)" + rec."Embroidery (Dz.)" + rec."Printing (Dz.)" + rec."Washing (Dz.)" + rec."Others (Dz.)";
                        rec."Sub Total (Dz.) Pcs" := rec."Sub Total (Dz.) Dz." / 12;
                        rec."Sub Total (Dz.) Total" := rec."Sub Total (Dz.) Pcs" * rec.Quantity;

                        rec."Gross CM With Commission Dz." := rec."FOB Dz." - rec."Sub Total (Dz.) Dz." - rec."Commission Dz." - rec."Deferred Payment Dz.";
                        rec."Gross CM With Commission Pcs" := rec."Gross CM With Commission Dz." / 12;

                        if rec."FOB Pcs" = 0 then
                            rec."Gross CM With Commission %" := 0
                        else
                            rec."Gross CM With Commission %" := (rec."Gross CM With Commission Pcs" / rec."FOB Pcs") * 100;

                        rec."Gross CM With Commission Total" := rec."Gross CM With Commission Pcs" * rec.Quantity;

                        CalTotalCost();
                    end;
                }

                field("Printing (Dz.)"; rec."Printing (Dz.)")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var

                    begin
                        rec."Sub Total (Dz.) Dz." := rec."Raw Material (Dz.)" + rec."Embroidery (Dz.)" + rec."Printing (Dz.)" + rec."Washing (Dz.)" + rec."Others (Dz.)";
                        rec."Sub Total (Dz.) Pcs" := rec."Sub Total (Dz.) Dz." / 12;
                        rec."Sub Total (Dz.) Total" := rec."Sub Total (Dz.) Pcs" * rec.Quantity;

                        rec."Gross CM With Commission Dz." := rec."FOB Dz." - rec."Sub Total (Dz.) Dz." - rec."Commission Dz." - rec."Deferred Payment Dz.";
                        rec."Gross CM With Commission Pcs" := rec."Gross CM With Commission Dz." / 12;

                        if rec."FOB Pcs" = 0 then
                            rec."Gross CM With Commission %" := 0
                        else
                            rec."Gross CM With Commission %" := (rec."Gross CM With Commission Pcs" / rec."FOB Pcs") * 100;


                        rec."Gross CM With Commission Total" := rec."Gross CM With Commission Pcs" * rec.Quantity;

                        CalTotalCost();
                    end;
                }

                field("Washing (Dz.)"; rec."Washing (Dz.)")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var

                    begin
                        rec."Sub Total (Dz.) Dz." := rec."Raw Material (Dz.)" + rec."Embroidery (Dz.)" + rec."Printing (Dz.)" + rec."Washing (Dz.)" + rec."Others (Dz.)";
                        rec."Sub Total (Dz.) Pcs" := rec."Sub Total (Dz.) Dz." / 12;
                        rec."Sub Total (Dz.) Total" := rec."Sub Total (Dz.) Pcs" * rec.Quantity;

                        rec."Gross CM With Commission Dz." := rec."FOB Dz." - rec."Sub Total (Dz.) Dz." - rec."Commission Dz." - rec."Deferred Payment Dz.";
                        rec."Gross CM With Commission Pcs" := rec."Gross CM With Commission Dz." / 12;

                        if rec."FOB Pcs" = 0 then
                            rec."Gross CM With Commission %" := 0
                        else
                            rec."Gross CM With Commission %" := (rec."Gross CM With Commission Pcs" / rec."FOB Pcs") * 100;

                        rec."Gross CM With Commission Total" := rec."Gross CM With Commission Pcs" * rec.Quantity;

                        CalTotalCost();
                    end;
                }

                field("Others (Dz.)"; rec."Others (Dz.)")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var

                    begin
                        rec."Sub Total (Dz.) Dz." := rec."Raw Material (Dz.)" + rec."Embroidery (Dz.)" + rec."Printing (Dz.)" + rec."Washing (Dz.)" + rec."Others (Dz.)";
                        rec."Sub Total (Dz.) Pcs" := rec."Sub Total (Dz.) Dz." / 12;
                        rec."Sub Total (Dz.) Total" := rec."Sub Total (Dz.) Pcs" * rec.Quantity;

                        rec."Gross CM With Commission Dz." := rec."FOB Dz." - rec."Sub Total (Dz.) Dz." - rec."Commission Dz." - rec."Deferred Payment Dz.";
                        rec."Gross CM With Commission Pcs" := rec."Gross CM With Commission Dz." / 12;

                        if rec."FOB Pcs" = 0 then
                            rec."Gross CM With Commission %" := 0
                        else
                            rec."Gross CM With Commission %" := (rec."Gross CM With Commission Pcs" / rec."FOB Pcs") * 100;

                        rec."Gross CM With Commission Total" := rec."Gross CM With Commission Pcs" * rec.Quantity;

                        CalTotalCost();
                    end;
                }

                field(Rate; rec.Rate)
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Stich Gmt Name"; rec."Stich Gmt Name")
                {
                    ApplicationArea = All;
                    Caption = 'Stich Gmt';

                    trigger OnValidate()
                    var
                        StRec: Record "Stich Gmt";
                    begin

                        StRec.Reset();
                        StRec.SetRange("Stich Gmt Name", rec."Stich Gmt Name");
                        if StRec.FindSet() then
                            rec."Stich Gmt" := StRec."No.";

                    end;
                }

                field("Print Type Name"; rec."Print Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Print Type';

                    trigger OnValidate()
                    var
                        PTRec: Record "Print Type";
                    begin

                        PTRec.Reset();
                        PTRec.SetRange("Print Type Name", rec."Print Type Name");
                        if PTRec.FindSet() then
                            rec."Print Type" := PTRec."No.";

                    end;
                }

                field("Wash Type Name"; rec."Wash Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Wash Type';

                    trigger OnValidate()
                    var
                        WTRec: Record "Wash Type";
                    begin

                        WTRec.Reset();
                        WTRec.SetRange("Wash Type Name", rec."Wash Type Name");
                        if WTRec.FindSet() then
                            rec."Wash Type" := WTRec."No.";

                    end;
                }

            }

            group("CM Calculation")
            {
                field("Factory Name"; rec."Factory Name")
                {
                    ApplicationArea = All;
                    Caption = 'Factory';

                    trigger OnValidate()
                    var
                        Locationrec: Record Location;
                        FacCPMRec: Record "Factory CPM";
                        StyleRec: Record "Style Master";
                        DimenstionsRec: Record "Default Dimension";
                        LineNo: Integer;
                        GlobalDimenstion: Code[20];
                    begin
                        Locationrec.Reset();
                        Locationrec.SetRange(Name, rec."Factory Name");
                        if Locationrec.FindSet() then
                            rec."Factory Code" := Locationrec.Code;

                        //Get default dimension
                        DimenstionsRec.Reset();
                        DimenstionsRec.SetRange("No.", Locationrec.Code);
                        if DimenstionsRec.FindSet() then
                            GlobalDimenstion := DimenstionsRec."Dimension Value Code";


                        //Get Max line no
                        FacCPMRec.Reset();
                        FacCPMRec.SetRange("Factory Code", Locationrec.Code);

                        if FacCPMRec.FindLast() then begin
                            rec.CPM := FacCPMRec.CPM;
                            CurrPage.Update();
                            CalMFGCost();
                            CalTotalCost();

                            //Update Allocated factory in style master
                            StyleRec.Reset();
                            StyleRec.SetRange("No.", rec."Style No.");
                            if StyleRec.FindSet() then begin
                                StyleRec."Factory Code" := Locationrec.Code;
                                StyleRec."Factory Name" := rec."Factory Name";
                                StyleRec."Global Dimension Code" := GlobalDimenstion;
                                StyleRec.Modify();
                            end
                            else
                                Error('Cannot find style details.');

                        end
                        else
                            Error('CPM is not setup for the factory : %1', rec."Factory Name");

                        CurrPage.Update();
                    end;
                }

                field(SMV; rec.SMV)
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

                field(CPM; rec.CPM)
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

                field("Project Efficiency."; rec."Project Efficiency.")
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

                field(EPM; rec.EPM)   //Margin
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalMFGCost();
                        CalTotalCost();
                    end;
                }


                field("CM Doz"; rec."CM Doz")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Status; rec.Status)
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
                        field("Sub Total (Dz.)%"; rec."Sub Total (Dz.)%")
                        {
                            ApplicationArea = All;
                            Caption = '%';
                            Editable = false;
                        }

                        field("Sub Total (Dz.) Pcs"; rec."Sub Total (Dz.) Pcs")
                        {
                            ApplicationArea = All;
                            Caption = 'Pcs';
                            Editable = false;
                        }

                        field("Sub Total (Dz.) Dz."; rec."Sub Total (Dz.) Dz.")
                        {
                            ApplicationArea = All;
                            Caption = 'Dz.';
                            Editable = false;
                        }

                        field("Sub Total (Dz.) Total"; rec."Sub Total (Dz.) Total")
                        {
                            ApplicationArea = All;
                            Caption = 'Total';
                            Editable = false;
                        }
                    }
                    group("FOB")
                    {
                        field("FOB %"; rec."FOB %")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("FOB Pcs"; rec."FOB Pcs")
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

                        field("FOB Dz."; rec."FOB Dz.")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("FOB Total"; rec."FOB Total")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }
                    }

                    group("Gross CM With Commission ")
                    {
                        field("Gross CM With Commission %"; rec."Gross CM With Commission %")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("Gross CM With Commission Pcs"; rec."Gross CM With Commission Pcs")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("Gross CM With Commission Dz."; rec."Gross CM With Commission Dz.")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("Gross CM With Commission Total"; rec."Gross CM With Commission Total")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }
                    }

                    group("MFG Cost")
                    {
                        field("MFG Cost %"; rec."MFG Cost %")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("MFG Cost Pcs"; rec."MFG Cost Pcs")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("MFG Cost Dz."; rec."MFG Cost Dz.")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            StyleExpr = 'StrongAccent';

                            trigger OnValidate()
                            var

                            begin
                                rec."MFG Cost Pcs" := rec."MFG Cost Dz." / 12;
                                rec."MFG Cost Total" := rec."MFG Cost Pcs" * rec.Quantity;

                                if rec."FOB Pcs" <> 0 then
                                    rec."MFG Cost %" := (rec."MFG Cost Pcs" * 100 / rec."FOB Pcs");

                                // "Commercial Pcs" := ("Commercial %" * "FOB Pcs") / 100;
                                // "Commercial Dz." := "Commercial Pcs" * 12;
                                // "Commercial Total" := "Commercial Pcs" * Quantity;

                                CalTotalCost();
                            end;
                        }

                        field("MFG Cost Total"; rec."MFG Cost Total")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;

                        }
                    }

                    group("Overhead")
                    {
                        field("Overhead %"; rec."Overhead %")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            StyleExpr = 'StrongAccent';

                            trigger OnValidate()
                            var

                            begin
                                rec."Overhead Pcs" := (rec."Overhead %" * rec."FOB Pcs") / 100;
                                rec."Overhead Dz." := rec."Overhead Pcs" * 12;
                                rec."Overhead Total" := rec."Overhead Pcs" * rec.Quantity;

                                rec."Deferred Payment Pcs" := (rec."Deferred Payment %" * rec."Overhead Pcs") / 100;
                                rec."Deferred Payment Dz." := rec."Deferred Payment Pcs" * 12;
                                rec."Deferred Payment Total" := rec."Deferred Payment Pcs" * rec.Quantity;

                                CalTotalCost();
                            end;
                        }

                        field("Overhead Pcs"; rec."Overhead Pcs")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("Overhead Dz."; rec."Overhead Dz.")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("Overhead Total"; rec."Overhead Total")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }
                    }

                    group("Commission")
                    {
                        field("Commission %"; rec."Commission %")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            StyleExpr = 'StrongAccent';

                            trigger OnValidate()
                            var
                            begin
                                rec."Commission Pcs" := (rec."Commission %" * rec."FOB Pcs") / 100;
                                rec."Commission Dz." := rec."Commission Pcs" * 12;
                                rec."Commission Total" := rec."Commission Pcs" * rec.Quantity;

                                rec."Gross CM With Commission Dz." := rec."FOB Dz." - rec."Sub Total (Dz.) Dz." - rec."Commission Dz." - rec."Deferred Payment Dz.";
                                rec."Gross CM With Commission Pcs" := rec."Gross CM With Commission Dz." / 12;
                                rec."Gross CM With Commission %" := (rec."Gross CM With Commission Pcs" / rec."FOB Pcs") * 100;
                                rec."Gross CM With Commission Total" := rec."Gross CM With Commission Pcs" * rec.Quantity;

                                CalTotalCost();
                            end;
                        }

                        field("Commission Pcs"; rec."Commission Pcs")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("Commission Dz."; rec."Commission Dz.")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("Commission Total"; rec."Commission Total")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }
                    }

                    group("Commercial Cost")
                    {
                        field("Commercial %"; rec."Commercial %")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            StyleExpr = 'StrongAccent';

                            trigger OnValidate()
                            var
                            begin
                                rec."Commercial Pcs" := (rec."Commercial %" * rec."FOB Pcs") / 100;
                                rec."Commercial Dz." := rec."Commercial Pcs" * 12;
                                rec."Commercial Total" := rec."Commercial Pcs" * rec.Quantity;

                                CalTotalCost();
                            end;
                        }

                        field("Commercial Pcs"; rec."Commercial Pcs")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("Commercial Dz."; rec."Commercial Dz.")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("Commercial Total"; rec."Commercial Total")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }
                    }

                    group("Deferred Payment")
                    {
                        field("Deferred Payment %"; rec."Deferred Payment %")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            StyleExpr = 'StrongAccent';

                            trigger OnValidate()
                            var

                            begin
                                rec."Deferred Payment Pcs" := (rec."Deferred Payment %" * rec."FOB Pcs") / 100;
                                rec."Deferred Payment Dz." := rec."Deferred Payment Pcs" * 12;
                                rec."Deferred Payment Total" := rec."Deferred Payment Pcs" * rec.Quantity;

                                CalTotalCost();
                            end;
                        }

                        field("Deferred Payment Pcs"; rec."Deferred Payment Pcs")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("Deferred Payment Dz."; rec."Deferred Payment Dz.")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("Deferred Payment Total"; rec."Deferred Payment Total")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }
                    }

                    group("Risk Factor")
                    {
                        field("Risk factor %"; rec."Risk factor %")
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

                        field("Risk factor Pcs"; rec."Risk factor Pcs")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("Risk factor Dz."; rec."Risk factor Dz.")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("Risk factor Total"; rec."Risk factor Total")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }
                    }

                    group("TAX")
                    {
                        field("TAX %"; rec."TAX %")
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

                        field("TAX Pcs"; rec."TAX Pcs")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("TAX Dz."; rec."TAX Dz.")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("TAX Total"; rec."TAX Total")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }
                    }

                    group("Sourcing")
                    {
                        field("Sourcing %"; rec."ABA Sourcing %")
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

                        field("ABA Sourcing Pcs"; rec."ABA Sourcing Pcs")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("ABA Sourcing Dz."; rec."ABA Sourcing Dz.")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("ABA Sourcing Total"; rec."ABA Sourcing Total")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }
                    }

                    group("Total Cost")
                    {
                        field("Total Cost %"; rec."Total Cost %")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("Total Cost Pcs"; rec."Total Cost Pcs")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("Total Cost Dz."; rec."Total Cost Dz.")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("Total Cost Total"; rec."Total Cost Total")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;

                        }
                    }

                    group("Profit Margin")
                    {
                        field("Profit Margin %"; rec."Profit Margin %")
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
                                Total1 := rec."Commission %" + rec."Overhead %" + rec."Profit Margin %" + rec."Deferred Payment %" + rec."Commercial %" + rec."Risk factor %" + rec."ABA Sourcing %" + rec."TAX %";
                                Total2 := Total1 / (100 - Total1);
                                Total3 := rec."Sub Total (Dz.) Pcs" + rec."MFG Cost Pcs";
                                Total4 := Total2 * Total3;
                                rec."FOB Pcs" := Total3 + Total4;
                                FOB_Change();
                            end;
                        }

                        field("Profit Margin Pcs"; rec."Profit Margin Pcs")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("Profit Margin Dz."; rec."Profit Margin Dz.")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field("Profit Margin Total"; rec."Profit Margin Total")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;

                        }
                    }

                    group("Gross CM Less Commission ")
                    {
                        field("Gross CM Less Commission"; rec."Gross CM Less Commission")
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
                    if rec.Status = rec.Status::Approved then begin
                        Message('This BOM Costing is already approved');
                    end
                    else begin
                        rec.Status := rec.Status::"Pending Approval";
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
                    CustMangemnt: Codeunit "Customization Management";
                    StyleMasterRec: Record "Style Master";
                    LoginSessionsRec: Record LoginSessions;
                    LoginRec: Page "Login Card";
                begin

                    //Check whether user logged in or not
                    LoginSessionsRec.Reset();
                    LoginSessionsRec.SetRange(SessionID, SessionId());

                    if not LoginSessionsRec.FindSet() then begin  //not logged in
                        Clear(LoginRec);
                        LoginRec.LookupMode(true);
                        LoginRec.RunModal();

                        LoginSessionsRec.Reset();
                        LoginSessionsRec.SetRange(SessionID, SessionId());
                        LoginSessionsRec.FindSet();
                    end;

                    CustMangemnt.InsertTemp(Rec);

                    rec.Status := rec.Status::Approved;
                    rec."Approved Date" := WorkDate();
                    rec."Rejected Date" := 0D;
                    CurrPage.Update();

                    //Get max revision no
                    BOMCostReviHeaderRec.Reset();
                    BOMCostReviHeaderRec.SetRange("No.", rec."No.");

                    if not BOMCostReviHeaderRec.FindSet() then
                        Revision := 1
                    else
                        Revision := BOMCostReviHeaderRec.Count + 1;

                    //Write to Revision table
                    BOMCostReviHeaderRec.Init();
                    BOMCostReviHeaderRec."No." := rec."No.";
                    BOMCostReviHeaderRec.Revision := Revision;
                    BOMCostReviHeaderRec."ABA Sourcing %" := rec."ABA Sourcing %";
                    BOMCostReviHeaderRec."ABA Sourcing Dz." := rec."ABA Sourcing Dz.";
                    BOMCostReviHeaderRec."ABA Sourcing Pcs" := rec."ABA Sourcing Pcs";
                    BOMCostReviHeaderRec."ABA Sourcing Total" := rec."ABA Sourcing Total";
                    BOMCostReviHeaderRec."BOM No." := rec."BOM No.";
                    BOMCostReviHeaderRec."Brand Name" := rec."Brand Name";
                    BOMCostReviHeaderRec."Brand No." := rec."Brand No.";
                    BOMCostReviHeaderRec."Buyer Name" := rec."Buyer Name";
                    BOMCostReviHeaderRec."Buyer No." := rec."Buyer No.";
                    BOMCostReviHeaderRec."CM Doz" := rec."CM Doz";
                    BOMCostReviHeaderRec."Commercial %" := rec."Commercial %";
                    BOMCostReviHeaderRec."Commercial Dz." := rec."Commercial Dz.";
                    BOMCostReviHeaderRec."Commercial Pcs" := rec."Commercial Pcs";
                    BOMCostReviHeaderRec."Commercial Total" := rec."Commercial Total";
                    BOMCostReviHeaderRec."Commission %" := rec."Commission %";
                    BOMCostReviHeaderRec."Commission Dz." := rec."Commission Dz.";
                    BOMCostReviHeaderRec."Commercial Pcs" := rec."Commission Pcs";
                    BOMCostReviHeaderRec."Commercial Total" := rec."Commission Total";
                    BOMCostReviHeaderRec.CPM := rec.CPM;
                    BOMCostReviHeaderRec."Created Date" := rec."Created Date";
                    BOMCostReviHeaderRec."Created User" := rec."Created User";
                    BOMCostReviHeaderRec."Currency No." := rec."Currency No.";
                    BOMCostReviHeaderRec."Deferred Payment %" := rec."Deferred Payment %";
                    BOMCostReviHeaderRec."Deferred Payment Dz." := rec."Deferred Payment Dz.";
                    BOMCostReviHeaderRec."Deferred Payment Pcs" := rec."Deferred Payment Pcs";
                    BOMCostReviHeaderRec."Deferred Payment Total" := rec."Deferred Payment Total";
                    BOMCostReviHeaderRec."Department Name" := rec."Department Name";
                    BOMCostReviHeaderRec."Department No." := rec."Department No.";
                    BOMCostReviHeaderRec."Embroidery (Dz.)" := rec."Embroidery (Dz.)";
                    BOMCostReviHeaderRec.EPM := rec.EPM;
                    BOMCostReviHeaderRec."Factory Code" := rec."Factory Code";
                    BOMCostReviHeaderRec."Factory Name" := rec."Factory Name";
                    BOMCostReviHeaderRec."FOB %" := rec."FOB %";
                    BOMCostReviHeaderRec."FOB Dz." := rec."FOB Dz.";
                    BOMCostReviHeaderRec."FOB Pcs" := rec."FOB Pcs";
                    BOMCostReviHeaderRec."FOB Total" := rec."FOB Total";
                    BOMCostReviHeaderRec."Garment Type Name" := rec."Garment Type Name";
                    BOMCostReviHeaderRec."Garment Type No." := rec."Garment Type No.";
                    BOMCostReviHeaderRec."Gross CM Less Commission" := rec."Gross CM Less Commission";
                    BOMCostReviHeaderRec."Gross CM With Commission %" := rec."Gross CM With Commission %";
                    BOMCostReviHeaderRec."Gross CM With Commission Dz." := rec."Gross CM With Commission Dz.";
                    BOMCostReviHeaderRec."Gross CM With Commission Pcs" := rec."Gross CM With Commission Pcs";
                    BOMCostReviHeaderRec."Gross CM With Commission Total" := rec."Gross CM With Commission Total";
                    BOMCostReviHeaderRec."MFG Cost %" := rec."MFG Cost %";
                    BOMCostReviHeaderRec."MFG Cost Dz." := rec."MFG Cost Dz.";
                    BOMCostReviHeaderRec."MFG Cost Pcs" := rec."MFG Cost Pcs";
                    BOMCostReviHeaderRec."MFG Cost Total" := rec."MFG Cost Total";
                    BOMCostReviHeaderRec."Others (Dz.)" := rec."Others (Dz.)";
                    BOMCostReviHeaderRec."Overhead %" := rec."Overhead %";
                    BOMCostReviHeaderRec."Overhead Dz." := rec."Overhead Dz.";
                    BOMCostReviHeaderRec."Overhead Pcs" := rec."Overhead Pcs";
                    BOMCostReviHeaderRec."Overhead Total" := rec."Overhead Total";
                    BOMCostReviHeaderRec."Print Type" := rec."Print Type";
                    BOMCostReviHeaderRec."Print Type Name" := rec."Print Type Name";
                    BOMCostReviHeaderRec."Printing (Dz.)" := rec."Printing (Dz.)";
                    BOMCostReviHeaderRec."Profit Margin %" := rec."Profit Margin %";
                    BOMCostReviHeaderRec."Profit Margin Dz." := rec."Profit Margin Dz.";
                    BOMCostReviHeaderRec."Profit Margin Pcs" := rec."Profit Margin Pcs";
                    BOMCostReviHeaderRec."Profit Margin Total" := rec."Profit Margin Total";
                    BOMCostReviHeaderRec."Project Efficiency." := rec."Project Efficiency.";
                    BOMCostReviHeaderRec.Quantity := rec.Quantity;
                    BOMCostReviHeaderRec.Rate := rec.Rate;
                    BOMCostReviHeaderRec."Raw Material (Dz.)" := rec."Raw Material (Dz.)";
                    BOMCostReviHeaderRec."Revised Date" := WorkDate();
                    BOMCostReviHeaderRec."Risk factor %" := rec."Risk factor %";
                    BOMCostReviHeaderRec."Risk factor Dz." := rec."Risk factor Dz.";
                    BOMCostReviHeaderRec."Risk factor Pcs" := rec."Risk factor Pcs";
                    BOMCostReviHeaderRec."Risk factor Total" := rec."Risk factor Total";
                    BOMCostReviHeaderRec."Season Name" := rec."Season Name";
                    BOMCostReviHeaderRec."Season No." := rec."Season No.";
                    BOMCostReviHeaderRec.SMV := rec.SMV;
                    BOMCostReviHeaderRec.Status := rec.Status;
                    BOMCostReviHeaderRec."Stich Gmt" := rec."Stich Gmt";
                    BOMCostReviHeaderRec."Stich Gmt Name" := rec."Stich Gmt Name";
                    BOMCostReviHeaderRec."Store Name" := rec."Store Name";
                    BOMCostReviHeaderRec."Store No." := rec."Store No.";
                    BOMCostReviHeaderRec."Style Name" := rec."Style Name";
                    BOMCostReviHeaderRec."Style No." := rec."Style No.";
                    BOMCostReviHeaderRec."Sub Total (Dz.) Dz." := rec."Sub Total (Dz.) Dz.";
                    BOMCostReviHeaderRec."Sub Total (Dz.) Pcs" := rec."Sub Total (Dz.) Pcs";
                    BOMCostReviHeaderRec."Sub Total (Dz.) Total" := rec."Sub Total (Dz.) Total";
                    BOMCostReviHeaderRec."Sub Total (Dz.)%" := rec."Sub Total (Dz.)%";
                    BOMCostReviHeaderRec."TAX %" := rec."TAX %";
                    BOMCostReviHeaderRec."TAX Dz." := rec."TAX Dz.";
                    BOMCostReviHeaderRec."TAX Pcs" := rec."TAX Pcs";
                    BOMCostReviHeaderRec."TAX Total" := rec."TAX Total";
                    BOMCostReviHeaderRec."Total Cost %" := rec."Total Cost %";
                    BOMCostReviHeaderRec."Total Cost Dz." := rec."Total Cost Dz.";
                    BOMCostReviHeaderRec."Total Cost Pcs" := rec."Total Cost Pcs";
                    BOMCostReviHeaderRec."Total Cost Total" := rec."Total Cost Total";
                    BOMCostReviHeaderRec."Wash Type" := rec."Wash Type";
                    BOMCostReviHeaderRec."Wash Type Name" := rec."Wash Type Name";
                    BOMCostReviHeaderRec."Washing (Dz.)" := rec."Washing (Dz.)";
                    BOMCostReviHeaderRec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                    BOMCostReviHeaderRec.Insert();

                    //Write to line table
                    BOMCostLineRec.Reset();
                    BOMCostLineRec.SetRange("No.", rec."No.");

                    if BOMCostLineRec.FindSet() then begin
                        repeat
                            BOMCostReviLineRec.Init();
                            BOMCostReviLineRec."No." := rec."No.";
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

                    //Update style status confirmed. 
                    StyleMasterRec.Reset();
                    StyleMasterRec.Get(rec."Style No.");
                    StyleMasterRec.Status := StyleMasterRec.Status::Confirmed;
                    StyleMasterRec.Modify();

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
                    rec.Status := rec.Status::Rejected;
                    rec."Rejected Date" := WorkDate();
                    rec."Approved Date" := 0D;
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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."BOM Cost Nos.", xRec."No.", rec."No.") THEN BEGIN
            NoSeriesMngment.SetSeries(rec."No.");
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
        BOMEstCostLineRec.SetRange("No.", rec."No.");
        BOMEstCostLineRec.SetRange("BOM No.", rec."BOM No.");

        IF (BOMEstCostLineRec.FINDSET) THEN begin
            repeat

                RawMaterialCost += BOMEstCostLineRec."Doz Cost";
                rec."Raw Material (Dz.)" := RawMaterialCost;

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

        BOMEstimateCostLineRec.SetRange("No.", rec."No.");
        BOMEstimateCostLineRec.DeleteAll();

        BOMEstimateLineRec.reset;
        BOMEstimateLineRec.SetCurrentKey("Master Category No.");
        BOMEstimateLineRec.SetRange("No.", rec."BOM No.");
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
                    BOMEstimateCostLineRec."No." := rec."No.";
                    BOMEstimateCostLineRec."Master Category No." := "MasterCategoryNo.";
                    BOMEstimateCostLineRec."Master Category Name" := "MasterCategoryName.";
                    BOMEstimateCostLineRec."BOM No." := BOMEstimateLineRec."No.";
                    BOMEstimateCostLineRec.Value := Value;
                    BOMEstimateCostLineRec."Doz Cost" := (Value / rec.Quantity) * 12;
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
        BOMEstimateCostLineRec."No." := rec."No.";
        BOMEstimateCostLineRec."Master Category No." := "MasterCategoryNo.";
        BOMEstimateCostLineRec."Master Category Name" := "MasterCategoryName.";
        BOMEstimateCostLineRec."BOM No." := rec."BOM No.";
        BOMEstimateCostLineRec.Value := Value;
        BOMEstimateCostLineRec."Doz Cost" := (Value / rec.Quantity) * 12;
        BOMEstimateCostLineRec.Insert();

    end;

    procedure CalMFGCost()
    var

    begin
        rec."CM Doz" := ((rec.smv + (100 - rec."Project Efficiency.") / 100 * rec.SMV) * rec.CPM + ((rec.SMV + (100 - rec."Project Efficiency.") / 100 * rec.SMV) * rec.CPM) * rec.EPM / 100) * 12;
        rec."MFG Cost Dz." := rec."CM Doz";
        rec."MFG Cost Pcs" := rec."MFG Cost Dz." / 12;
        rec."MFG Cost Total" := rec."MFG Cost Pcs" * rec.Quantity;

        if rec."FOB Pcs" <> 0 then
            rec."MFG Cost %" := (rec."MFG Cost Pcs" * 100 / rec."FOB Pcs");

        // "Commercial Pcs" := ("Commercial %" * "FOB Pcs") / 100;
        // "Commercial Dz." := "Commercial Pcs" * 12;
        // "Commercial Total" := "Commercial Pcs" * Quantity;

    end;

    procedure CalTotalCost()
    var
    begin
        rec."Total Cost Dz." := rec."Sub Total (Dz.) Dz." + rec."MFG Cost Dz." + rec."Overhead Dz." + rec."Commission Dz." + rec."Commercial Dz." + rec."Deferred Payment Dz." + rec."TAX Dz." + rec."ABA Sourcing Dz." + rec."Risk factor Dz.";
        rec."Total Cost Pcs" := rec."Total Cost Dz." / 12;
        rec."Total Cost Total" := rec."Total Cost Pcs" * rec.Quantity;
        rec."Total Cost %" := (rec."Total Cost Pcs" * 100) / rec."FOB Pcs";

        CalProfitMargin();
    end;

    procedure CalProfitMargin()
    var
    begin
        rec."Profit Margin Pcs" := rec."FOB Pcs" - rec."Total Cost Pcs";
        rec."Profit Margin Dz." := rec."Profit Margin Pcs" * 12;
        rec."Profit Margin Total" := rec."Profit Margin Pcs" * rec.Quantity;
        rec."Profit Margin %" := (rec."Profit Margin Pcs" * 100) / rec."FOB Pcs";

        rec."Gross CM Less Commission" := rec."Gross CM With Commission Dz." - rec."Commission Dz." - rec."Deferred Payment Dz.";
    end;


    procedure FOB_Change()
    var
    begin

        if rec."FOB Pcs" <> 0 then begin
            rec."FOB Dz." := rec."FOB Pcs" * 12;
            rec."FOB %" := 100;
            rec."FOB Total" := rec."FOB Pcs" * rec.Quantity;

            rec."Sub Total (Dz.)%" := (rec."Sub Total (Dz.) Pcs" * 100) / rec."FOB Pcs";
            rec."Gross CM With Commission Dz." := rec."FOB Dz." - rec."Sub Total (Dz.) Dz." - rec."Commission Dz." - rec."Deferred Payment Dz.";
            rec."Gross CM With Commission Pcs" := rec."Gross CM With Commission Dz." / 12;
            rec."Gross CM With Commission %" := (rec."Gross CM With Commission Pcs" / rec."FOB Pcs") * 100;
            rec."Gross CM With Commission Total" := rec."Gross CM With Commission Pcs" * rec.Quantity;

            rec."MFG Cost %" := (rec."MFG Cost Pcs" * 100 / rec."FOB Pcs");

            rec."Overhead Pcs" := (rec."Overhead %" * rec."FOB Pcs") / 100;
            rec."Overhead Dz." := rec."Overhead Pcs" * 12;
            rec."Overhead Total" := rec."Overhead Pcs" * rec.Quantity;

            rec."Commission Pcs" := (rec."Commission %" * rec."FOB Pcs") / 100;
            rec."Commission Dz." := rec."Commission Pcs" * 12;
            rec."Commission Total" := rec."Commission Pcs" * rec.Quantity;

            rec."Commercial Pcs" := (rec."Commercial %" * rec."FOB Pcs") / 100;
            rec."Commercial Dz." := rec."Commercial Pcs" * 12;
            rec."Commercial Total" := rec."Commercial Pcs" * rec.Quantity;

            rec."Deferred Payment Pcs" := (rec."Deferred Payment %" * rec."FOB Pcs") / 100;
            rec."Deferred Payment Dz." := rec."Deferred Payment Pcs" * 12;
            rec."Deferred Payment Total" := rec."Deferred Payment Pcs" * rec.Quantity;

            rec."Risk factor Pcs" := (rec."Risk factor %" * rec."FOB Pcs") / 100;
            rec."Risk factor Dz." := rec."Risk factor Pcs" * 12;
            rec."Risk factor Total" := rec."Risk factor Pcs" * rec.Quantity;

            rec."TAX Pcs" := (rec."TAX %" * rec."FOB Pcs") / 100;
            rec."TAX Dz." := rec."TAX Pcs" * 12;
            rec."TAX Total" := rec."TAX Pcs" * rec.Quantity;

            rec."ABA Sourcing Pcs" := (rec."ABA Sourcing %" * rec."FOB Pcs") / 100;
            rec."ABA Sourcing Dz." := rec."ABA Sourcing Pcs" * 12;
            rec."ABA Sourcing Total" := rec."ABA Sourcing Pcs" * rec.Quantity;

            if rec."FOB Pcs" <> 0 then
                rec."Total Cost %" := (rec."Total Cost Pcs" * 100 / rec."FOB Pcs");

            CalTotalCost();

            //Running for the second time
            rec."FOB Dz." := rec."FOB Pcs" * 12;
            rec."FOB %" := 100;
            rec."FOB Total" := rec."FOB Pcs" * rec.Quantity;

            rec."Sub Total (Dz.)%" := (rec."Sub Total (Dz.) Pcs" * 100) / rec."FOB Pcs";
            rec."Gross CM With Commission Dz." := rec."FOB Dz." - rec."Sub Total (Dz.) Dz." - rec."Commission Dz." - rec."Deferred Payment Dz.";
            rec."Gross CM With Commission Pcs" := rec."Gross CM With Commission Dz." / 12;
            rec."Gross CM With Commission %" := (rec."Gross CM With Commission Pcs" / rec."FOB Pcs") * 100;
            rec."Gross CM With Commission Total" := rec."Gross CM With Commission Pcs" * rec.Quantity;

            rec."MFG Cost %" := (rec."MFG Cost Pcs" * 100 / rec."FOB Pcs");

            rec."Overhead Pcs" := (rec."Overhead %" * rec."FOB Pcs") / 100;
            rec."Overhead Dz." := rec."Overhead Pcs" * 12;
            rec."Overhead Total" := rec."Overhead Pcs" * rec.Quantity;

            rec."Commission Pcs" := (rec."Commission %" * rec."FOB Pcs") / 100;
            rec."Commission Dz." := rec."Commission Pcs" * 12;
            rec."Commission Total" := rec."Commission Pcs" * rec.Quantity;

            rec."Commercial Pcs" := (rec."Commercial %" * rec."FOB Pcs") / 100;
            rec."Commercial Dz." := rec."Commercial Pcs" * 12;
            rec."Commercial Total" := rec."Commercial Pcs" * rec.Quantity;

            rec."Deferred Payment Pcs" := (rec."Deferred Payment %" * rec."FOB Pcs") / 100;
            rec."Deferred Payment Dz." := rec."Deferred Payment Pcs" * 12;
            rec."Deferred Payment Total" := rec."Deferred Payment Pcs" * rec.Quantity;

            rec."Risk factor Pcs" := (rec."Risk factor %" * rec."FOB Pcs") / 100;
            rec."Risk factor Dz." := rec."Risk factor Pcs" * 12;
            rec."Risk factor Total" := rec."Risk factor Pcs" * rec.Quantity;

            rec."TAX Pcs" := (rec."TAX %" * rec."FOB Pcs") / 100;
            rec."TAX Dz." := rec."TAX Pcs" * 12;
            rec."TAX Total" := rec."TAX Pcs" * rec.Quantity;

            rec."ABA Sourcing Pcs" := (rec."ABA Sourcing %" * rec."FOB Pcs") / 100;
            rec."ABA Sourcing Dz." := rec."ABA Sourcing Pcs" * 12;
            rec."ABA Sourcing Total" := rec."ABA Sourcing Pcs" * rec.Quantity;


            if rec."FOB Pcs" <> 0 then
                rec."Total Cost %" := (rec."Total Cost Pcs" * 100 / rec."FOB Pcs");

            CalTotalCost();

        end;

    end;


    trigger OnDeleteRecord(): Boolean
    var
        BOMEstimateCostRec: Record "BOM Estimate Cost";
        BOMEstCostLineRec: Record "BOM Estimate Costing Line";
    begin
        BOMEstimateCostRec.SetRange("No.", rec."No.");
        BOMEstimateCostRec.DeleteAll();

        BOMEstCostLineRec.SetRange("No.", rec."No.");
        BOMEstCostLineRec.DeleteAll();
    end;


    trigger OnOpenPage()
    var
        NavAppSetup: Record "NavApp Setup";
    begin
        NavAppSetup.Get('0001');
        rec."Risk factor %" := NavAppSetup."Risk Factor";
        rec."TAX %" := NavAppSetup.TAX;
        rec."ABA Sourcing %" := NavAppSetup."ABA Sourcing";

        if rec."FOB Pcs" = 0 then
            rec."FOB Pcs" := 1;

        CurrPage.Update();
    end;

}