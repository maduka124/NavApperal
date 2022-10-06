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
                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Seq No';
                }

                field("Main Category Name"; "Main Category Name")
                {
                    ApplicationArea = All;
                    Caption = 'Main Category';

                    trigger OnValidate()
                    var
                        MainCategoryRec: Record "Main Category";
                        SampleRequLineRec: Record "Sample Requsition Line";
                    begin
                        MainCategoryRec.Reset();
                        MainCategoryRec.SetRange("Main Category Name", "Main Category Name");
                        if MainCategoryRec.FindSet() then begin
                            if MainCategoryRec."Inv. Posting Group Code" = '' then
                                Error('Inventory Posting Group is not setup for this Main Category. Cannot proceed.');

                            if MainCategoryRec."Prod. Posting Group Code" = '' then
                                Error('Prod. Posting Group is not setup for this Main Category. Cannot proceed.');

                            "Main Category No." := MainCategoryRec."No.";
                            "Item No." := '';
                            "Item Name" := '';
                            "Dimension No." := '';
                            "Dimension Name." := '';
                            "Sub Category Name" := '';
                            "Sub Category No." := '';
                            "Article No." := '';
                            "Article Name." := '';
                            "Supplier No." := '';
                            "Supplier Name." := '';
                        end;

                        SampleRequLineRec.Reset();
                        SampleRequLineRec.SetRange("No.", "No.");
                        if SampleRequLineRec.FindSet() then begin
                            Qty := SampleRequLineRec.Qty;
                            "GMT Size Name" := SampleRequLineRec.Size;
                            "GMT Color Name" := SampleRequLineRec."Color Name";
                            "GMT Color No." := SampleRequLineRec."Color No";
                            "Item Color Name" := SampleRequLineRec."Color Name";
                            "Item Color No." := SampleRequLineRec."Color No";
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
                        SampleRequLineRec: Record "Sample Requsition Line";
                    begin
                        ItemRec.Reset();
                        ItemRec.SetRange(Description, "Item Name");
                        if ItemRec.FindSet() then begin
                            "Item No." := ItemRec."No.";
                            "Unit N0." := ItemRec."Base Unit of Measure";
                        end;

                        SampleRequLineRec.Reset();
                        SampleRequLineRec.SetRange("No.", "No.");
                        if SampleRequLineRec.FindSet() then begin
                            Qty := SampleRequLineRec.Qty;
                            "GMT Size Name" := SampleRequLineRec.Size;
                            "GMT Color Name" := SampleRequLineRec."Color Name";
                            "GMT Color No." := SampleRequLineRec."Color No";
                            "Item Color Name" := SampleRequLineRec."Color Name";
                            "Item Color No." := SampleRequLineRec."Color No";
                        end;
                    end;
                }

                field("GMT Color Name"; "GMT Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'GMT Color';

                    trigger OnValidate()
                    var
                        ColorRec: Record Colour;
                    begin
                        ColorRec.Reset();
                        ColorRec.SetRange("Colour Name", "GMT Color Name");
                        if ColorRec.FindSet() then
                            "GMT Color No." := ColorRec."No.";
                    end;
                }

                field("Item Color Name"; "Item Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'Item Color';

                    trigger OnValidate()
                    var
                        ColorRec: Record Colour;
                    begin
                        ColorRec.Reset();
                        ColorRec.SetRange("Colour Name", "Item Color Name");
                        if ColorRec.FindSet() then
                            "Item Color No." := ColorRec."No.";
                    end;
                }

                // field("GMT Size Name"; "GMT Size Name")
                // {
                //     ApplicationArea = All;
                //     Caption = 'GMT Size';
                // }

                field("Article Name."; "Article Name.")
                {
                    ApplicationArea = All;
                    Caption = 'Article/Construction';

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

                field(Type; Type)
                {
                    ApplicationArea = All;
                    Caption = 'Consumption Type';
                }

                field(Consumption; Consumption)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        Calculate();
                    end;
                }

                field(WST; WST)
                {
                    ApplicationArea = All;
                    Caption = 'WST%';

                    trigger OnValidate()
                    var
                    begin
                        Calculate();
                    end;
                }
                field(Rate; Rate)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        Calculate();
                    end;
                }

                field(Value; Value)
                {
                    ApplicationArea = All;
                    Editable = false;
                    //StyleExpr = StyleExprTxt;
                }

                field(Requirment; Requirment)
                {
                    ApplicationArea = All;
                    Editable = false;
                    //StyleExpr = StyleExprTxt;
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
                    end;
                }

                field("Placement of GMT"; "Placement of GMT")
                {
                    ApplicationArea = All;
                }

                field(Remarks; Remarks)
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
        UOMRec.SetRange(Code, "Unit N0.");
        UOMRec.FindSet();
        ConvFactor := UOMRec."Converion Parameter";
        Value := 0;
        Requirment := 0;

        //if Type = Type::Pcs then
        Requirment := (Consumption * Qty) + (Consumption * Qty) * WST / 100;
        // else
        //     if Type = Type::Doz then
        //         Requirment := ((Consumption * Qty) + (Consumption * Qty) * WST / 100) / 12;

        if (ConvFactor <> 0) then
            Requirment := Requirment / ConvFactor;

        //Requirment := Round(Requirment, 1);

        if Requirment = 0 then
            Requirment := 1;

        Value := Requirment * Rate;

    end;


    procedure CalculateWST()
    var
    begin

        if Type = type::Pcs then
            WST := WST + ((AjstReq / Requirment) - 1) * 100;


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