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
                field("Main Category Name"; Rec."Main Category Name")
                {
                    ApplicationArea = All;
                    Caption = 'Main Category';
                    Editable = EditableGb;

                    trigger OnValidate()
                    var
                        MainCategoryRec: Record "Main Category";
                    begin
                        MainCategoryRec.Reset();
                        MainCategoryRec.SetRange("Main Category Name", Rec."Main Category Name");
                        if MainCategoryRec.FindSet() then
                            Rec."Main Category No." := MainCategoryRec."No.";

                        //Article
                        if (Rec."Main Category Name" = 'SPAIR PARTS') or (Rec."Main Category Name" = 'CHEMICAL')
                            or (Rec."Main Category Name" = 'STATIONARY') or (Rec."Main Category Name" = 'IT ACESSORIES')
                            or (Rec."Main Category Name" = 'ELETRICAL') then
                            CaptionA := 'Brand'
                        else
                            CaptionA := 'Article';

                        //Size                            
                        if (Rec."Main Category Name" = 'SPAIR PARTS') then
                            CaptionB := 'Type of Machine'
                        else
                            if (Rec."Main Category Name" = 'CHEMICAL') then
                                CaptionB := 'Chemical Type'
                            else
                                CaptionB := 'Size';

                        //Color                            
                        if (Rec."Main Category Name" = 'SPAIR PARTS') then
                            CaptionC := 'Model'
                        else
                            if (Rec."Main Category Name" = 'CHEMICAL') then
                                CaptionC := 'Batch'
                            else
                                CaptionC := 'Color';

                        //remarks                            
                        if (Rec."Main Category Name" = 'SPAIR PARTS') then
                            CaptionD := 'Part No'
                        else
                            if (Rec."Main Category Name" = 'CHEMICAL') then
                                CaptionD := 'Lot'
                            else
                                CaptionD := 'Other';


                        Rec."Item Name" := '';
                        Rec."Item No" := '';
                        Rec."Dimension No." := '';
                        Rec."Dimension Name." := '';
                        Rec."Article No." := '';
                        Rec.Article := '';
                        Rec."Size Range No." := '';
                        Rec.Remarks := '';
                        Rec."Color Name" := '';
                        Rec."Color No." := '';
                        Rec."Sub Category Name" := '';
                        Rec."Sub Category No." := '';
                    end;
                }

                field("Item No"; Rec."Item No")
                {
                    ApplicationArea = All;
                    Editable = EditableGb;

                    trigger OnValidate()
                    var
                        itemRec: Record Item;
                        DeptReqSheetLineRec: Record DeptReqSheetLine;
                    begin
                        if Rec."Qty Received" > 0 then
                            Error('Cannot change the Item as Qty already received.');

                        if Rec."PO Raized" then
                            Error('Cannot change the Item as PO already created by the central purchasing department.');

                        if Rec."Item No" <> '' then begin
                            itemRec.Reset();
                            itemRec.SetRange("No.", Rec."Item No");

                            if itemRec.FindSet() then begin
                                Rec."Item Name" := itemRec.Description;
                                Rec.UOM := itemRec."Base Unit of Measure";
                                Rec.Article := itemRec.Article;
                                Rec."Article No." := itemRec."Article No.";
                                Rec."Color Name" := itemRec."Color Name";
                                Rec."Color No." := itemRec."Color No.";
                                Rec."Dimension Name." := itemRec."Dimension Width";
                                Rec."Dimension No." := itemRec."Dimension Width No.";
                                Rec."Size Range No." := itemRec."Size Range No.";
                                Rec.Other := itemRec.Remarks;
                                Rec."Sub Category No." := itemRec."Sub Category No.";
                                Rec."Sub Category Name" := itemRec."Sub Category Name";
                            end;
                        end
                        else
                            Rec."Item Name" := '';
                    end;
                }

                field("Item Name"; Rec."Item Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Sub Category Name"; Rec."Sub Category Name")
                {
                    ApplicationArea = All;
                    Caption = 'Sub Category';

                    trigger OnValidate()
                    var
                        CategoryRec: Record "Sub Category";
                    begin
                        CategoryRec.Reset();
                        CategoryRec.SetRange("Sub Category Name", Rec."Sub Category Name");
                        if CategoryRec.FindSet() then
                            Rec."Sub Category No." := CategoryRec."No.";
                    end;
                }

                field(Article; Rec.Article)
                {
                    ApplicationArea = All;
                    CaptionClass = CaptionA;
                    Editable = EditableGb;

                    trigger OnValidate()
                    var
                        ArticleRec: Record Article;
                        BrandRec: Record Brand;
                    begin
                        if (Rec."Main Category Name" = 'SPAIR PARTS') or (Rec."Main Category Name" = 'CHEMICAL')
                        or (Rec."Main Category Name" = 'STATIONARY') or (Rec."Main Category Name" = 'IT ACESSORIES')
                        or (Rec."Main Category Name" = 'ELETRICAL') then begin
                            BrandRec.Reset();
                            BrandRec.SetRange("Brand Name", Rec.Article);
                            if BrandRec.FindSet() then
                                Rec."Article No." := BrandRec."No.";
                        end
                        else begin
                            ArticleRec.Reset();
                            ArticleRec.SetRange(Article, Rec.Article);
                            if ArticleRec.FindSet() then
                                Rec."Article No." := ArticleRec."No.";
                        end;
                    end;
                }

                field("Size Range No."; Rec."Size Range No.")
                {
                    ApplicationArea = All;
                    CaptionClass = CaptionB;
                }

                field("Color Name"; Rec."Color Name")
                {
                    ApplicationArea = All;
                    CaptionClass = CaptionC;

                    trigger OnValidate()
                    var
                        ColourRec: Record Colour;
                        ModelRec: Record Model;
                    begin

                        if (Rec."Main Category Name" = 'SPAIR PARTS') then begin
                            ModelRec.Reset();
                            ModelRec.SetRange("Model Name", Rec."Color Name");
                            if ModelRec.FindSet() then
                                Rec."Color No." := ModelRec."No.";
                        end
                        else
                            if (Rec."Main Category Name" = 'ELETRICAL') or (Rec."Main Category Name" = 'STATIONARY') or (Rec."Main Category Name" = 'IT ACESSORIES') then begin
                                ColourRec.Reset();
                                ColourRec.SetRange("Colour Name", Rec."Color Name");
                                if ColourRec.FindSet() then
                                    Rec."Color No." := ColourRec."No.";
                            end
                            else
                                if (Rec."Main Category Name" = 'CHEMICAL') then begin

                                end
                                else begin
                                    ColourRec.Reset();
                                    ColourRec.SetRange("Colour Name", Rec."Color Name");
                                    if ColourRec.FindSet() then
                                        Rec."Color No." := ColourRec."No.";
                                end;
                    end;
                }

                field("Dimension Name."; Rec."Dimension Name.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        DimensionWidthRec: Record DimensionWidth;
                    begin
                        DimensionWidthRec.Reset();
                        DimensionWidthRec.SetRange("Dimension Width", Rec."Dimension Name.");
                        if DimensionWidthRec.FindSet() then
                            Rec."Dimension No." := DimensionWidthRec."No.";
                    end;
                }

                field(Other; Rec.Other)
                {
                    ApplicationArea = All;
                    CaptionClass = CaptionD;
                }

                field(Qty; Rec.Qty)
                {
                    ApplicationArea = All;
                    Caption = 'Order Qty';
                    Editable = EditableGb;

                    trigger OnValidate()
                    var
                    begin
                        if Rec."Qty Received" > 0 then
                            Error('Item: %1 already marked as received. Cannot change the order quantity.', Rec."Item Name");

                        if Rec."PO Raized" then
                            Error('Cannot change the order quantity as PO already created by the central purchasing department.');


                        Rec."Qty to Received" := Rec.Qty - Rec."Qty Received";
                    end;
                }

                field("UOM Code"; Rec."UOM Code")
                {
                    ApplicationArea = All;
                    Caption = 'UOM';
                    trigger OnValidate()
                    var
                        UOMRec: Record "Unit of Measure";
                    begin

                        UOMRec.Reset();
                        UOMRec.SetRange(Code, Rec."UOM Code");

                        if UOMRec.FindSet() then
                            Rec.UOM := UOMRec.Description;
                    end;
                }

                field(UOM; Rec.UOM)
                {
                    ApplicationArea = All;
                    Editable = EditableGb;
                    Visible = false;
                }

                field("Qty Received"; Rec."Qty Received")
                {
                    ApplicationArea = All;
                    Editable = EditableGb;

                    trigger OnValidate()
                    var
                        DeptReqSheetLineRec: Record DeptReqSheetLine;
                        DeptReqSheetHeadRec: Record DeptReqSheetHeader;
                        Status: Boolean;
                    begin
                        if Rec."Qty Received" > Rec.Qty then
                            Error('Qty Received is greater than the Order Qty.');


                        Rec."Qty to Received" := Rec.Qty - Rec."Qty Received";
                        CurrPage.Update();

                        //Check whether po fully received or not
                        DeptReqSheetLineRec.Reset();
                        DeptReqSheetLineRec.SetRange("Req No", Rec."Req No");

                        if DeptReqSheetLineRec.FindSet() then begin
                            repeat
                                if DeptReqSheetLineRec."Qty to Received" > 0 then
                                    Status := true;
                            until DeptReqSheetLineRec.Next() = 0;
                        end;

                        //Update Header status
                        DeptReqSheetHeadRec.Reset();
                        DeptReqSheetHeadRec.SetRange("Req No", Rec."Req No");
                        DeptReqSheetHeadRec.FindSet();

                        if Status = false then
                            DeptReqSheetHeadRec."Completely Received" := DeptReqSheetHeadRec."Completely Received"::Yes
                        else
                            DeptReqSheetHeadRec."Completely Received" := DeptReqSheetHeadRec."Completely Received"::No;

                        DeptReqSheetHeadRec.Modify();
                        CurrPage.Update();

                    end;
                }

                field("Qty to Received"; Rec."Qty to Received")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    Editable = EditableGb;
                }

                field("PO Raized"; Rec."PO Raized")
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
                    DeptReqSheetLineRec.SetRange("Req No", Rec."Req No");
                    if DeptReqSheetLineRec.FindSet() then begin
                        repeat
                            if DeptReqSheetLineRec."Item No" = '' then begin

                                ItemDesc := DeptReqSheetLineRec."Sub Category Name";

                                if DeptReqSheetLineRec.Article <> '' then
                                    ItemDesc := ItemDesc + ' / ' + DeptReqSheetLineRec.Article;

                                if DeptReqSheetLineRec."Color Name" <> '' then
                                    ItemDesc := ItemDesc + ' / ' + DeptReqSheetLineRec."Color Name";

                                if DeptReqSheetLineRec."Size Range No." <> '' then
                                    ItemDesc := ItemDesc + ' / ' + DeptReqSheetLineRec."Size Range No.";

                                if DeptReqSheetLineRec."Dimension Name." <> '' then
                                    ItemDesc := ItemDesc + ' / ' + DeptReqSheetLineRec."Dimension Name.";

                                if DeptReqSheetLineRec.Other <> '' then
                                    ItemDesc := ItemDesc + ' / ' + DeptReqSheetLineRec.Other;

                                //Check whether item exists
                                ItemMasterRec.Reset();
                                ItemMasterRec.SetRange(Description, ItemDesc);

                                if ItemMasterRec.FindSet() then begin
                                    DeptReqSheetLineRec."Item No" := ItemMasterRec."No.";
                                    DeptReqSheetLineRec."Item Name" := ItemDesc;
                                    DeptReqSheetLineRec.UOM := ItemMasterRec."Base Unit of Measure";
                                    DeptReqSheetLineRec.Modify();
                                end
                                else begin

                                    //Get Dimenion only status
                                    MainCateRec.Reset();
                                    MainCateRec.SetRange("No.", DeptReqSheetLineRec."Main Category No.");
                                    if MainCateRec.FindSet() then
                                        if MainCateRec."Inv. Posting Group Code" = '' then
                                            Error('Inventory Posting Group is not setup for the Main Category : %1. Cannot proceed.', DeptReqSheetLineRec."Main Category Name");

                                    if MainCateRec."Prod. Posting Group Code" = '' then
                                        Error('Product Posting Group is not setup for the Main Category : %1. Cannot proceed.', DeptReqSheetLineRec."Main Category Name");

                                    if MainCateRec."No Series" <> '' then
                                        NextItemNo := NoSeriesManagementCode.GetNextNo(MainCateRec."No Series", Today(), true)
                                    else
                                        NextItemNo := NoSeriesManagementCode.GetNextNo(NavAppSetupRec."MISCITEM Nos.", Today(), true);

                                    ItemMasterRec.Init();
                                    ItemMasterRec."No." := NextItemNo;
                                    ItemMasterRec.Description := ItemDesc;
                                    ItemMasterRec."Main Category No." := DeptReqSheetLineRec."Main Category No.";
                                    ItemMasterRec."Main Category Name" := DeptReqSheetLineRec."Main Category Name";
                                    ItemMasterRec."Sub Category No." := DeptReqSheetLineRec."Sub Category No.";
                                    ItemMasterRec."Sub Category Name" := DeptReqSheetLineRec."Sub Category Name";
                                    ItemMasterRec."Rounding Precision" := 0.00001;

                                    //Check for Item category
                                    ItemCategoryRec.Reset();
                                    ItemCategoryRec.SetRange(Code, DeptReqSheetLineRec."Main Category No.");
                                    if not ItemCategoryRec.FindSet() then begin
                                        ItemCategoryRec.Init();
                                        ItemCategoryRec.Code := DeptReqSheetLineRec."Main Category No.";
                                        ItemCategoryRec.Description := DeptReqSheetLineRec."Main Category Name";
                                        ItemCategoryRec.Insert();
                                    end;

                                    ItemMasterRec."Item Category Code" := DeptReqSheetLineRec."Main Category No.";
                                    ItemMasterRec."Color No." := DeptReqSheetLineRec."Color No.";
                                    ItemMasterRec."Color Name" := DeptReqSheetLineRec."Color Name";
                                    ItemMasterRec."Size Range No." := DeptReqSheetLineRec."Size Range No.";
                                    ItemMasterRec."Article No." := DeptReqSheetLineRec."Article No.";
                                    ItemMasterRec."Article" := DeptReqSheetLineRec."Article";
                                    ItemMasterRec."Dimension Width No." := DeptReqSheetLineRec."Dimension No.";
                                    ItemMasterRec."Dimension Width" := DeptReqSheetLineRec."Dimension Name.";
                                    ItemMasterRec.Remarks := DeptReqSheetLineRec.Other;
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
                                    ItemUinitRec.Code := DeptReqSheetLineRec."UOM Code";
                                    ItemUinitRec."Qty. per Unit of Measure" := 1;
                                    ItemUinitRec.Insert();

                                    ItemMasterRec.Validate("Base Unit of Measure", DeptReqSheetLineRec."UOM Code");
                                    ItemMasterRec.Validate("Replenishment System", 0);
                                    ItemMasterRec.Validate("Manufacturing Policy", 1);
                                    ItemMasterRec.Insert(true);

                                    DeptReqSheetLineRec."Item No" := NextItemNo;
                                    DeptReqSheetLineRec."Item Name" := ItemDesc;
                                    DeptReqSheetLineRec.Modify();

                                end;
                            end;
                        until DeptReqSheetLineRec.Next() = 0;
                        CurrPage.Update();
                    end;
                end;
            }
        }
    }


    trigger OnNewRecord(BelowxRec: Boolean)
    var
        inx: Integer;
    begin
        Rec."Line No" := xRec."Line No" + 1;
    end;


    trigger OnOpenPage()
    var
        DeptReqSheetHeader: Record DeptReqSheetHeader;
    begin
        if Rec."Req No" <> '' then begin
            DeptReqSheetHeader.Get(Rec."Req No");

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
        if Rec."Req No" <> '' then begin
            DeptReqSheetHeader.Get(Rec."Req No");

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