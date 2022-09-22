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
                        if MainCategoryRec.FindSet() then
                            "Main Category No." := MainCategoryRec."No.";

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

                field(Type; Type)
                {
                    ApplicationArea = All;
                    Caption = 'Type';
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

                field(Requirment; Requirment)
                {
                    ApplicationArea = All;
                    Editable = false;
                    //StyleExpr = StyleExprTxt;
                }

                // field(AjstReq; AjstReq)
                // {
                //     ApplicationArea = All;
                //     Caption = 'Adjust. Req.';
                //     //Editable = false;
                //     //StyleExpr = StyleExprTxt;
                // }

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

        Value := Requirment * Rate;

    end;
}