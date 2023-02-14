pageextension 50957 ItemCardExt extends "Item Card"
{
    layout
    {
        addafter("Common Item No.")
        {
            group("Apperal Settings")
            {
                field("Main Category Name"; rec."Main Category Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Main Category';

                    trigger OnValidate()
                    var
                        MainCatRec: Record "Main Category";
                    begin

                        MainCatRec.Reset();
                        MainCatRec.SetRange("Main Category Name", rec."Main Category Name");
                        if MainCatRec.FindSet() then begin
                            rec."Main Category No." := MainCatRec."No.";
                            rec.Validate("Gen. Prod. Posting Group", MainCatRec."Prod. Posting Group Code");
                            rec.Validate("Inventory Posting Group", MainCatRec."Inv. Posting Group Code");
                        end;

                        //Article
                        if (rec."Main Category Name" = 'SPARE PARTS')
                            or (rec."Main Category Name" = 'SPAIR PARTS') or (rec."Main Category Name" = 'CHEMICAL')
                            or (rec."Main Category Name" = 'STATIONARY') or (rec."Main Category Name" = 'IT ACESSORIES')
                            or (rec."Main Category Name" = 'ELETRICAL') then
                            CaptionA := 'Brand'
                        else
                            CaptionA := 'Article';

                        //Size                            
                        if (rec."Main Category Name" = 'SPARE PARTS') or (rec."Main Category Name" = 'SPAIR PARTS') then
                            CaptionB := 'Type of Machine'
                        else
                            if (rec."Main Category Name" = 'CHEMICAL') then
                                CaptionB := 'Chemical Type'
                            else
                                CaptionB := 'Size';

                        //Color                            
                        if (rec."Main Category Name" = 'SPARE PARTS') or (rec."Main Category Name" = 'SPAIR PARTS') then
                            CaptionC := 'Model'
                        else
                            if (rec."Main Category Name" = 'CHEMICAL') then
                                CaptionC := 'Batch'
                            else
                                CaptionC := 'Color';

                        //remarks                            
                        if (rec."Main Category Name" = 'SPARE PARTS') or (rec."Main Category Name" = 'SPAIR PARTS') then
                            CaptionD := 'Part No'
                        else
                            if (rec."Main Category Name" = 'CHEMICAL') then
                                CaptionD := 'Lot'
                            else
                                CaptionD := 'Other';
                    end;
                }

                field("Sub Category Name"; rec."Sub Category Name")
                {
                    ApplicationArea = All;
                    Caption = 'Sub Category';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        CategoryRec: Record "Sub Category";
                    begin
                        CategoryRec.Reset();
                        CategoryRec.SetRange("Sub Category Name", rec."Sub Category Name");
                        if CategoryRec.FindSet() then
                            rec."Sub Category No." := CategoryRec."No.";

                        Get_Description();
                    end;
                }


                field("Color Name"; rec."Color Name")
                {
                    ApplicationArea = All;
                    CaptionClass = CaptionC;

                    trigger OnValidate()
                    var
                        ColourRec: Record Colour;
                        ModelRec: Record Model;
                    begin

                        if (rec."Main Category Name" = 'SPARE PARTS') or (rec."Main Category Name" = 'SPAIR PARTS') then begin
                            ModelRec.Reset();
                            ModelRec.SetRange("Model Name", rec."Color Name");
                            if ModelRec.FindSet() then
                                rec."Color No." := ModelRec."No.";
                        end
                        else
                            if (rec."Main Category Name" = 'ELETRICAL') or (rec."Main Category Name" = 'STATIONARY') or (rec."Main Category Name" = 'IT ACESSORIES') then begin
                                ColourRec.Reset();
                                ColourRec.SetRange("Colour Name", rec."Color Name");
                                if ColourRec.FindSet() then
                                    rec."Color No." := ColourRec."No.";
                            end
                            else
                                if (rec."Main Category Name" = 'CHEMICAL') then begin

                                end
                                else begin
                                    ColourRec.Reset();
                                    ColourRec.SetRange("Colour Name", rec."Color Name");
                                    if ColourRec.FindSet() then
                                        rec."Color No." := ColourRec."No.";
                                end;

                        Get_Description();
                    end;
                }

                field("Size Range No."; rec."Size Range No.")
                {
                    ApplicationArea = All;
                    CaptionClass = CaptionB;

                    trigger OnValidate()
                    var
                    //     // ChemicalTypeRec: Record ChemicalType;
                    //     ServiceItemRec: Record "Service Item";
                    begin
                        Get_Description();
                        //     if (rec."Main Category Name" = 'SPAIR PARTS') then begin
                        //         ServiceItemRec.Reset();
                        //         ServiceItemRec.SetRange(Description, "Size Range No.");
                        //         if ServiceItemRec.FindSet() then
                        //             "Article No." := ServiceItemRec."No.";
                        //     end
                        //     else
                        //         if (rec."Main Category Name" = 'CHEMICAL') then begin
                        //             ChemicalTypeRec.Reset();
                        //             ChemicalTypeRec.SetRange("Chemical Type Name", "Size Range No.");
                        //             if ChemicalTypeRec.FindSet() then
                        //                 "Article No." := ChemicalTypeRec."No.";
                        //         end
                    end;


                }

                field(Article; rec.Article)
                {
                    ApplicationArea = All;
                    CaptionClass = CaptionA;

                    trigger OnValidate()
                    var
                        ArticleRec: Record Article;
                        BrandRec: Record Brand;
                    begin
                        if (rec."Main Category Name" = 'SPARE PARTS')
                        or (rec."Main Category Name" = 'SPAIR PARTS') or (rec."Main Category Name" = 'CHEMICAL')
                        or (rec."Main Category Name" = 'STATIONARY') or (rec."Main Category Name" = 'IT ACESSORIES')
                        or (rec."Main Category Name" = 'ELETRICAL') then begin
                            BrandRec.Reset();
                            BrandRec.SetRange("Brand Name", rec.Article);
                            if BrandRec.FindSet() then
                                rec."Article No." := BrandRec."No.";
                        end
                        else begin
                            ArticleRec.Reset();
                            ArticleRec.SetRange(Article, rec.Article);
                            if ArticleRec.FindSet() then
                                rec."Article No." := ArticleRec."No.";
                        end;

                        Get_Description();
                    end;

                    // trigger OnValidate()
                    // var
                    //     ArticleRec: Record Article;
                    // begin
                    //     ArticleRec.Reset();
                    //     ArticleRec.SetRange(Article, Article);
                    //     if ArticleRec.FindSet() then
                    //         "Article No." := ArticleRec."No.";
                    // end;
                }


                field("Dimension Width"; rec."Dimension Width")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        DimensionWidthRec: Record DimensionWidth;
                    begin
                        DimensionWidthRec.Reset();
                        DimensionWidthRec.SetRange("Dimension Width", rec."Dimension Width");
                        if DimensionWidthRec.FindSet() then
                            rec."Dimension Width No." := DimensionWidthRec."No.";

                        Get_Description();
                    end;
                }


                // field("Type of Machine"; "Type of Machine")
                // {
                //     ApplicationArea = All;
                // }

                // field("Model Name"; "Model Name")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Model';

                //     trigger OnValidate()
                //     var
                //         ModelRec: Record Model;
                //     begin
                //         ModelRec.Reset();
                //         ModelRec.SetRange("Model Name", "Model Name");
                //         if ModelRec.FindSet() then
                //             "Model Code" := ModelRec."No.";
                //     end;
                // }

                // field("Brand Name"; "Brand Name")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Brand';

                //     trigger OnValidate()
                //     var
                //         BrandRec: Record Brand;
                //     begin
                //         BrandRec.Reset();
                //         BrandRec.SetRange("Brand Name", "Brand Name");
                //         if BrandRec.FindSet() then
                //             "Brand Code" := BrandRec."No.";
                //     end;
                // }

                // field("Part No"; "Part No")
                // {
                //     ApplicationArea = All;
                // }

                // field("Ref Page in Catelog"; "Ref Page in Catelog")
                // {
                //     ApplicationArea = All;
                // }

                // field("Chemical Type Name"; "Chemical Type Name")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Chemical Type';

                //     trigger OnValidate()
                //     var
                //         ChemicalTypeRec: Record "ChemicalType";
                //     begin
                //         ChemicalTypeRec.Reset();
                //         ChemicalTypeRec.SetRange("Chemical Type Name", "Chemical Type Name");
                //         if ChemicalTypeRec.FindSet() then
                //             "Chemical Type Code" := ChemicalTypeRec."No.";
                //     end;
                // }

                // field(Batch; Batch)
                // {
                //     ApplicationArea = All;
                // }

                // field(Lot; Lot)
                // {
                //     ApplicationArea = All;
                // }

                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = All;
                    CaptionClass = CaptionD;

                    trigger OnValidate()
                    var
                    begin
                        Get_Description();
                    end;

                }

                field("EstimateBOM Item"; rec."EstimateBOM Item")
                {
                    ApplicationArea = All;
                }
            }
        }

        modify(Description)
        {
            trigger OnAfterValidate()
            var
                LoginSessionsRec: Record LoginSessions;
                LoginRec: Page "Login Card";
            begin
                //Check whether user logged in or not
                LoginSessionsRec.Reset();
                LoginSessionsRec.SetRange(SessionID, SessionId());

                if not LoginSessionsRec.FindSet() then begin  //not logged in
                    Clear(LoginRec);
                    LoginRec.LookupMode(true);
                    LoginRec.RunModal();

                    LoginSessionsRec.Reset();
                    LoginSessionsRec.SetRange(SessionID, SessionId());
                    LoginSessionsRec.FindSet();
                    rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                end
                else begin   //logged in
                    rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                end;
            end;
        }

    }

    trigger OnAfterGetCurrRecord()
    var

    begin
        //Article
        if (rec."Main Category Name" = 'SPARE PARTS') or (rec."Main Category Name" = 'SPAIR PARTS')
            or (rec."Main Category Name" = 'CHEMICAL')
            or (rec."Main Category Name" = 'STATIONARY') or (rec."Main Category Name" = 'IT ACESSORIES')
            or (rec."Main Category Name" = 'ELETRICAL') then
            CaptionA := 'Brand'
        else
            CaptionA := 'Article';

        //Size                            
        if (rec."Main Category Name" = 'SPARE PARTS') or (rec."Main Category Name" = 'SPAIR PARTS') then
            CaptionB := 'Type of Machine'
        else
            if (rec."Main Category Name" = 'CHEMICAL') then
                CaptionB := 'Chemical Type'
            else
                CaptionB := 'Size';

        //Color                            
        if (rec."Main Category Name" = 'SPARE PARTS') or (rec."Main Category Name" = 'SPAIR PARTS') then
            CaptionC := 'Model'
        else
            if (rec."Main Category Name" = 'CHEMICAL') then
                CaptionC := 'Batch'
            else
                CaptionC := 'Color';

        //remarks                            
        if (rec."Main Category Name" = 'SPARE PARTS') or (rec."Main Category Name" = 'SPAIR PARTS') then
            CaptionD := 'Part No'
        else
            if (rec."Main Category Name" = 'CHEMICAL') then
                CaptionD := 'Lot'
            else
                CaptionD := 'Other';
    end;


    procedure Get_Description()
    var
        ItemDesc: Text[500];
    begin
        ItemDesc := rec."Sub Category Name";

        if rec.Article <> '' then
            ItemDesc := ItemDesc + ' / ' + rec.Article;

        if rec."Color Name" <> '' then
            ItemDesc := ItemDesc + ' / ' + rec."Color Name";

        if rec."Size Range No." <> '' then
            ItemDesc := ItemDesc + ' / ' + rec."Size Range No.";

        if rec."Dimension Width" <> '' then
            ItemDesc := ItemDesc + ' / ' + rec."Dimension Width";

        if rec.Remarks <> '' then
            ItemDesc := ItemDesc + ' / ' + rec.Remarks;

        rec.Description := ItemDesc;
    end;


    var
        CaptionA: Text[100];
        CaptionB: Text[100];
        CaptionC: Text[100];
        CaptionD: Text[100];
}