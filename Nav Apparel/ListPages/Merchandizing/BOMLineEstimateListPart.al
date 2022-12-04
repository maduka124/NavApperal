page 51031 "BOM Line Estimate ListPart"
{
    PageType = ListPart;
    SourceTable = "BOM Line Estimate";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Main Category Name"; rec."Main Category Name")
                {
                    ApplicationArea = All;
                    Caption = 'Main Category';
                    StyleExpr = StyleExprTxt;

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

                            rec."Item No." := '';
                            rec."Item Name" := '';
                            rec."Dimension No." := '';
                            rec."Dimension Name." := '';
                            // "Sub Category Name" := '';
                            // "Sub Category No." := '';
                            rec."Article No." := '';
                            rec."Article Name." := '';
                            rec."Supplier No." := '';
                            rec."Supplier Name." := '';
                        end;
                    end;
                }

                field("Item Name"; rec."Item Name")
                {
                    ApplicationArea = All;
                    Caption = 'Item';
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                        ItemRec: Record "Item";
                        BOMHeaderRec: record "BOM";
                    begin
                        ItemRec.Reset();
                        ItemRec.SetRange(Description, rec."Item Name");

                        if ItemRec.FindSet() then
                            rec."Item No." := ItemRec."No.";

                        //Get Qty from Header 
                        BOMHeaderRec.get(rec."No.");
                        rec.Qty := BOMHeaderRec.Quantity;
                    end;
                }

                field("Article Name."; rec."Article Name.")
                {
                    ApplicationArea = All;
                    Caption = 'Article';
                    StyleExpr = StyleExprTxt;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        ArticleRec: Record "Article";
                    begin
                        ArticleRec.Reset();
                        ArticleRec.SetRange(Article, rec."Article Name.");

                        if ArticleRec.FindSet() then
                            rec."Article No." := ArticleRec."No.";
                    end;
                }

                field("Dimension Name."; rec."Dimension Name.")
                {
                    ApplicationArea = All;
                    Caption = 'Dimension/Width';
                    StyleExpr = StyleExprTxt;
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
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        if rec."Article Name." = '' then
                            Error('Article is blank.');

                        if rec."Dimension Name." = '' then
                            Error('Dimension is blank.');

                        CalculateValue(0);
                    end;
                }

                field(Type; rec.Type)
                {
                    ApplicationArea = All;
                    Caption = 'Type';
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        if rec."Article Name." = '' then
                            Error('Article is blank.');

                        if rec."Dimension Name." = '' then
                            Error('Dimension is blank.');
                    end;
                }

                field("GMT Qty"; rec."GMT Qty")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        if rec."Article Name." = '' then
                            Error('Article is blank.');

                        if rec."Dimension Name." = '' then
                            Error('Dimension is blank.');
                    end;
                }

                field(Consumption; rec.Consumption)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;

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
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalculateValue(0);
                    end;
                }

                field(Rate; rec.Rate)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;

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
                    StyleExpr = StyleExprTxt;
                }

                field("Supplier Name."; rec."Supplier Name.")
                {
                    ApplicationArea = All;
                    Caption = 'Supplier';
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                        SupplierRec: Record Vendor;
                    begin
                        SupplierRec.Reset();
                        SupplierRec.SetRange(Name, rec."Supplier Name.");

                        if SupplierRec.FindSet() then
                            rec."Supplier No." := SupplierRec."No.";
                    end;
                }

                field(Requirment; rec.Requirment)
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field(AjstReq; rec.AjstReq)
                {
                    ApplicationArea = All;
                    Caption = 'Adjust. Req.';
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalculateWST();
                    end;
                }

                field(Qty; rec.Qty)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Size Sensitive"; rec."Size Sensitive")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Color Sensitive"; rec."Color Sensitive")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Country Sensitive"; rec."Country Sensitive")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("PO Sensitive"; rec."PO Sensitive")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(Reconfirm; rec.Reconfirm)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                    end;
                }

                field("Placement of GMT"; rec."Placement of GMT")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
            }
        }
    }


    trigger OnAfterGetRecord()
    var
    begin
        if rec.Reconfirm = true then
            StyleExprTxt := 'Strong'
        else
            StyleExprTxt := 'None';
    end;


    trigger OnAfterGetCurrRecord()
    var
    begin
        if rec.Reconfirm = true then
            StyleExprTxt := 'Strong'
        else
            StyleExprTxt := 'None';
    end;

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
        UOMRec.FindSet();
        ConvFactor := UOMRec."Converion Parameter";
        rec.Value := 0;
        rec.Requirment := 0;

        if rec.Type = rec.type::Pcs then
            rec.Requirment := (rec.Consumption * rec.Qty) + (rec.Consumption * rec.Qty) * rec.WST / 100
        else
            if rec.Type = rec.type::Doz then
                rec.Requirment := ((rec.Consumption * rec.Qty) + (rec.Consumption * rec.Qty) * rec.WST / 100) / 12;

        if (x = 0) and (ConvFactor <> 0) then
            rec.Requirment := rec.Requirment / ConvFactor;

        if rec.Requirment = 0 then
            rec.Requirment := 1;

        rec.Value := rec.Requirment * rec.Rate;
        CurrPage.Update(true);
        // CalculateCost();
    end;

    procedure CalculateWST()
    var
        X: Decimal;
        y: Decimal;
    begin

        case rec.Type of
            rec.type::Pcs:
                begin
                    //Message(format(AjstReq / Requirment));
                    rec.WST := rec.WST + ((rec.AjstReq / rec.Requirment) - 1) * 100;
                end;
            rec.type::Doz:
                begin
                    // X := AjstReq / Requirment;
                    // Message(format(x));
                    // y := x - 1;
                    // Message(format(y));
                    rec.WST := rec.WST + ((rec.AjstReq / rec.Requirment) - 1) * 100;
                end;
        end;


        //if Type = type::Pcs then
        // if AjstReq = 0 then
        //     WST := (100 * Requirment) / (Qty * Consumption) - 100
        // else
        //     WST := (100 * AjstReq) / (Qty * Consumption) - 100
        //else
        // if Type = type::Doz then
        //     if AjstReq = 0 then
        //         WST := (100 * Requirment * 12) / (Qty * Consumption) - 100
        //     else
        //         WST := (100 * AjstReq * 12) / (Qty * Consumption) - 100;

        CalculateValue(0);
    end;


    trigger OnDeleteRecord(): Boolean
    var
        BOMLineRec: Record "BOM Line";
        BLAutoGenNewRec: Record "BOM Line AutoGen";
    begin

        //Delete existing records
        BLAutoGenNewRec.Reset();
        BLAutoGenNewRec.SetRange("No.", rec."No.");
        BLAutoGenNewRec.SetRange("Item No.", rec."Item No.");
        BLAutoGenNewRec.SetRange("Placement of GMT", rec."Placement of GMT");
        BLAutoGenNewRec.SetFilter("Included in PO", '=%1', true);

        if BLAutoGenNewRec.FindSet() then
            Error('This item has been raised for the PO. Cannot delete')
        else begin

            //Delete from AutoGen table
            BLAutoGenNewRec.Reset();
            BLAutoGenNewRec.SetRange("No.", rec."No.");
            BLAutoGenNewRec.SetRange("Item No.", rec."Item No.");
            BLAutoGenNewRec.SetRange("Placement of GMT", rec."Placement of GMT");
            BLAutoGenNewRec.DeleteAll();

            //Delete from BOM Lines(Coor/Size/Country/PO) table
            BOMLineRec.Reset();
            BOMLineRec.SetRange("No.", rec."No.");
            BOMLineRec.SetRange("Item No.", rec."Item No.");
            BOMLineRec.SetRange(Placement, rec."Placement of GMT");
            BOMLineRec.DeleteAll();
        end;
    end;

    var
        StyleExprTxt: Text[50];

}