page 50628 "Gate Pass ListPart"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = "Gate Pass Line";
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("Inventory Type"; Rec."Inventory Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.Remarks := '';
                        Rec."Main Category Code" := '';
                        Rec."Main Category Name" := '';
                        Rec.Description := '';
                        Rec."Item No." := '';
                        Rec.Qty := 0;
                        Rec.UOM := '';
                        Rec."UOM Code" := '';

                    end;
                }

                field("Main Category Name"; Rec."Main Category Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        MainCategoryRec: Record "Main Category";
                        FAClassRec: Record "FA Class";
                        ServiceItemRec: Record "Service Item";
                        GatepassLineRec: Record "Gate Pass Line";
                    begin

                        if (Rec."Inventory Type" = Rec."Inventory Type"::Inventory) then begin
                            MainCategoryRec.Reset();
                            MainCategoryRec.SetRange("Main Category Name", Rec."Main Category Name");
                            if MainCategoryRec.FindSet() then
                                Rec."Main Category Code" := MainCategoryRec."No.";
                        end;

                        if (Rec."Inventory Type" = Rec."Inventory Type"::"Fixed Assets") then begin
                            FAClassRec.Reset();
                            FAClassRec.SetRange(name, Rec."Main Category Name");
                            if FAClassRec.FindSet() then
                                Rec."Main Category Code" := FAClassRec."code";
                        end;
                    end;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        ItemRec: Record Item;
                        FARec: Record "Fixed Asset";
                        UOMRec: Record "Unit of Measure";
                        ServiceItemRec: Record "Service Item";
                        SalesLineRec: Record "Sales Line";
                        SalesOrderNo: Code[20];
                        SalesInvoiceNo: Code[20];
                        SalesHeaderRec: Record "Sales Header";
                        SalesInvoiceHeader: Record "Sales Invoice Header";
                        SalesInvoiceLine: Record "Sales Invoice Line";
                    begin
                        if (Rec."Inventory Type" = Rec."Inventory Type"::Inventory) then begin
                            ItemRec.Reset();
                            ItemRec.SetRange(Description, Rec.Description);
                            if ItemRec.FindSet() then begin
                                Rec."Item No." := ItemRec."No.";
                                Rec."UOM Code" := ItemRec."Base Unit of Measure";

                                UOMRec.Reset();
                                UOMRec.SetRange(Code, Rec."UOM Code");
                                if UOMRec.FindSet() then
                                    Rec.UOM := UOMRec.Description;
                            end;
                        end;

                        //Done By Sachith on 27/01/23
                        if Rec."Inventory Type" = Rec."Inventory Type"::"Finish Goods" then begin
                            ItemRec.Reset();
                            ItemRec.SetRange(Description, Rec.Description);

                            if ItemRec.FindSet() then begin
                                Rec."Item No." := ItemRec."No.";
                                Rec."UOM Code" := ItemRec."Base Unit of Measure";

                            end;

                            UOMRec.Reset();
                            UOMRec.SetRange(Code, Rec."UOM Code");
                            if UOMRec.FindSet() then
                                Rec.UOM := UOMRec.Description;

                            SalesLineRec.Reset();
                            SalesLineRec.SetRange(Type, SalesLineRec.Type::Item);
                            SalesLineRec.SetRange("No.", Rec."Item No.");

                            if SalesLineRec.FindSet() then begin

                                SalesOrderNo := SalesLineRec."Document No.";

                                SalesHeaderRec.Reset();
                                SalesHeaderRec.SetRange("No.", SalesOrderNo);

                                if SalesHeaderRec.FindSet() then
                                    Rec.Remarks := SalesHeaderRec."Bill-to Name" + '/' + SalesHeaderRec."Style Name" + '/' + ItemRec."Color Name" + '/' + ItemRec."Size Range No.";
                            end;

                            SalesInvoiceLine.Reset();
                            SalesInvoiceLine.SetRange("No.", Rec."Item No.");

                            if SalesInvoiceLine.FindSet() then begin

                                SalesInvoiceNo := SalesInvoiceLine."Document No.";

                                SalesInvoiceHeader.Reset();
                                SalesInvoiceHeader.SetRange("No.", SalesInvoiceNo);

                                if SalesInvoiceHeader.FindSet() then
                                    Rec.Remarks := SalesInvoiceHeader."Bill-to Name" + '/' + SalesInvoiceHeader."Style Name" + '/' + ItemRec."Color Name" + '/' + ItemRec."Size Range No.";
                            end;

                        end;

                        if (Rec."Inventory Type" = Rec."Inventory Type"::"Fixed Assets") then begin
                            FARec.Reset();
                            FARec.SetRange(Description, Rec.Description);
                            if FARec.FindSet() then
                                Rec."Item No." := FARec."No.";
                        end;

                        if (Rec."Inventory Type" = rec."Inventory Type"::"Service Machine") then begin

                            ServiceItemRec.Reset();
                            ServiceItemRec.SetRange(Description, Rec.Description);
                            if ServiceItemRec.FindSet() then begin
                                Rec."Item No." := ServiceItemRec."Item No.";
                                Rec."UOM Code" := ServiceItemRec."Unit of Measure Code";
                            end;

                            UOMRec.Reset();
                            UOMRec.SetRange(Code, Rec."UOM Code");
                            if UOMRec.FindSet() then
                                Rec.UOM := UOMRec.Description;
                        end;
                        CurrPage.Update();
                    end;
                }

                field(UOM; Rec.UOM)
                {
                    ApplicationArea = All;
                }

                field(Qty; Rec.Qty)
                {
                    ApplicationArea = All;
                }

                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}