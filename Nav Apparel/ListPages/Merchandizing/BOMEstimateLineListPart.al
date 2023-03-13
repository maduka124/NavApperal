page 51025 "BOM Estimate Line List part"
{
    PageType = ListPart;
    SourceTable = "BOM Estimate Line";
    SourceTableView = sorting("No.", "Line No.") order(ascending);
    AutoSplitKey = true;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                // field("Line No."; rec."Line No.")
                // {
                //     ApplicationArea = all;
                // }


                field("Main Category Name"; rec."Main Category Name")
                {
                    ApplicationArea = All;
                    Caption = 'Main Category';

                    trigger OnValidate()
                    var
                        MainCategoryRec: Record "Main Category";
                    begin
                        MainCategoryRec.Reset();
                        MainCategoryRec.SetRange("Main Category Name", rec."Main Category Name");
                        if MainCategoryRec.FindSet() then begin

                            if MainCategoryRec."Inv. Posting Group Code" = '' then
                                Error('Inventory Posting Group is not setup for this Main Category. Cannot proceed.');

                            if MainCategoryRec."Prod. Posting Group Code" = '' then
                                Error('Prod. Posting Group is not setup for this Main Category. Cannot proceed.');

                            rec."Main Category No." := MainCategoryRec."No.";
                            rec."Master Category No." := MainCategoryRec."Master Category No.";
                            rec."Master Category Name" := MainCategoryRec."Master Category Name";

                            rec."Item No." := '';
                            rec."Item Name" := '';
                            rec."Dimension No." := '';
                            rec."Dimension Name." := '';
                            rec."Article No." := '';
                            rec."Article Name." := '';
                            rec."Supplier No." := '';
                            rec."Supplier Name." := '';
                            CurrPage.Update();
                        end;
                    end;
                }

                field("Item Name"; rec."Item Name")
                {
                    ApplicationArea = All;
                    Caption = 'Item';

                    trigger OnLookup(var texts: text): Boolean
                    var
                        BOMHeaderRec: record "BOM Estimate";
                        ItemRec: Record "Item";
                        VendorRec: Record Vendor;
                    begin
                        ItemRec.Reset();
                        ItemRec.SetRange("Main Category No.", Rec."Main Category No.");
                        ItemRec.SetFilter("EstimateBOM Item", '=%1', true);
                        if ItemRec.FindSet() then begin

                            if Page.RunModal(51161, ItemRec) = Action::LookupOK then begin
                                Rec."Item Name" := ItemRec.Description;
                                Rec."Item No." := ItemRec."No.";
                            end;

                            ItemRec.Reset();
                            ItemRec.SetRange(Description, rec."Item Name");
                            ItemRec.FindSet();

                            if ItemRec."Vendor No." <> '' then begin

                                rec."Supplier No." := ItemRec."Vendor No.";
                                VendorRec.Reset();
                                VendorRec.SetRange("No.", ItemRec."Vendor No.");

                                if VendorRec.FindSet() then
                                    rec."Supplier Name." := VendorRec.Name;
                            end;

                            rec."Unit N0." := ItemRec."Base Unit of Measure";

                            //Get Qty from Header 
                            BOMHeaderRec.Reset();
                            BOMHeaderRec.SetRange("No.", rec."No.");
                            if BOMHeaderRec.FindSet() then
                                rec.Qty := BOMHeaderRec.Quantity;

                            //CurrPage.Update();

                        end;
                    end;


                    // trigger OnValidate()
                    // var
                    //     ItemRec: Record "Item";
                    //     BOMHeaderRec: record "BOM Estimate";
                    //     VendorRec: Record Vendor;
                    // begin
                    //     ItemRec.Reset();
                    //     ItemRec.SetRange(Description, rec."Item Name");
                    //     if ItemRec.FindSet() then
                    //         rec."Item No." := ItemRec."No."
                    //     else
                    //         Error('Invalid Item.');

                    //     CurrPage.Update();

                    //     if ItemRec."Vendor No." <> '' then begin

                    //         rec."Supplier No." := ItemRec."Vendor No.";
                    //         VendorRec.Reset();
                    //         VendorRec.SetRange("No.", ItemRec."Vendor No.");

                    //         if VendorRec.FindSet() then
                    //             rec."Supplier Name." := VendorRec.Name;

                    //     end;

                    //     //Get Qty from Header 
                    //     BOMHeaderRec.Reset();
                    //     BOMHeaderRec.SetRange("No.", rec."No.");
                    //     if BOMHeaderRec.FindSet() then
                    //         rec.Qty := BOMHeaderRec.Quantity;

                    //     CurrPage.Update();
                    // end;
                }

                field("Article Name."; rec."Article Name.")
                {
                    ApplicationArea = All;
                    Caption = 'Article/Construction';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        ConstructionRec: Record Article;
                    begin
                        ConstructionRec.Reset();
                        ConstructionRec.SetRange(Article, rec."Article Name.");
                        if ConstructionRec.FindSet() then
                            rec."Article No." := ConstructionRec."No.";
                    end;
                }

                field("Dimension Name."; rec."Dimension Name.")
                {
                    ApplicationArea = All;
                    Caption = 'Dimension';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        DimensionRec: Record DimensionWidth;
                    begin
                        DimensionRec.Reset();
                        DimensionRec.SetRange("Dimension Width", rec."Dimension Name.");
                        if DimensionRec.FindSet() then
                            rec."Dimension No." := DimensionRec."No.";
                    end;
                }

                field("Unit N0."; rec."Unit N0.")
                {
                    ApplicationArea = All;
                    Caption = 'Unit';

                    trigger OnValidate()
                    var
                    begin
                        CalculateValue(0);
                    end;
                }

                field(Type; rec.Type)
                {
                    ApplicationArea = All;
                    Caption = 'Type';

                    trigger OnValidate()
                    var
                    begin
                        CalculateValue(0);
                    end;
                }

                field(Consumption; rec.Consumption)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalculateValue(0);
                    end;
                }

                field(WST; rec.WST)
                {
                    ApplicationArea = All;
                    Caption = 'WST%';

                    trigger OnValidate()
                    var

                    begin
                        CalculateValue(0);
                    end;
                }

                field(Rate; rec.Rate)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalculateValue(0);
                    end;
                }

                field(Value; rec.Value)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Supplier Name."; rec."Supplier Name.")
                {
                    ApplicationArea = All;
                    Caption = 'Supplier';

                    trigger OnValidate()
                    var
                        SupplierRec: Record Vendor;
                    begin
                        SupplierRec.Reset();
                        SupplierRec.SetRange(Name, rec."Supplier Name.");
                        if SupplierRec.FindSet() then
                            rec."Supplier No." := SupplierRec."No."
                        else
                            Error('Invalid Supplier Name');

                        CurrPage.Update();
                    end;
                }

                field(Requirment; rec.Requirment)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(AjstReq; rec.AjstReq)
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

        if rec."Article Name." = '' then
            Error('Article is blank.');

        if rec."Dimension Name." = '' then
            Error('Dimension is blank.');

        UOMRec.Reset();
        UOMRec.SetRange(Code, rec."Unit N0.");
        if UOMRec.FindSet() then
            ConvFactor := UOMRec."Converion Parameter";

        // if ConvFactor = 0 then
        //     Error('Conversion Factor is zero. Cannot proceed');

        if rec.Type = rec.type::Pcs then
            rec.Requirment := (rec.Consumption * rec.Qty) + (rec.Consumption * rec.Qty) * rec.WST / 100
        else
            if rec.Type = rec.type::Doz then
                rec.Requirment := ((rec.Consumption * rec.Qty) + (rec.Consumption * rec.Qty) * rec.WST / 100) / 12;

        if (x = 0) and (ConvFactor <> 0) then
            rec.Requirment := rec.Requirment / ConvFactor;

        if rec.Requirment = 0 then
            rec.Requirment := 1;

        //Requirment := Round(Requirment, 1);
        rec.Value := rec.Requirment * rec.Rate;
        CurrPage.Update(true);
        CalculateCost();

    end;

    procedure CalculateWST()
    var
    begin

        case rec.Type of
            rec.type::Pcs:
                begin
                    rec.WST := rec.WST + ((rec.AjstReq / rec.Requirment) - 1) * 100;
                end;
            rec.type::Doz:
                begin
                    rec.WST := rec.WST + ((rec.AjstReq / rec.Requirment) - 1) * 100;
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
        BOMEstimateLIneRec.SetRange("No.", rec."No.");

        IF (BOMEstimateLIneRec.FINDSET) THEN
            repeat
                Total += BOMEstimateLIneRec.Value;
            until BOMEstimateLIneRec.Next() = 0;


        BOMHeaderRec.get(rec."No.");

        if rec.Qty <> 0 then
            BOMHeaderRec."Material Cost Pcs." := (Total / rec.Qty);

        BOMHeaderRec."Material Cost Doz." := BOMHeaderRec."Material Cost Pcs." * 12;
        BOMHeaderRec.Modify();

    end;

}