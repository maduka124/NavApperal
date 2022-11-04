page 50823 "DepReqSheetListpart"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = DeptReqSheetLine;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Main Category Name"; "Main Category Name")
                {
                    ApplicationArea = All;
                    Caption = 'Main Category';
                    Editable = EditableGb;

                    trigger OnValidate()
                    var
                        MainCategoryRec: Record "Main Category";
                    begin
                        MainCategoryRec.Reset();
                        MainCategoryRec.SetRange("Main Category Name", "Main Category Name");
                        if MainCategoryRec.FindSet() then
                            "Main Category No." := MainCategoryRec."No.";

                        //Article
                        if ("Main Category Name" = 'SPAIR PARTS') or ("Main Category Name" = 'CHEMICAL')
                            or ("Main Category Name" = 'STATIONARY') or ("Main Category Name" = 'IT ACESSORIES')
                            or ("Main Category Name" = 'ELETRICAL') then
                            CaptionA := 'Brand'
                        else
                            CaptionA := 'Article';

                        //Size                            
                        if ("Main Category Name" = 'SPAIR PARTS') then
                            CaptionB := 'Type of Machine'
                        else
                            if ("Main Category Name" = 'CHEMICAL') then
                                CaptionB := 'Chemical Type'
                            else
                                CaptionB := 'Size';

                        //Color                            
                        if ("Main Category Name" = 'SPAIR PARTS') then
                            CaptionC := 'Model'
                        else
                            if ("Main Category Name" = 'CHEMICAL') then
                                CaptionC := 'Batch'
                            else
                                CaptionC := 'Color';

                        //remarks                            
                        if ("Main Category Name" = 'SPAIR PARTS') then
                            CaptionD := 'Part No'
                        else
                            if ("Main Category Name" = 'CHEMICAL') then
                                CaptionD := 'Lot'
                            else
                                CaptionD := 'Other';


                        "Item Name" := '';
                        "Item No" := '';
                        "Dimension No." := '';
                        "Dimension Name." := '';
                        "Article No." := '';
                        Article := '';
                        "Size Range No." := '';
                        Remarks := '';
                        "Color Name" := '';
                        "Color No." := '';
                        "Sub Category Name" := '';
                        "Sub Category No." := '';
                    end;
                }

                field("Item No"; "Item No")
                {
                    ApplicationArea = All;
                    Editable = EditableGb;

                    trigger OnValidate()
                    var
                        itemRec: Record Item;
                        DeptReqSheetLineRec: Record DeptReqSheetLine;
                    begin
                        if "Qty Received" > 0 then
                            Error('Cannot change the Item as Qty already received.');

                        if "PO Raized" then
                            Error('Cannot change the Item as PO already created by the central purchasing department.');

                        itemRec.Reset();
                        itemRec.SetRange("No.", "Item No");

                        if itemRec.FindSet() then begin
                            "Item Name" := itemRec.Description;
                            UOM := itemRec."Base Unit of Measure";
                            Article := itemRec.Article;
                            "Article No." := itemRec."Article No.";
                            "Color Name" := itemRec."Color Name";
                            "Color No." := itemRec."Color No.";
                            "Dimension Name." := itemRec."Dimension Width";
                            "Dimension No." := itemRec."Dimension Width No.";
                            "Size Range No." := itemRec."Size Range No.";
                            Other := itemRec.Remarks;
                            "Sub Category No." := itemRec."Sub Category No.";
                            "Sub Category Name" := itemRec."Sub Category Name";
                        end;
                    end;
                }

                field("Item Name"; "Item Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Sub Category Name"; "Sub Category Name")
                {
                    ApplicationArea = All;
                    Caption = 'Sub Category';

                    trigger OnValidate()
                    var
                        CategoryRec: Record "Sub Category";
                    begin
                        CategoryRec.Reset();
                        CategoryRec.SetRange("Sub Category Name", "Sub Category Name");
                        if CategoryRec.FindSet() then
                            "Sub Category No." := CategoryRec."No.";
                    end;
                }

                field(Article; Article)
                {
                    ApplicationArea = All;
                    CaptionClass = CaptionA;
                    Editable = EditableGb;

                    trigger OnValidate()
                    var
                        ArticleRec: Record Article;
                        BrandRec: Record Brand;
                    begin
                        if ("Main Category Name" = 'SPAIR PARTS') or ("Main Category Name" = 'CHEMICAL')
                        or ("Main Category Name" = 'STATIONARY') or ("Main Category Name" = 'IT ACESSORIES')
                        or ("Main Category Name" = 'ELETRICAL') then begin
                            BrandRec.Reset();
                            BrandRec.SetRange("Brand Name", Article);
                            if BrandRec.FindSet() then
                                "Article No." := BrandRec."No.";
                        end
                        else begin
                            ArticleRec.Reset();
                            ArticleRec.SetRange(Article, Article);
                            if ArticleRec.FindSet() then
                                "Article No." := ArticleRec."No.";
                        end;
                    end;
                }

                field("Size Range No."; "Size Range No.")
                {
                    ApplicationArea = All;
                    CaptionClass = CaptionB;
                }

                field("Color Name"; "Color Name")
                {
                    ApplicationArea = All;
                    CaptionClass = CaptionC;

                    trigger OnValidate()
                    var
                        ColourRec: Record Colour;
                        ModelRec: Record Model;
                    begin

                        if ("Main Category Name" = 'SPAIR PARTS') then begin
                            ModelRec.Reset();
                            ModelRec.SetRange("Model Name", "Color Name");
                            if ModelRec.FindSet() then
                                "Color No." := ModelRec."No.";
                        end
                        else
                            if ("Main Category Name" = 'ELETRICAL') or ("Main Category Name" = 'STATIONARY') or ("Main Category Name" = 'IT ACESSORIES') then begin
                                ColourRec.Reset();
                                ColourRec.SetRange("Colour Name", "Color Name");
                                if ColourRec.FindSet() then
                                    "Color No." := ColourRec."No.";
                            end
                            else
                                if ("Main Category Name" = 'CHEMICAL') then begin

                                end
                                else begin
                                    ColourRec.Reset();
                                    ColourRec.SetRange("Colour Name", "Color Name");
                                    if ColourRec.FindSet() then
                                        "Color No." := ColourRec."No.";
                                end;
                    end;
                }

                field("Dimension Name."; "Dimension Name.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        DimensionWidthRec: Record DimensionWidth;
                    begin
                        DimensionWidthRec.Reset();
                        DimensionWidthRec.SetRange("Dimension Width", "Dimension Name.");
                        if DimensionWidthRec.FindSet() then
                            "Dimension No." := DimensionWidthRec."No.";
                    end;
                }

                field(Other; Other)
                {
                    ApplicationArea = All;
                    CaptionClass = CaptionD;
                }

                field(Qty; Qty)
                {
                    ApplicationArea = All;
                    Caption = 'Order Qty';
                    Editable = EditableGb;

                    trigger OnValidate()
                    var
                    begin
                        if "Qty Received" > 0 then
                            Error('Item: %1 already marked as received. Cannot change the order quantity.', "Item Name");

                        if "PO Raized" then
                            Error('Cannot change the order quantity as PO already created by the central purchasing department.');


                        "Qty to Received" := Qty - "Qty Received";
                    end;
                }

                field(UOM; UOM)
                {
                    ApplicationArea = All;
                    Editable = EditableGb;
                }

                field("Qty Received"; "Qty Received")
                {
                    ApplicationArea = All;
                    Editable = EditableGb;

                    trigger OnValidate()
                    var
                        DeptReqSheetLineRec: Record DeptReqSheetLine;
                        DeptReqSheetHeadRec: Record DeptReqSheetHeader;
                        Status: Boolean;
                    begin
                        if "Qty Received" > Qty then
                            Error('Qty Received is greater than the Order Qty.');


                        "Qty to Received" := Qty - "Qty Received";
                        CurrPage.Update();

                        //Check whether po fully received or not
                        DeptReqSheetLineRec.Reset();
                        DeptReqSheetLineRec.SetRange("Req No", "Req No");

                        if DeptReqSheetLineRec.FindSet() then begin
                            repeat
                                if DeptReqSheetLineRec."Qty to Received" > 0 then
                                    Status := true;
                            until DeptReqSheetLineRec.Next() = 0;
                        end;

                        //Update Header status
                        DeptReqSheetHeadRec.Reset();
                        DeptReqSheetHeadRec.SetRange("Req No", "Req No");
                        DeptReqSheetHeadRec.FindSet();

                        if Status = false then
                            DeptReqSheetHeadRec."Completely Received" := DeptReqSheetHeadRec."Completely Received"::Yes
                        else
                            DeptReqSheetHeadRec."Completely Received" := DeptReqSheetHeadRec."Completely Received"::No;

                        DeptReqSheetHeadRec.Modify();
                        CurrPage.Update();

                    end;
                }

                field("Qty to Received"; "Qty to Received")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
                    Editable = EditableGb;
                }

                field("PO Raized"; "PO Raized")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }


    trigger OnNewRecord(BelowxRec: Boolean)
    var
        inx: Integer;
    begin
        "Line No" := xRec."Line No" + 1;
    end;


    trigger OnOpenPage()
    var
        DeptReqSheetHeader: Record DeptReqSheetHeader;
    begin
        if "Req No" <> '' then begin
            DeptReqSheetHeader.Get("Req No");

            if DeptReqSheetHeader."Completely Received" = DeptReqSheetHeader."Completely Received"::Yes then
                EditableGb := false
            else
                EditableGb := true;
        end;
    end;


    trigger OnAfterGetCurrRecord()
    var
        DeptReqSheetHeader: Record DeptReqSheetHeader;
    begin
        if "Req No" <> '' then begin
            DeptReqSheetHeader.Get("Req No");

            if DeptReqSheetHeader."Completely Received" = DeptReqSheetHeader."Completely Received"::Yes then
                EditableGb := false
            else
                EditableGb := true;
        end;
    end;


    var
        EditableGb: Boolean;
        CaptionA: Text[100];
        CaptionB: Text[100];
        CaptionC: Text[100];
        CaptionD: Text[100];

}