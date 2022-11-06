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

                        if "Item No" <> '' then begin
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
                        end
                        else
                            "Item Name" := '';
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

    actions
    {
        area(Processing)
        {
            action("Generate Items")
            {
                Image = Create;
                ApplicationArea = all;

                trigger OnAction()
                var
                    NoSeriesManagementCode: Codeunit NoSeriesManagement;
                    ItemCategoryRec: Record "Item Category";
                    DeptReqSheetLineRec: Record DeptReqSheetLine;
                    DeptReqSheetHeaderRec: Record DeptReqSheetHeader;
                    NavAppSetupRec: Record "NavApp Setup";
                    ItemUinitRec: Record "Item Unit of Measure";
                    MainCateRec: Record "Main Category";
                    ItemMasterRec: Record item;
                    NextItemNo: Code[20];
                    ItemDesc: Text[500];
                begin

                    //Get Worksheet line no
                    NavAppSetupRec.Reset();
                    NavAppSetupRec.FindSet();

                    DeptReqSheetLineRec.Reset();
                    DeptReqSheetLineRec.SetRange("Req No", "Req No");
                    if DeptReqSheetLineRec.FindSet() then begin
                        repeat
                            if "Item No" = '' then begin

                                ItemDesc := "Sub Category Name";

                                if Article <> '' then
                                    ItemDesc := ItemDesc + ' / ' + Article;

                                if "Color Name" <> '' then
                                    ItemDesc := ItemDesc + ' / ' + "Color Name";

                                if "Size Range No." <> '' then
                                    ItemDesc := ItemDesc + ' / ' + "Size Range No.";

                                if "Dimension Name." <> '' then
                                    ItemDesc := ItemDesc + ' / ' + "Dimension Name.";

                                if Other <> '' then
                                    ItemDesc := ItemDesc + ' / ' + Other;

                                //Check whether item exists
                                ItemMasterRec.Reset();
                                ItemMasterRec.SetRange(Description, ItemDesc);

                                if ItemMasterRec.FindSet() then begin
                                    "Item No" := ItemMasterRec."No.";
                                    "Item Name" := ItemDesc;
                                    UOM := ItemMasterRec."Base Unit of Measure";
                                end
                                else begin

                                    //Get Dimenion only status
                                    MainCateRec.Reset();
                                    MainCateRec.SetRange("No.", "Main Category No.");
                                    if MainCateRec.FindSet() then
                                        if MainCateRec."Inv. Posting Group Code" = '' then
                                            Error('Inventory Posting Group is not setup for the Main Category : %1. Cannot proceed.', "Main Category Name");

                                    if MainCateRec."Prod. Posting Group Code" = '' then
                                        Error('Product Posting Group is not setup for the Main Category : %1. Cannot proceed.', "Main Category Name");

                                    NextItemNo := NoSeriesManagementCode.GetNextNo(NavAppSetupRec."MISCITEM Nos.", Today(), true);

                                    ItemMasterRec.Init();
                                    ItemMasterRec."No." := NextItemNo;
                                    ItemMasterRec.Description := ItemDesc;
                                    ItemMasterRec."Main Category No." := "Main Category No.";
                                    ItemMasterRec."Main Category Name" := "Main Category Name";
                                    ItemMasterRec."Sub Category No." := "Sub Category No.";
                                    ItemMasterRec."Sub Category Name" := "Sub Category Name";
                                    ItemMasterRec."Rounding Precision" := 0.00001;

                                    //Check for Item category
                                    ItemCategoryRec.Reset();
                                    ItemCategoryRec.SetRange(Code, "Main Category No.");
                                    if not ItemCategoryRec.FindSet() then begin
                                        ItemCategoryRec.Init();
                                        ItemCategoryRec.Code := "Main Category No.";
                                        ItemCategoryRec.Description := "Main Category Name";
                                        ItemCategoryRec.Insert();
                                    end;

                                    ItemMasterRec."Item Category Code" := "Main Category No.";
                                    ItemMasterRec."Color No." := "Color No.";
                                    ItemMasterRec."Color Name" := "Color Name";
                                    ItemMasterRec."Size Range No." := "Size Range No.";
                                    ItemMasterRec."Article No." := "Article No.";
                                    ItemMasterRec."Article" := "Article";
                                    ItemMasterRec."Dimension Width No." := "Dimension No.";
                                    ItemMasterRec."Dimension Width" := "Dimension Name.";
                                    ItemMasterRec.Remarks := Other;
                                    ItemMasterRec.Type := ItemMasterRec.Type::Inventory;
                                    ItemMasterRec."Unit Cost" := 0;
                                    ItemMasterRec."Unit Price" := 0;
                                    ItemMasterRec."Last Direct Cost" := 0;
                                    ItemMasterRec.validate("Gen. Prod. Posting Group", MainCateRec."Prod. Posting Group Code");
                                    ItemMasterRec.validate("Inventory Posting Group", MainCateRec."Inv. Posting Group Code");
                                    ItemMasterRec."VAT Prod. Posting Group" := 'ZERO';

                                    if MainCateRec.LOTTracking then begin
                                        ItemMasterRec.Validate("Item Tracking Code", NavAppSetupRec."LOT Tracking Code");
                                        ItemMasterRec."Lot Nos." := NavAppSetupRec."LOTTracking Nos.";
                                    end;

                                    //Insert into Item unit of measure
                                    ItemUinitRec.Init();
                                    ItemUinitRec."Item No." := NextItemNo;
                                    ItemUinitRec.Code := UOM;
                                    ItemUinitRec."Qty. per Unit of Measure" := 1;
                                    ItemUinitRec.Insert();

                                    ItemMasterRec.Validate("Base Unit of Measure", UOM);
                                    ItemMasterRec.Validate("Replenishment System", 0);
                                    ItemMasterRec.Validate("Manufacturing Policy", 1);
                                    ItemMasterRec.Insert(true);

                                    "Item No" := NextItemNo;
                                    "Item Name" := ItemDesc;

                                end;
                            end;
                        until DeptReqSheetLineRec.Next() = 0;
                    end;
                end;
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