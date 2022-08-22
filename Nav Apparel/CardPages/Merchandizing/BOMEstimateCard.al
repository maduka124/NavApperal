page 71012694 "BOM Estimate Card"
{
    PageType = Card;
    SourceTable = "BOM Estimate";
    Caption = 'Estimate BOM';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Estimate BOM No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Style';

                    trigger OnValidate()
                    var
                        StyleMasterRec: Record "Style Master";
                        CustomerRec: Record Customer;
                        BOMRec: Record "BOM Estimate";
                    begin

                        //Check for duplicates
                        BOMRec.Reset();
                        BOMRec.SetRange("Style Name", "Style Name");
                        if BOMRec.FindSet() then
                            Error('Style : %1 already used to create an Estimate BOM ', BOMRec."Style Name");

                        StyleMasterRec.Reset();
                        StyleMasterRec.SetRange("Style No.", "Style Name");
                        if StyleMasterRec.FindSet() then
                            "Style No." := StyleMasterRec."No.";

                        CurrPage.Update();

                        StyleMasterRec.get("Style No.");
                        "Style Name" := StyleMasterRec."Style No.";
                        "Store No." := StyleMasterRec."Store No.";
                        "Brand No." := StyleMasterRec."Brand No.";
                        "Buyer No." := StyleMasterRec."Buyer No.";
                        "Season No." := StyleMasterRec."Season No.";
                        "Department No." := StyleMasterRec."Department No.";
                        "Garment Type No." := StyleMasterRec."Garment Type No.";

                        "Store Name" := StyleMasterRec."Store Name";
                        "Brand Name" := StyleMasterRec."Brand Name";
                        "Buyer Name" := StyleMasterRec."Buyer Name";
                        "Season Name" := StyleMasterRec."Season Name";
                        "Department Name" := StyleMasterRec."Department Name";
                        "Garment Type Name" := StyleMasterRec."Garment Type Name";
                        Quantity := StyleMasterRec."Order Qty";

                        CustomerRec.get("Buyer No.");
                        "Currency No." := CustomerRec."Currency Code";

                        //Assigh Estimate bom no to the style. (For "Copy BOM feature" purpose only)
                        StyleMasterRec.EstimateBOM := "No.";
                        StyleMasterRec.Modify();

                        CurrPage.Update();

                    end;
                }

                field("Store Name"; "Store Name")
                {
                    ApplicationArea = All;
                    Caption = 'Store';

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

                // field(Revision; Revision)
                // {
                //     ApplicationArea = All;
                // }

                field(Quantity; Quantity)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        BOMEstLineRec: Record "BOM Estimate Line";
                        ConvFactor: Decimal;
                        UOMRec: Record "Unit of Measure";
                        x: Integer;
                        Total: Decimal;
                    begin

                        Total := 0;
                        BOMEstLineRec.Reset();
                        BOMEstLineRec.SetRange("No.", "No.");
                        if BOMEstLineRec.FindSet() then begin

                            repeat
                                BOMEstLineRec.qty := Quantity;

                                UOMRec.Reset();
                                UOMRec.SetRange(Code, BOMEstLineRec."Unit N0.");
                                if UOMRec.FindSet() then
                                    ConvFactor := UOMRec."Converion Parameter";

                                if BOMEstLineRec.Type = BOMEstLineRec.type::Pcs then
                                    BOMEstLineRec.Requirment := (BOMEstLineRec.Consumption * Quantity) + (BOMEstLineRec.Consumption * Quantity) * BOMEstLineRec.WST / 100
                                else
                                    if BOMEstLineRec.Type = BOMEstLineRec.type::Doz then
                                        BOMEstLineRec.Requirment := ((BOMEstLineRec.Consumption * Quantity) + (BOMEstLineRec.Consumption * Quantity) * BOMEstLineRec.WST / 100) / 12;

                                if (x = 0) and (ConvFactor <> 0) then
                                    BOMEstLineRec.Requirment := BOMEstLineRec.Requirment / ConvFactor;

                                BOMEstLineRec.Requirment := Round(BOMEstLineRec.Requirment, 1);
                                BOMEstLineRec.Value := BOMEstLineRec.Requirment * BOMEstLineRec.Rate;
                                Total += BOMEstLineRec.Value;

                                BOMEstLineRec.Modify();

                            until BOMEstLineRec.Next() = 0;

                            if Quantity <> 0 then
                                "Material Cost Pcs." := (Total / Quantity);

                            "Material Cost Doz." := "Material Cost Pcs." * 12;
                            CurrPage.Update();
                        end;
                    end;
                }

                field("Currency No."; "Currency No.")
                {
                    ApplicationArea = All;
                    Caption = 'Currency';
                }

                field("Material Cost Doz."; "Material Cost Doz.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Material Cost Pcs."; "Material Cost Pcs.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group(" ")
            {
                part("BOM Estimate Line List part"; "BOM Estimate Line List part")
                {
                    ApplicationArea = All;
                    Caption = 'Line Items';
                    SubPageLink = "No." = FIELD("No.");
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
            action(Calculate)
            {
                ApplicationArea = All;
                Image = Calculate;

                trigger OnAction()
                var
                    BOMEstimateLIneRec: Record "BOM Estimate Line";
                    Total: Decimal;
                begin

                    if Quantity = 0 then
                        Error('Quantity is zero. Cannot proceed.');

                    Total := 0;
                    BOMEstimateLIneRec.Reset();
                    BOMEstimateLIneRec.SetCurrentKey("No.");
                    BOMEstimateLIneRec.SetRange("No.", "No.");

                    IF (BOMEstimateLIneRec.FINDSET) THEN
                        repeat

                            if BOMEstimateLIneRec.Type = BOMEstimateLIneRec.Type::Pcs then
                                if BOMEstimateLIneRec.AjstReq = 0 then
                                    BOMEstimateLIneRec.WST := (100 * BOMEstimateLIneRec.Requirment) / (BOMEstimateLIneRec.Qty * BOMEstimateLIneRec.Consumption) - 100
                                else
                                    BOMEstimateLIneRec.WST := (100 * BOMEstimateLIneRec.AjstReq) / (BOMEstimateLIneRec.Qty * BOMEstimateLIneRec.Consumption) - 100
                            else
                                if BOMEstimateLIneRec.Type = BOMEstimateLIneRec.Type::Doz then
                                    if BOMEstimateLIneRec.AjstReq = 0 then
                                        BOMEstimateLIneRec.WST := (100 * BOMEstimateLIneRec.Requirment * 12) / (BOMEstimateLIneRec.Qty * BOMEstimateLIneRec.Consumption) - 100
                                    else
                                        BOMEstimateLIneRec.WST := (100 * BOMEstimateLIneRec.AjstReq * 12) / (BOMEstimateLIneRec.Qty * BOMEstimateLIneRec.Consumption) - 100;


                            if BOMEstimateLIneRec.Type = BOMEstimateLIneRec.Type::Pcs then
                                BOMEstimateLIneRec.Requirment := (BOMEstimateLIneRec.Consumption * BOMEstimateLIneRec.Qty) + (BOMEstimateLIneRec.Qty * BOMEstimateLIneRec.Consumption) * BOMEstimateLIneRec.WST / 100
                            else
                                if BOMEstimateLIneRec.Type = BOMEstimateLIneRec.Type::Doz then
                                    BOMEstimateLIneRec.Requirment := ((BOMEstimateLIneRec.Consumption * BOMEstimateLIneRec.Qty) + (BOMEstimateLIneRec.Qty * BOMEstimateLIneRec.Consumption) * BOMEstimateLIneRec.WST / 100) / 12;

                            BOMEstimateLIneRec.Requirment := Round(BOMEstimateLIneRec.Requirment, 1);
                            BOMEstimateLIneRec.Value := BOMEstimateLIneRec.Requirment * BOMEstimateLIneRec.Rate;
                            Total += BOMEstimateLIneRec.Value;
                            BOMEstimateLIneRec.Modify();

                        until BOMEstimateLIneRec.Next() = 0;

                    "Material Cost Pcs." := (Total / Quantity);
                    "Material Cost Doz." := "Material Cost Pcs." * 12;
                    CurrPage.Update();

                    Message('Completed');

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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."BOM Nos.", xRec."No.", "No.") THEN BEGIN
            NoSeriesMngment.SetSeries("No.");
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        BOMEstimateRec: Record "BOM Estimate";
        BOMLineEstRec: Record "BOM Estimate Line";
        StyleMas: Record "Style Master";
    begin
        BOMEstimateRec.SetRange("No.", "No.");
        BOMEstimateRec.DeleteAll();

        BOMLineEstRec.SetRange("No.", "No.");
        BOMLineEstRec.DeleteAll();

        StyleMas.Reset();
        StyleMas.SetRange("No.", "Style No.");
        StyleMas.FindSet();
        StyleMas.ModifyAll(EstimateBOM, '');

    end;

    trigger OnClosePage()
    var
        BOMEstLineRec: Record "BOM Estimate Line";
    begin
        BOMEstLineRec.Reset();
        BOMEstLineRec.SetRange("No.", "No.");
        if BOMEstLineRec.FindSet() then begin
            repeat
                if BOMEstLineRec."Supplier No." = '' then
                    Error('Suppler is mandatory.');

            until BOMEstLineRec.Next() = 0;

        end;

        if "Material Cost Doz." = 0 then
            Error('Material Cost Doz is not calculated.');

        if "Material Cost Pcs." = 0 then
            Error('Material Cost Pcs is not calculated.');

    end;

}