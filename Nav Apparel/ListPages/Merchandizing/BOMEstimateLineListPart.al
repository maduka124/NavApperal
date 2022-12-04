page 71012695 "BOM Estimate Line List part"
{
    PageType = ListPart;
    SourceTable = "BOM Estimate Line";
    SourceTableView = sorting("No.", "Line No.") order(ascending);
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Main Category Name"; "Main Category Name")
                {
                    ApplicationArea = All;
                    Caption = 'Main Category';

                    trigger OnValidate()
                    var
                        MainCategoryRec: Record "Main Category";
                    begin
                        MainCategoryRec.Reset();
                        MainCategoryRec.SetRange("Main Category Name", "Main Category Name");
                        if MainCategoryRec.FindSet() then begin

                            if MainCategoryRec."Inv. Posting Group Code" = '' then
                                Error('Inventory Posting Group is not setup for this Main Category. Cannot proceed.');

                            if MainCategoryRec."Prod. Posting Group Code" = '' then
                                Error('Prod. Posting Group is not setup for this Main Category. Cannot proceed.');

                            "Main Category No." := MainCategoryRec."No.";
                            "Master Category No." := MainCategoryRec."Master Category No.";
                            "Master Category Name" := MainCategoryRec."Master Category Name";

                            "Item No." := '';
                            "Item Name" := '';
                            "Dimension No." := '';
                            "Dimension Name." := '';
                            "Article No." := '';
                            "Article Name." := '';
                            "Supplier No." := '';
                            "Supplier Name." := '';
                        end;
                    end;
                }

                field("Item Name"; "Item Name")
                {
                    ApplicationArea = All;
                    Caption = 'Item';

                    trigger OnValidate()
                    var
                        ItemRec: Record "Item";
                        BOMHeaderRec: record "BOM Estimate";
                        VendorRec: Record Vendor;
                    begin
                        ItemRec.Reset();
                        ItemRec.SetRange(Description, "Item Name");
                        if ItemRec.FindSet() then
                            "Item No." := ItemRec."No.";

                        CurrPage.Update();

                        if ItemRec."Vendor No." <> '' then begin

                            "Supplier No." := ItemRec."Vendor No.";
                            VendorRec.Reset();
                            VendorRec.SetRange("No.", ItemRec."Vendor No.");

                            if VendorRec.FindSet() then
                                "Supplier Name." := VendorRec.Name;

                        end;

                        //Get Qty from Header 
                        BOMHeaderRec.get("No.");
                        Qty := BOMHeaderRec.Quantity;

                        CurrPage.Update();
                    end;
                }

                field("Article Name."; "Article Name.")
                {
                    ApplicationArea = All;
                    Caption = 'Article/Construction';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        ConstructionRec: Record Article;
                    begin
                        ConstructionRec.Reset();
                        ConstructionRec.SetRange(Article, "Article Name.");
                        if ConstructionRec.FindSet() then
                            "Article No." := ConstructionRec."No.";
                    end;
                }

                field("Dimension Name."; "Dimension Name.")
                {
                    ApplicationArea = All;
                    Caption = 'Dimension';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        DimensionRec: Record DimensionWidth;
                    begin
                        DimensionRec.Reset();
                        DimensionRec.SetRange("Dimension Width", "Dimension Name.");
                        if DimensionRec.FindSet() then
                            "Dimension No." := DimensionRec."No.";
                    end;
                }

                field("Unit N0."; "Unit N0.")
                {
                    ApplicationArea = All;
                    Caption = 'Unit';

                    trigger OnValidate()
                    var
                    begin
                        CalculateValue(0);
                    end;
                }

                field(Type; Type)
                {
                    ApplicationArea = All;
                    Caption = 'Type';

                    trigger OnValidate()
                    var
                    begin
                        CalculateValue(0);
                    end;
                }

                field(Consumption; Consumption)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalculateValue(0);
                    end;
                }

                field(WST; WST)
                {
                    ApplicationArea = All;
                    Caption = 'WST%';

                    trigger OnValidate()
                    var

                    begin
                        CalculateValue(0);
                    end;
                }

                field(Rate; Rate)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalculateValue(0);
                    end;
                }

                field(Value; Value)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Supplier Name."; "Supplier Name.")
                {
                    ApplicationArea = All;
                    Caption = 'Supplier';

                    trigger OnValidate()
                    var
                        SupplierRec: Record Vendor;
                    begin
                        SupplierRec.Reset();
                        SupplierRec.SetRange(Name, "Supplier Name.");
                        if SupplierRec.FindSet() then
                            "Supplier No." := SupplierRec."No.";

                        CurrPage.Update();
                    end;
                }

                field(Requirment; Requirment)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(AjstReq; AjstReq)
                {
                    ApplicationArea = All;
                    Caption = 'Adjust. Req.';

                    trigger OnValidate()
                    var

                    begin
                        CalculateWST();
                    end;
                }
            }
        }
    }

    procedure CalculateValue(x: Integer)
    var
        ConvFactor: Decimal;
        UOMRec: Record "Unit of Measure";
    begin

        if "Article Name." = '' then
            Error('Article is blank.');

        if "Dimension Name." = '' then
            Error('Dimension is blank.');

        UOMRec.Reset();
        UOMRec.SetRange(Code, "Unit N0.");
        if UOMRec.FindSet() then
            ConvFactor := UOMRec."Converion Parameter";

        // if ConvFactor = 0 then
        //     Error('Conversion Factor is zero. Cannot proceed');

        if Type = type::Pcs then
            Requirment := (Consumption * Qty) + (Consumption * Qty) * WST / 100
        else
            if Type = type::Doz then
                Requirment := ((Consumption * Qty) + (Consumption * Qty) * WST / 100) / 12;

        if (x = 0) and (ConvFactor <> 0) then
            Requirment := Requirment / ConvFactor;

        if Requirment = 0 then
            Requirment := 1;

        //Requirment := Round(Requirment, 1);
        Value := Requirment * Rate;
        CurrPage.Update(true);
        CalculateCost();

    end;

    procedure CalculateWST()
    var
    begin

        case Type of
            type::Pcs:
                begin
                    WST := WST + ((AjstReq / Requirment) - 1) * 100;
                end;
            type::Doz:
                begin
                    WST := WST + ((AjstReq / Requirment) - 1) * 100;
                end;
        end;

        // if Type = type::Pcs then
        //     if AjstReq = 0 then
        //         WST := (100 * Requirment) / (Qty * Consumption) - 100
        //     else
        //         WST := (100 * AjstReq) / (Qty * Consumption) - 100
        // else
        //     if Type = type::Doz then
        //         if AjstReq = 0 then
        //             WST := (100 * Requirment * 12) / (Qty * Consumption) - 100
        //         else
        //             WST := (100 * AjstReq * 12) / (Qty * Consumption) - 100;

        CalculateValue(0);
    end;

    procedure CalculateCost()
    var
        BOMEstimateLIneRec: Record "BOM Estimate Line";
        Total: Decimal;
        BOMHeaderRec: record "BOM Estimate";
    begin

        // if Qty = 0 then
        //     Error('Quantity is zero. Cannot proceed');

        Total := 0;
        BOMEstimateLIneRec.Reset();
        BOMEstimateLIneRec.SetCurrentKey("No.");
        BOMEstimateLIneRec.SetRange("No.", "No.");

        IF (BOMEstimateLIneRec.FINDSET) THEN
            repeat
                Total += BOMEstimateLIneRec.Value;
            until BOMEstimateLIneRec.Next() = 0;


        BOMHeaderRec.get("No.");

        if Qty <> 0 then
            BOMHeaderRec."Material Cost Pcs." := (Total / Qty);

        BOMHeaderRec."Material Cost Doz." := BOMHeaderRec."Material Cost Pcs." * 12;
        BOMHeaderRec.Modify();

    end;

}