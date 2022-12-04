page 71012777 SampleReqAccListPart
{
    PageType = ListPart;
    AutoSplitKey = true;
    SourceTable = "Sample Requsition Acce";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Seq No';
                }

                field("Main Category Name"; rec."Main Category Name")
                {
                    ApplicationArea = All;
                    Caption = 'Main Category';

                    trigger OnValidate()
                    var
                        MainCategoryRec: Record "Main Category";
                        SampleRequLineRec: Record "Sample Requsition Line";
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
                            rec."Sub Category Name" := '';
                            rec."Sub Category No." := '';
                            rec."Article No." := '';
                            rec."Article Name." := '';
                            rec."Supplier No." := '';
                            rec."Supplier Name." := '';
                        end;

                        SampleRequLineRec.Reset();
                        SampleRequLineRec.SetRange("No.", rec."No.");
                        if SampleRequLineRec.FindSet() then begin
                            rec.Qty := SampleRequLineRec.Qty;
                            rec."GMT Size Name" := SampleRequLineRec.Size;
                            rec."GMT Color Name" := SampleRequLineRec."Color Name";
                            rec."GMT Color No." := SampleRequLineRec."Color No";
                            rec."Item Color Name" := SampleRequLineRec."Color Name";
                            rec."Item Color No." := SampleRequLineRec."Color No";
                        end;
                    end;
                }

                field("Item Name"; rec."Item Name")
                {
                    ApplicationArea = All;
                    Caption = 'Item';

                    trigger OnValidate()
                    var
                        ItemRec: Record "Item";
                        SampleRequLineRec: Record "Sample Requsition Line";
                    begin
                        ItemRec.Reset();
                        ItemRec.SetRange(Description, rec."Item Name");
                        if ItemRec.FindSet() then begin
                            rec."Item No." := ItemRec."No.";
                            rec."Unit N0." := ItemRec."Base Unit of Measure";
                            rec."Sub Category Name" := ItemRec."Sub Category Name";
                            rec."Sub Category No." := ItemRec."Sub Category No.";
                        end;

                        SampleRequLineRec.Reset();
                        SampleRequLineRec.SetRange("No.", rec."No.");
                        if SampleRequLineRec.FindSet() then begin
                            rec.Qty := SampleRequLineRec.Qty;
                            rec."GMT Size Name" := SampleRequLineRec.Size;
                            rec."GMT Color Name" := SampleRequLineRec."Color Name";
                            rec."GMT Color No." := SampleRequLineRec."Color No";
                            rec."Item Color Name" := SampleRequLineRec."Color Name";
                            rec."Item Color No." := SampleRequLineRec."Color No";
                        end;
                    end;
                }

                field("GMT Color Name"; rec."GMT Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'GMT Color';

                    trigger OnValidate()
                    var
                        ColorRec: Record Colour;
                    begin
                        ColorRec.Reset();
                        ColorRec.SetRange("Colour Name", rec."GMT Color Name");
                        if ColorRec.FindSet() then
                            rec."GMT Color No." := ColorRec."No.";
                    end;
                }

                field("Item Color Name"; rec."Item Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'Item Color';

                    trigger OnValidate()
                    var
                        ColorRec: Record Colour;
                    begin
                        ColorRec.Reset();
                        ColorRec.SetRange("Colour Name", rec."Item Color Name");
                        if ColorRec.FindSet() then
                            rec."Item Color No." := ColorRec."No.";
                    end;
                }

                // field("GMT Size Name"; "GMT Size Name")
                // {
                //     ApplicationArea = All;
                //     Caption = 'GMT Size';
                // }

                field("Article Name."; rec."Article Name.")
                {
                    ApplicationArea = All;
                    Caption = 'Article/Construction';

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
                    Editable = false;

                    trigger OnValidate()
                    var
                    begin
                        Calculate();
                    end;
                }

                // field("Qty"; "Qty")
                // {
                //     ApplicationArea = All;

                //     trigger OnValidate()
                //     var
                //     begin
                //         Calculate();
                //     end;
                // }

                field(Type; rec.Type)
                {
                    ApplicationArea = All;
                    Caption = 'Consumption Type';
                }

                field(Consumption; rec.Consumption)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        Calculate();
                    end;
                }

                field(WST; rec.WST)
                {
                    ApplicationArea = All;
                    Caption = 'WST%';

                    trigger OnValidate()
                    var
                    begin
                        Calculate();
                    end;
                }
                field(Rate; rec.Rate)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        Calculate();
                    end;
                }

                field(Value; rec.Value)
                {
                    ApplicationArea = All;
                    Editable = false;
                    //StyleExpr = StyleExprTxt;
                }

                field(Requirment; rec.Requirment)
                {
                    ApplicationArea = All;
                    Editable = false;
                    //StyleExpr = StyleExprTxt;
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
                            rec."Supplier No." := SupplierRec."No.";
                    end;
                }

                field("Placement of GMT"; rec."Placement of GMT")
                {
                    ApplicationArea = All;
                }

                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    procedure Calculate()
    var
        ConvFactor: Decimal;
        UOMRec: Record "Unit of Measure";
    begin

        UOMRec.Reset();
        UOMRec.SetRange(Code, rec."Unit N0.");
        UOMRec.FindSet();
        ConvFactor := UOMRec."Converion Parameter";
        rec.Value := 0;
        rec.Requirment := 0;

        //if Type = Type::Pcs then
        rec.Requirment := (rec.Consumption * rec.Qty) + (rec.Consumption * rec.Qty) * rec.WST / 100;
        // else
        //     if Type = Type::Doz then
        //         Requirment := ((Consumption * Qty) + (Consumption * Qty) * WST / 100) / 12;

        if (ConvFactor <> 0) then
            rec.Requirment := rec.Requirment / ConvFactor;

        //Requirment := Round(Requirment, 1);

        if rec.Requirment = 0 then
            rec.Requirment := 1;

        rec.Value := rec.Requirment * rec.Rate;

    end;


    procedure CalculateWST()
    var
    begin

        if rec.Type = rec.type::Pcs then
            rec.WST := rec.WST + ((rec.AjstReq / rec.Requirment) - 1) * 100;


        // if Type = type::Pcs then
        //     if AjstReq = 0 then
        //         WST := (100 * Requirment) / (Qty * Consumption) - 100
        //     else
        //         WST := (100 * AjstReq) / (Qty * Consumption) - 100;


        // else
        //     if Type = type::Doz then
        //         if AjstReq = 0 then
        //             WST := (100 * Requirment * 12) / (Qty * Consumption) - 100
        //         else
        //             WST := (100 * AjstReq * 12) / (Qty * Consumption) - 100;

        Calculate();
    end;

}