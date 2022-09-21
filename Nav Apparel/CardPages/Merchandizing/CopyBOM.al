page 71012781 "Copy BOM Card"
{
    PageType = Card;
    UsageCategory = Tasks;
    ApplicationArea = all;
    Caption = 'Copy BOM';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(SourceStyle; SourceStyle)
                {
                    ApplicationArea = All;
                    TableRelation = "Style Master"."No." where(EstimateBOM = filter(<> ''));
                    ShowMandatory = true;
                    Caption = 'Source Style No';

                    trigger OnValidate()
                    var
                        StyleMasterRec: Record "Style Master";
                    begin
                        StyleMasterRec.Reset();
                        StyleMasterRec.SetRange("No.", SourceStyle);
                        StyleMasterRec.SetFilter(EstimateBOM, '<>%1', '');

                        StyleMasterRec.FindSet();
                        SourceStyleName := StyleMasterRec."Style No.";
                    end;
                }

                field(SourceStyleName; SourceStyleName)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Source Style';
                }

                field(DestinationStyle; DestinationStyle)
                {
                    ApplicationArea = All;
                    Caption = 'Target Style No';
                    TableRelation = "Style Master"."No." where(EstimateBOM = filter(''));
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        StyleMasterRec: Record "Style Master";
                    begin
                        StyleMasterRec.Reset();
                        StyleMasterRec.SetRange("No.", DestinationStyle);
                        StyleMasterRec.SetFilter(EstimateBOM, '=%1', '');

                        StyleMasterRec.FindSet();
                        DestinationStyleName := StyleMasterRec."Style No.";
                    end;
                }

                field(DestinationStyleName; DestinationStyleName)
                {
                    ApplicationArea = All;
                    Caption = 'Target Style';
                    Editable = false;
                }

                field(MainCategory; MainCategory)
                {
                    ApplicationArea = All;
                    TableRelation = "Main Category"."No.";
                    ShowMandatory = true;
                    Caption = 'Main Category Code';

                    trigger OnValidate()
                    var
                        MainCategoryRec: Record "Main Category";
                    begin
                        MainCategoryRec.Reset();
                        MainCategoryRec.SetRange("No.", MainCategory);

                        MainCategoryRec.FindSet();
                        MainCategoryName := MainCategoryRec."Main Category Name";
                    end;
                }

                field(MainCategoryName; MainCategoryName)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Main Category';
                }

                field(SpecialOption; SpecialOption)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Copy)
            {
                ApplicationArea = All;
                Image = CopyBOM;

                trigger OnAction()
                var
                    BOMEstRec: Record "BOM Estimate";
                    BOMEstLineRec: Record "BOM Estimate Line";
                    BOMEstNewRec: Record "BOM Estimate";
                    BOMEstLineNewRec: Record "BOM Estimate Line";
                    StyleRec: Record "Style Master";
                    NoSeriesManagementCode: Codeunit NoSeriesManagement;
                    NextBOMNo: Code[20];
                    LineNo: Integer;
                    NavAppSetupRec: Record "NavApp Setup";
                begin

                    NavAppSetupRec.Reset();
                    NavAppSetupRec.FindSet();

                    BOMEstRec.Reset();
                    BOMEstRec.SetRange("Style No.", SourceStyle);

                    if BOMEstRec.FindSet() then begin

                        //Master Record
                        NextBOMNo := NoSeriesManagementCode.GetNextNo(NavAppSetupRec."BOM Nos.", Today(), true);
                        BOMEstNewRec.Init();
                        BOMEstNewRec."No." := NextBOMNo;
                        BOMEstNewRec."Brand Name" := BOMEstRec."Brand Name";
                        BOMEstNewRec."Brand No." := BOMEstRec."Brand No.";
                        BOMEstNewRec."Buyer Name" := BOMEstRec."Buyer Name";
                        BOMEstNewRec."Buyer No." := BOMEstRec."Buyer No.";
                        BOMEstNewRec."Created Date" := Today;
                        BOMEstNewRec."Created User" := UserId;
                        BOMEstNewRec."Currency No." := BOMEstRec."Currency No.";
                        BOMEstNewRec."Department Name" := BOMEstRec."Department Name";
                        BOMEstNewRec."Department No." := BOMEstRec."Department No.";
                        BOMEstNewRec."Garment Type Name" := BOMEstRec."Garment Type Name";
                        BOMEstNewRec."Garment Type No." := BOMEstRec."Garment Type No.";
                        BOMEstNewRec."Main Category Name" := MainCategoryName;
                        BOMEstNewRec."Main Category No." := MainCategory;
                        BOMEstNewRec."Material Cost Doz." := BOMEstRec."Material Cost Doz.";
                        BOMEstNewRec."Material Cost Pcs." := BOMEstRec."Material Cost Pcs.";
                        BOMEstNewRec.Quantity := BOMEstRec.Quantity;
                        BOMEstNewRec.Revision := 0;
                        BOMEstNewRec."Season Name" := BOMEstRec."Season Name";
                        BOMEstNewRec."Season No." := BOMEstRec."Season No.";
                        BOMEstNewRec.Status := BOMEstRec.Status;
                        BOMEstNewRec."Store Name" := BOMEstRec."Store Name";
                        BOMEstNewRec."Store No." := BOMEstRec."Store No.";
                        BOMEstNewRec."Style Name" := DestinationStyleName;
                        BOMEstNewRec."Style No." := DestinationStyle;
                        BOMEstNewRec.Insert();

                        //Line Records
                        BOMEstLineRec.Reset();
                        BOMEstLineRec.SetRange("No.", BOMEstRec."No.");

                        if MainCategoryName <> 'ALL CATEGORIES' then
                            BOMEstLineRec.SetRange("Main Category No.", MainCategory);

                        if BOMEstLineRec.FindSet() then begin
                            repeat
                                LineNo += 1;
                                BOMEstLineNewRec.Init();
                                BOMEstLineNewRec."No." := NextBOMNo;
                                BOMEstLineNewRec."Article Name." := BOMEstLineRec."Article Name.";
                                BOMEstLineNewRec."Article No." := BOMEstLineRec."Article No.";
                                BOMEstLineNewRec."Created Date" := Today;
                                BOMEstLineNewRec."Created User" := UserId;
                                BOMEstLineNewRec."Dimension Name." := BOMEstLineRec."Dimension Name.";
                                BOMEstLineNewRec."Dimension No." := BOMEstLineRec."Dimension No.";
                                BOMEstLineNewRec."Item Name" := BOMEstLineRec."Item Name";
                                BOMEstLineNewRec."Item No." := BOMEstLineRec."Item No.";
                                BOMEstLineNewRec."Line No." := LineNo;
                                BOMEstLineNewRec."Main Category Name" := BOMEstLineRec."Main Category Name";
                                BOMEstLineNewRec."Main Category No." := BOMEstLineRec."Main Category No.";
                                BOMEstLineNewRec."Master Category Name" := BOMEstLineRec."Master Category Name";
                                BOMEstLineNewRec."Master Category No." := BOMEstLineRec."Master Category No.";
                                BOMEstLineNewRec."Supplier Name." := BOMEstLineRec."Supplier Name.";
                                BOMEstLineNewRec."Supplier No." := BOMEstLineRec."Supplier No.";
                                BOMEstLineNewRec.Type := BOMEstLineRec.Type;
                                BOMEstLineNewRec."Unit N0." := BOMEstLineRec."Unit N0.";

                                if SpecialOption = SpecialOption::"With Consumption" then begin
                                    BOMEstLineNewRec.AjstReq := BOMEstLineRec.AjstReq;
                                    BOMEstLineNewRec.Consumption := BOMEstLineRec.Consumption;
                                    BOMEstLineNewRec.Qty := BOMEstLineRec.Qty;
                                    BOMEstLineNewRec.Rate := BOMEstLineRec.Rate;
                                    BOMEstLineNewRec.Requirment := BOMEstLineRec.Requirment;
                                    BOMEstLineNewRec.Value := BOMEstLineRec.Value;
                                    BOMEstLineNewRec.WST := BOMEstLineRec.WST;
                                end
                                else
                                    if SpecialOption = SpecialOption::"Without Consumption" then begin
                                        BOMEstLineNewRec.AjstReq := 0;
                                        BOMEstLineNewRec.Consumption := 0;
                                        BOMEstLineNewRec.Qty := 0;
                                        BOMEstLineNewRec.Rate := 0;
                                        BOMEstLineNewRec.Requirment := 0;
                                        BOMEstLineNewRec.Value := 0;
                                        BOMEstLineNewRec.WST := 0;
                                    end;

                                BOMEstLineNewRec.Insert();

                            until BOMEstLineRec.Next() = 0;
                        end;

                        //Update ExtBOMNo in Style Master table
                        StyleRec.Reset();
                        StyleRec.SetRange("No.", DestinationStyle);

                        if StyleRec.FindSet() then begin
                            StyleRec.EstimateBOM := NextBOMNo;
                            StyleRec.Modify();
                        end;

                        Message('Estimate BOM No %1 Created.', NextBOMNo);

                    end;

                end;
            }
        }
    }

    var
        SourceStyle: Code[20];
        SourceStyleName: Text[50];
        DestinationStyle: Code[20];
        DestinationStyleName: Text[50];
        MainCategory: code[20];
        MainCategoryName: Text[50];
        SpecialOption: option "With Consumption","Without Consumption";

}