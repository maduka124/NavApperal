page 71012617 "Main Category Card"
{
    PageType = Card;
    SourceTable = "Main Category";
    Caption = 'Main Category';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Main Category No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Master Category No."; rec."Master Category No.")
                {
                    ApplicationArea = All;
                    TableRelation = "Master Category"."No.";
                    Caption = 'Master Category';

                    trigger OnValidate()
                    var
                        MasterCategoryrec: Record "Master Category";
                    begin
                        MasterCategoryrec.get(rec."Master Category No.");
                        rec."Master Category Name" := MasterCategoryrec."Master Category Name";
                    end;
                }

                field("Master Category Name"; rec."Master Category Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Main Category Name"; rec."Main Category Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        MainCategoryRec: Record "Main Category";
                    begin
                        MainCategoryRec.Reset();
                        MainCategoryRec.SetRange("Master Category No.", rec."Master Category No.");
                        MainCategoryRec.SetRange("Main Category Name", rec."Main Category Name");

                        if MainCategoryRec.FindSet() then
                            Error('Main Category : %1 already exists for Master Category : %2', rec."Main Category Name", rec."Master Category Name");
                    end;
                }

                field("Inv. Posting Group Code"; rec."Inv. Posting Group Code")
                {
                    ApplicationArea = All;
                    Caption = 'Inv. Posting Group';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        InvPostingGroup: Record "Inventory Posting Group";
                    begin
                        InvPostingGroup.Reset();
                        InvPostingGroup.SetRange(Code, rec."Inv. Posting Group Code");
                        if InvPostingGroup.FindSet() then
                            rec."Inv. Posting Group Name" := InvPostingGroup.Description;
                    end;
                }

                field("Prod. Posting Group Code"; rec."Prod. Posting Group Code")
                {
                    ApplicationArea = All;
                    Caption = 'Prod. Posting Group';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        ProdPostingGroup: Record "Gen. Product Posting Group";
                    begin
                        ProdPostingGroup.Reset();
                        ProdPostingGroup.SetRange(Code, rec."Prod. Posting Group Code");
                        if ProdPostingGroup.FindSet() then
                            rec."Prod. Posting Group Name" := ProdPostingGroup.Description;
                    end;
                }

                field("No Series"; rec."No Series")
                {
                    ApplicationArea = All;
                }

                field(DimensionOnly; rec.DimensionOnly)
                {
                    ApplicationArea = All;
                    Caption = 'Dimension Only';
                }

                field(SewingJobOnly; rec.SewingJobOnly)
                {
                    ApplicationArea = All;
                    Caption = 'Sewing Job Only';
                }

                field(LOTTracking; rec.LOTTracking)
                {
                    ApplicationArea = All;
                    Caption = 'LOT Tracking';
                }

                field("Style Related"; rec."Style Related")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."MainCat Nos.", xRec."No.", rec."No.") THEN BEGIN
            NoSeriesMngment.SetSeries(rec."No.");
            CurrPage.Update();
            EXIT(TRUE);
        END;
    end;

    trigger OnClosePage()
    var

    begin
        if rec."Inv. Posting Group Code" = '' then
            Error('Inventory Posting Group is not setup for this Main Category.');

        if rec."Prod. Posting Group Code" = '' then
            Error('Product Posting Group is not setup for this Main Category.');

        exit;
    end;
}