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
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Main Category No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Master Category No."; "Master Category No.")
                {
                    ApplicationArea = All;
                    TableRelation = "Master Category"."No.";
                    Caption = 'Master Category';

                    trigger OnValidate()
                    var
                        MasterCategoryrec: Record "Master Category";
                    begin
                        MasterCategoryrec.get("Master Category No.");
                        "Master Category Name" := MasterCategoryrec."Master Category Name";
                    end;
                }

                field("Master Category Name"; "Master Category Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Main Category Name"; "Main Category Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        MainCategoryRec: Record "Main Category";
                    begin
                        MainCategoryRec.Reset();
                        MainCategoryRec.SetRange("Master Category No.", "Master Category No.");
                        MainCategoryRec.SetRange("Main Category Name", "Main Category Name");

                        if MainCategoryRec.FindSet() then
                            Error('Main Category : %1 already exists for Master Category : %2', "Main Category Name", "Master Category Name");
                    end;
                }

                field("Inv. Posting Group Code"; "Inv. Posting Group Code")
                {
                    ApplicationArea = All;
                    Caption = 'Inv. Posting Group';
                    ShowMandatory = true;
                    //NotBlank = true;

                    trigger OnValidate()
                    var
                        InvPostingGroup: Record "Inventory Posting Group";
                    begin
                        InvPostingGroup.Reset();
                        InvPostingGroup.SetRange(Code, "Inv. Posting Group Code");
                        if InvPostingGroup.FindSet() then
                            "Inv. Posting Group Name" := InvPostingGroup.Description;
                    end;
                }

                field(DimensionOnly; DimensionOnly)
                {
                    ApplicationArea = All;
                    Caption = 'Dimension Only';
                }

                field(SewingJobOnly; SewingJobOnly)
                {
                    ApplicationArea = All;
                    Caption = 'Sewing Job Only';
                }

                field(LOTTracking; LOTTracking)
                {
                    ApplicationArea = All;
                    Caption = 'LOT Tracking';
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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."MainCat Nos.", xRec."No.", "No.") THEN BEGIN
            NoSeriesMngment.SetSeries("No.");
            CurrPage.Update();
            EXIT(TRUE);
        END;
    end;

    trigger OnClosePage()
    var

    begin
        if "Inv. Posting Group Code" = '' then
            Error('Inventory Posting Group is not setup for this Main Category.');
    end;
}