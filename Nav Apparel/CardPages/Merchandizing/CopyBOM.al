page 50989 "Copy BOM Card"
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
                    //TableRelation = "Style Master"."No." where(EstimateBOM = filter(<> ''), "Merchandizer Group Name" = filter(gr));
                    ShowMandatory = true;
                    Caption = 'Source Style No';

                    trigger OnLookup(var text: Text): Boolean
                    var
                        StyleMasterRec: Record "Style Master";
                        Users: Record "User Setup";
                        NewBrRec: Record "New Breakdown";
                    begin

                        StyleMasterRec.Reset();
                        StyleMasterRec.SetRange("Merchandizer Group Name", "Mercha Group Name");
                        StyleMasterRec.SetFilter(EstimateBOM, '<>%1', '');

                        if StyleMasterRec.Findset() then begin
                            repeat
                                NewBrRec.Reset();
                                NewBrRec.SetRange("Style No.", StyleMasterRec."No.");

                                if NewBrRec.Findset() then
                                    StyleMasterRec.Mark(true);

                            until StyleMasterRec.Next() = 0;
                        end;

                        StyleMasterRec.MARKEDONLY(TRUE);

                        if Page.RunModal(51185, StyleMasterRec) = Action::LookupOK then begin
                            SourceStyle := StyleMasterRec."No.";
                            SourceStyleName := StyleMasterRec."Style No.";
                        end;


                    end;

                    trigger OnValidate()
                    var
                        StyleMasterRec: Record "Style Master";
                    begin

                        StyleMasterRec.Reset();
                        StyleMasterRec.SetRange("No.", SourceStyle);

                        if not StyleMasterRec.FindSet() then
                            Error('Invalid Style');

                    end;


                    // trigger OnValidate()
                    // var
                    //     StyleMasterRec: Record "Style Master";
                    // begin
                    //     StyleMasterRec.Reset();
                    //     StyleMasterRec.SetRange("No.", SourceStyle);
                    //     StyleMasterRec.SetFilter(EstimateBOM, '<>%1', '');

                    //     StyleMasterRec.FindSet();
                    //     SourceStyleName := StyleMasterRec."Style No.";

                    // end;
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
                    //TableRelation = "Style Master"."No." where(EstimateBOM = filter(''));
                    ShowMandatory = true;

                    trigger OnLookup(var text: Text): Boolean
                    var
                        StyleMasterRec: Record "Style Master";
                        Users: Record "User Setup";
                    begin

                        StyleMasterRec.Reset();
                        StyleMasterRec.SetRange("Merchandizer Group Name", "Mercha Group Name");
                        StyleMasterRec.SetRange(Type, StyleMasterRec.Type::Costing);
                        StyleMasterRec.SetFilter(EstimateBOM, '=%1', '');

                        if StyleMasterRec.Findset() then begin
                            repeat
                                StyleMasterRec.Mark(true);
                            until StyleMasterRec.Next() = 0;
                        end;

                        StyleMasterRec.MARKEDONLY(TRUE);

                        if Page.RunModal(51185, StyleMasterRec) = Action::LookupOK then begin
                            DestinationStyle := StyleMasterRec."No.";
                            DestinationStyleName := StyleMasterRec."Style No.";
                        end;
                    end;

                    trigger OnValidate()
                    var
                        StyleMasterRec: Record "Style Master";
                    begin

                        StyleMasterRec.Reset();
                        StyleMasterRec.SetRange("No.", DestinationStyle);

                        if not StyleMasterRec.FindSet() then
                            Error('Invalid Style');
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
                    Qty: BigInteger;
                    UOMRec: Record "Unit of Measure";
                    ConvFactor: Decimal;
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
                    end;

                    NavAppSetupRec.Reset();
                    NavAppSetupRec.FindSet();

                    StyleRec.Reset();
                    StyleRec.SetRange("No.", DestinationStyle);
                    if StyleRec.FindSet() then
                        Qty := StyleRec."Order Qty";


                    BOMEstRec.Reset();
                    BOMEstRec.SetRange("Style No.", SourceStyle);

                    if BOMEstRec.FindSet() then begin

                        //Master Record
                        NextBOMNo := NoSeriesManagementCode.GetNextNo(NavAppSetupRec."BOM Nos.", Today(), true);
                        BOMEstNewRec.Init();
                        BOMEstNewRec."No." := NextBOMNo;
                        // BOMEstNewRec."Brand Name" := BOMEstRec."Brand Name";
                        // BOMEstNewRec."Brand No." := BOMEstRec."Brand No.";
                        // BOMEstNewRec."Buyer Name" := BOMEstRec."Buyer Name";
                        // BOMEstNewRec."Buyer No." := BOMEstRec."Buyer No.";
                        // BOMEstNewRec."Created Date" := Today;
                        // BOMEstNewRec."Created User" := UserId;
                        // BOMEstNewRec."Currency No." := BOMEstRec."Currency No.";
                        // BOMEstNewRec."Department Name" := BOMEstRec."Department Name";
                        // BOMEstNewRec."Department No." := BOMEstRec."Department No.";
                        // BOMEstNewRec."Garment Type Name" := BOMEstRec."Garment Type Name";
                        // BOMEstNewRec."Garment Type No." := BOMEstRec."Garment Type No.";
                        // //BOMEstNewRec."Main Category Name" := MainCategoryName;
                        // //BOMEstNewRec."Main Category No." := MainCategory;
                        // BOMEstNewRec."Material Cost Doz." := BOMEstRec."Material Cost Doz.";
                        // BOMEstNewRec."Material Cost Pcs." := BOMEstRec."Material Cost Pcs.";
                        // BOMEstNewRec.Quantity := Qty;
                        // BOMEstNewRec.Revision := 0;
                        // BOMEstNewRec."Season Name" := BOMEstRec."Season Name";
                        // BOMEstNewRec."Season No." := BOMEstRec."Season No.";
                        // BOMEstNewRec.Status := BOMEstRec.Status;
                        // BOMEstNewRec."Store Name" := BOMEstRec."Store Name";
                        // BOMEstNewRec."Store No." := BOMEstRec."Store No.";
                        // BOMEstNewRec."Style Name" := DestinationStyleName;
                        // BOMEstNewRec."Style No." := DestinationStyle;


                        BOMEstNewRec."Brand Name" := StyleRec."Brand Name";
                        BOMEstNewRec."Brand No." := StyleRec."Brand No.";
                        BOMEstNewRec."Buyer Name" := StyleRec."Buyer Name";
                        BOMEstNewRec."Buyer No." := StyleRec."Buyer No.";
                        BOMEstNewRec."Created Date" := WorkDate();
                        BOMEstNewRec."Created User" := UserId;
                        BOMEstNewRec."Currency No." := BOMEstRec."Currency No.";
                        BOMEstNewRec."Department Name" := StyleRec."Department Name";
                        BOMEstNewRec."Department No." := StyleRec."Department No.";
                        BOMEstNewRec."Garment Type Name" := StyleRec."Garment Type Name";
                        BOMEstNewRec."Garment Type No." := StyleRec."Garment Type No.";
                        //BOMEstNewRec."Main Category Name" := MainCategoryName;
                        //BOMEstNewRec."Main Category No." := MainCategory;
                        BOMEstNewRec."Material Cost Doz." := BOMEstRec."Material Cost Doz.";
                        BOMEstNewRec."Material Cost Pcs." := BOMEstRec."Material Cost Pcs.";
                        BOMEstNewRec.Quantity := Qty;
                        BOMEstNewRec.Revision := 0;
                        BOMEstNewRec."Season Name" := StyleRec."Season Name";
                        BOMEstNewRec."Season No." := StyleRec."Season No.";
                        BOMEstNewRec.Status := StyleRec.Status;
                        BOMEstNewRec."Store Name" := StyleRec."Store Name";
                        BOMEstNewRec."Store No." := StyleRec."Store No.";
                        BOMEstNewRec."Style Name" := DestinationStyleName;
                        BOMEstNewRec."Style No." := DestinationStyle;
                        BOMEstNewRec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        BOMEstNewRec."Merchandizer Group Name" := StyleRec."Merchandizer Group Name";
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

                                    BOMEstLineNewRec.qty := Qty;

                                    UOMRec.Reset();
                                    UOMRec.SetRange(Code, BOMEstLineRec."Unit N0.");
                                    if UOMRec.FindSet() then
                                        ConvFactor := UOMRec."Converion Parameter";

                                    if BOMEstLineRec.Type = BOMEstLineRec.type::Pcs then
                                        BOMEstLineNewRec.Requirment := (BOMEstLineRec.Consumption * Qty) + (BOMEstLineRec.Consumption * Qty) * BOMEstLineRec.WST / 100
                                    else
                                        if BOMEstLineRec.Type = BOMEstLineRec.type::Doz then
                                            BOMEstLineNewRec.Requirment := ((BOMEstLineRec.Consumption * Qty) + (BOMEstLineRec.Consumption * Qty) * BOMEstLineRec.WST / 100) / 12;

                                    if ConvFactor <> 0 then
                                        BOMEstLineNewRec.Requirment := BOMEstLineNewRec.Requirment / ConvFactor;

                                    //BOMEstLineNewRec.Requirment := Round(BOMEstLineRec.Requirment, 1);
                                    BOMEstLineNewRec.Value := BOMEstLineNewRec.Requirment * BOMEstLineRec.Rate;

                                    BOMEstLineNewRec.AjstReq := BOMEstLineRec.AjstReq;
                                    BOMEstLineNewRec.Consumption := BOMEstLineRec.Consumption;
                                    //BOMEstLineNewRec.Qty := BOMEstLineRec.Qty;
                                    BOMEstLineNewRec.Rate := BOMEstLineRec.Rate;
                                    //BOMEstLineNewRec.Requirment := BOMEstLineRec.Requirment;
                                    //BOMEstLineNewRec.Value := BOMEstLineRec.Value;
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
        "Mercha Group Name": text[50];


    trigger OnOpenPage()
    var
        UserRec: Record "User Setup";
    begin
        UserRec.Reset();
        UserRec.SetRange("User ID", UserId);
        if UserRec.FindSet() then
            "Mercha Group Name" := UserRec."Merchandizer Group Name";
    end;

}