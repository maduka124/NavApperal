page 71012683 "BOM Line Estimate ListPart"
{
    PageType = ListPart;
    SourceTable = "BOM Line Estimate";

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
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                        MainCategoryRec: Record "Main Category";
                    begin
                        MainCategoryRec.Reset();
                        MainCategoryRec.SetRange("Main Category Name", "Main Category Name");
                        if MainCategoryRec.FindSet() then begin
                            if MainCategoryRec."Inv. Posting Group Code" = '' then
                                Error('Inventory Posting Group is not setup for this Main Category. Cannot proceed.');
                            "Main Category No." := MainCategoryRec."No.";
                        end;
                    end;
                }

                field("Item Name"; "Item Name")
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
                        ItemRec.SetRange(Description, "Item Name");

                        if ItemRec.FindSet() then
                            "Item No." := ItemRec."No.";

                        //Get Qty from Header 
                        BOMHeaderRec.get("No.");
                        Qty := BOMHeaderRec.Quantity;
                    end;
                }

                field("Article Name."; "Article Name.")
                {
                    ApplicationArea = All;
                    Caption = 'Article';
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                        ArticleRec: Record "Article";
                    begin
                        ArticleRec.Reset();
                        ArticleRec.SetRange(Article, "Article Name.");

                        if ArticleRec.FindSet() then
                            "Article No." := ArticleRec."No.";
                    end;
                }

                field("Dimension Name."; "Dimension Name.")
                {
                    ApplicationArea = All;
                    Caption = 'Dimension/Width';
                    StyleExpr = StyleExprTxt;

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
                    StyleExpr = StyleExprTxt;

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
                    StyleExpr = StyleExprTxt;
                }

                field("GMT Qty"; "GMT Qty")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(Consumption; Consumption)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;

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
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var

                    begin
                        CalculateValue(0);
                    end;
                }

                field(Rate; Rate)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;

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
                    StyleExpr = StyleExprTxt;
                }

                field("Supplier Name."; "Supplier Name.")
                {
                    ApplicationArea = All;
                    Caption = 'Supplier';
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                        SupplierRec: Record Vendor;
                    begin
                        SupplierRec.Reset();
                        SupplierRec.SetRange(Name, "Supplier Name.");

                        if SupplierRec.FindSet() then
                            "Supplier No." := SupplierRec."No.";
                    end;
                }

                field(Requirment; Requirment)
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field(AjstReq; AjstReq)
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

                field(Qty; Qty)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Size Sensitive"; "Size Sensitive")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Color Sensitive"; "Color Sensitive")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Country Sensitive"; "Country Sensitive")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("PO Sensitive"; "PO Sensitive")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(Reconfirm; Reconfirm)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                    end;
                }

                field("Placement of GMT"; "Placement of GMT")
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

        if Reconfirm = true then
            StyleExprTxt := 'Strong'
        else
            StyleExprTxt := 'None';
    end;


    trigger OnAfterGetCurrRecord()
    var
    begin

        if Reconfirm = true then
            StyleExprTxt := 'Strong'
        else
            StyleExprTxt := 'None';
    end;

    procedure CalculateValue(x: Integer)
    var
        ConvFactor: Decimal;
        UOMRec: Record "Unit of Measure";
    begin

        UOMRec.Reset();
        UOMRec.SetRange(Code, "Unit N0.");
        UOMRec.FindSet();
        ConvFactor := UOMRec."Converion Parameter";


        if Type = type::Pcs then
            Requirment := (Consumption * Qty) + (Consumption * Qty) * WST / 100
        else
            if Type = type::Doz then
                Requirment := ((Consumption * Qty) + (Consumption * Qty) * WST / 100) / 12;

        if (x = 0) and (ConvFactor <> 0) then
            Requirment := Requirment / ConvFactor;

        Value := Requirment * Rate;
        CurrPage.Update(true);
        // CalculateCost();
    end;

    procedure CalculateWST()
    var
    begin

        if Type = type::Pcs then
            if AjstReq = 0 then
                WST := (100 * Requirment) / (Qty * Consumption) - 100
            else
                WST := (100 * AjstReq) / (Qty * Consumption) - 100
        else
            if Type = type::Doz then
                if AjstReq = 0 then
                    WST := (100 * Requirment * 12) / (Qty * Consumption) - 100
                else
                    WST := (100 * AjstReq * 12) / (Qty * Consumption) - 100;

        CalculateValue(1);
    end;


    trigger OnDeleteRecord(): Boolean
    var
        BOMLineRec: Record "BOM Line";
        BLAutoGenNewRec: Record "BOM Line AutoGen";
    begin

        //Delete existing records
        BLAutoGenNewRec.Reset();
        BLAutoGenNewRec.SetRange("No.", "No.");
        BLAutoGenNewRec.SetRange("Item No.", "Item No.");
        BLAutoGenNewRec.SetRange("Placement of GMT", "Placement of GMT");
        BLAutoGenNewRec.SetFilter("Included in PO", '=%1', true);

        if BLAutoGenNewRec.FindSet() then
            Error('This item has been raised for the PO. Cannot delete')
        else begin

            //Delete from AutoGen table
            BLAutoGenNewRec.Reset();
            BLAutoGenNewRec.SetRange("No.", "No.");
            BLAutoGenNewRec.SetRange("Item No.", "Item No.");
            BLAutoGenNewRec.SetRange("Placement of GMT", "Placement of GMT");
            BLAutoGenNewRec.DeleteAll();

            //Delete from BOM Lines(Coor/Size/Country/PO) table
            BOMLineRec.Reset();
            BOMLineRec.SetRange("No.", "No.");
            BOMLineRec.SetRange("Item No.", "Item No.");
            BOMLineRec.SetRange(Placement, "Placement of GMT");
            BOMLineRec.DeleteAll();
        end;
    end;

    var
        StyleExprTxt: Text[50];

}