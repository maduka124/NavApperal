page 50984 "BOM Card"
{
    PageType = Card;
    SourceTable = BOM;
    Caption = 'BOM';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No"; rec."No")
                {
                    ApplicationArea = All;
                    //Editable = false;
                    Caption = 'BOM No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';

                    trigger OnValidate()
                    var
                        StyleMasterRec: Record "Style Master";
                        CustomerRec: Record Customer;

                        BOMPOSelectionRec: Record BOMPOSelection;
                        BOMPOSelectionNewRec: Record BOMPOSelection;
                        StyleMasterPORec: Record "Style Master PO";
                        BOMEstimateLineRec: Record "BOM Estimate Line";
                        BOMEstimateRec: Record "BOM Estimate";
                        BOMLineEstimateNewRec: Record "BOM Line Estimate";
                        BOMRec: Record BOM;
                        LineNo: Integer;
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
                            if LoginSessionsRec.FindSet() then
                                rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end
                        else begin   //logged in
                            rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end;



                        //Check for duplicates
                        BOMRec.Reset();
                        BOMRec.SetRange("Style Name", rec."Style Name");
                        if BOMRec.FindSet() then
                            Error('Style : %1 already used to create a BOM', BOMRec."Style Name");


                        StyleMasterRec.Reset();
                        StyleMasterRec.SetRange("Style No.", rec."Style Name");
                        if StyleMasterRec.FindSet() then begin

                            if StyleMasterRec.AssignedContractNo = '' then
                                Error('Style is not assigned for a Contract. Cannot proceed.');

                            rec."Style No." := StyleMasterRec."No.";
                            rec."Store No." := StyleMasterRec."Store No.";
                            rec."Brand No." := StyleMasterRec."Brand No.";
                            rec."Buyer No." := StyleMasterRec."Buyer No.";
                            rec."Season No." := StyleMasterRec."Season No.";
                            rec."Department No." := StyleMasterRec."Department No.";
                            rec."Garment Type No." := StyleMasterRec."Garment Type No.";

                            rec."Store Name" := StyleMasterRec."Store Name";
                            rec."Brand Name" := StyleMasterRec."Brand Name";
                            rec."Buyer Name" := StyleMasterRec."Buyer Name";
                            rec."Season Name" := StyleMasterRec."Season Name";
                            rec."Department Name" := StyleMasterRec."Department Name";
                            rec."Garment Type Name" := StyleMasterRec."Garment Type Name";
                            rec.Quantity := 0;

                            ///CustomerRec.get(rec."Buyer No.");
                            //rec."Currency No." := CustomerRec."Currency Code";

                            //insert PO details
                            StyleMasterPORec.Reset();
                            StyleMasterPORec.SetRange("Style No.", rec."Style No.");

                            if StyleMasterPORec.FindSet() then begin

                                //Delete old records
                                BOMPOSelectionRec.Reset();
                                BOMPOSelectionRec.SetRange("BOM No.", rec."No");
                                BOMPOSelectionRec.DeleteAll();

                                repeat

                                    BOMPOSelectionNewRec.Init();
                                    BOMPOSelectionNewRec."BOM No." := rec."No";
                                    BOMPOSelectionNewRec."Style No." := rec."Style No.";
                                    BOMPOSelectionNewRec."Lot No." := StyleMasterPORec."Lot No.";
                                    BOMPOSelectionNewRec."PO No." := StyleMasterPORec."PO No.";
                                    BOMPOSelectionNewRec.Qty := StyleMasterPORec.Qty;
                                    BOMPOSelectionNewRec.Mode := StyleMasterPORec.Mode;
                                    BOMPOSelectionNewRec."Ship Date" := StyleMasterPORec."Ship Date";
                                    BOMPOSelectionNewRec.Selection := false;
                                    BOMPOSelectionNewRec."Created User" := UserId;
                                    BOMPOSelectionNewRec."Created Date" := WorkDate();
                                    BOMPOSelectionNewRec.Insert();

                                until StyleMasterPORec.Next() = 0;
                            end;

                            CurrPage.GetRecord(BOMPOSelectionRec);


                            //Load BOM Estimate Items to the Grid
                            BOMEstimateRec.Reset();
                            BOMEstimateRec.SetRange("Style No.", rec."Style No.");
                            BOMEstimateRec.FindSet();

                            rec."Currency No." := BOMEstimateRec."Currency No.";

                            BOMEstimateLineRec.Reset();
                            BOMEstimateLineRec.SetRange("No.", BOMEstimateRec."No.");

                            LineNo := 0;

                            if BOMEstimateLineRec.FindSet() then begin

                                BOMLineEstimateNewRec.Reset();
                                BOMLineEstimateNewRec.SetRange("No.", rec."No");
                                //BOMLineEstimateNewRec.SetRange("Item No.", BOMEstimateLineRec."Item No.");
                                BOMLineEstimateNewRec.DeleteAll();

                                repeat

                                    //if Not BOMLineEstimateNewRec.FindSet() then begin

                                    LineNo += 10000;
                                    BOMLineEstimateNewRec.Init();
                                    BOMLineEstimateNewRec."No." := rec."No";
                                    BOMLineEstimateNewRec."Item No." := BOMEstimateLineRec."Item No.";
                                    BOMLineEstimateNewRec."Item Name" := BOMEstimateLineRec."Item Name";
                                    BOMLineEstimateNewRec."Main Category No." := BOMEstimateLineRec."Main Category No.";
                                    BOMLineEstimateNewRec."Main Category Name" := BOMEstimateLineRec."Main Category Name";
                                    BOMLineEstimateNewRec."Article No." := BOMEstimateLineRec."Article No.";
                                    BOMLineEstimateNewRec."Article Name." := BOMEstimateLineRec."Article Name.";
                                    BOMLineEstimateNewRec."Dimension No." := BOMEstimateLineRec."Dimension No.";
                                    BOMLineEstimateNewRec."Dimension Name." := BOMEstimateLineRec."Dimension Name.";
                                    BOMLineEstimateNewRec."Unit N0." := BOMEstimateLineRec."Unit N0.";
                                    BOMLineEstimateNewRec.Type := BOMEstimateLineRec.Type;
                                    BOMLineEstimateNewRec.Consumption := BOMEstimateLineRec.Consumption;
                                    BOMLineEstimateNewRec.WST := BOMEstimateLineRec.WST;
                                    BOMLineEstimateNewRec.Rate := BOMEstimateLineRec.Rate;
                                    BOMLineEstimateNewRec.Value := BOMEstimateLineRec.Value;
                                    BOMLineEstimateNewRec."Supplier Name." := BOMEstimateLineRec."Supplier Name.";
                                    BOMLineEstimateNewRec."Supplier No." := BOMEstimateLineRec."Supplier No.";
                                    BOMLineEstimateNewRec.Requirment := BOMEstimateLineRec.Requirment;
                                    BOMLineEstimateNewRec.AjstReq := BOMEstimateLineRec.AjstReq;
                                    BOMLineEstimateNewRec.Qty := BOMEstimateLineRec.Qty;
                                    BOMLineEstimateNewRec."Created User" := UserId;
                                    BOMLineEstimateNewRec."Created Date" := WorkDate();
                                    BOMLineEstimateNewRec."Line No." := LineNo;
                                    BOMLineEstimateNewRec."Color Sensitive" := true;
                                    BOMLineEstimateNewRec.Insert();

                                //end;

                                until BOMEstimateLineRec.Next() = 0;

                                CurrPage.GetRecord(BOMLineEstimateNewRec);
                            end;

                        end;

                        CurrPage.Update();
                    end;
                }

                field("Store Name"; rec."Store Name")
                {
                    ApplicationArea = All;
                    Caption = 'Store';

                    trigger OnValidate()
                    var
                        GarmentStoreRec: Record "Garment Store";
                    begin
                        GarmentStoreRec.Reset();
                        GarmentStoreRec.SetRange("Store Name", rec."Store Name");
                        if GarmentStoreRec.FindSet() then
                            rec."Store No." := GarmentStoreRec."No.";
                    end;
                }

                field("Brand Name"; rec."Brand Name")
                {
                    ApplicationArea = All;
                    Caption = 'Brand';

                    trigger OnValidate()
                    var
                        BrandRec: Record "Brand";
                    begin
                        BrandRec.Reset();
                        BrandRec.SetRange("Brand Name", rec."Brand Name");
                        if BrandRec.FindSet() then
                            rec."Brand No." := BrandRec."No.";
                    end;
                }

                field("Buyer Name"; rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';

                    trigger OnValidate()
                    var
                        BuyerRec: Record Customer;
                    begin
                        BuyerRec.Reset();
                        BuyerRec.SetRange(Name, rec."Buyer Name");
                        if BuyerRec.FindSet() then begin
                            rec."Buyer No." := BuyerRec."No.";
                            rec."Currency No." := BuyerRec."Currency Code";
                        end;
                    end;
                }

                field("Season Name"; rec."Season Name")
                {
                    ApplicationArea = All;
                    Caption = 'Season';

                    trigger OnValidate()
                    var
                        SeasonsRec: Record "Seasons";
                    begin
                        SeasonsRec.Reset();
                        SeasonsRec.SetRange("Season Name", rec."Season Name");
                        if SeasonsRec.FindSet() then
                            rec."Season No." := SeasonsRec."No.";
                    end;
                }

                field("Department Name"; rec."Department Name")
                {
                    ApplicationArea = All;
                    Caption = 'Department';

                    trigger OnValidate()
                    var
                        DepartmentRec: Record "Department Style";
                    begin
                        DepartmentRec.Reset();
                        DepartmentRec.SetRange("Department Name", rec."Department Name");
                        if DepartmentRec.FindSet() then
                            rec."Department No." := DepartmentRec."No.";
                    end;
                }

                field("Garment Type Name"; rec."Garment Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Garment Type';

                    trigger OnValidate()
                    var
                        GarmentTypeRec: Record "Garment Type";
                    begin
                        GarmentTypeRec.Reset();
                        GarmentTypeRec.SetRange("Garment Type Description", rec."Garment Type Name");
                        if GarmentTypeRec.FindSet() then
                            rec."Garment Type No." := GarmentTypeRec."No.";
                    end;
                }

                // field(Revision; Revision)
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }

                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Currency No."; rec."Currency No.")
                {
                    ApplicationArea = All;
                }
            }

            group("Lot/PO Selection")
            {
                part("BOM PO ion ListPart"; "BOM PO Selection ListPart")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "BOM No." = FIELD("No"), "Style No." = field("Style No.");
                    UpdatePropagation = Both;
                }
            }

            group("Bill Of Materials (BOM)")
            {
                part("BOM Line Estimate ListPart"; "BOM Line Estimate ListPart")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "No." = FIELD("No");
                }
            }

            group("Color Sensitivity")
            {
                part("BOM Line Color ListPart"; "BOM Line Color ListPart")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "No." = FIELD("No");
                }
            }

            group("Size Sensitivity")
            {
                part("BOM Line Size ListPart"; "BOM Line Size ListPart")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "No." = FIELD("No");
                }
            }

            group("Country Sensitivity")
            {
                part("BOM Line Country ListPart"; "BOM Line Country ListPart")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "No." = FIELD("No");
                }
            }

            group("Item PO Sensitivity")
            {
                part("BOM Line ItemPO ListPart"; "BOM Line ItemPO ListPart")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "No." = FIELD("No");
                }
            }

            group("Auto Generated BOM")
            {
                part("BOM Line Autogen ListPart"; "BOM Line Autogen ListPart")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "No." = FIELD("No");
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Add Sensitivity")
            {
                ApplicationArea = All;
                Image = AddAction;

                trigger OnAction()
                var
                begin
                    CurrPage.Update();
                    ColorSensitivity();
                    SizeSensitivity();
                    CountrySensitivity();
                    ItemPOSensitivity();
                    Message('Completed');
                end;
            }

            action("Auto Generate")
            {
                ApplicationArea = All;
                Image = GeneralPostingSetup;

                trigger OnAction()
                var
                    ConvFactor: Decimal;
                    UOMRec: Record "Unit of Measure";
                    BLERec: Record "BOM Line Estimate";
                    BLE1Rec: Record "BOM Line Estimate";
                    BOMLine1Rec: Record "BOM Line";  //For Color
                    BOMLine2Rec: Record "BOM Line";  //For Size
                    BOMLine3Rec: Record "BOM Line";  //For country
                    BOMLine4Rec: Record "BOM Line";  //For Item PO
                    BLAutoGenNewRec: Record "BOM Line AutoGen";
                    BLAutoGenPrBOMRec: Record "BOM Line AutoGen ProdBOM";
                    AssortDetailsRec: Record AssorColorSizeRatioView;
                    AssortDetails1Rec: Record AssorColorSizeRatioView;
                    BOMPOSelecRec: Record BOMPOSelection;
                    ItemMasterRec: Record Item;
                    Total: Integer;
                    LineNo: BigInteger;
                    Value: Decimal;
                    Requirment: Decimal;
                    Count: Integer;
                    SubTotal: Decimal;
                    SubCat: Code[20];
                    SubCatDesc: Text[50];
                begin

                    BLERec.Reset();
                    BLERec.SetRange("No.", rec."No");
                    Total := 0;
                    SubTotal := 0;
                    LineNo := 0;
                    Value := 0;
                    Requirment := 0;

                    //Delete existing records
                    BLAutoGenNewRec.Reset();
                    BLAutoGenNewRec.SetRange("No.", rec."No");
                    BLAutoGenNewRec.SetFilter("Included in PO", '=%1', false);
                    if BLAutoGenNewRec.FindSet() then
                        repeat

                            BLAutoGenPrBOMRec.Reset();
                            BLAutoGenPrBOMRec.SetRange("No.", rec."No");
                            BLAutoGenPrBOMRec.SetRange("Line No.", BLAutoGenNewRec."Line No.");
                            BLAutoGenPrBOMRec.SetRange("Item No.", BLAutoGenNewRec."Item No.");
                            if BLAutoGenPrBOMRec.FindSet() then
                                BLAutoGenPrBOMRec.Delete();

                            BLAutoGenNewRec.Delete();

                        until BLAutoGenNewRec.Next() = 0;


                    if BLERec.FindSet() then begin
                        repeat

                            SubCat := '';
                            SubCatDesc := '';

                            if BLERec."Color Sensitive" = false then begin
                                Message('Color Sensitivity not selected. Cannot proceed.');
                                exit;
                            end;

                            if BLERec."Supplier No." = '' then begin
                                Error('Supplier is empty. Cannot proceed.');
                                exit;
                            end;

                            ItemMasterRec.Reset();
                            ItemMasterRec.SetRange("No.", BLERec."Item No.");

                            if ItemMasterRec.FindSet() then begin
                                SubCat := ItemMasterRec."Sub Category No.";
                                SubCatDesc := ItemMasterRec."Sub Category Name";
                            end
                            else
                                Error('Sub Category is blank for the item : %1', BLERec."Item Name");

                            // else begin
                            //     SubCat := '';
                            //     SubCatDesc := '';
                            // end;


                            // //Check whether already "po raised"items are there, then do not insert
                            // BLAutoGenNewRec.Reset();
                            // BLAutoGenNewRec.SetRange("No.", rec."No");
                            // BLAutoGenNewRec.SetRange("Item No.", BLERec."Item No.");
                            // BLAutoGenNewRec.SetRange("Placement of GMT", BLERec."Placement of GMT");

                            // if Not BLAutoGenNewRec.FindSet() then begin


                            //Get Max Lineno
                            BLAutoGenNewRec.Reset();
                            BLAutoGenNewRec.SetRange("No.", rec."No");
                            BLAutoGenNewRec.SetRange("Item No.", BLERec."Item No.");
                            //BLE1Rec.SetRange("Placement of GMT", BLERec."Placement of GMT");

                            if BLAutoGenNewRec.FindLast() then
                                LineNo := BLAutoGenNewRec."Line No.";


                            //Color, Size, Country and PO
                            if BLERec."Color Sensitive" and BLERec."Size Sensitive" and BLERec."Country Sensitive" and BLERec."PO Sensitive" then begin

                                //Color filter
                                BOMLine1Rec.Reset();
                                BOMLine1Rec.SetRange("No.", rec."No");
                                BOMLine1Rec.SetRange(Type, 1);
                                BOMLine1Rec.SetRange("Item No.", BLERec."Item No.");
                                BOMLine1Rec.SetRange(Placement, BLERec."Placement of GMT");
                                BOMLine1Rec.SetFilter(Select, '=%1', true);

                                if BOMLine1Rec.FindSet() then begin

                                    repeat

                                        //Size filter
                                        BOMLine2Rec.Reset();
                                        BOMLine2Rec.SetRange("No.", rec."No");
                                        BOMLine2Rec.SetRange(Type, 2);
                                        BOMLine2Rec.SetRange("Item No.", BOMLine1Rec."Item No.");
                                        BOMLine2Rec.SetRange(Placement, BOMLine1Rec."Placement");
                                        BOMLine2Rec.SetFilter(Select, '=%1', true);

                                        if BOMLine2Rec.FindSet() then begin
                                            repeat

                                                BOMPOSelecRec.Reset();
                                                BOMPOSelecRec.SetRange("BOM No.", rec."No");
                                                BOMPOSelecRec.SetRange(Selection, true);

                                                if BOMPOSelecRec.FindSet() then begin

                                                    repeat

                                                        //Item po filter
                                                        BOMLine4Rec.Reset();
                                                        BOMLine4Rec.SetRange("No.", rec."No");
                                                        BOMLine4Rec.SetRange(Type, 4);
                                                        BOMLine4Rec.SetRange("Item No.", BOMLine1Rec."Item No.");
                                                        BOMLine4Rec.SetRange(Placement, BOMLine1Rec."Placement");
                                                        BOMLine4Rec.SetRange("Lot No.", BOMPOSelecRec."Lot No.");
                                                        BOMLine4Rec.SetRange(Select, true);

                                                        if BOMLine4Rec.FindSet() then begin
                                                            repeat

                                                                //Country filter
                                                                BOMLine3Rec.Reset();
                                                                BOMLine3Rec.SetRange("No.", rec."No");
                                                                BOMLine3Rec.SetRange(Type, 3);
                                                                BOMLine3Rec.SetRange("Item No.", BOMLine1Rec."Item No.");
                                                                BOMLine3Rec.SetRange(Placement, BOMLine1Rec."Placement");
                                                                BOMLine3Rec.SetRange(Select, true);

                                                                if BOMLine3Rec.FindSet() then begin

                                                                    repeat

                                                                        //Insert new line
                                                                        AssortDetailsRec.Reset();
                                                                        AssortDetailsRec.SetRange("Style No.", rec."Style No.");
                                                                        AssortDetailsRec.SetRange("Lot No.", BOMLine4Rec."lot No.");
                                                                        AssortDetailsRec.SetRange("Colour No", BOMLine1Rec."GMT Color No.");
                                                                        AssortDetailsRec.SetRange("Country Code", BOMLine3Rec."Country Code");

                                                                        if AssortDetailsRec.FindSet() then begin

                                                                            //Find the correct column for the GMT size
                                                                            AssortDetails1Rec.Reset();
                                                                            AssortDetails1Rec.SetRange("Style No.", rec."Style No.");
                                                                            AssortDetails1Rec.SetRange("Lot No.", BOMLine4Rec."lot No.");
                                                                            AssortDetails1Rec.SetRange("Colour No", '*');
                                                                            AssortDetails1Rec.SetRange("Country Code", BOMLine3Rec."Country Code");

                                                                            AssortDetails1Rec.FindSet();

                                                                            FOR Count := 1 TO 64 DO begin

                                                                                case Count of
                                                                                    1:
                                                                                        if AssortDetails1Rec."1" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."1");
                                                                                            break;
                                                                                        end;
                                                                                    2:
                                                                                        if AssortDetails1Rec."2" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."2");
                                                                                            break;
                                                                                        end;
                                                                                    3:
                                                                                        if AssortDetails1Rec."3" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."3");
                                                                                            break;
                                                                                        end;
                                                                                    4:
                                                                                        if AssortDetails1Rec."4" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."4");
                                                                                            break;
                                                                                        end;
                                                                                    5:
                                                                                        if AssortDetails1Rec."5" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."5");
                                                                                            break;
                                                                                        end;
                                                                                    6:
                                                                                        if AssortDetails1Rec."6" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."6");
                                                                                            break;
                                                                                        end;
                                                                                    7:
                                                                                        if AssortDetails1Rec."7" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."7");
                                                                                            break;
                                                                                        end;
                                                                                    8:
                                                                                        if AssortDetails1Rec."8" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."8");
                                                                                            break;
                                                                                        end;
                                                                                    9:
                                                                                        if AssortDetails1Rec."9" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."9");
                                                                                            break;
                                                                                        end;
                                                                                    10:
                                                                                        if AssortDetails1Rec."10" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."10");
                                                                                            break;
                                                                                        end;
                                                                                    11:
                                                                                        if AssortDetails1Rec."11" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."11");
                                                                                            break;
                                                                                        end;
                                                                                    12:
                                                                                        if AssortDetails1Rec."12" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."12");
                                                                                            break;
                                                                                        end;
                                                                                    13:
                                                                                        if AssortDetails1Rec."13" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."13");
                                                                                            break;
                                                                                        end;
                                                                                    14:
                                                                                        if AssortDetails1Rec."14" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."14");
                                                                                            break;
                                                                                        end;
                                                                                    15:
                                                                                        if AssortDetails1Rec."15" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."15");
                                                                                            break;
                                                                                        end;
                                                                                    16:
                                                                                        if AssortDetails1Rec."16" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."16");
                                                                                            break;
                                                                                        end;
                                                                                    17:
                                                                                        if AssortDetails1Rec."17" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."17");
                                                                                            break;
                                                                                        end;
                                                                                    18:
                                                                                        if AssortDetails1Rec."18" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."18");
                                                                                            break;
                                                                                        end;
                                                                                    19:
                                                                                        if AssortDetails1Rec."19" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."19");
                                                                                            break;
                                                                                        end;
                                                                                    20:
                                                                                        if AssortDetails1Rec."20" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."20");
                                                                                            break;
                                                                                        end;
                                                                                    21:
                                                                                        if AssortDetails1Rec."21" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."21");
                                                                                            break;
                                                                                        end;
                                                                                    22:
                                                                                        if AssortDetails1Rec."22" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."22");
                                                                                            break;
                                                                                        end;
                                                                                    23:
                                                                                        if AssortDetails1Rec."23" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."23");
                                                                                            break;
                                                                                        end;
                                                                                    24:
                                                                                        if AssortDetails1Rec."24" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."24");
                                                                                            break;
                                                                                        end;
                                                                                    25:
                                                                                        if AssortDetails1Rec."25" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."25");
                                                                                            break;
                                                                                        end;
                                                                                    26:
                                                                                        if AssortDetails1Rec."26" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."26");
                                                                                            break;
                                                                                        end;
                                                                                    27:
                                                                                        if AssortDetails1Rec."27" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."27");
                                                                                            break;
                                                                                        end;
                                                                                    28:
                                                                                        if AssortDetails1Rec."28" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."28");
                                                                                            break;
                                                                                        end;
                                                                                    29:
                                                                                        if AssortDetails1Rec."29" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."29");
                                                                                            break;
                                                                                        end;
                                                                                    30:
                                                                                        if AssortDetails1Rec."30" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."30");
                                                                                            break;
                                                                                        end;
                                                                                    31:
                                                                                        if AssortDetails1Rec."31" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."31");
                                                                                            break;
                                                                                        end;
                                                                                    32:
                                                                                        if AssortDetails1Rec."32" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."32");
                                                                                            break;
                                                                                        end;
                                                                                    33:
                                                                                        if AssortDetails1Rec."33" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."33");
                                                                                            break;
                                                                                        end;
                                                                                    34:
                                                                                        if AssortDetails1Rec."34" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."34");
                                                                                            break;
                                                                                        end;
                                                                                    35:
                                                                                        if AssortDetails1Rec."35" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."35");
                                                                                            break;
                                                                                        end;
                                                                                    36:
                                                                                        if AssortDetails1Rec."36" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."36");
                                                                                            break;
                                                                                        end;
                                                                                    37:
                                                                                        if AssortDetails1Rec."37" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."37");
                                                                                            break;
                                                                                        end;
                                                                                    38:
                                                                                        if AssortDetails1Rec."38" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."38");
                                                                                            break;
                                                                                        end;
                                                                                    39:
                                                                                        if AssortDetails1Rec."39" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."39");
                                                                                            break;
                                                                                        end;
                                                                                    40:
                                                                                        if AssortDetails1Rec."40" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."40");
                                                                                            break;
                                                                                        end;
                                                                                    41:
                                                                                        if AssortDetails1Rec."41" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."41");
                                                                                            break;
                                                                                        end;
                                                                                    42:
                                                                                        if AssortDetails1Rec."42" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."42");
                                                                                            break;
                                                                                        end;
                                                                                    43:
                                                                                        if AssortDetails1Rec."43" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."43");
                                                                                            break;
                                                                                        end;
                                                                                    44:
                                                                                        if AssortDetails1Rec."44" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."44");
                                                                                            break;
                                                                                        end;
                                                                                    45:
                                                                                        if AssortDetails1Rec."45" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."45");
                                                                                            break;
                                                                                        end;
                                                                                    46:
                                                                                        if AssortDetails1Rec."46" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."46");
                                                                                            break;
                                                                                        end;
                                                                                    47:
                                                                                        if AssortDetails1Rec."47" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."47");
                                                                                            break;
                                                                                        end;
                                                                                    48:
                                                                                        if AssortDetails1Rec."48" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."48");
                                                                                            break;
                                                                                        end;
                                                                                    49:
                                                                                        if AssortDetails1Rec."49" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."49");
                                                                                            break;
                                                                                        end;
                                                                                    50:
                                                                                        if AssortDetails1Rec."50" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."50");
                                                                                            break;
                                                                                        end;
                                                                                    51:
                                                                                        if AssortDetails1Rec."51" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."51");
                                                                                            break;
                                                                                        end;
                                                                                    52:
                                                                                        if AssortDetails1Rec."52" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."52");
                                                                                            break;
                                                                                        end;
                                                                                    53:
                                                                                        if AssortDetails1Rec."53" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."53");
                                                                                            break;
                                                                                        end;
                                                                                    54:
                                                                                        if AssortDetails1Rec."54" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."54");
                                                                                            break;
                                                                                        end;
                                                                                    55:
                                                                                        if AssortDetails1Rec."55" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."55");
                                                                                            break;
                                                                                        end;
                                                                                    56:
                                                                                        if AssortDetails1Rec."56" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."56");
                                                                                            break;
                                                                                        end;
                                                                                    57:
                                                                                        if AssortDetails1Rec."57" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."57");
                                                                                            break;
                                                                                        end;
                                                                                    58:
                                                                                        if AssortDetails1Rec."58" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."58");
                                                                                            break;
                                                                                        end;
                                                                                    59:
                                                                                        if AssortDetails1Rec."59" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."59");
                                                                                            break;
                                                                                        end;
                                                                                    60:
                                                                                        if AssortDetails1Rec."60" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."60");
                                                                                            break;
                                                                                        end;
                                                                                    61:
                                                                                        if AssortDetails1Rec."61" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."61");
                                                                                            break;
                                                                                        end;
                                                                                    62:
                                                                                        if AssortDetails1Rec."62" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."62");
                                                                                            break;
                                                                                        end;
                                                                                    63:
                                                                                        if AssortDetails1Rec."63" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."63");
                                                                                            break;
                                                                                        end;
                                                                                    64:
                                                                                        if AssortDetails1Rec."64" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(Total, AssortDetailsRec."64");
                                                                                            break;
                                                                                        end;
                                                                                end;
                                                                            end;

                                                                            LineNo += 1;
                                                                            Value := 0;
                                                                            Requirment := 0;

                                                                            UOMRec.Reset();
                                                                            UOMRec.SetRange(Code, BLERec."Unit N0.");
                                                                            UOMRec.FindSet();
                                                                            ConvFactor := UOMRec."Converion Parameter";

                                                                            //Check whether already "po raised"items are there, then do not insert
                                                                            BLAutoGenNewRec.Reset();
                                                                            BLAutoGenNewRec.SetRange("No.", rec."No");
                                                                            BLAutoGenNewRec.SetRange("Item No.", BLERec."Item No.");
                                                                            BLAutoGenNewRec.SetRange("Placement of GMT", BLERec."Placement of GMT");
                                                                            BLAutoGenNewRec.SetRange("GMT Color No.", BOMLine1Rec."GMT Color No.");
                                                                            // BLAutoGenNewRec.SetRange("Item Color No.", BOMLine1Rec."Item Color No.");
                                                                            BLAutoGenNewRec.SetRange("GMT Size Name", BOMLine2Rec."GMR Size Name");
                                                                            BLAutoGenNewRec.SetRange("Country No.", BOMLine3Rec."Country Code");
                                                                            BLAutoGenNewRec.SetRange(PO, BOMLine4Rec."PO No.");
                                                                            BLAutoGenNewRec.SetRange("Lot No.", BOMLine4Rec."Lot No.");
                                                                            BLAutoGenNewRec.SetRange("Article No.", BLERec."Article No.");
                                                                            BLAutoGenNewRec.SetRange("Dimension No.", BOMLine2Rec."Dimension No.");
                                                                            BLAutoGenNewRec.SetRange("Supplier No.", BLERec."Supplier No.");

                                                                            if Not BLAutoGenNewRec.FindSet() then begin
                                                                                if Total <> 0 then begin

                                                                                    BLAutoGenNewRec.Init();
                                                                                    BLAutoGenNewRec."No." := rec."No";
                                                                                    BLAutoGenNewRec."Item No." := BLERec."Item No.";
                                                                                    BLAutoGenNewRec."Item Name" := BLERec."Item Name";
                                                                                    BLAutoGenNewRec."Line No." := LineNo;
                                                                                    BLAutoGenNewRec."Main Category No." := BLERec."Main Category No.";
                                                                                    BLAutoGenNewRec."Main Category Name" := BLERec."Main Category Name";
                                                                                    BLAutoGenNewRec."Sub Category No." := SubCat;
                                                                                    BLAutoGenNewRec."Sub Category Name" := SubCatDesc;
                                                                                    BLAutoGenNewRec."Article No." := BLERec."Article No.";
                                                                                    BLAutoGenNewRec."Article Name." := BLERec."Article Name.";
                                                                                    BLAutoGenNewRec."Dimension No." := BOMLine2Rec."Dimension No.";
                                                                                    BLAutoGenNewRec."Dimension Name." := BOMLine2Rec."Dimension Name";
                                                                                    BLAutoGenNewRec."Unit N0." := BLERec."Unit N0.";
                                                                                    BLAutoGenNewRec.Type := BLERec.Type;
                                                                                    BLAutoGenNewRec.Consumption := BLERec.Consumption;
                                                                                    BLAutoGenNewRec.WST := BLERec.WST;
                                                                                    BLAutoGenNewRec.Rate := BLERec.Rate;
                                                                                    BLAutoGenNewRec."Supplier No." := BLERec."Supplier No.";
                                                                                    BLAutoGenNewRec."Supplier Name." := BLERec."Supplier Name.";
                                                                                    BLAutoGenNewRec.AjstReq := BLERec.AjstReq;
                                                                                    BLAutoGenNewRec.Qty := BLERec.Qty;
                                                                                    BLAutoGenNewRec."Created User" := UserId;
                                                                                    BLAutoGenNewRec."Created Date" := WorkDate();
                                                                                    BLAutoGenNewRec."Stock Bal" := BLERec."Stock Bal";
                                                                                    BLAutoGenNewRec."Size Sensitive" := false;
                                                                                    BLAutoGenNewRec."Color Sensitive" := false;
                                                                                    BLAutoGenNewRec."Country Sensitive" := false;
                                                                                    BLAutoGenNewRec."PO Sensitive" := false;
                                                                                    BLAutoGenNewRec.Reconfirm := false;
                                                                                    BLAutoGenNewRec."Placement of GMT" := BLERec."Placement of GMT";
                                                                                    BLAutoGenNewRec."GMT Color No." := BOMLine1Rec."GMT Color No.";
                                                                                    BLAutoGenNewRec."GMT Color Name" := BOMLine1Rec."GMT Color Name.";
                                                                                    BLAutoGenNewRec."Item Color No." := BOMLine1Rec."Item Color No.";
                                                                                    BLAutoGenNewRec."Item Color Name" := BOMLine1Rec."Item Color Name.";
                                                                                    BLAutoGenNewRec."GMT Size Name" := BOMLine2Rec."GMR Size Name";
                                                                                    BLAutoGenNewRec."Country No." := BOMLine3Rec."Country Code";
                                                                                    BLAutoGenNewRec."Country Name" := BOMLine3Rec."Country Name";
                                                                                    BLAutoGenNewRec.PO := BOMLine4Rec."PO No.";
                                                                                    BLAutoGenNewRec."Lot No." := BOMLine4Rec."Lot No.";
                                                                                    BLAutoGenNewRec."GMT Qty" := Total;

                                                                                    if BLERec.Type = BLERec.Type::Pcs then
                                                                                        Requirment := (BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100
                                                                                    else
                                                                                        if BLERec.Type = BLERec.Type::Doz then
                                                                                            Requirment := ((BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100) / 12;


                                                                                    if (ConvFactor <> 0) then
                                                                                        Requirment := Requirment / ConvFactor;

                                                                                    //Requirment := Round(Requirment, 1);

                                                                                    if Requirment < 0 then
                                                                                        Requirment := 1;

                                                                                    Value := Requirment * BLERec.Rate;

                                                                                    BLAutoGenNewRec.Requirment := Requirment;
                                                                                    BLAutoGenNewRec.Value := Value;

                                                                                    BLAutoGenNewRec.Insert();

                                                                                    //Insert into AutoGenPRBOM
                                                                                    InsertAutoGenProdBOM(BLERec."Item No.", LineNo);

                                                                                    Total := 0;
                                                                                end;
                                                                            end;

                                                                        end;

                                                                    until BOMLine3Rec.Next() = 0;

                                                                end;

                                                            until BOMLine4Rec.Next() = 0;
                                                        end;
                                                    until BOMPOSelecRec.Next() = 0;
                                                end;
                                            until BOMLine2Rec.Next() = 0;
                                        end;
                                    until BOMLine1Rec.Next() = 0;
                                end;

                            end;

                            //Color, Size and Country
                            if BLERec."Color Sensitive" and BLERec."Size Sensitive" and BLERec."Country Sensitive" and not BLERec."PO Sensitive" then begin

                                //Color filter
                                BOMLine1Rec.Reset();
                                BOMLine1Rec.SetRange("No.", rec."No");
                                BOMLine1Rec.SetRange(Type, 1);
                                BOMLine1Rec.SetRange("Item No.", BLERec."Item No.");
                                BOMLine1Rec.SetRange(Placement, BLERec."Placement of GMT");
                                BOMLine1Rec.SetFilter(Select, '=%1', true);

                                if BOMLine1Rec.FindSet() then begin

                                    repeat

                                        //Size filter
                                        BOMLine2Rec.Reset();
                                        BOMLine2Rec.SetRange("No.", rec."No");
                                        BOMLine2Rec.SetRange(Type, 2);
                                        BOMLine2Rec.SetRange("Item No.", BOMLine1Rec."Item No.");
                                        BOMLine2Rec.SetRange(Placement, BOMLine1Rec."Placement");
                                        BOMLine2Rec.SetFilter(Select, '=%1', true);

                                        if BOMLine2Rec.FindSet() then begin
                                            repeat

                                                //PO filter
                                                BOMPOSelecRec.Reset();
                                                BOMPOSelecRec.SetRange("BOM No.", rec."No");
                                                BOMPOSelecRec.SetRange(Selection, true);

                                                if BOMPOSelecRec.FindSet() then begin
                                                    repeat

                                                        //Country filter
                                                        BOMLine3Rec.Reset();
                                                        BOMLine3Rec.SetRange("No.", rec."No");
                                                        BOMLine3Rec.SetRange(Type, 3);
                                                        BOMLine3Rec.SetRange("Item No.", BOMLine1Rec."Item No.");
                                                        BOMLine3Rec.SetRange(Placement, BOMLine1Rec."Placement");
                                                        BOMLine3Rec.SetRange(Select, true);

                                                        if BOMLine3Rec.FindSet() then begin

                                                            repeat

                                                                //Insert new line
                                                                AssortDetailsRec.Reset();
                                                                AssortDetailsRec.SetRange("Style No.", rec."Style No.");
                                                                AssortDetailsRec.SetRange("lot No.", BOMPOSelecRec."lot No.");
                                                                AssortDetailsRec.SetRange("Colour No", BOMLine1Rec."GMT Color No.");
                                                                AssortDetailsRec.SetRange("Country Code", BOMLine3Rec."Country Code");

                                                                if AssortDetailsRec.FindSet() then begin

                                                                    //Find the correct column for the GMT size
                                                                    AssortDetails1Rec.Reset();
                                                                    AssortDetails1Rec.SetRange("Style No.", rec."Style No.");
                                                                    AssortDetails1Rec.SetRange("lot No.", BOMPOSelecRec."lot No.");
                                                                    AssortDetails1Rec.SetRange("Colour No", '*');
                                                                    AssortDetails1Rec.SetRange("Country Code", BOMLine3Rec."Country Code");

                                                                    AssortDetails1Rec.FindSet();

                                                                    FOR Count := 1 TO 64 DO begin

                                                                        case Count of
                                                                            1:
                                                                                if AssortDetails1Rec."1" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."1");
                                                                                    break;
                                                                                end;
                                                                            2:
                                                                                if AssortDetails1Rec."2" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."2");
                                                                                    break;
                                                                                end;
                                                                            3:
                                                                                if AssortDetails1Rec."3" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."3");
                                                                                    break;
                                                                                end;
                                                                            4:
                                                                                if AssortDetails1Rec."4" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."4");
                                                                                    break;
                                                                                end;
                                                                            5:
                                                                                if AssortDetails1Rec."5" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."5");
                                                                                    break;
                                                                                end;
                                                                            6:
                                                                                if AssortDetails1Rec."6" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."6");
                                                                                    break;
                                                                                end;
                                                                            7:
                                                                                if AssortDetails1Rec."7" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."7");
                                                                                    break;
                                                                                end;
                                                                            8:
                                                                                if AssortDetails1Rec."8" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."8");
                                                                                    break;
                                                                                end;
                                                                            9:
                                                                                if AssortDetails1Rec."9" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."9");
                                                                                    break;
                                                                                end;
                                                                            10:
                                                                                if AssortDetails1Rec."10" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."10");
                                                                                    break;
                                                                                end;
                                                                            11:
                                                                                if AssortDetails1Rec."11" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."11");
                                                                                    break;
                                                                                end;
                                                                            12:
                                                                                if AssortDetails1Rec."12" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."12");
                                                                                    break;
                                                                                end;
                                                                            13:
                                                                                if AssortDetails1Rec."13" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."13");
                                                                                    break;
                                                                                end;
                                                                            14:
                                                                                if AssortDetails1Rec."14" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."14");
                                                                                    break;
                                                                                end;
                                                                            15:
                                                                                if AssortDetails1Rec."15" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."15");
                                                                                    break;
                                                                                end;
                                                                            16:
                                                                                if AssortDetails1Rec."16" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."16");
                                                                                    break;
                                                                                end;
                                                                            17:
                                                                                if AssortDetails1Rec."17" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."17");
                                                                                    break;
                                                                                end;
                                                                            18:
                                                                                if AssortDetails1Rec."18" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."18");
                                                                                    break;
                                                                                end;
                                                                            19:
                                                                                if AssortDetails1Rec."19" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."19");
                                                                                    break;
                                                                                end;
                                                                            20:
                                                                                if AssortDetails1Rec."20" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."20");
                                                                                    break;
                                                                                end;
                                                                            21:
                                                                                if AssortDetails1Rec."21" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."21");
                                                                                    break;
                                                                                end;
                                                                            22:
                                                                                if AssortDetails1Rec."22" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."22");
                                                                                    break;
                                                                                end;
                                                                            23:
                                                                                if AssortDetails1Rec."23" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."23");
                                                                                    break;
                                                                                end;
                                                                            24:
                                                                                if AssortDetails1Rec."24" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."24");
                                                                                    break;
                                                                                end;
                                                                            25:
                                                                                if AssortDetails1Rec."25" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."25");
                                                                                    break;
                                                                                end;
                                                                            26:
                                                                                if AssortDetails1Rec."26" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."26");
                                                                                    break;
                                                                                end;
                                                                            27:
                                                                                if AssortDetails1Rec."27" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."27");
                                                                                    break;
                                                                                end;
                                                                            28:
                                                                                if AssortDetails1Rec."28" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."28");
                                                                                    break;
                                                                                end;
                                                                            29:
                                                                                if AssortDetails1Rec."29" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."29");
                                                                                    break;
                                                                                end;
                                                                            30:
                                                                                if AssortDetails1Rec."30" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."30");
                                                                                    break;
                                                                                end;
                                                                            31:
                                                                                if AssortDetails1Rec."31" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."31");
                                                                                    break;
                                                                                end;
                                                                            32:
                                                                                if AssortDetails1Rec."32" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."32");
                                                                                    break;
                                                                                end;
                                                                            33:
                                                                                if AssortDetails1Rec."33" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."33");
                                                                                    break;
                                                                                end;
                                                                            34:
                                                                                if AssortDetails1Rec."34" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."34");
                                                                                    break;
                                                                                end;
                                                                            35:
                                                                                if AssortDetails1Rec."35" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."35");
                                                                                    break;
                                                                                end;
                                                                            36:
                                                                                if AssortDetails1Rec."36" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."36");
                                                                                    break;
                                                                                end;
                                                                            37:
                                                                                if AssortDetails1Rec."37" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."37");
                                                                                    break;
                                                                                end;
                                                                            38:
                                                                                if AssortDetails1Rec."38" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."38");
                                                                                    break;
                                                                                end;
                                                                            39:
                                                                                if AssortDetails1Rec."39" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."39");
                                                                                    break;
                                                                                end;
                                                                            40:
                                                                                if AssortDetails1Rec."40" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."40");
                                                                                    break;
                                                                                end;
                                                                            41:
                                                                                if AssortDetails1Rec."41" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."41");
                                                                                    break;
                                                                                end;
                                                                            42:
                                                                                if AssortDetails1Rec."42" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."42");
                                                                                    break;
                                                                                end;
                                                                            43:
                                                                                if AssortDetails1Rec."43" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."43");
                                                                                    break;
                                                                                end;
                                                                            44:
                                                                                if AssortDetails1Rec."44" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."44");
                                                                                    break;
                                                                                end;
                                                                            45:
                                                                                if AssortDetails1Rec."45" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."45");
                                                                                    break;
                                                                                end;
                                                                            46:
                                                                                if AssortDetails1Rec."46" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."46");
                                                                                    break;
                                                                                end;
                                                                            47:
                                                                                if AssortDetails1Rec."47" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."47");
                                                                                    break;
                                                                                end;
                                                                            48:
                                                                                if AssortDetails1Rec."48" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."48");
                                                                                    break;
                                                                                end;
                                                                            49:
                                                                                if AssortDetails1Rec."49" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."49");
                                                                                    break;
                                                                                end;
                                                                            50:
                                                                                if AssortDetails1Rec."50" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."50");
                                                                                    break;
                                                                                end;
                                                                            51:
                                                                                if AssortDetails1Rec."51" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."51");
                                                                                    break;
                                                                                end;
                                                                            52:
                                                                                if AssortDetails1Rec."52" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."52");
                                                                                    break;
                                                                                end;
                                                                            53:
                                                                                if AssortDetails1Rec."53" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."53");
                                                                                    break;
                                                                                end;
                                                                            54:
                                                                                if AssortDetails1Rec."54" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."54");
                                                                                    break;
                                                                                end;
                                                                            55:
                                                                                if AssortDetails1Rec."55" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."55");
                                                                                    break;
                                                                                end;
                                                                            56:
                                                                                if AssortDetails1Rec."56" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."56");
                                                                                    break;
                                                                                end;
                                                                            57:
                                                                                if AssortDetails1Rec."57" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."57");
                                                                                    break;
                                                                                end;
                                                                            58:
                                                                                if AssortDetails1Rec."58" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."58");
                                                                                    break;
                                                                                end;
                                                                            59:
                                                                                if AssortDetails1Rec."59" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."59");
                                                                                    break;
                                                                                end;
                                                                            60:
                                                                                if AssortDetails1Rec."60" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."60");
                                                                                    break;
                                                                                end;
                                                                            61:
                                                                                if AssortDetails1Rec."61" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."61");
                                                                                    break;
                                                                                end;
                                                                            62:
                                                                                if AssortDetails1Rec."62" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."62");
                                                                                    break;
                                                                                end;
                                                                            63:
                                                                                if AssortDetails1Rec."63" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."63");
                                                                                    break;
                                                                                end;
                                                                            64:
                                                                                if AssortDetails1Rec."64" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(Total, AssortDetailsRec."64");
                                                                                    break;
                                                                                end;
                                                                        end;
                                                                    end;
                                                                    //Message(Format(Total));

                                                                    LineNo += 1;
                                                                    Value := 0;
                                                                    Requirment := 0;

                                                                    UOMRec.Reset();
                                                                    UOMRec.SetRange(Code, BLERec."Unit N0.");
                                                                    UOMRec.FindSet();
                                                                    ConvFactor := UOMRec."Converion Parameter";

                                                                    //Check whether already "po raised"items are there, then do not insert
                                                                    BLAutoGenNewRec.Reset();
                                                                    BLAutoGenNewRec.SetRange("No.", rec."No");
                                                                    BLAutoGenNewRec.SetRange("Item No.", BLERec."Item No.");
                                                                    BLAutoGenNewRec.SetRange("Placement of GMT", BLERec."Placement of GMT");
                                                                    BLAutoGenNewRec.SetRange("GMT Color No.", BOMLine1Rec."GMT Color No.");
                                                                    //BLAutoGenNewRec.SetRange("Item Color No.", BOMLine1Rec."Item Color No.");
                                                                    BLAutoGenNewRec.SetRange("GMT Size Name", BOMLine2Rec."GMR Size Name");
                                                                    BLAutoGenNewRec.SetRange("Country No.", BOMLine3Rec."Country Code");
                                                                    BLAutoGenNewRec.SetRange(PO, BOMPOSelecRec."PO No.");
                                                                    BLAutoGenNewRec.SetRange("Lot No.", BOMPOSelecRec."Lot No.");
                                                                    BLAutoGenNewRec.SetRange("Article No.", BLERec."Article No.");
                                                                    BLAutoGenNewRec.SetRange("Dimension No.", BOMLine2Rec."Dimension No.");
                                                                    BLAutoGenNewRec.SetRange("Supplier No.", BLERec."Supplier No.");

                                                                    if Not BLAutoGenNewRec.FindSet() then begin
                                                                        if Total <> 0 then begin

                                                                            BLAutoGenNewRec.Init();
                                                                            BLAutoGenNewRec."No." := rec."No";
                                                                            BLAutoGenNewRec."Item No." := BLERec."Item No.";
                                                                            BLAutoGenNewRec."Item Name" := BLERec."Item Name";
                                                                            BLAutoGenNewRec."Line No." := LineNo;
                                                                            BLAutoGenNewRec."Main Category No." := BLERec."Main Category No.";
                                                                            BLAutoGenNewRec."Main Category Name" := BLERec."Main Category Name";
                                                                            BLAutoGenNewRec."Sub Category No." := SubCat;
                                                                            BLAutoGenNewRec."Sub Category Name" := SubCatDesc;
                                                                            BLAutoGenNewRec."Article No." := BLERec."Article No.";
                                                                            BLAutoGenNewRec."Article Name." := BLERec."Article Name.";
                                                                            BLAutoGenNewRec."Dimension No." := BOMLine2Rec."Dimension No.";
                                                                            BLAutoGenNewRec."Dimension Name." := BOMLine2Rec."Dimension Name";
                                                                            BLAutoGenNewRec."Unit N0." := BLERec."Unit N0.";
                                                                            BLAutoGenNewRec.Type := BLERec.Type;
                                                                            BLAutoGenNewRec.Consumption := BLERec.Consumption;
                                                                            BLAutoGenNewRec.WST := BLERec.WST;
                                                                            BLAutoGenNewRec.Rate := BLERec.Rate;
                                                                            BLAutoGenNewRec."Supplier No." := BLERec."Supplier No.";
                                                                            BLAutoGenNewRec."Supplier Name." := BLERec."Supplier Name.";
                                                                            BLAutoGenNewRec.AjstReq := BLERec.AjstReq;
                                                                            BLAutoGenNewRec.Qty := BLERec.Qty;
                                                                            BLAutoGenNewRec."Created User" := UserId;
                                                                            BLAutoGenNewRec."Created Date" := WorkDate();
                                                                            BLAutoGenNewRec."Stock Bal" := BLERec."Stock Bal";
                                                                            BLAutoGenNewRec."Size Sensitive" := false;
                                                                            BLAutoGenNewRec."Color Sensitive" := false;
                                                                            BLAutoGenNewRec."Country Sensitive" := false;
                                                                            BLAutoGenNewRec."PO Sensitive" := false;
                                                                            BLAutoGenNewRec.Reconfirm := false;
                                                                            BLAutoGenNewRec."Placement of GMT" := BLERec."Placement of GMT";
                                                                            BLAutoGenNewRec."GMT Color No." := BOMLine1Rec."GMT Color No.";
                                                                            BLAutoGenNewRec."GMT Color Name" := BOMLine1Rec."GMT Color Name.";
                                                                            BLAutoGenNewRec."Item Color No." := BOMLine1Rec."Item Color No.";
                                                                            BLAutoGenNewRec."Item Color Name" := BOMLine1Rec."Item Color Name.";
                                                                            BLAutoGenNewRec."GMT Size Name" := BOMLine2Rec."GMR Size Name";
                                                                            BLAutoGenNewRec."Country No." := BOMLine3Rec."Country Code";
                                                                            BLAutoGenNewRec."Country Name" := BOMLine3Rec."Country Name";
                                                                            BLAutoGenNewRec.PO := BOMPOSelecRec."PO No.";
                                                                            BLAutoGenNewRec."Lot No." := BOMPOSelecRec."Lot No.";
                                                                            BLAutoGenNewRec."GMT Qty" := Total;

                                                                            if BLERec.Type = BLERec.Type::Pcs then
                                                                                Requirment := (BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100
                                                                            else
                                                                                if BLERec.Type = BLERec.Type::Doz then
                                                                                    Requirment := ((BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100) / 12;

                                                                            if (ConvFactor <> 0) then
                                                                                Requirment := Requirment / ConvFactor;

                                                                            //Requirment := Round(Requirment, 1);

                                                                            if Requirment < 0 then
                                                                                Requirment := 1;

                                                                            Value := Requirment * BLERec.Rate;

                                                                            BLAutoGenNewRec.Requirment := Requirment;
                                                                            BLAutoGenNewRec.Value := Value;

                                                                            BLAutoGenNewRec.Insert();

                                                                            //Insert into AutoGenPRBOM
                                                                            InsertAutoGenProdBOM(BLERec."Item No.", LineNo);

                                                                            Total := 0;
                                                                        end;
                                                                    end;
                                                                end;

                                                            until BOMLine3Rec.Next() = 0;
                                                        end;

                                                    until BOMPOSelecRec.Next() = 0;
                                                end;
                                            until BOMLine2Rec.Next() = 0;
                                        end;
                                    until BOMLine1Rec.Next() = 0;
                                end;
                            end;

                            //Color and Size
                            if BLERec."Color Sensitive" and BLERec."Size Sensitive" and not BLERec."Country Sensitive" and not BLERec."PO Sensitive" then begin

                                //Color filter
                                BOMLine1Rec.Reset();
                                BOMLine1Rec.SetRange("No.", rec."No");
                                BOMLine1Rec.SetRange(Type, 1);
                                BOMLine1Rec.SetRange("Item No.", BLERec."Item No.");
                                BOMLine1Rec.SetRange(Placement, BLERec."Placement of GMT");
                                BOMLine1Rec.SetFilter(Select, '=%1', true);

                                if BOMLine1Rec.FindSet() then begin

                                    repeat

                                        //Size filter
                                        BOMLine2Rec.Reset();
                                        BOMLine2Rec.SetRange("No.", rec."No");
                                        BOMLine2Rec.SetRange(Type, 2);
                                        BOMLine2Rec.SetRange("Item No.", BOMLine1Rec."Item No.");
                                        BOMLine2Rec.SetRange(Placement, BOMLine1Rec."Placement");
                                        BOMLine2Rec.SetFilter(Select, '=%1', true);

                                        if BOMLine2Rec.FindSet() then begin
                                            repeat

                                                //PO filter
                                                BOMPOSelecRec.Reset();
                                                BOMPOSelecRec.SetRange("BOM No.", rec."No");
                                                BOMPOSelecRec.SetRange(Selection, true);

                                                if BOMPOSelecRec.FindSet() then begin
                                                    repeat

                                                        //Insert new line
                                                        AssortDetailsRec.Reset();
                                                        AssortDetailsRec.SetRange("Style No.", rec."Style No.");
                                                        AssortDetailsRec.SetRange("Lot No.", BOMPOSelecRec."Lot No.");
                                                        AssortDetailsRec.SetRange("Colour No", BOMLine1Rec."GMT Color No.");

                                                        if AssortDetailsRec.FindSet() then begin

                                                            //Find the correct column for the GMT size
                                                            AssortDetails1Rec.Reset();
                                                            AssortDetails1Rec.SetRange("Style No.", rec."Style No.");
                                                            AssortDetails1Rec.SetRange("Lot No.", BOMPOSelecRec."Lot No.");
                                                            AssortDetails1Rec.SetRange("Colour No", '*');

                                                            AssortDetails1Rec.FindSet();

                                                            FOR Count := 1 TO 64 DO begin

                                                                case Count of
                                                                    1:
                                                                        if AssortDetails1Rec."1" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."1");
                                                                            break;
                                                                        end;
                                                                    2:
                                                                        if AssortDetails1Rec."2" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."2");
                                                                            break;
                                                                        end;
                                                                    3:
                                                                        if AssortDetails1Rec."3" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."3");
                                                                            break;
                                                                        end;
                                                                    4:
                                                                        if AssortDetails1Rec."4" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."4");
                                                                            break;
                                                                        end;
                                                                    5:
                                                                        if AssortDetails1Rec."5" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."5");
                                                                            break;
                                                                        end;
                                                                    6:
                                                                        if AssortDetails1Rec."6" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."6");
                                                                            break;
                                                                        end;
                                                                    7:
                                                                        if AssortDetails1Rec."7" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."7");
                                                                            break;
                                                                        end;
                                                                    8:
                                                                        if AssortDetails1Rec."8" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."8");
                                                                            break;
                                                                        end;
                                                                    9:
                                                                        if AssortDetails1Rec."9" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."9");
                                                                            break;
                                                                        end;
                                                                    10:
                                                                        if AssortDetails1Rec."10" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."10");
                                                                            break;
                                                                        end;
                                                                    11:
                                                                        if AssortDetails1Rec."11" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."11");
                                                                            break;
                                                                        end;
                                                                    12:
                                                                        if AssortDetails1Rec."12" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."12");
                                                                            break;
                                                                        end;
                                                                    13:
                                                                        if AssortDetails1Rec."13" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."13");
                                                                            break;
                                                                        end;
                                                                    14:
                                                                        if AssortDetails1Rec."14" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."14");
                                                                            break;
                                                                        end;
                                                                    15:
                                                                        if AssortDetails1Rec."15" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."15");
                                                                            break;
                                                                        end;
                                                                    16:
                                                                        if AssortDetails1Rec."16" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."16");
                                                                            break;
                                                                        end;
                                                                    17:
                                                                        if AssortDetails1Rec."17" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."17");
                                                                            break;
                                                                        end;
                                                                    18:
                                                                        if AssortDetails1Rec."18" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."18");
                                                                            break;
                                                                        end;
                                                                    19:
                                                                        if AssortDetails1Rec."19" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."19");
                                                                            break;
                                                                        end;
                                                                    20:
                                                                        if AssortDetails1Rec."20" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."20");
                                                                            break;
                                                                        end;
                                                                    21:
                                                                        if AssortDetails1Rec."21" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."21");
                                                                            break;
                                                                        end;
                                                                    22:
                                                                        if AssortDetails1Rec."22" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."22");
                                                                            break;
                                                                        end;
                                                                    23:
                                                                        if AssortDetails1Rec."23" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."23");
                                                                            break;
                                                                        end;
                                                                    24:
                                                                        if AssortDetails1Rec."24" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."24");
                                                                            break;
                                                                        end;
                                                                    25:
                                                                        if AssortDetails1Rec."25" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."25");
                                                                            break;
                                                                        end;
                                                                    26:
                                                                        if AssortDetails1Rec."26" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."26");
                                                                            break;
                                                                        end;
                                                                    27:
                                                                        if AssortDetails1Rec."27" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."27");
                                                                            break;
                                                                        end;
                                                                    28:
                                                                        if AssortDetails1Rec."28" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."28");
                                                                            break;
                                                                        end;
                                                                    29:
                                                                        if AssortDetails1Rec."29" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."29");
                                                                            break;
                                                                        end;
                                                                    30:
                                                                        if AssortDetails1Rec."30" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."30");
                                                                            break;
                                                                        end;
                                                                    31:
                                                                        if AssortDetails1Rec."31" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."31");
                                                                            break;
                                                                        end;
                                                                    32:
                                                                        if AssortDetails1Rec."32" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."32");
                                                                            break;
                                                                        end;
                                                                    33:
                                                                        if AssortDetails1Rec."33" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."33");
                                                                            break;
                                                                        end;
                                                                    34:
                                                                        if AssortDetails1Rec."34" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."34");
                                                                            break;
                                                                        end;
                                                                    35:
                                                                        if AssortDetails1Rec."35" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."35");
                                                                            break;
                                                                        end;
                                                                    36:
                                                                        if AssortDetails1Rec."36" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."36");
                                                                            break;
                                                                        end;
                                                                    37:
                                                                        if AssortDetails1Rec."37" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."37");
                                                                            break;
                                                                        end;
                                                                    38:
                                                                        if AssortDetails1Rec."38" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."38");
                                                                            break;
                                                                        end;
                                                                    39:
                                                                        if AssortDetails1Rec."39" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."39");
                                                                            break;
                                                                        end;
                                                                    40:
                                                                        if AssortDetails1Rec."40" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."40");
                                                                            break;
                                                                        end;
                                                                    41:
                                                                        if AssortDetails1Rec."41" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."41");
                                                                            break;
                                                                        end;
                                                                    42:
                                                                        if AssortDetails1Rec."42" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."42");
                                                                            break;
                                                                        end;
                                                                    43:
                                                                        if AssortDetails1Rec."43" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."43");
                                                                            break;
                                                                        end;
                                                                    44:
                                                                        if AssortDetails1Rec."44" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."44");
                                                                            break;
                                                                        end;
                                                                    45:
                                                                        if AssortDetails1Rec."45" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."45");
                                                                            break;
                                                                        end;
                                                                    46:
                                                                        if AssortDetails1Rec."46" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."46");
                                                                            break;
                                                                        end;
                                                                    47:
                                                                        if AssortDetails1Rec."47" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."47");
                                                                            break;
                                                                        end;
                                                                    48:
                                                                        if AssortDetails1Rec."48" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."48");
                                                                            break;
                                                                        end;
                                                                    49:
                                                                        if AssortDetails1Rec."49" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."49");
                                                                            break;
                                                                        end;
                                                                    50:
                                                                        if AssortDetails1Rec."50" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."50");
                                                                            break;
                                                                        end;
                                                                    51:
                                                                        if AssortDetails1Rec."51" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."51");
                                                                            break;
                                                                        end;
                                                                    52:
                                                                        if AssortDetails1Rec."52" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."52");
                                                                            break;
                                                                        end;
                                                                    53:
                                                                        if AssortDetails1Rec."53" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."53");
                                                                            break;
                                                                        end;
                                                                    54:
                                                                        if AssortDetails1Rec."54" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."54");
                                                                            break;
                                                                        end;
                                                                    55:
                                                                        if AssortDetails1Rec."55" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."55");
                                                                            break;
                                                                        end;
                                                                    56:
                                                                        if AssortDetails1Rec."56" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."56");
                                                                            break;
                                                                        end;
                                                                    57:
                                                                        if AssortDetails1Rec."57" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."57");
                                                                            break;
                                                                        end;
                                                                    58:
                                                                        if AssortDetails1Rec."58" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."58");
                                                                            break;
                                                                        end;
                                                                    59:
                                                                        if AssortDetails1Rec."59" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."59");
                                                                            break;
                                                                        end;
                                                                    60:
                                                                        if AssortDetails1Rec."60" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."60");
                                                                            break;
                                                                        end;
                                                                    61:
                                                                        if AssortDetails1Rec."61" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."61");
                                                                            break;
                                                                        end;
                                                                    62:
                                                                        if AssortDetails1Rec."62" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."62");
                                                                            break;
                                                                        end;
                                                                    63:
                                                                        if AssortDetails1Rec."63" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."63");
                                                                            break;
                                                                        end;
                                                                    64:
                                                                        if AssortDetails1Rec."64" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(Total, AssortDetailsRec."64");
                                                                            break;
                                                                        end;
                                                                end;
                                                            end;

                                                            LineNo += 1;
                                                            Value := 0;
                                                            Requirment := 0;

                                                            UOMRec.Reset();
                                                            UOMRec.SetRange(Code, BLERec."Unit N0.");
                                                            UOMRec.FindSet();
                                                            ConvFactor := UOMRec."Converion Parameter";

                                                            //Check whether already "po raised"items are there, then do not insert
                                                            BLAutoGenNewRec.Reset();
                                                            BLAutoGenNewRec.SetRange("No.", rec."No");
                                                            BLAutoGenNewRec.SetRange("Item No.", BLERec."Item No.");
                                                            BLAutoGenNewRec.SetRange("Placement of GMT", BLERec."Placement of GMT");
                                                            BLAutoGenNewRec.SetRange("GMT Color No.", BOMLine1Rec."GMT Color No.");
                                                            //BLAutoGenNewRec.SetRange("Item Color No.", BOMLine1Rec."Item Color No.");
                                                            BLAutoGenNewRec.SetRange("GMT Size Name", BOMLine2Rec."GMR Size Name");
                                                            BLAutoGenNewRec.SetRange("Country No.", BOMLine3Rec."Country Code");
                                                            BLAutoGenNewRec.SetRange(PO, BOMPOSelecRec."PO No.");
                                                            BLAutoGenNewRec.SetRange("Lot No.", BOMPOSelecRec."Lot No.");
                                                            BLAutoGenNewRec.SetRange("Article No.", BLERec."Article No.");
                                                            BLAutoGenNewRec.SetRange("Dimension No.", BOMLine2Rec."Dimension No.");
                                                            BLAutoGenNewRec.SetRange("Supplier No.", BLERec."Supplier No.");

                                                            if Not BLAutoGenNewRec.FindSet() then begin
                                                                if Total <> 0 then begin

                                                                    BLAutoGenNewRec.Init();
                                                                    BLAutoGenNewRec."No." := rec."No";
                                                                    BLAutoGenNewRec."Item No." := BLERec."Item No.";
                                                                    BLAutoGenNewRec."Item Name" := BLERec."Item Name";
                                                                    BLAutoGenNewRec."Line No." := LineNo;
                                                                    BLAutoGenNewRec."Main Category No." := BLERec."Main Category No.";
                                                                    BLAutoGenNewRec."Main Category Name" := BLERec."Main Category Name";
                                                                    BLAutoGenNewRec."Sub Category No." := SubCat;
                                                                    BLAutoGenNewRec."Sub Category Name" := SubCatDesc;
                                                                    BLAutoGenNewRec."Article No." := BLERec."Article No.";
                                                                    BLAutoGenNewRec."Article Name." := BLERec."Article Name.";
                                                                    BLAutoGenNewRec."Dimension No." := BOMLine2Rec."Dimension No.";
                                                                    BLAutoGenNewRec."Dimension Name." := BOMLine2Rec."Dimension Name";
                                                                    BLAutoGenNewRec."Unit N0." := BLERec."Unit N0.";
                                                                    BLAutoGenNewRec.Type := BLERec.Type;
                                                                    BLAutoGenNewRec.Consumption := BLERec.Consumption;
                                                                    BLAutoGenNewRec.WST := BLERec.WST;
                                                                    BLAutoGenNewRec.Rate := BLERec.Rate;
                                                                    BLAutoGenNewRec."Supplier No." := BLERec."Supplier No.";
                                                                    BLAutoGenNewRec."Supplier Name." := BLERec."Supplier Name.";
                                                                    BLAutoGenNewRec.AjstReq := BLERec.AjstReq;
                                                                    BLAutoGenNewRec.Qty := BLERec.Qty;
                                                                    BLAutoGenNewRec."Created User" := UserId;
                                                                    BLAutoGenNewRec."Created Date" := WorkDate();
                                                                    BLAutoGenNewRec."Stock Bal" := BLERec."Stock Bal";
                                                                    BLAutoGenNewRec."Size Sensitive" := false;
                                                                    BLAutoGenNewRec."Color Sensitive" := false;
                                                                    BLAutoGenNewRec."Country Sensitive" := false;
                                                                    BLAutoGenNewRec."PO Sensitive" := false;
                                                                    BLAutoGenNewRec.Reconfirm := false;
                                                                    BLAutoGenNewRec."Placement of GMT" := BLERec."Placement of GMT";
                                                                    BLAutoGenNewRec."GMT Color No." := BOMLine1Rec."GMT Color No.";
                                                                    BLAutoGenNewRec."GMT Color Name" := BOMLine1Rec."GMT Color Name.";
                                                                    BLAutoGenNewRec."Item Color No." := BOMLine1Rec."Item Color No.";
                                                                    BLAutoGenNewRec."Item Color Name" := BOMLine1Rec."Item Color Name.";
                                                                    BLAutoGenNewRec."GMT Size Name" := BOMLine2Rec."GMR Size Name";
                                                                    BLAutoGenNewRec."Country No." := '';
                                                                    BLAutoGenNewRec."Country Name" := '';
                                                                    BLAutoGenNewRec.PO := BOMPOSelecRec."PO No.";
                                                                    BLAutoGenNewRec."Lot No." := BOMPOSelecRec."Lot No.";
                                                                    BLAutoGenNewRec."GMT Qty" := Total;

                                                                    if BLERec.Type = BLERec.Type::Pcs then
                                                                        Requirment := (BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100
                                                                    else
                                                                        if BLERec.Type = BLERec.Type::Doz then
                                                                            Requirment := ((BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100) / 12;

                                                                    if (ConvFactor <> 0) then
                                                                        Requirment := Requirment / ConvFactor;

                                                                    //Requirment := Round(Requirment, 1);

                                                                    if Requirment < 0 then
                                                                        Requirment := 1;

                                                                    Value := Requirment * BLERec.Rate;

                                                                    BLAutoGenNewRec.Requirment := Requirment;
                                                                    BLAutoGenNewRec.Value := Value;

                                                                    BLAutoGenNewRec.Insert();

                                                                    //Insert into AutoGenPRBOM
                                                                    InsertAutoGenProdBOM(BLERec."Item No.", LineNo);

                                                                    Total := 0;
                                                                end;
                                                            end;

                                                        end;

                                                    until BOMPOSelecRec.Next() = 0;
                                                end;
                                            until BOMLine2Rec.Next() = 0;
                                        end;
                                    until BOMLine1Rec.Next() = 0;
                                end;

                            end;

                            //Color Only
                            if BLERec."Color Sensitive" and not BLERec."Size Sensitive" and not BLERec."Country Sensitive" and not BLERec."PO Sensitive" then begin

                                BOMLine1Rec.Reset();
                                BOMLine1Rec.SetRange("No.", rec."No");
                                BOMLine1Rec.SetRange(Type, 1);
                                BOMLine1Rec.SetRange("Item No.", BLERec."Item No.");
                                BOMLine1Rec.SetRange(Placement, BLERec."Placement of GMT");
                                BOMLine1Rec.SetFilter(Select, '=%1', true);

                                if BOMLine1Rec.FindSet() then begin
                                    repeat

                                        BOMPOSelecRec.Reset();
                                        BOMPOSelecRec.SetRange("BOM No.", rec."No");
                                        BOMPOSelecRec.SetRange(Selection, true);

                                        if BOMPOSelecRec.FindSet() then begin
                                            repeat

                                                AssortDetailsRec.Reset();
                                                AssortDetailsRec.SetRange("Style No.", rec."Style No.");
                                                AssortDetailsRec.SetRange("Lot No.", BOMPOSelecRec."Lot No.");
                                                AssortDetailsRec.SetRange("Colour No", BOMLine1Rec."GMT Color No.");

                                                if AssortDetailsRec.FindSet() then begin
                                                    Total := AssortDetailsRec.Total;
                                                    LineNo += 1;
                                                    Value := 0;
                                                    Requirment := 0;

                                                    UOMRec.Reset();
                                                    UOMRec.SetRange(Code, BLERec."Unit N0.");
                                                    UOMRec.FindSet();
                                                    ConvFactor := UOMRec."Converion Parameter";

                                                    //Check whether already "po raised"items are there, then do not insert
                                                    BLAutoGenNewRec.Reset();
                                                    BLAutoGenNewRec.SetRange("No.", rec."No");
                                                    BLAutoGenNewRec.SetRange("Item No.", BLERec."Item No.");
                                                    BLAutoGenNewRec.SetRange("Placement of GMT", BLERec."Placement of GMT");
                                                    BLAutoGenNewRec.SetRange("GMT Color No.", BOMLine1Rec."GMT Color No.");
                                                    //BLAutoGenNewRec.SetRange("Item Color No.", BOMLine1Rec."Item Color No.");
                                                    BLAutoGenNewRec.SetRange("GMT Size Name", '');
                                                    BLAutoGenNewRec.SetRange("Country No.", '');
                                                    BLAutoGenNewRec.SetRange(PO, BOMPOSelecRec."PO No.");
                                                    BLAutoGenNewRec.SetRange("Lot No.", BOMPOSelecRec."Lot No.");
                                                    BLAutoGenNewRec.SetRange("Article No.", BLERec."Article No.");
                                                    BLAutoGenNewRec.SetRange("Dimension No.", BLERec."Dimension No.");
                                                    BLAutoGenNewRec.SetRange("Supplier No.", BLERec."Supplier No.");

                                                    if Not BLAutoGenNewRec.FindSet() then begin
                                                        if Total <> 0 then begin

                                                            BLAutoGenNewRec.Init();
                                                            BLAutoGenNewRec."No." := rec."No";
                                                            BLAutoGenNewRec."Item No." := BLERec."Item No.";
                                                            BLAutoGenNewRec."Item Name" := BLERec."Item Name";
                                                            BLAutoGenNewRec."Line No." := LineNo;
                                                            BLAutoGenNewRec."Main Category No." := BLERec."Main Category No.";
                                                            BLAutoGenNewRec."Main Category Name" := BLERec."Main Category Name";
                                                            BLAutoGenNewRec."Sub Category No." := SubCat;
                                                            BLAutoGenNewRec."Sub Category Name" := SubCatDesc;
                                                            BLAutoGenNewRec."Article No." := BLERec."Article No.";
                                                            BLAutoGenNewRec."Article Name." := BLERec."Article Name.";
                                                            BLAutoGenNewRec."Dimension No." := BLERec."Dimension No.";
                                                            BLAutoGenNewRec."Dimension Name." := BLERec."Dimension Name.";
                                                            BLAutoGenNewRec."Unit N0." := BLERec."Unit N0.";
                                                            BLAutoGenNewRec.Type := BLERec.Type;
                                                            BLAutoGenNewRec.Consumption := BLERec.Consumption;
                                                            BLAutoGenNewRec.WST := BLERec.WST;
                                                            BLAutoGenNewRec.Rate := BLERec.Rate;
                                                            BLAutoGenNewRec."Supplier No." := BLERec."Supplier No.";
                                                            BLAutoGenNewRec."Supplier Name." := BLERec."Supplier Name.";
                                                            BLAutoGenNewRec.AjstReq := BLERec.AjstReq;
                                                            BLAutoGenNewRec.Qty := BLERec.Qty;
                                                            BLAutoGenNewRec."Created User" := UserId;
                                                            BLAutoGenNewRec."Created Date" := WorkDate();
                                                            BLAutoGenNewRec."Stock Bal" := BLERec."Stock Bal";
                                                            BLAutoGenNewRec."Size Sensitive" := false;
                                                            BLAutoGenNewRec."Color Sensitive" := false;
                                                            BLAutoGenNewRec."Country Sensitive" := false;
                                                            BLAutoGenNewRec."PO Sensitive" := false;
                                                            BLAutoGenNewRec.Reconfirm := false;
                                                            BLAutoGenNewRec."Placement of GMT" := BLERec."Placement of GMT";
                                                            BLAutoGenNewRec."GMT Color No." := BOMLine1Rec."GMT Color No.";
                                                            BLAutoGenNewRec."GMT Color Name" := BOMLine1Rec."GMT Color Name.";
                                                            BLAutoGenNewRec."Item Color No." := BOMLine1Rec."Item Color No.";
                                                            BLAutoGenNewRec."Item Color Name" := BOMLine1Rec."Item Color Name.";
                                                            BLAutoGenNewRec."GMT Size Name" := '';
                                                            BLAutoGenNewRec."Country No." := '';
                                                            BLAutoGenNewRec."Country Name" := '';
                                                            BLAutoGenNewRec.PO := BOMPOSelecRec."PO No.";
                                                            BLAutoGenNewRec."Lot No." := BOMPOSelecRec."Lot No.";
                                                            BLAutoGenNewRec."GMT Qty" := Total;

                                                            if BLERec.Type = BLERec.Type::Pcs then
                                                                Requirment := (BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100
                                                            else
                                                                if BLERec.Type = BLERec.Type::Doz then
                                                                    Requirment := ((BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100) / 12;

                                                            if (ConvFactor <> 0) then
                                                                Requirment := Requirment / ConvFactor;

                                                            //Requirment := Round(Requirment, 1);

                                                            if Requirment < 0 then
                                                                Requirment := 1;

                                                            Value := Requirment * BLERec.Rate;

                                                            BLAutoGenNewRec.Requirment := Requirment;
                                                            BLAutoGenNewRec.Value := Value;

                                                            BLAutoGenNewRec.Insert();

                                                            //Insert into AutoGenPRBOM
                                                            InsertAutoGenProdBOM(BLERec."Item No.", LineNo);

                                                        end;
                                                    end;
                                                end;

                                            until BOMPOSelecRec.Next() = 0;
                                        end;

                                    until BOMLine1Rec.Next() = 0;
                                end;

                            end;

                            //Size Only
                            if not BLERec."Color Sensitive" and BLERec."Size Sensitive" and not BLERec."Country Sensitive" and not BLERec."PO Sensitive" then begin

                                //Size filter
                                BOMLine2Rec.Reset();
                                BOMLine2Rec.SetRange("No.", rec."No");
                                BOMLine2Rec.SetRange(Type, 2);
                                BOMLine2Rec.SetRange("Item No.", BLERec."Item No.");
                                BOMLine2Rec.SetRange(Placement, BLERec."Placement of GMT");
                                BOMLine2Rec.SetFilter(Select, '=%1', true);

                                if BOMLine2Rec.FindSet() then begin
                                    repeat

                                        //PO filter
                                        BOMPOSelecRec.Reset();
                                        BOMPOSelecRec.SetRange("BOM No.", rec."No");
                                        BOMPOSelecRec.SetRange(Selection, true);

                                        if BOMPOSelecRec.FindSet() then begin

                                            repeat

                                                //Insert new line
                                                AssortDetailsRec.Reset();
                                                AssortDetailsRec.SetRange("Style No.", rec."Style No.");
                                                AssortDetailsRec.SetRange("lot No.", BOMPOSelecRec."Lot No.");

                                                if AssortDetailsRec.FindSet() then begin

                                                    repeat

                                                        if AssortDetailsRec."Colour No" <> '*' then begin

                                                            //Find the correct column for the GMT size
                                                            AssortDetails1Rec.Reset();
                                                            AssortDetails1Rec.SetRange("Style No.", rec."Style No.");
                                                            AssortDetails1Rec.SetRange("lot No.", BOMPOSelecRec."lot No.");
                                                            AssortDetails1Rec.SetRange("Colour No", '*');

                                                            AssortDetails1Rec.FindSet();
                                                            SubTotal := 0;

                                                            FOR Count := 1 TO 64 DO begin

                                                                case Count of
                                                                    1:
                                                                        if AssortDetails1Rec."1" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."1");
                                                                            break;
                                                                        end;
                                                                    2:
                                                                        if AssortDetails1Rec."2" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."2");
                                                                            break;
                                                                        end;
                                                                    3:
                                                                        if AssortDetails1Rec."3" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."3");
                                                                            break;
                                                                        end;
                                                                    4:
                                                                        if AssortDetails1Rec."4" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."4");
                                                                            break;
                                                                        end;
                                                                    5:
                                                                        if AssortDetails1Rec."5" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."5");
                                                                            break;
                                                                        end;
                                                                    6:
                                                                        if AssortDetails1Rec."6" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."6");
                                                                            break;
                                                                        end;
                                                                    7:
                                                                        if AssortDetails1Rec."7" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."7");
                                                                            break;
                                                                        end;
                                                                    8:
                                                                        if AssortDetails1Rec."8" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."8");
                                                                            break;
                                                                        end;
                                                                    9:
                                                                        if AssortDetails1Rec."9" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."9");
                                                                            break;
                                                                        end;
                                                                    10:
                                                                        if AssortDetails1Rec."10" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."10");
                                                                            break;
                                                                        end;
                                                                    11:
                                                                        if AssortDetails1Rec."11" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."11");
                                                                            break;
                                                                        end;
                                                                    12:
                                                                        if AssortDetails1Rec."12" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."12");
                                                                            break;
                                                                        end;
                                                                    13:
                                                                        if AssortDetails1Rec."13" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."13");
                                                                            break;
                                                                        end;
                                                                    14:
                                                                        if AssortDetails1Rec."14" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."14");
                                                                            break;
                                                                        end;
                                                                    15:
                                                                        if AssortDetails1Rec."15" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."15");
                                                                            break;
                                                                        end;
                                                                    16:
                                                                        if AssortDetails1Rec."16" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."16");
                                                                            break;
                                                                        end;
                                                                    17:
                                                                        if AssortDetails1Rec."17" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."17");
                                                                            break;
                                                                        end;
                                                                    18:
                                                                        if AssortDetails1Rec."18" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."18");
                                                                            break;
                                                                        end;
                                                                    19:
                                                                        if AssortDetails1Rec."19" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."19");
                                                                            break;
                                                                        end;
                                                                    20:
                                                                        if AssortDetails1Rec."20" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."20");
                                                                            break;
                                                                        end;
                                                                    21:
                                                                        if AssortDetails1Rec."21" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."21");
                                                                            break;
                                                                        end;
                                                                    22:
                                                                        if AssortDetails1Rec."22" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."22");
                                                                            break;
                                                                        end;
                                                                    23:
                                                                        if AssortDetails1Rec."23" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."23");
                                                                            break;
                                                                        end;
                                                                    24:
                                                                        if AssortDetails1Rec."24" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."24");
                                                                            break;
                                                                        end;
                                                                    25:
                                                                        if AssortDetails1Rec."25" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."25");
                                                                            break;
                                                                        end;
                                                                    26:
                                                                        if AssortDetails1Rec."26" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."26");
                                                                            break;
                                                                        end;
                                                                    27:
                                                                        if AssortDetails1Rec."27" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."27");
                                                                            break;
                                                                        end;
                                                                    28:
                                                                        if AssortDetails1Rec."28" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."28");
                                                                            break;
                                                                        end;
                                                                    29:
                                                                        if AssortDetails1Rec."29" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."29");
                                                                            break;
                                                                        end;
                                                                    30:
                                                                        if AssortDetails1Rec."30" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."30");
                                                                            break;
                                                                        end;
                                                                    31:
                                                                        if AssortDetails1Rec."31" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."31");
                                                                            break;
                                                                        end;
                                                                    32:
                                                                        if AssortDetails1Rec."32" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."32");
                                                                            break;
                                                                        end;
                                                                    33:
                                                                        if AssortDetails1Rec."33" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."33");
                                                                            break;
                                                                        end;
                                                                    34:
                                                                        if AssortDetails1Rec."34" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."34");
                                                                            break;
                                                                        end;
                                                                    35:
                                                                        if AssortDetails1Rec."35" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."35");
                                                                            break;
                                                                        end;
                                                                    36:
                                                                        if AssortDetails1Rec."36" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."36");
                                                                            break;
                                                                        end;
                                                                    37:
                                                                        if AssortDetails1Rec."37" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."37");
                                                                            break;
                                                                        end;
                                                                    38:
                                                                        if AssortDetails1Rec."38" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."38");
                                                                            break;
                                                                        end;
                                                                    39:
                                                                        if AssortDetails1Rec."39" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."39");
                                                                            break;
                                                                        end;
                                                                    40:
                                                                        if AssortDetails1Rec."40" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."40");
                                                                            break;
                                                                        end;
                                                                    41:
                                                                        if AssortDetails1Rec."41" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."41");
                                                                            break;
                                                                        end;
                                                                    42:
                                                                        if AssortDetails1Rec."42" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."42");
                                                                            break;
                                                                        end;
                                                                    43:
                                                                        if AssortDetails1Rec."43" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."43");
                                                                            break;
                                                                        end;
                                                                    44:
                                                                        if AssortDetails1Rec."44" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."44");
                                                                            break;
                                                                        end;
                                                                    45:
                                                                        if AssortDetails1Rec."45" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."45");
                                                                            break;
                                                                        end;
                                                                    46:
                                                                        if AssortDetails1Rec."46" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."46");
                                                                            break;
                                                                        end;
                                                                    47:
                                                                        if AssortDetails1Rec."47" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."47");
                                                                            break;
                                                                        end;
                                                                    48:
                                                                        if AssortDetails1Rec."48" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."48");
                                                                            break;
                                                                        end;
                                                                    49:
                                                                        if AssortDetails1Rec."49" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."49");
                                                                            break;
                                                                        end;
                                                                    50:
                                                                        if AssortDetails1Rec."50" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."50");
                                                                            break;
                                                                        end;
                                                                    51:
                                                                        if AssortDetails1Rec."51" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."51");
                                                                            break;
                                                                        end;
                                                                    52:
                                                                        if AssortDetails1Rec."52" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."52");
                                                                            break;
                                                                        end;
                                                                    53:
                                                                        if AssortDetails1Rec."53" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."53");
                                                                            break;
                                                                        end;
                                                                    54:
                                                                        if AssortDetails1Rec."54" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."54");
                                                                            break;
                                                                        end;
                                                                    55:
                                                                        if AssortDetails1Rec."55" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."55");
                                                                            break;
                                                                        end;
                                                                    56:
                                                                        if AssortDetails1Rec."56" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."56");
                                                                            break;
                                                                        end;
                                                                    57:
                                                                        if AssortDetails1Rec."57" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."57");
                                                                            break;
                                                                        end;
                                                                    58:
                                                                        if AssortDetails1Rec."58" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."58");
                                                                            break;
                                                                        end;
                                                                    59:
                                                                        if AssortDetails1Rec."59" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."59");
                                                                            break;
                                                                        end;
                                                                    60:
                                                                        if AssortDetails1Rec."60" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."60");
                                                                            break;
                                                                        end;
                                                                    61:
                                                                        if AssortDetails1Rec."61" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."61");
                                                                            break;
                                                                        end;
                                                                    62:
                                                                        if AssortDetails1Rec."62" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."62");
                                                                            break;
                                                                        end;
                                                                    63:
                                                                        if AssortDetails1Rec."63" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."63");
                                                                            break;
                                                                        end;
                                                                    64:
                                                                        if AssortDetails1Rec."64" = BOMLine2Rec."GMR Size Name" then begin
                                                                            Evaluate(SubTotal, AssortDetailsRec."64");
                                                                            break;
                                                                        end;
                                                                end;
                                                            end;

                                                            Total += SubTotal;
                                                        end;

                                                    until AssortDetailsRec.Next() = 0;

                                                    LineNo += 1;
                                                    Value := 0;
                                                    Requirment := 0;

                                                    UOMRec.Reset();
                                                    UOMRec.SetRange(Code, BLERec."Unit N0.");
                                                    UOMRec.FindSet();
                                                    ConvFactor := UOMRec."Converion Parameter";

                                                    //Check whether already "po raised"items are there, then do not insert
                                                    BLAutoGenNewRec.Reset();
                                                    BLAutoGenNewRec.SetRange("No.", rec."No");
                                                    BLAutoGenNewRec.SetRange("Item No.", BLERec."Item No.");
                                                    BLAutoGenNewRec.SetRange("Placement of GMT", BLERec."Placement of GMT");
                                                    BLAutoGenNewRec.SetRange("Item Color No.", BOMLine2Rec."Item Color No.");
                                                    BLAutoGenNewRec.SetRange("GMT Size Name", BOMLine2Rec."GMR Size Name");
                                                    BLAutoGenNewRec.SetRange("Country No.", '');
                                                    BLAutoGenNewRec.SetRange(PO, BOMPOSelecRec."PO No.");
                                                    BLAutoGenNewRec.SetRange("Lot No.", BOMPOSelecRec."Lot No.");
                                                    BLAutoGenNewRec.SetRange("Article No.", BLERec."Article No.");
                                                    BLAutoGenNewRec.SetRange("Dimension No.", BOMLine2Rec."Dimension No.");
                                                    BLAutoGenNewRec.SetRange("Supplier No.", BLERec."Supplier No.");

                                                    if Not BLAutoGenNewRec.FindSet() then begin
                                                        if Total <> 0 then begin

                                                            BLAutoGenNewRec.Init();
                                                            BLAutoGenNewRec."No." := rec."No";
                                                            BLAutoGenNewRec."Item No." := BLERec."Item No.";
                                                            BLAutoGenNewRec."Item Name" := BLERec."Item Name";
                                                            BLAutoGenNewRec."Line No." := LineNo;
                                                            BLAutoGenNewRec."Main Category No." := BLERec."Main Category No.";
                                                            BLAutoGenNewRec."Main Category Name" := BLERec."Main Category Name";
                                                            BLAutoGenNewRec."Sub Category No." := SubCat;
                                                            BLAutoGenNewRec."Sub Category Name" := SubCatDesc;
                                                            BLAutoGenNewRec."Article No." := BLERec."Article No.";
                                                            BLAutoGenNewRec."Article Name." := BLERec."Article Name.";
                                                            BLAutoGenNewRec."Dimension No." := BOMLine2Rec."Dimension No.";
                                                            BLAutoGenNewRec."Dimension Name." := BOMLine2Rec."Dimension Name";
                                                            BLAutoGenNewRec."Unit N0." := BLERec."Unit N0.";
                                                            BLAutoGenNewRec.Type := BLERec.Type;
                                                            BLAutoGenNewRec.Consumption := BLERec.Consumption;
                                                            BLAutoGenNewRec.WST := BLERec.WST;
                                                            BLAutoGenNewRec.Rate := BLERec.Rate;
                                                            BLAutoGenNewRec."Supplier No." := BLERec."Supplier No.";
                                                            BLAutoGenNewRec."Supplier Name." := BLERec."Supplier Name.";
                                                            BLAutoGenNewRec.AjstReq := BLERec.AjstReq;
                                                            BLAutoGenNewRec.Qty := BLERec.Qty;
                                                            BLAutoGenNewRec."Created User" := UserId;
                                                            BLAutoGenNewRec."Created Date" := WorkDate();
                                                            BLAutoGenNewRec."Stock Bal" := BLERec."Stock Bal";
                                                            BLAutoGenNewRec."Size Sensitive" := false;
                                                            BLAutoGenNewRec."Color Sensitive" := false;
                                                            BLAutoGenNewRec."Country Sensitive" := false;
                                                            BLAutoGenNewRec."PO Sensitive" := false;
                                                            BLAutoGenNewRec.Reconfirm := false;
                                                            BLAutoGenNewRec."Placement of GMT" := BLERec."Placement of GMT";
                                                            BLAutoGenNewRec."GMT Color No." := BOMLine2Rec."GMT Color No.";
                                                            BLAutoGenNewRec."GMT Color Name" := BOMLine2Rec."GMT Color Name.";
                                                            BLAutoGenNewRec."Item Color No." := BOMLine2Rec."Item Color No.";
                                                            BLAutoGenNewRec."Item Color Name" := BOMLine2Rec."Item Color Name.";
                                                            BLAutoGenNewRec."GMT Size Name" := BOMLine2Rec."GMR Size Name";
                                                            BLAutoGenNewRec."Country No." := '';
                                                            BLAutoGenNewRec."Country Name" := '';
                                                            BLAutoGenNewRec.PO := BOMPOSelecRec."PO No.";
                                                            BLAutoGenNewRec."Lot No." := BOMPOSelecRec."lot No.";
                                                            BLAutoGenNewRec."GMT Qty" := Total;

                                                            if BLERec.Type = BLERec.Type::Pcs then
                                                                Requirment := (BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100
                                                            else
                                                                if BLERec.Type = BLERec.Type::Doz then
                                                                    Requirment := ((BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100) / 12;

                                                            if (ConvFactor <> 0) then
                                                                Requirment := Requirment / ConvFactor;

                                                            //Requirment := Round(Requirment, 1);

                                                            if Requirment < 0 then
                                                                Requirment := 1;

                                                            Value := Requirment * BLERec.Rate;

                                                            BLAutoGenNewRec.Requirment := Requirment;
                                                            BLAutoGenNewRec.Value := Value;

                                                            BLAutoGenNewRec.Insert();

                                                            //Insert into AutoGenPRBOM
                                                            InsertAutoGenProdBOM(BLERec."Item No.", LineNo);

                                                            Total := 0;

                                                        end;
                                                    end;
                                                end;

                                            until BOMPOSelecRec.Next() = 0;
                                        end;
                                    until BOMLine2Rec.Next() = 0;
                                end;
                            end;

                            //Size and country
                            if not BLERec."Color Sensitive" and BLERec."Size Sensitive" and BLERec."Country Sensitive" and not BLERec."PO Sensitive" then begin

                                //Size filter
                                BOMLine2Rec.Reset();
                                BOMLine2Rec.SetRange("No.", rec."No");
                                BOMLine2Rec.SetRange(Type, 2);
                                BOMLine2Rec.SetRange("Item No.", BLERec."Item No.");
                                BOMLine2Rec.SetRange(Placement, BLERec."Placement of GMT");
                                BOMLine2Rec.SetFilter(Select, '=%1', true);

                                if BOMLine2Rec.FindSet() then begin
                                    repeat

                                        //PO filter
                                        BOMPOSelecRec.Reset();
                                        BOMPOSelecRec.SetRange("BOM No.", rec."No");
                                        BOMPOSelecRec.SetRange(Selection, true);

                                        if BOMPOSelecRec.FindSet() then begin

                                            repeat

                                                //Country filter
                                                BOMLine3Rec.Reset();
                                                BOMLine3Rec.SetRange("No.", rec."No");
                                                BOMLine3Rec.SetRange(Type, 3);
                                                BOMLine3Rec.SetRange("Item No.", BOMLine2Rec."Item No.");
                                                BOMLine3Rec.SetRange(Placement, BOMLine2Rec."Placement");
                                                BOMLine3Rec.SetRange(Select, true);

                                                if BOMLine3Rec.FindSet() then begin

                                                    repeat

                                                        //Insert new line
                                                        AssortDetailsRec.Reset();
                                                        AssortDetailsRec.SetRange("Style No.", rec."Style No.");
                                                        AssortDetailsRec.SetRange("lot No.", BOMPOSelecRec."lot No.");
                                                        AssortDetailsRec.SetRange("Country Code", BOMLine3Rec."Country Code");

                                                        if AssortDetailsRec.FindSet() then begin

                                                            repeat

                                                                if AssortDetailsRec."Colour No" <> '*' then begin

                                                                    //Find the correct column for the GMT size
                                                                    AssortDetails1Rec.Reset();
                                                                    AssortDetails1Rec.SetRange("Style No.", rec."Style No.");
                                                                    AssortDetails1Rec.SetRange("lot No.", BOMPOSelecRec."lot No.");
                                                                    AssortDetails1Rec.SetRange("Country Code", BOMLine3Rec."Country Code");
                                                                    AssortDetails1Rec.SetRange("Colour No", '*');

                                                                    AssortDetails1Rec.FindSet();
                                                                    SubTotal := 0;

                                                                    FOR Count := 1 TO 64 DO begin

                                                                        case Count of
                                                                            1:
                                                                                if AssortDetails1Rec."1" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."1");
                                                                                    break;
                                                                                end;
                                                                            2:
                                                                                if AssortDetails1Rec."2" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."2");
                                                                                    break;
                                                                                end;
                                                                            3:
                                                                                if AssortDetails1Rec."3" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."3");
                                                                                    break;
                                                                                end;
                                                                            4:
                                                                                if AssortDetails1Rec."4" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."4");
                                                                                    break;
                                                                                end;
                                                                            5:
                                                                                if AssortDetails1Rec."5" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."5");
                                                                                    break;
                                                                                end;
                                                                            6:
                                                                                if AssortDetails1Rec."6" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."6");
                                                                                    break;
                                                                                end;
                                                                            7:
                                                                                if AssortDetails1Rec."7" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."7");
                                                                                    break;
                                                                                end;
                                                                            8:
                                                                                if AssortDetails1Rec."8" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."8");
                                                                                    break;
                                                                                end;
                                                                            9:
                                                                                if AssortDetails1Rec."9" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."9");
                                                                                    break;
                                                                                end;
                                                                            10:
                                                                                if AssortDetails1Rec."10" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."10");
                                                                                    break;
                                                                                end;
                                                                            11:
                                                                                if AssortDetails1Rec."11" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."11");
                                                                                    break;
                                                                                end;
                                                                            12:
                                                                                if AssortDetails1Rec."12" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."12");
                                                                                    break;
                                                                                end;
                                                                            13:
                                                                                if AssortDetails1Rec."13" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."13");
                                                                                    break;
                                                                                end;
                                                                            14:
                                                                                if AssortDetails1Rec."14" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."14");
                                                                                    break;
                                                                                end;
                                                                            15:
                                                                                if AssortDetails1Rec."15" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."15");
                                                                                    break;
                                                                                end;
                                                                            16:
                                                                                if AssortDetails1Rec."16" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."16");
                                                                                    break;
                                                                                end;
                                                                            17:
                                                                                if AssortDetails1Rec."17" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."17");
                                                                                    break;
                                                                                end;
                                                                            18:
                                                                                if AssortDetails1Rec."18" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."18");
                                                                                    break;
                                                                                end;
                                                                            19:
                                                                                if AssortDetails1Rec."19" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."19");
                                                                                    break;
                                                                                end;
                                                                            20:
                                                                                if AssortDetails1Rec."20" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."20");
                                                                                    break;
                                                                                end;
                                                                            21:
                                                                                if AssortDetails1Rec."21" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."21");
                                                                                    break;
                                                                                end;
                                                                            22:
                                                                                if AssortDetails1Rec."22" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."22");
                                                                                    break;
                                                                                end;
                                                                            23:
                                                                                if AssortDetails1Rec."23" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."23");
                                                                                    break;
                                                                                end;
                                                                            24:
                                                                                if AssortDetails1Rec."24" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."24");
                                                                                    break;
                                                                                end;
                                                                            25:
                                                                                if AssortDetails1Rec."25" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."25");
                                                                                    break;
                                                                                end;
                                                                            26:
                                                                                if AssortDetails1Rec."26" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."26");
                                                                                    break;
                                                                                end;
                                                                            27:
                                                                                if AssortDetails1Rec."27" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."27");
                                                                                    break;
                                                                                end;
                                                                            28:
                                                                                if AssortDetails1Rec."28" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."28");
                                                                                    break;
                                                                                end;
                                                                            29:
                                                                                if AssortDetails1Rec."29" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."29");
                                                                                    break;
                                                                                end;
                                                                            30:
                                                                                if AssortDetails1Rec."30" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."30");
                                                                                    break;
                                                                                end;
                                                                            31:
                                                                                if AssortDetails1Rec."31" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."31");
                                                                                    break;
                                                                                end;
                                                                            32:
                                                                                if AssortDetails1Rec."32" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."32");
                                                                                    break;
                                                                                end;
                                                                            33:
                                                                                if AssortDetails1Rec."33" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."33");
                                                                                    break;
                                                                                end;
                                                                            34:
                                                                                if AssortDetails1Rec."34" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."34");
                                                                                    break;
                                                                                end;
                                                                            35:
                                                                                if AssortDetails1Rec."35" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."35");
                                                                                    break;
                                                                                end;
                                                                            36:
                                                                                if AssortDetails1Rec."36" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."36");
                                                                                    break;
                                                                                end;
                                                                            37:
                                                                                if AssortDetails1Rec."37" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."37");
                                                                                    break;
                                                                                end;
                                                                            38:
                                                                                if AssortDetails1Rec."38" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."38");
                                                                                    break;
                                                                                end;
                                                                            39:
                                                                                if AssortDetails1Rec."39" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."39");
                                                                                    break;
                                                                                end;
                                                                            40:
                                                                                if AssortDetails1Rec."40" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."40");
                                                                                    break;
                                                                                end;
                                                                            41:
                                                                                if AssortDetails1Rec."41" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."41");
                                                                                    break;
                                                                                end;
                                                                            42:
                                                                                if AssortDetails1Rec."42" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."42");
                                                                                    break;
                                                                                end;
                                                                            43:
                                                                                if AssortDetails1Rec."43" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."43");
                                                                                    break;
                                                                                end;
                                                                            44:
                                                                                if AssortDetails1Rec."44" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."44");
                                                                                    break;
                                                                                end;
                                                                            45:
                                                                                if AssortDetails1Rec."45" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."45");
                                                                                    break;
                                                                                end;
                                                                            46:
                                                                                if AssortDetails1Rec."46" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."46");
                                                                                    break;
                                                                                end;
                                                                            47:
                                                                                if AssortDetails1Rec."47" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."47");
                                                                                    break;
                                                                                end;
                                                                            48:
                                                                                if AssortDetails1Rec."48" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."48");
                                                                                    break;
                                                                                end;
                                                                            49:
                                                                                if AssortDetails1Rec."49" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."49");
                                                                                    break;
                                                                                end;
                                                                            50:
                                                                                if AssortDetails1Rec."50" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."50");
                                                                                    break;
                                                                                end;
                                                                            51:
                                                                                if AssortDetails1Rec."51" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."51");
                                                                                    break;
                                                                                end;
                                                                            52:
                                                                                if AssortDetails1Rec."52" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."52");
                                                                                    break;
                                                                                end;
                                                                            53:
                                                                                if AssortDetails1Rec."53" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."53");
                                                                                    break;
                                                                                end;
                                                                            54:
                                                                                if AssortDetails1Rec."54" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."54");
                                                                                    break;
                                                                                end;
                                                                            55:
                                                                                if AssortDetails1Rec."55" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."55");
                                                                                    break;
                                                                                end;
                                                                            56:
                                                                                if AssortDetails1Rec."56" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."56");
                                                                                    break;
                                                                                end;
                                                                            57:
                                                                                if AssortDetails1Rec."57" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."57");
                                                                                    break;
                                                                                end;
                                                                            58:
                                                                                if AssortDetails1Rec."58" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."58");
                                                                                    break;
                                                                                end;
                                                                            59:
                                                                                if AssortDetails1Rec."59" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."59");
                                                                                    break;
                                                                                end;
                                                                            60:
                                                                                if AssortDetails1Rec."60" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."60");
                                                                                    break;
                                                                                end;
                                                                            61:
                                                                                if AssortDetails1Rec."61" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."61");
                                                                                    break;
                                                                                end;
                                                                            62:
                                                                                if AssortDetails1Rec."62" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."62");
                                                                                    break;
                                                                                end;
                                                                            63:
                                                                                if AssortDetails1Rec."63" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."63");
                                                                                    break;
                                                                                end;
                                                                            64:
                                                                                if AssortDetails1Rec."64" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."64");
                                                                                    break;
                                                                                end;
                                                                        end;
                                                                    end;

                                                                    Total += SubTotal;
                                                                end;

                                                            until AssortDetailsRec.Next() = 0;

                                                            LineNo += 1;
                                                            Value := 0;
                                                            Requirment := 0;

                                                            UOMRec.Reset();
                                                            UOMRec.SetRange(Code, BLERec."Unit N0.");
                                                            UOMRec.FindSet();
                                                            ConvFactor := UOMRec."Converion Parameter";

                                                            //Check whether already "po raised"items are there, then do not insert
                                                            BLAutoGenNewRec.Reset();
                                                            BLAutoGenNewRec.SetRange("No.", rec."No");
                                                            BLAutoGenNewRec.SetRange("Item No.", BLERec."Item No.");
                                                            BLAutoGenNewRec.SetRange("Placement of GMT", BLERec."Placement of GMT");
                                                            BLAutoGenNewRec.SetRange("Item Color No.", BOMLine2Rec."Item Color No.");
                                                            BLAutoGenNewRec.SetRange("GMT Size Name", BOMLine2Rec."GMR Size Name");
                                                            BLAutoGenNewRec.SetRange("Country No.", BOMLine3Rec."Country Code");
                                                            BLAutoGenNewRec.SetRange(PO, BOMPOSelecRec."PO No.");
                                                            BLAutoGenNewRec.SetRange("Lot No.", BOMPOSelecRec."Lot No.");
                                                            BLAutoGenNewRec.SetRange("Article No.", BLERec."Article No.");
                                                            BLAutoGenNewRec.SetRange("Dimension No.", BOMLine2Rec."Dimension No.");
                                                            BLAutoGenNewRec.SetRange("Supplier No.", BLERec."Supplier No.");

                                                            if Not BLAutoGenNewRec.FindSet() then begin
                                                                if Total <> 0 then begin

                                                                    BLAutoGenNewRec.Init();
                                                                    BLAutoGenNewRec."No." := rec."No";
                                                                    BLAutoGenNewRec."Item No." := BLERec."Item No.";
                                                                    BLAutoGenNewRec."Item Name" := BLERec."Item Name";
                                                                    BLAutoGenNewRec."Line No." := LineNo;
                                                                    BLAutoGenNewRec."Main Category No." := BLERec."Main Category No.";
                                                                    BLAutoGenNewRec."Main Category Name" := BLERec."Main Category Name";
                                                                    BLAutoGenNewRec."Sub Category No." := SubCat;
                                                                    BLAutoGenNewRec."Sub Category Name" := SubCatDesc;
                                                                    BLAutoGenNewRec."Article No." := BLERec."Article No.";
                                                                    BLAutoGenNewRec."Article Name." := BLERec."Article Name.";
                                                                    BLAutoGenNewRec."Dimension No." := BOMLine2Rec."Dimension No.";
                                                                    BLAutoGenNewRec."Dimension Name." := BOMLine2Rec."Dimension Name";
                                                                    BLAutoGenNewRec."Unit N0." := BLERec."Unit N0.";
                                                                    BLAutoGenNewRec.Type := BLERec.Type;
                                                                    BLAutoGenNewRec.Consumption := BLERec.Consumption;
                                                                    BLAutoGenNewRec.WST := BLERec.WST;
                                                                    BLAutoGenNewRec.Rate := BLERec.Rate;
                                                                    BLAutoGenNewRec."Supplier No." := BLERec."Supplier No.";
                                                                    BLAutoGenNewRec."Supplier Name." := BLERec."Supplier Name.";
                                                                    BLAutoGenNewRec.AjstReq := BLERec.AjstReq;
                                                                    BLAutoGenNewRec.Qty := BLERec.Qty;
                                                                    BLAutoGenNewRec."Created User" := UserId;
                                                                    BLAutoGenNewRec."Created Date" := WorkDate();
                                                                    BLAutoGenNewRec."Stock Bal" := BLERec."Stock Bal";
                                                                    BLAutoGenNewRec."Size Sensitive" := false;
                                                                    BLAutoGenNewRec."Color Sensitive" := false;
                                                                    BLAutoGenNewRec."Country Sensitive" := false;
                                                                    BLAutoGenNewRec."PO Sensitive" := false;
                                                                    BLAutoGenNewRec.Reconfirm := false;
                                                                    BLAutoGenNewRec."Placement of GMT" := BLERec."Placement of GMT";
                                                                    BLAutoGenNewRec."GMT Color No." := BOMLine2Rec."GMT Color No.";
                                                                    BLAutoGenNewRec."GMT Color Name" := BOMLine2Rec."GMT Color Name.";
                                                                    BLAutoGenNewRec."Item Color No." := BOMLine2Rec."Item Color No.";
                                                                    BLAutoGenNewRec."Item Color Name" := BOMLine2Rec."Item Color Name.";
                                                                    BLAutoGenNewRec."GMT Size Name" := BOMLine2Rec."GMR Size Name";
                                                                    BLAutoGenNewRec."Country No." := BOMLine3Rec."Country Code";
                                                                    BLAutoGenNewRec."Country Name" := BOMLine3Rec."Country Name";
                                                                    BLAutoGenNewRec.PO := BOMPOSelecRec."PO No.";
                                                                    BLAutoGenNewRec."Lot No." := BOMPOSelecRec."lot No.";
                                                                    BLAutoGenNewRec."GMT Qty" := Total;

                                                                    if BLERec.Type = BLERec.Type::Pcs then
                                                                        Requirment := (BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100
                                                                    else
                                                                        if BLERec.Type = BLERec.Type::Doz then
                                                                            Requirment := ((BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100) / 12;

                                                                    if (ConvFactor <> 0) then
                                                                        Requirment := Requirment / ConvFactor;

                                                                    //Requirment := Round(Requirment, 1);

                                                                    if Requirment < 0 then
                                                                        Requirment := 1;

                                                                    Value := Requirment * BLERec.Rate;

                                                                    BLAutoGenNewRec.Requirment := Requirment;
                                                                    BLAutoGenNewRec.Value := Value;

                                                                    BLAutoGenNewRec.Insert();

                                                                    //Insert into AutoGenPRBOM
                                                                    InsertAutoGenProdBOM(BLERec."Item No.", LineNo);

                                                                    Total := 0;

                                                                end;
                                                            end;
                                                        end;

                                                    until BOMLine3Rec.Next() = 0;
                                                end;
                                            until BOMPOSelecRec.Next() = 0;
                                        end;
                                    until BOMLine2Rec.Next() = 0;
                                end;
                            end;

                            //country only
                            if not BLERec."Color Sensitive" and not BLERec."Size Sensitive" and BLERec."Country Sensitive" and not BLERec."PO Sensitive" then begin

                                //PO filter
                                BOMPOSelecRec.Reset();
                                BOMPOSelecRec.SetRange("BOM No.", rec."No");
                                BOMPOSelecRec.SetRange(Selection, true);

                                if BOMPOSelecRec.FindSet() then begin

                                    repeat

                                        //Country filter
                                        BOMLine3Rec.Reset();
                                        BOMLine3Rec.SetRange("No.", rec."No");
                                        BOMLine3Rec.SetRange(Type, 3);
                                        BOMLine3Rec.SetRange("Item No.", BLERec."Item No.");
                                        BOMLine3Rec.SetRange(Placement, BLERec."Placement of GMT");
                                        BOMLine3Rec.SetRange(Select, true);

                                        if BOMLine3Rec.FindSet() then begin

                                            repeat

                                                //Insert new line
                                                AssortDetailsRec.Reset();
                                                AssortDetailsRec.SetRange("Style No.", rec."Style No.");
                                                AssortDetailsRec.SetRange("lot No.", BOMPOSelecRec."lot No.");
                                                AssortDetailsRec.SetRange("Country Code", BOMLine3Rec."Country Code");

                                                if AssortDetailsRec.FindSet() then begin

                                                    repeat

                                                        if AssortDetailsRec."Colour No" <> '*' then begin
                                                            Total += AssortDetailsRec.Total;
                                                        end;

                                                    until AssortDetailsRec.Next() = 0;

                                                    LineNo += 1;
                                                    Value := 0;
                                                    Requirment := 0;

                                                    UOMRec.Reset();
                                                    UOMRec.SetRange(Code, BLERec."Unit N0.");
                                                    UOMRec.FindSet();
                                                    ConvFactor := UOMRec."Converion Parameter";

                                                    //Check whether already "po raised"items are there, then do not insert
                                                    BLAutoGenNewRec.Reset();
                                                    BLAutoGenNewRec.SetRange("No.", rec."No");
                                                    BLAutoGenNewRec.SetRange("Item No.", BLERec."Item No.");
                                                    BLAutoGenNewRec.SetRange("Placement of GMT", BLERec."Placement of GMT");
                                                    BLAutoGenNewRec.SetRange("Item Color No.", BOMLine3Rec."Item Color No.");
                                                    BLAutoGenNewRec.SetRange("GMT Size Name", BOMLine3Rec."GMR Size Name");
                                                    BLAutoGenNewRec.SetRange("Country No.", BOMLine3Rec."Country Code");
                                                    BLAutoGenNewRec.SetRange(PO, BOMPOSelecRec."PO No.");
                                                    BLAutoGenNewRec.SetRange("Lot No.", BOMPOSelecRec."Lot No.");
                                                    BLAutoGenNewRec.SetRange("Article No.", BLERec."Article No.");
                                                    BLAutoGenNewRec.SetRange("Dimension No.", BLERec."Dimension No.");
                                                    BLAutoGenNewRec.SetRange("Supplier No.", BLERec."Supplier No.");

                                                    if Not BLAutoGenNewRec.FindSet() then begin
                                                        if Total <> 0 then begin

                                                            BLAutoGenNewRec.Init();
                                                            BLAutoGenNewRec."No." := rec."No";
                                                            BLAutoGenNewRec."Item No." := BLERec."Item No.";
                                                            BLAutoGenNewRec."Item Name" := BLERec."Item Name";
                                                            BLAutoGenNewRec."Line No." := LineNo;
                                                            BLAutoGenNewRec."Main Category No." := BLERec."Main Category No.";
                                                            BLAutoGenNewRec."Main Category Name" := BLERec."Main Category Name";
                                                            BLAutoGenNewRec."Sub Category No." := SubCat;
                                                            BLAutoGenNewRec."Sub Category Name" := SubCatDesc;
                                                            BLAutoGenNewRec."Article No." := BLERec."Article No.";
                                                            BLAutoGenNewRec."Article Name." := BLERec."Article Name.";
                                                            BLAutoGenNewRec."Dimension No." := BLERec."Dimension No.";
                                                            BLAutoGenNewRec."Dimension Name." := BLERec."Dimension Name.";
                                                            BLAutoGenNewRec."Unit N0." := BLERec."Unit N0.";
                                                            BLAutoGenNewRec.Type := BLERec.Type;
                                                            BLAutoGenNewRec.Consumption := BLERec.Consumption;
                                                            BLAutoGenNewRec.WST := BLERec.WST;
                                                            BLAutoGenNewRec.Rate := BLERec.Rate;
                                                            BLAutoGenNewRec."Supplier No." := BLERec."Supplier No.";
                                                            BLAutoGenNewRec."Supplier Name." := BLERec."Supplier Name.";
                                                            BLAutoGenNewRec.AjstReq := BLERec.AjstReq;
                                                            BLAutoGenNewRec.Qty := BLERec.Qty;
                                                            BLAutoGenNewRec."Created User" := UserId;
                                                            BLAutoGenNewRec."Created Date" := WorkDate();
                                                            BLAutoGenNewRec."Stock Bal" := BLERec."Stock Bal";
                                                            BLAutoGenNewRec."Size Sensitive" := false;
                                                            BLAutoGenNewRec."Color Sensitive" := false;
                                                            BLAutoGenNewRec."Country Sensitive" := false;
                                                            BLAutoGenNewRec."PO Sensitive" := false;
                                                            BLAutoGenNewRec.Reconfirm := false;
                                                            BLAutoGenNewRec."Placement of GMT" := BLERec."Placement of GMT";
                                                            BLAutoGenNewRec."GMT Color No." := BOMLine3Rec."GMT Color No.";
                                                            BLAutoGenNewRec."GMT Color Name" := BOMLine3Rec."GMT Color Name.";
                                                            BLAutoGenNewRec."Item Color No." := BOMLine3Rec."Item Color No.";
                                                            BLAutoGenNewRec."Item Color Name" := BOMLine3Rec."Item Color Name.";
                                                            BLAutoGenNewRec."GMT Size Name" := BOMLine3Rec."GMR Size Name";
                                                            BLAutoGenNewRec."Country No." := BOMLine3Rec."Country Code";
                                                            BLAutoGenNewRec."Country Name" := BOMLine3Rec."Country Name";
                                                            BLAutoGenNewRec.PO := BOMPOSelecRec."PO No.";
                                                            BLAutoGenNewRec."Lot No." := BOMPOSelecRec."Lot No.";
                                                            BLAutoGenNewRec."GMT Qty" := Total;

                                                            if BLERec.Type = BLERec.Type::Pcs then
                                                                Requirment := (BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100
                                                            else
                                                                if BLERec.Type = BLERec.Type::Doz then
                                                                    Requirment := ((BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100) / 12;

                                                            if (ConvFactor <> 0) then
                                                                Requirment := Requirment / ConvFactor;

                                                            //Requirment := Round(Requirment, 1);

                                                            if Requirment < 0 then
                                                                Requirment := 1;

                                                            Value := Requirment * BLERec.Rate;

                                                            BLAutoGenNewRec.Requirment := Requirment;
                                                            BLAutoGenNewRec.Value := Value;

                                                            BLAutoGenNewRec.Insert();

                                                            //Insert into AutoGenPRBOM
                                                            InsertAutoGenProdBOM(BLERec."Item No.", LineNo);

                                                            Total := 0;
                                                        end;
                                                    end;

                                                end;

                                            until BOMLine3Rec.Next() = 0;
                                        end;
                                    until BOMPOSelecRec.Next() = 0;
                                end;

                            end;

                            //Color and Country
                            if BLERec."Color Sensitive" and not BLERec."Size Sensitive" and BLERec."Country Sensitive" and not BLERec."PO Sensitive" then begin

                                //Color filter
                                BOMLine1Rec.Reset();
                                BOMLine1Rec.SetRange("No.", rec."No");
                                BOMLine1Rec.SetRange(Type, 1);
                                BOMLine1Rec.SetRange("Item No.", BLERec."Item No.");
                                BOMLine1Rec.SetRange(Placement, BLERec."Placement of GMT");
                                BOMLine1Rec.SetFilter(Select, '=%1', true);

                                if BOMLine1Rec.FindSet() then begin

                                    repeat

                                        //PO filter
                                        BOMPOSelecRec.Reset();
                                        BOMPOSelecRec.SetRange("BOM No.", rec."No");
                                        BOMPOSelecRec.SetRange(Selection, true);

                                        if BOMPOSelecRec.FindSet() then begin
                                            repeat

                                                //Country filter
                                                BOMLine3Rec.Reset();
                                                BOMLine3Rec.SetRange("No.", rec."No");
                                                BOMLine3Rec.SetRange(Type, 3);
                                                BOMLine3Rec.SetRange("Item No.", BOMLine1Rec."Item No.");
                                                BOMLine3Rec.SetRange(Placement, BOMLine1Rec."Placement");
                                                BOMLine3Rec.SetRange(Select, true);

                                                if BOMLine3Rec.FindSet() then begin

                                                    repeat

                                                        //Insert new line
                                                        AssortDetailsRec.Reset();
                                                        AssortDetailsRec.SetRange("Style No.", rec."Style No.");
                                                        AssortDetailsRec.SetRange("lot No.", BOMPOSelecRec."lot No.");
                                                        AssortDetailsRec.SetRange("Colour No", BOMLine1Rec."GMT Color No.");
                                                        AssortDetailsRec.SetRange("Country Code", BOMLine3Rec."Country Code");

                                                        if AssortDetailsRec.FindSet() then begin

                                                            Total := AssortDetailsRec.Total;
                                                            LineNo += 1;
                                                            Value := 0;
                                                            Requirment := 0;

                                                            UOMRec.Reset();
                                                            UOMRec.SetRange(Code, BLERec."Unit N0.");
                                                            UOMRec.FindSet();
                                                            ConvFactor := UOMRec."Converion Parameter";

                                                            //Check whether already "po raised"items are there, then do not insert
                                                            BLAutoGenNewRec.Reset();
                                                            BLAutoGenNewRec.SetRange("No.", rec."No");
                                                            BLAutoGenNewRec.SetRange("Item No.", BLERec."Item No.");
                                                            BLAutoGenNewRec.SetRange("Placement of GMT", BLERec."Placement of GMT");
                                                            BLAutoGenNewRec.SetRange("GMT Color No.", BOMLine1Rec."GMT Color No.");
                                                            //BLAutoGenNewRec.SetRange("Item Color No.", BOMLine1Rec."Item Color No.");
                                                            BLAutoGenNewRec.SetRange("GMT Size Name", BOMLine1Rec."GMR Size Name");
                                                            BLAutoGenNewRec.SetRange("Country No.", BOMLine3Rec."Country Code");
                                                            BLAutoGenNewRec.SetRange(PO, BOMPOSelecRec."PO No.");
                                                            BLAutoGenNewRec.SetRange("Lot No.", BOMPOSelecRec."Lot No.");
                                                            BLAutoGenNewRec.SetRange("Article No.", BLERec."Article No.");
                                                            BLAutoGenNewRec.SetRange("Dimension No.", BLERec."Dimension No.");
                                                            BLAutoGenNewRec.SetRange("Supplier No.", BLERec."Supplier No.");

                                                            if Not BLAutoGenNewRec.FindSet() then begin
                                                                if Total <> 0 then begin

                                                                    BLAutoGenNewRec.Init();
                                                                    BLAutoGenNewRec."No." := rec."No";
                                                                    BLAutoGenNewRec."Item No." := BLERec."Item No.";
                                                                    BLAutoGenNewRec."Item Name" := BLERec."Item Name";
                                                                    BLAutoGenNewRec."Line No." := LineNo;
                                                                    BLAutoGenNewRec."Main Category No." := BLERec."Main Category No.";
                                                                    BLAutoGenNewRec."Main Category Name" := BLERec."Main Category Name";
                                                                    BLAutoGenNewRec."Sub Category No." := SubCat;
                                                                    BLAutoGenNewRec."Sub Category Name" := SubCatDesc;
                                                                    BLAutoGenNewRec."Article No." := BLERec."Article No.";
                                                                    BLAutoGenNewRec."Article Name." := BLERec."Article Name.";
                                                                    BLAutoGenNewRec."Dimension No." := BLERec."Dimension No.";
                                                                    BLAutoGenNewRec."Dimension Name." := BLERec."Dimension Name.";
                                                                    BLAutoGenNewRec."Unit N0." := BLERec."Unit N0.";
                                                                    BLAutoGenNewRec.Type := BLERec.Type;
                                                                    BLAutoGenNewRec.Consumption := BLERec.Consumption;
                                                                    BLAutoGenNewRec.WST := BLERec.WST;
                                                                    BLAutoGenNewRec.Rate := BLERec.Rate;
                                                                    BLAutoGenNewRec."Supplier No." := BLERec."Supplier No.";
                                                                    BLAutoGenNewRec."Supplier Name." := BLERec."Supplier Name.";
                                                                    BLAutoGenNewRec.AjstReq := BLERec.AjstReq;
                                                                    BLAutoGenNewRec.Qty := BLERec.Qty;
                                                                    BLAutoGenNewRec."Created User" := UserId;
                                                                    BLAutoGenNewRec."Created Date" := WorkDate();
                                                                    BLAutoGenNewRec."Stock Bal" := BLERec."Stock Bal";
                                                                    BLAutoGenNewRec."Size Sensitive" := false;
                                                                    BLAutoGenNewRec."Color Sensitive" := false;
                                                                    BLAutoGenNewRec."Country Sensitive" := false;
                                                                    BLAutoGenNewRec."PO Sensitive" := false;
                                                                    BLAutoGenNewRec.Reconfirm := false;
                                                                    BLAutoGenNewRec."Placement of GMT" := BLERec."Placement of GMT";
                                                                    BLAutoGenNewRec."GMT Color No." := BOMLine1Rec."GMT Color No.";
                                                                    BLAutoGenNewRec."GMT Color Name" := BOMLine1Rec."GMT Color Name.";
                                                                    BLAutoGenNewRec."Item Color No." := BOMLine1Rec."Item Color No.";
                                                                    BLAutoGenNewRec."Item Color Name" := BOMLine1Rec."Item Color Name.";
                                                                    BLAutoGenNewRec."GMT Size Name" := BOMLine1Rec."GMR Size Name";
                                                                    BLAutoGenNewRec."Country No." := BOMLine3Rec."Country Code";
                                                                    BLAutoGenNewRec."Country Name" := BOMLine3Rec."Country Name";
                                                                    BLAutoGenNewRec.PO := BOMPOSelecRec."PO No.";
                                                                    BLAutoGenNewRec."Lot No." := BOMPOSelecRec."lot No.";
                                                                    BLAutoGenNewRec."GMT Qty" := Total;

                                                                    if BLERec.Type = BLERec.Type::Pcs then
                                                                        Requirment := (BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100
                                                                    else
                                                                        if BLERec.Type = BLERec.Type::Doz then
                                                                            Requirment := ((BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100) / 12;

                                                                    if (ConvFactor <> 0) then
                                                                        Requirment := Requirment / ConvFactor;

                                                                    //Requirment := Round(Requirment, 1);

                                                                    if Requirment < 0 then
                                                                        Requirment := 1;

                                                                    Value := Requirment * BLERec.Rate;

                                                                    BLAutoGenNewRec.Requirment := Requirment;
                                                                    BLAutoGenNewRec.Value := Value;

                                                                    BLAutoGenNewRec.Insert();

                                                                    //Insert into AutoGenPRBOM
                                                                    InsertAutoGenProdBOM(BLERec."Item No.", LineNo);

                                                                    Total := 0;
                                                                end;
                                                            end;

                                                        end;

                                                    until BOMLine3Rec.Next() = 0;
                                                end;

                                            until BOMPOSelecRec.Next() = 0;
                                        end;

                                    until BOMLine1Rec.Next() = 0;
                                end;
                            end;

                            //PO only
                            if not BLERec."Color Sensitive" and not BLERec."Size Sensitive" and not BLERec."Country Sensitive" and BLERec."PO Sensitive" then begin

                                //PO filter
                                BOMPOSelecRec.Reset();
                                BOMPOSelecRec.SetRange("BOM No.", rec."No");
                                BOMPOSelecRec.SetRange(Selection, true);

                                if BOMPOSelecRec.FindSet() then begin
                                    repeat

                                        //Item po filter
                                        BOMLine4Rec.Reset();
                                        BOMLine4Rec.SetRange("No.", rec."No");
                                        BOMLine4Rec.SetRange(Type, 4);
                                        BOMLine4Rec.SetRange("Item No.", BLERec."Item No.");
                                        BOMLine4Rec.SetRange(Placement, BLERec."Placement of GMT");
                                        BOMLine4Rec.SetRange("lot No.", BOMPOSelecRec."lot No.");
                                        BOMLine4Rec.SetRange(Select, true);

                                        if BOMLine4Rec.FindSet() then begin

                                            //Insert new line
                                            AssortDetailsRec.Reset();
                                            AssortDetailsRec.SetRange("Style No.", rec."Style No.");
                                            AssortDetailsRec.SetRange("lot No.", BOMLine4Rec."lot No.");

                                            if AssortDetailsRec.FindSet() then begin

                                                repeat
                                                    if AssortDetailsRec."Colour No" <> '*' then
                                                        Total += AssortDetailsRec.Total;
                                                until AssortDetailsRec.Next() = 0;


                                                LineNo += 1;
                                                Value := 0;
                                                Requirment := 0;

                                                UOMRec.Reset();
                                                UOMRec.SetRange(Code, BLERec."Unit N0.");
                                                UOMRec.FindSet();
                                                ConvFactor := UOMRec."Converion Parameter";

                                                //Check whether already "po raised"items are there, then do not insert
                                                BLAutoGenNewRec.Reset();
                                                BLAutoGenNewRec.SetRange("No.", rec."No");
                                                BLAutoGenNewRec.SetRange("Item No.", BLERec."Item No.");
                                                BLAutoGenNewRec.SetRange("Placement of GMT", BLERec."Placement of GMT");
                                                //BLAutoGenNewRec.SetRange("GMT Color No.", BOMLine1Rec."GMT Color No.");
                                                BLAutoGenNewRec.SetRange("Item Color No.", BOMLine1Rec."Item Color No.");
                                                BLAutoGenNewRec.SetRange("GMT Size Name", BOMLine2Rec."GMR Size Name");
                                                BLAutoGenNewRec.SetRange("Country No.", BOMLine3Rec."Country Code");
                                                BLAutoGenNewRec.SetRange(PO, BOMLine4Rec."PO No.");
                                                BLAutoGenNewRec.SetRange("Lot No.", BOMLine4Rec."Lot No.");
                                                BLAutoGenNewRec.SetRange("Article No.", BLERec."Article No.");
                                                BLAutoGenNewRec.SetRange("Dimension No.", BLERec."Dimension No.");
                                                BLAutoGenNewRec.SetRange("Supplier No.", BLERec."Supplier No.");

                                                if Not BLAutoGenNewRec.FindSet() then begin
                                                    if Total <> 0 then begin

                                                        BLAutoGenNewRec.Init();
                                                        BLAutoGenNewRec."No." := rec."No";
                                                        BLAutoGenNewRec."Item No." := BLERec."Item No.";
                                                        BLAutoGenNewRec."Item Name" := BLERec."Item Name";
                                                        BLAutoGenNewRec."Line No." := LineNo;
                                                        BLAutoGenNewRec."Main Category No." := BLERec."Main Category No.";
                                                        BLAutoGenNewRec."Main Category Name" := BLERec."Main Category Name";
                                                        BLAutoGenNewRec."Sub Category No." := SubCat;
                                                        BLAutoGenNewRec."Sub Category Name" := SubCatDesc;
                                                        BLAutoGenNewRec."Article No." := BLERec."Article No.";
                                                        BLAutoGenNewRec."Article Name." := BLERec."Article Name.";
                                                        BLAutoGenNewRec."Dimension No." := BLERec."Dimension No.";
                                                        BLAutoGenNewRec."Dimension Name." := BLERec."Dimension Name.";
                                                        BLAutoGenNewRec."Unit N0." := BLERec."Unit N0.";
                                                        BLAutoGenNewRec.Type := BLERec.Type;
                                                        BLAutoGenNewRec.Consumption := BLERec.Consumption;
                                                        BLAutoGenNewRec.WST := BLERec.WST;
                                                        BLAutoGenNewRec.Rate := BLERec.Rate;
                                                        BLAutoGenNewRec."Supplier No." := BLERec."Supplier No.";
                                                        BLAutoGenNewRec."Supplier Name." := BLERec."Supplier Name.";
                                                        BLAutoGenNewRec.AjstReq := BLERec.AjstReq;
                                                        BLAutoGenNewRec.Qty := BLERec.Qty;
                                                        BLAutoGenNewRec."Created User" := UserId;
                                                        BLAutoGenNewRec."Created Date" := WorkDate();
                                                        BLAutoGenNewRec."Stock Bal" := BLERec."Stock Bal";
                                                        BLAutoGenNewRec."Size Sensitive" := false;
                                                        BLAutoGenNewRec."Color Sensitive" := false;
                                                        BLAutoGenNewRec."Country Sensitive" := false;
                                                        BLAutoGenNewRec."PO Sensitive" := false;
                                                        BLAutoGenNewRec.Reconfirm := false;
                                                        BLAutoGenNewRec."Placement of GMT" := BLERec."Placement of GMT";
                                                        BLAutoGenNewRec."GMT Color No." := BOMLine1Rec."GMT Color No.";
                                                        BLAutoGenNewRec."GMT Color Name" := BOMLine1Rec."GMT Color Name.";
                                                        BLAutoGenNewRec."Item Color No." := BOMLine1Rec."Item Color No.";
                                                        BLAutoGenNewRec."Item Color Name" := BOMLine1Rec."Item Color Name.";
                                                        BLAutoGenNewRec."GMT Size Name" := BOMLine2Rec."GMR Size Name";
                                                        BLAutoGenNewRec."Country No." := BOMLine3Rec."Country Code";
                                                        BLAutoGenNewRec."Country Name" := BOMLine3Rec."Country Name";
                                                        BLAutoGenNewRec.PO := BOMLine4Rec."PO No.";
                                                        BLAutoGenNewRec."Lot No." := BOMLine4Rec."lot No.";
                                                        BLAutoGenNewRec."GMT Qty" := Total;

                                                        if BLERec.Type = BLERec.Type::Pcs then
                                                            Requirment := (BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100
                                                        else
                                                            if BLERec.Type = BLERec.Type::Doz then
                                                                Requirment := ((BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100) / 12;

                                                        if (ConvFactor <> 0) then
                                                            Requirment := Requirment / ConvFactor;

                                                        //Requirment := Round(Requirment, 1);

                                                        if Requirment < 0 then
                                                            Requirment := 1;

                                                        Value := Requirment * BLERec.Rate;

                                                        BLAutoGenNewRec.Requirment := Requirment;
                                                        BLAutoGenNewRec.Value := Value;

                                                        BLAutoGenNewRec.Insert();

                                                        //Insert into AutoGenPRBOM
                                                        InsertAutoGenProdBOM(BLERec."Item No.", LineNo);

                                                        Total := 0;
                                                    end;
                                                end;
                                            end;
                                        end;
                                    until BOMPOSelecRec.Next() = 0;
                                end;
                            end;

                            //Size and PO
                            if not BLERec."Color Sensitive" and BLERec."Size Sensitive" and not BLERec."Country Sensitive" and BLERec."PO Sensitive" then begin

                                //Size filter
                                BOMLine2Rec.Reset();
                                BOMLine2Rec.SetRange("No.", rec."No");
                                BOMLine2Rec.SetRange(Type, 2);
                                BOMLine2Rec.SetRange("Item No.", BLERec."Item No.");
                                BOMLine2Rec.SetRange(Placement, BLERec."Placement of GMT");
                                BOMLine2Rec.SetFilter(Select, '=%1', true);

                                if BOMLine2Rec.FindSet() then begin

                                    repeat

                                        //PO filter
                                        BOMPOSelecRec.Reset();
                                        BOMPOSelecRec.SetRange("BOM No.", rec."No");
                                        BOMPOSelecRec.SetRange(Selection, true);

                                        if BOMPOSelecRec.FindSet() then begin

                                            repeat

                                                //Item po filter
                                                BOMLine4Rec.Reset();
                                                BOMLine4Rec.SetRange("No.", rec."No");
                                                BOMLine4Rec.SetRange(Type, 4);
                                                BOMLine4Rec.SetRange("Item No.", BOMLine2Rec."Item No.");
                                                BOMLine4Rec.SetRange(Placement, BOMLine2Rec."Placement");
                                                BOMLine4Rec.SetRange("lot No.", BOMPOSelecRec."lot No.");
                                                BOMLine4Rec.SetRange(Select, true);

                                                if BOMLine4Rec.FindSet() then begin

                                                    repeat

                                                        //Insert new line
                                                        AssortDetailsRec.Reset();
                                                        AssortDetailsRec.SetRange("Style No.", rec."Style No.");
                                                        AssortDetailsRec.SetRange("lot No.", BOMPOSelecRec."lot No.");

                                                        if AssortDetailsRec.FindSet() then begin

                                                            repeat

                                                                if AssortDetailsRec."Colour No" <> '*' then begin

                                                                    //Find the correct column for the GMT size
                                                                    AssortDetails1Rec.Reset();
                                                                    AssortDetails1Rec.SetRange("Style No.", rec."Style No.");
                                                                    AssortDetails1Rec.SetRange("lot No.", BOMPOSelecRec."lot No.");
                                                                    AssortDetails1Rec.SetRange("Colour No", '*');

                                                                    AssortDetails1Rec.FindSet();

                                                                    FOR Count := 1 TO 64 DO begin

                                                                        case Count of
                                                                            1:
                                                                                if AssortDetails1Rec."1" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."1");
                                                                                    break;
                                                                                end;
                                                                            2:
                                                                                if AssortDetails1Rec."2" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."2");
                                                                                    break;
                                                                                end;
                                                                            3:
                                                                                if AssortDetails1Rec."3" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."3");
                                                                                    break;
                                                                                end;
                                                                            4:
                                                                                if AssortDetails1Rec."4" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."4");
                                                                                    break;
                                                                                end;
                                                                            5:
                                                                                if AssortDetails1Rec."5" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."5");
                                                                                    break;
                                                                                end;
                                                                            6:
                                                                                if AssortDetails1Rec."6" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."6");
                                                                                    break;
                                                                                end;
                                                                            7:
                                                                                if AssortDetails1Rec."7" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."7");
                                                                                    break;
                                                                                end;
                                                                            8:
                                                                                if AssortDetails1Rec."8" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."8");
                                                                                    break;
                                                                                end;
                                                                            9:
                                                                                if AssortDetails1Rec."9" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."9");
                                                                                    break;
                                                                                end;
                                                                            10:
                                                                                if AssortDetails1Rec."10" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."10");
                                                                                    break;
                                                                                end;
                                                                            11:
                                                                                if AssortDetails1Rec."11" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."11");
                                                                                    break;
                                                                                end;
                                                                            12:
                                                                                if AssortDetails1Rec."12" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."12");
                                                                                    break;
                                                                                end;
                                                                            13:
                                                                                if AssortDetails1Rec."13" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."13");
                                                                                    break;
                                                                                end;
                                                                            14:
                                                                                if AssortDetails1Rec."14" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."14");
                                                                                    break;
                                                                                end;
                                                                            15:
                                                                                if AssortDetails1Rec."15" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."15");
                                                                                    break;
                                                                                end;
                                                                            16:
                                                                                if AssortDetails1Rec."16" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."16");
                                                                                    break;
                                                                                end;
                                                                            17:
                                                                                if AssortDetails1Rec."17" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."17");
                                                                                    break;
                                                                                end;
                                                                            18:
                                                                                if AssortDetails1Rec."18" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."18");
                                                                                    break;
                                                                                end;
                                                                            19:
                                                                                if AssortDetails1Rec."19" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."19");
                                                                                    break;
                                                                                end;
                                                                            20:
                                                                                if AssortDetails1Rec."20" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."20");
                                                                                    break;
                                                                                end;
                                                                            21:
                                                                                if AssortDetails1Rec."21" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."21");
                                                                                    break;
                                                                                end;
                                                                            22:
                                                                                if AssortDetails1Rec."22" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."22");
                                                                                    break;
                                                                                end;
                                                                            23:
                                                                                if AssortDetails1Rec."23" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."23");
                                                                                    break;
                                                                                end;
                                                                            24:
                                                                                if AssortDetails1Rec."24" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."24");
                                                                                    break;
                                                                                end;
                                                                            25:
                                                                                if AssortDetails1Rec."25" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."25");
                                                                                    break;
                                                                                end;
                                                                            26:
                                                                                if AssortDetails1Rec."26" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."26");
                                                                                    break;
                                                                                end;
                                                                            27:
                                                                                if AssortDetails1Rec."27" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."27");
                                                                                    break;
                                                                                end;
                                                                            28:
                                                                                if AssortDetails1Rec."28" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."28");
                                                                                    break;
                                                                                end;
                                                                            29:
                                                                                if AssortDetails1Rec."29" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."29");
                                                                                    break;
                                                                                end;
                                                                            30:
                                                                                if AssortDetails1Rec."30" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."30");
                                                                                    break;
                                                                                end;
                                                                            31:
                                                                                if AssortDetails1Rec."31" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."31");
                                                                                    break;
                                                                                end;
                                                                            32:
                                                                                if AssortDetails1Rec."32" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."32");
                                                                                    break;
                                                                                end;
                                                                            33:
                                                                                if AssortDetails1Rec."33" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."33");
                                                                                    break;
                                                                                end;
                                                                            34:
                                                                                if AssortDetails1Rec."34" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."34");
                                                                                    break;
                                                                                end;
                                                                            35:
                                                                                if AssortDetails1Rec."35" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."35");
                                                                                    break;
                                                                                end;
                                                                            36:
                                                                                if AssortDetails1Rec."36" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."36");
                                                                                    break;
                                                                                end;
                                                                            37:
                                                                                if AssortDetails1Rec."37" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."37");
                                                                                    break;
                                                                                end;
                                                                            38:
                                                                                if AssortDetails1Rec."38" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."38");
                                                                                    break;
                                                                                end;
                                                                            39:
                                                                                if AssortDetails1Rec."39" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."39");
                                                                                    break;
                                                                                end;
                                                                            40:
                                                                                if AssortDetails1Rec."40" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."40");
                                                                                    break;
                                                                                end;
                                                                            41:
                                                                                if AssortDetails1Rec."41" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."41");
                                                                                    break;
                                                                                end;
                                                                            42:
                                                                                if AssortDetails1Rec."42" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."42");
                                                                                    break;
                                                                                end;
                                                                            43:
                                                                                if AssortDetails1Rec."43" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."43");
                                                                                    break;
                                                                                end;
                                                                            44:
                                                                                if AssortDetails1Rec."44" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."44");
                                                                                    break;
                                                                                end;
                                                                            45:
                                                                                if AssortDetails1Rec."45" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."45");
                                                                                    break;
                                                                                end;
                                                                            46:
                                                                                if AssortDetails1Rec."46" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."46");
                                                                                    break;
                                                                                end;
                                                                            47:
                                                                                if AssortDetails1Rec."47" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."47");
                                                                                    break;
                                                                                end;
                                                                            48:
                                                                                if AssortDetails1Rec."48" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."48");
                                                                                    break;
                                                                                end;
                                                                            49:
                                                                                if AssortDetails1Rec."49" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."49");
                                                                                    break;
                                                                                end;
                                                                            50:
                                                                                if AssortDetails1Rec."50" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."50");
                                                                                    break;
                                                                                end;
                                                                            51:
                                                                                if AssortDetails1Rec."51" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."51");
                                                                                    break;
                                                                                end;
                                                                            52:
                                                                                if AssortDetails1Rec."52" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."52");
                                                                                    break;
                                                                                end;
                                                                            53:
                                                                                if AssortDetails1Rec."53" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."53");
                                                                                    break;
                                                                                end;
                                                                            54:
                                                                                if AssortDetails1Rec."54" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."54");
                                                                                    break;
                                                                                end;
                                                                            55:
                                                                                if AssortDetails1Rec."55" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."55");
                                                                                    break;
                                                                                end;
                                                                            56:
                                                                                if AssortDetails1Rec."56" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."56");
                                                                                    break;
                                                                                end;
                                                                            57:
                                                                                if AssortDetails1Rec."57" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."57");
                                                                                    break;
                                                                                end;
                                                                            58:
                                                                                if AssortDetails1Rec."58" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."58");
                                                                                    break;
                                                                                end;
                                                                            59:
                                                                                if AssortDetails1Rec."59" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."59");
                                                                                    break;
                                                                                end;
                                                                            60:
                                                                                if AssortDetails1Rec."60" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."60");
                                                                                    break;
                                                                                end;
                                                                            61:
                                                                                if AssortDetails1Rec."61" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."61");
                                                                                    break;
                                                                                end;
                                                                            62:
                                                                                if AssortDetails1Rec."62" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."62");
                                                                                    break;
                                                                                end;
                                                                            63:
                                                                                if AssortDetails1Rec."63" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."63");
                                                                                    break;
                                                                                end;
                                                                            64:
                                                                                if AssortDetails1Rec."64" = BOMLine2Rec."GMR Size Name" then begin
                                                                                    Evaluate(SubTotal, AssortDetailsRec."64");
                                                                                    break;
                                                                                end;
                                                                        end;
                                                                    end;

                                                                    Total += SubTotal;

                                                                end;

                                                            until AssortDetailsRec.Next() = 0;

                                                            LineNo += 1;
                                                            Value := 0;
                                                            Requirment := 0;

                                                            UOMRec.Reset();
                                                            UOMRec.SetRange(Code, BLERec."Unit N0.");
                                                            UOMRec.FindSet();
                                                            ConvFactor := UOMRec."Converion Parameter";

                                                            //Check whether already "po raised"items are there, then do not insert
                                                            BLAutoGenNewRec.Reset();
                                                            BLAutoGenNewRec.SetRange("No.", rec."No");
                                                            BLAutoGenNewRec.SetRange("Item No.", BLERec."Item No.");
                                                            BLAutoGenNewRec.SetRange("Placement of GMT", BLERec."Placement of GMT");
                                                            BLAutoGenNewRec.SetRange("Item Color No.", BOMLine2Rec."Item Color No.");
                                                            BLAutoGenNewRec.SetRange("GMT Size Name", BOMLine2Rec."GMR Size Name");
                                                            BLAutoGenNewRec.SetRange("Country No.", BOMLine2Rec."Country Code");
                                                            BLAutoGenNewRec.SetRange(PO, BOMPOSelecRec."PO No.");
                                                            BLAutoGenNewRec.SetRange("Lot No.", BOMPOSelecRec."Lot No.");
                                                            BLAutoGenNewRec.SetRange("Article No.", BLERec."Article No.");
                                                            BLAutoGenNewRec.SetRange("Dimension No.", BOMLine2Rec."Dimension No.");
                                                            BLAutoGenNewRec.SetRange("Supplier No.", BLERec."Supplier No.");

                                                            if Not BLAutoGenNewRec.FindSet() then begin
                                                                if Total <> 0 then begin

                                                                    BLAutoGenNewRec.Init();
                                                                    BLAutoGenNewRec."No." := rec."No";
                                                                    BLAutoGenNewRec."Item No." := BLERec."Item No.";
                                                                    BLAutoGenNewRec."Item Name" := BLERec."Item Name";
                                                                    BLAutoGenNewRec."Line No." := LineNo;
                                                                    BLAutoGenNewRec."Main Category No." := BLERec."Main Category No.";
                                                                    BLAutoGenNewRec."Main Category Name" := BLERec."Main Category Name";
                                                                    BLAutoGenNewRec."Sub Category No." := SubCat;
                                                                    BLAutoGenNewRec."Sub Category Name" := SubCatDesc;
                                                                    BLAutoGenNewRec."Article No." := BLERec."Article No.";
                                                                    BLAutoGenNewRec."Article Name." := BLERec."Article Name.";
                                                                    BLAutoGenNewRec."Dimension No." := BOMLine2Rec."Dimension No.";
                                                                    BLAutoGenNewRec."Dimension Name." := BOMLine2Rec."Dimension Name";
                                                                    BLAutoGenNewRec."Unit N0." := BLERec."Unit N0.";
                                                                    BLAutoGenNewRec.Type := BLERec.Type;
                                                                    BLAutoGenNewRec.Consumption := BLERec.Consumption;
                                                                    BLAutoGenNewRec.WST := BLERec.WST;
                                                                    BLAutoGenNewRec.Rate := BLERec.Rate;
                                                                    BLAutoGenNewRec."Supplier No." := BLERec."Supplier No.";
                                                                    BLAutoGenNewRec."Supplier Name." := BLERec."Supplier Name.";
                                                                    BLAutoGenNewRec.AjstReq := BLERec.AjstReq;
                                                                    BLAutoGenNewRec.Qty := BLERec.Qty;
                                                                    BLAutoGenNewRec."Created User" := UserId;
                                                                    BLAutoGenNewRec."Created Date" := WorkDate();
                                                                    BLAutoGenNewRec."Stock Bal" := BLERec."Stock Bal";
                                                                    BLAutoGenNewRec."Size Sensitive" := false;
                                                                    BLAutoGenNewRec."Color Sensitive" := false;
                                                                    BLAutoGenNewRec."Country Sensitive" := false;
                                                                    BLAutoGenNewRec."PO Sensitive" := false;
                                                                    BLAutoGenNewRec.Reconfirm := false;
                                                                    BLAutoGenNewRec."Placement of GMT" := BLERec."Placement of GMT";
                                                                    BLAutoGenNewRec."GMT Color No." := BOMLine2Rec."GMT Color No.";
                                                                    BLAutoGenNewRec."GMT Color Name" := BOMLine2Rec."GMT Color Name.";
                                                                    BLAutoGenNewRec."Item Color No." := BOMLine2Rec."Item Color No.";
                                                                    BLAutoGenNewRec."Item Color Name" := BOMLine2Rec."Item Color Name.";
                                                                    BLAutoGenNewRec."GMT Size Name" := BOMLine2Rec."GMR Size Name";
                                                                    BLAutoGenNewRec."Country No." := BOMLine2Rec."Country Code";
                                                                    BLAutoGenNewRec."Country Name" := BOMLine2Rec."Country Name";
                                                                    BLAutoGenNewRec.PO := BOMPOSelecRec."PO No.";
                                                                    BLAutoGenNewRec."Lot No." := BOMPOSelecRec."lot No.";
                                                                    BLAutoGenNewRec."GMT Qty" := Total;

                                                                    if BLERec.Type = BLERec.Type::Pcs then
                                                                        Requirment := (BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100
                                                                    else
                                                                        if BLERec.Type = BLERec.Type::Doz then
                                                                            Requirment := ((BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100) / 12;

                                                                    if (ConvFactor <> 0) then
                                                                        Requirment := Requirment / ConvFactor;

                                                                    //Requirment := Round(Requirment, 1);

                                                                    if Requirment < 0 then
                                                                        Requirment := 1;

                                                                    Value := Requirment * BLERec.Rate;

                                                                    BLAutoGenNewRec.Requirment := Requirment;
                                                                    BLAutoGenNewRec.Value := Value;

                                                                    BLAutoGenNewRec.Insert();

                                                                    //Insert into AutoGenPRBOM
                                                                    InsertAutoGenProdBOM(BLERec."Item No.", LineNo);

                                                                    Total := 0;
                                                                end;
                                                            end;

                                                        end;

                                                    until BOMLine4Rec.Next() = 0;
                                                end;
                                            until BOMPOSelecRec.Next() = 0;
                                        end;
                                    until BOMLine2Rec.Next() = 0;
                                end;
                            end;

                            //Color and PO
                            if BLERec."Color Sensitive" and not BLERec."Size Sensitive" and not BLERec."Country Sensitive" and BLERec."PO Sensitive" then begin

                                //color filter
                                BOMLine1Rec.Reset();
                                BOMLine1Rec.SetRange("No.", rec."No");
                                BOMLine1Rec.SetRange(Type, 1);
                                BOMLine1Rec.SetRange("Item No.", BLERec."Item No.");
                                BOMLine1Rec.SetRange(Placement, BLERec."Placement of GMT");
                                BOMLine1Rec.SetFilter(Select, '=%1', true);

                                if BOMLine1Rec.FindSet() then begin

                                    repeat

                                        //PO filter
                                        BOMPOSelecRec.Reset();
                                        BOMPOSelecRec.SetRange("BOM No.", rec."No");
                                        BOMPOSelecRec.SetRange(Selection, true);

                                        if BOMPOSelecRec.FindSet() then begin

                                            repeat

                                                //Item po filter
                                                BOMLine4Rec.Reset();
                                                BOMLine4Rec.SetRange("No.", rec."No");
                                                BOMLine4Rec.SetRange(Type, 4);
                                                BOMLine4Rec.SetRange("Item No.", BOMLine1Rec."Item No.");
                                                BOMLine4Rec.SetRange(Placement, BOMLine1Rec."Placement");
                                                BOMLine4Rec.SetRange("lot No.", BOMPOSelecRec."lot No.");
                                                BOMLine4Rec.SetRange(Select, true);

                                                if BOMLine4Rec.FindSet() then begin

                                                    repeat

                                                        //Insert new line
                                                        AssortDetailsRec.Reset();
                                                        AssortDetailsRec.SetRange("Style No.", rec."Style No.");
                                                        AssortDetailsRec.SetRange("lot No.", BOMPOSelecRec."lot No.");
                                                        AssortDetailsRec.SetRange("Colour No", BOMLine1Rec."GMT Color No.");

                                                        if AssortDetailsRec.FindSet() then begin
                                                            //Message(Format(Total));
                                                            repeat

                                                                if AssortDetailsRec."Colour No" <> '*' then begin
                                                                    Total += AssortDetailsRec.Total;
                                                                end;

                                                            until AssortDetailsRec.Next() = 0;

                                                        end;

                                                        LineNo += 1;
                                                        Value := 0;
                                                        Requirment := 0;

                                                        UOMRec.Reset();
                                                        UOMRec.SetRange(Code, BLERec."Unit N0.");
                                                        UOMRec.FindSet();
                                                        ConvFactor := UOMRec."Converion Parameter";

                                                        //Check whether already "po raised"items are there, then do not insert
                                                        BLAutoGenNewRec.Reset();
                                                        BLAutoGenNewRec.SetRange("No.", rec."No");
                                                        BLAutoGenNewRec.SetRange("Item No.", BLERec."Item No.");
                                                        BLAutoGenNewRec.SetRange("Placement of GMT", BLERec."Placement of GMT");
                                                        BLAutoGenNewRec.SetRange("GMT Color No.", BOMLine1Rec."GMT Color No.");
                                                        //BLAutoGenNewRec.SetRange("Item Color No.", BOMLine1Rec."Item Color No.");
                                                        BLAutoGenNewRec.SetRange("GMT Size Name", BOMLine1Rec."GMR Size Name");
                                                        BLAutoGenNewRec.SetRange("Country No.", BOMLine1Rec."Country Code");
                                                        BLAutoGenNewRec.SetRange(PO, BOMPOSelecRec."PO No.");
                                                        BLAutoGenNewRec.SetRange("Lot No.", BOMPOSelecRec."Lot No.");
                                                        BLAutoGenNewRec.SetRange("Article No.", BLERec."Article No.");
                                                        BLAutoGenNewRec.SetRange("Dimension No.", BLERec."Dimension No.");
                                                        BLAutoGenNewRec.SetRange("Supplier No.", BLERec."Supplier No.");

                                                        if Not BLAutoGenNewRec.FindSet() then begin
                                                            if Total <> 0 then begin

                                                                BLAutoGenNewRec.Init();
                                                                BLAutoGenNewRec."No." := rec."No";
                                                                BLAutoGenNewRec."Item No." := BLERec."Item No.";
                                                                BLAutoGenNewRec."Item Name" := BLERec."Item Name";
                                                                BLAutoGenNewRec."Line No." := LineNo;
                                                                BLAutoGenNewRec."Main Category No." := BLERec."Main Category No.";
                                                                BLAutoGenNewRec."Main Category Name" := BLERec."Main Category Name";
                                                                BLAutoGenNewRec."Sub Category No." := SubCat;
                                                                BLAutoGenNewRec."Sub Category Name" := SubCatDesc;
                                                                BLAutoGenNewRec."Article No." := BLERec."Article No.";
                                                                BLAutoGenNewRec."Article Name." := BLERec."Article Name.";
                                                                BLAutoGenNewRec."Dimension No." := BLERec."Dimension No.";
                                                                BLAutoGenNewRec."Dimension Name." := BLERec."Dimension Name.";
                                                                BLAutoGenNewRec."Unit N0." := BLERec."Unit N0.";
                                                                BLAutoGenNewRec.Type := BLERec.Type;
                                                                BLAutoGenNewRec.Consumption := BLERec.Consumption;
                                                                BLAutoGenNewRec.WST := BLERec.WST;
                                                                BLAutoGenNewRec.Rate := BLERec.Rate;
                                                                BLAutoGenNewRec."Supplier No." := BLERec."Supplier No.";
                                                                BLAutoGenNewRec."Supplier Name." := BLERec."Supplier Name.";
                                                                BLAutoGenNewRec.AjstReq := BLERec.AjstReq;
                                                                BLAutoGenNewRec.Qty := BLERec.Qty;
                                                                BLAutoGenNewRec."Created User" := UserId;
                                                                BLAutoGenNewRec."Created Date" := WorkDate();
                                                                BLAutoGenNewRec."Stock Bal" := BLERec."Stock Bal";
                                                                BLAutoGenNewRec."Size Sensitive" := false;
                                                                BLAutoGenNewRec."Color Sensitive" := false;
                                                                BLAutoGenNewRec."Country Sensitive" := false;
                                                                BLAutoGenNewRec."PO Sensitive" := false;
                                                                BLAutoGenNewRec.Reconfirm := false;
                                                                BLAutoGenNewRec."Placement of GMT" := BLERec."Placement of GMT";
                                                                BLAutoGenNewRec."GMT Color No." := BOMLine1Rec."GMT Color No.";
                                                                BLAutoGenNewRec."GMT Color Name" := BOMLine1Rec."GMT Color Name.";
                                                                BLAutoGenNewRec."Item Color No." := BOMLine1Rec."Item Color No.";
                                                                BLAutoGenNewRec."Item Color Name" := BOMLine1Rec."Item Color Name.";
                                                                BLAutoGenNewRec."GMT Size Name" := BOMLine1Rec."GMR Size Name";
                                                                BLAutoGenNewRec."Country No." := BOMLine1Rec."Country Code";
                                                                BLAutoGenNewRec."Country Name" := BOMLine1Rec."Country Name";
                                                                BLAutoGenNewRec.PO := BOMPOSelecRec."PO No.";
                                                                BLAutoGenNewRec."Lot No." := BOMPOSelecRec."lot No.";
                                                                BLAutoGenNewRec."GMT Qty" := Total;

                                                                if BLERec.Type = BLERec.Type::Pcs then
                                                                    Requirment := (BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100
                                                                else
                                                                    if BLERec.Type = BLERec.Type::Doz then
                                                                        Requirment := ((BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100) / 12;

                                                                if (ConvFactor <> 0) then
                                                                    Requirment := Requirment / ConvFactor;

                                                                //Requirment := Round(Requirment, 1);

                                                                if Requirment < 0 then
                                                                    Requirment := 1;

                                                                Value := Requirment * BLERec.Rate;

                                                                BLAutoGenNewRec.Requirment := Requirment;
                                                                BLAutoGenNewRec.Value := Value;

                                                                BLAutoGenNewRec.Insert();

                                                                //Insert into AutoGenPRBOM
                                                                InsertAutoGenProdBOM(BLERec."Item No.", LineNo);

                                                                Total := 0;
                                                            end;
                                                        end;

                                                    until BOMLine4Rec.Next() = 0;
                                                end;

                                            until BOMPOSelecRec.Next() = 0;
                                        end;
                                    until BOMLine1Rec.Next() = 0;
                                end;
                            end;

                            //Color,size and PO
                            if BLERec."Color Sensitive" and BLERec."Size Sensitive" and not BLERec."Country Sensitive" and BLERec."PO Sensitive" then begin

                                //color filter
                                BOMLine1Rec.Reset();
                                BOMLine1Rec.SetRange("No.", rec."No");
                                BOMLine1Rec.SetRange(Type, 1);
                                BOMLine1Rec.SetRange("Item No.", BLERec."Item No.");
                                BOMLine1Rec.SetRange(Placement, BLERec."Placement of GMT");
                                BOMLine1Rec.SetFilter(Select, '=%1', true);

                                if BOMLine1Rec.FindSet() then begin

                                    repeat

                                        //Size filter
                                        BOMLine2Rec.Reset();
                                        BOMLine2Rec.SetRange("No.", rec."No");
                                        BOMLine2Rec.SetRange(Type, 2);
                                        BOMLine2Rec.SetRange("Item No.", BOMLine1Rec."Item No.");
                                        BOMLine2Rec.SetRange(Placement, BOMLine1Rec."Placement");
                                        BOMLine2Rec.SetFilter(Select, '=%1', true);

                                        if BOMLine2Rec.FindSet() then begin

                                            repeat

                                                //PO filter
                                                BOMPOSelecRec.Reset();
                                                BOMPOSelecRec.SetRange("BOM No.", rec."No");
                                                BOMPOSelecRec.SetRange(Selection, true);

                                                if BOMPOSelecRec.FindSet() then begin

                                                    repeat

                                                        //Item po filter
                                                        BOMLine4Rec.Reset();
                                                        BOMLine4Rec.SetRange("No.", rec."No");
                                                        BOMLine4Rec.SetRange(Type, 4);
                                                        BOMLine4Rec.SetRange("Item No.", BOMLine1Rec."Item No.");
                                                        BOMLine4Rec.SetRange(Placement, BOMLine1Rec."Placement");
                                                        BOMLine4Rec.SetRange("lot No.", BOMPOSelecRec."lot No.");
                                                        BOMLine4Rec.SetRange(Select, true);

                                                        if BOMLine4Rec.FindSet() then begin

                                                            repeat

                                                                //Insert new line
                                                                AssortDetailsRec.Reset();
                                                                AssortDetailsRec.SetRange("Style No.", rec."Style No.");
                                                                AssortDetailsRec.SetRange("lot No.", BOMLine4Rec."lot No.");
                                                                AssortDetailsRec.SetRange("Colour No", BOMLine1Rec."GMT Color No.");

                                                                if AssortDetailsRec.FindSet() then begin

                                                                    repeat

                                                                        //Find the correct column for the GMT size
                                                                        AssortDetails1Rec.Reset();
                                                                        AssortDetails1Rec.SetRange("Style No.", rec."Style No.");
                                                                        AssortDetails1Rec.SetRange("lot No.", BOMLine4Rec."lot No.");
                                                                        AssortDetails1Rec.SetRange("Colour No", '*');

                                                                        AssortDetails1Rec.FindSet();

                                                                        FOR Count := 1 TO 64 DO begin
                                                                            case Count of
                                                                                1:
                                                                                    if AssortDetails1Rec."1" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."1");
                                                                                        break;
                                                                                    end;
                                                                                2:
                                                                                    if AssortDetails1Rec."2" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."2");
                                                                                        break;
                                                                                    end;
                                                                                3:
                                                                                    if AssortDetails1Rec."3" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."3");
                                                                                        break;
                                                                                    end;
                                                                                4:
                                                                                    if AssortDetails1Rec."4" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."4");
                                                                                        break;
                                                                                    end;
                                                                                5:
                                                                                    if AssortDetails1Rec."5" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."5");
                                                                                        break;
                                                                                    end;
                                                                                6:
                                                                                    if AssortDetails1Rec."6" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."6");
                                                                                        break;
                                                                                    end;
                                                                                7:
                                                                                    if AssortDetails1Rec."7" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."7");
                                                                                        break;
                                                                                    end;
                                                                                8:
                                                                                    if AssortDetails1Rec."8" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."8");
                                                                                        break;
                                                                                    end;
                                                                                9:
                                                                                    if AssortDetails1Rec."9" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."9");
                                                                                        break;
                                                                                    end;
                                                                                10:
                                                                                    if AssortDetails1Rec."10" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."10");
                                                                                        break;
                                                                                    end;
                                                                                11:
                                                                                    if AssortDetails1Rec."11" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."11");
                                                                                        break;
                                                                                    end;
                                                                                12:
                                                                                    if AssortDetails1Rec."12" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."12");
                                                                                        break;
                                                                                    end;
                                                                                13:
                                                                                    if AssortDetails1Rec."13" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."13");
                                                                                        break;
                                                                                    end;
                                                                                14:
                                                                                    if AssortDetails1Rec."14" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."14");
                                                                                        break;
                                                                                    end;
                                                                                15:
                                                                                    if AssortDetails1Rec."15" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."15");
                                                                                        break;
                                                                                    end;
                                                                                16:
                                                                                    if AssortDetails1Rec."16" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."16");
                                                                                        break;
                                                                                    end;
                                                                                17:
                                                                                    if AssortDetails1Rec."17" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."17");
                                                                                        break;
                                                                                    end;
                                                                                18:
                                                                                    if AssortDetails1Rec."18" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."18");
                                                                                        break;
                                                                                    end;
                                                                                19:
                                                                                    if AssortDetails1Rec."19" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."19");
                                                                                        break;
                                                                                    end;
                                                                                20:
                                                                                    if AssortDetails1Rec."20" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."20");
                                                                                        break;
                                                                                    end;
                                                                                21:
                                                                                    if AssortDetails1Rec."21" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."21");
                                                                                        break;
                                                                                    end;
                                                                                22:
                                                                                    if AssortDetails1Rec."22" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."22");
                                                                                        break;
                                                                                    end;
                                                                                23:
                                                                                    if AssortDetails1Rec."23" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."23");
                                                                                        break;
                                                                                    end;
                                                                                24:
                                                                                    if AssortDetails1Rec."24" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."24");
                                                                                        break;
                                                                                    end;
                                                                                25:
                                                                                    if AssortDetails1Rec."25" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."25");
                                                                                        break;
                                                                                    end;
                                                                                26:
                                                                                    if AssortDetails1Rec."26" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."26");
                                                                                        break;
                                                                                    end;
                                                                                27:
                                                                                    if AssortDetails1Rec."27" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."27");
                                                                                        break;
                                                                                    end;
                                                                                28:
                                                                                    if AssortDetails1Rec."28" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."28");
                                                                                        break;
                                                                                    end;
                                                                                29:
                                                                                    if AssortDetails1Rec."29" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."29");
                                                                                        break;
                                                                                    end;
                                                                                30:
                                                                                    if AssortDetails1Rec."30" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."30");
                                                                                        break;
                                                                                    end;
                                                                                31:
                                                                                    if AssortDetails1Rec."31" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."31");
                                                                                        break;
                                                                                    end;
                                                                                32:
                                                                                    if AssortDetails1Rec."32" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."32");
                                                                                        break;
                                                                                    end;
                                                                                33:
                                                                                    if AssortDetails1Rec."33" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."33");
                                                                                        break;
                                                                                    end;
                                                                                34:
                                                                                    if AssortDetails1Rec."34" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."34");
                                                                                        break;
                                                                                    end;
                                                                                35:
                                                                                    if AssortDetails1Rec."35" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."35");
                                                                                        break;
                                                                                    end;
                                                                                36:
                                                                                    if AssortDetails1Rec."36" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."36");
                                                                                        break;
                                                                                    end;
                                                                                37:
                                                                                    if AssortDetails1Rec."37" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."37");
                                                                                        break;
                                                                                    end;
                                                                                38:
                                                                                    if AssortDetails1Rec."38" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."38");
                                                                                        break;
                                                                                    end;
                                                                                39:
                                                                                    if AssortDetails1Rec."39" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."39");
                                                                                        break;
                                                                                    end;
                                                                                40:
                                                                                    if AssortDetails1Rec."40" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."40");
                                                                                        break;
                                                                                    end;
                                                                                41:
                                                                                    if AssortDetails1Rec."41" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."41");
                                                                                        break;
                                                                                    end;
                                                                                42:
                                                                                    if AssortDetails1Rec."42" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."42");
                                                                                        break;
                                                                                    end;
                                                                                43:
                                                                                    if AssortDetails1Rec."43" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."43");
                                                                                        break;
                                                                                    end;
                                                                                44:
                                                                                    if AssortDetails1Rec."44" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."44");
                                                                                        break;
                                                                                    end;
                                                                                45:
                                                                                    if AssortDetails1Rec."45" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."45");
                                                                                        break;
                                                                                    end;
                                                                                46:
                                                                                    if AssortDetails1Rec."46" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."46");
                                                                                        break;
                                                                                    end;
                                                                                47:
                                                                                    if AssortDetails1Rec."47" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."47");
                                                                                        break;
                                                                                    end;
                                                                                48:
                                                                                    if AssortDetails1Rec."48" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."48");
                                                                                        break;
                                                                                    end;
                                                                                49:
                                                                                    if AssortDetails1Rec."49" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."49");
                                                                                        break;
                                                                                    end;
                                                                                50:
                                                                                    if AssortDetails1Rec."50" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."50");
                                                                                        break;
                                                                                    end;
                                                                                51:
                                                                                    if AssortDetails1Rec."51" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."51");
                                                                                        break;
                                                                                    end;
                                                                                52:
                                                                                    if AssortDetails1Rec."52" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."52");
                                                                                        break;
                                                                                    end;
                                                                                53:
                                                                                    if AssortDetails1Rec."53" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."53");
                                                                                        break;
                                                                                    end;
                                                                                54:
                                                                                    if AssortDetails1Rec."54" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."54");
                                                                                        break;
                                                                                    end;
                                                                                55:
                                                                                    if AssortDetails1Rec."55" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."55");
                                                                                        break;
                                                                                    end;
                                                                                56:
                                                                                    if AssortDetails1Rec."56" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."56");
                                                                                        break;
                                                                                    end;
                                                                                57:
                                                                                    if AssortDetails1Rec."57" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."57");
                                                                                        break;
                                                                                    end;
                                                                                58:
                                                                                    if AssortDetails1Rec."58" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."58");
                                                                                        break;
                                                                                    end;
                                                                                59:
                                                                                    if AssortDetails1Rec."59" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."59");
                                                                                        break;
                                                                                    end;
                                                                                60:
                                                                                    if AssortDetails1Rec."60" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."60");
                                                                                        break;
                                                                                    end;
                                                                                61:
                                                                                    if AssortDetails1Rec."61" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."61");
                                                                                        break;
                                                                                    end;
                                                                                62:
                                                                                    if AssortDetails1Rec."62" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."62");
                                                                                        break;
                                                                                    end;
                                                                                63:
                                                                                    if AssortDetails1Rec."63" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."63");
                                                                                        break;
                                                                                    end;
                                                                                64:
                                                                                    if AssortDetails1Rec."64" = BOMLine2Rec."GMR Size Name" then begin
                                                                                        Evaluate(SubTotal, AssortDetailsRec."64");
                                                                                        break;
                                                                                    end;
                                                                            end;
                                                                        end;
                                                                        Total += SubTotal;

                                                                    until AssortDetailsRec.Next() = 0;
                                                                end;

                                                                LineNo += 1;
                                                                Value := 0;
                                                                Requirment := 0;

                                                                UOMRec.Reset();
                                                                UOMRec.SetRange(Code, BLERec."Unit N0.");
                                                                UOMRec.FindSet();
                                                                ConvFactor := UOMRec."Converion Parameter";

                                                                //Check whether already "po raised"items are there, then do not insert
                                                                BLAutoGenNewRec.Reset();
                                                                BLAutoGenNewRec.SetRange("No.", rec."No");
                                                                BLAutoGenNewRec.SetRange("Item No.", BLERec."Item No.");
                                                                BLAutoGenNewRec.SetRange("Placement of GMT", BLERec."Placement of GMT");
                                                                BLAutoGenNewRec.SetRange("GMT Color No.", BOMLine1Rec."GMT Color No.");
                                                                //BLAutoGenNewRec.SetRange("Item Color No.", BOMLine1Rec."Item Color No.");
                                                                BLAutoGenNewRec.SetRange("GMT Size Name", BOMLine2Rec."GMR Size Name");
                                                                BLAutoGenNewRec.SetRange("Country No.", BOMLine1Rec."Country Code");
                                                                BLAutoGenNewRec.SetRange(PO, BOMLine4Rec."PO No.");
                                                                BLAutoGenNewRec.SetRange("Lot No.", BOMLine4Rec."Lot No.");
                                                                BLAutoGenNewRec.SetRange("Article No.", BLERec."Article No.");
                                                                BLAutoGenNewRec.SetRange("Dimension No.", BOMLine2Rec."Dimension No.");
                                                                BLAutoGenNewRec.SetRange("Supplier No.", BLERec."Supplier No.");

                                                                if Not BLAutoGenNewRec.FindSet() then begin
                                                                    if Total <> 0 then begin

                                                                        BLAutoGenNewRec.Init();
                                                                        BLAutoGenNewRec."No." := rec."No";
                                                                        BLAutoGenNewRec."Item No." := BLERec."Item No.";
                                                                        BLAutoGenNewRec."Item Name" := BLERec."Item Name";
                                                                        BLAutoGenNewRec."Line No." := LineNo;
                                                                        BLAutoGenNewRec."Main Category No." := BLERec."Main Category No.";
                                                                        BLAutoGenNewRec."Main Category Name" := BLERec."Main Category Name";
                                                                        BLAutoGenNewRec."Sub Category No." := SubCat;
                                                                        BLAutoGenNewRec."Sub Category Name" := SubCatDesc;
                                                                        BLAutoGenNewRec."Article No." := BLERec."Article No.";
                                                                        BLAutoGenNewRec."Article Name." := BLERec."Article Name.";
                                                                        BLAutoGenNewRec."Dimension No." := BOMLine2Rec."Dimension No.";
                                                                        BLAutoGenNewRec."Dimension Name." := BOMLine2Rec."Dimension Name";
                                                                        BLAutoGenNewRec."Unit N0." := BLERec."Unit N0.";
                                                                        BLAutoGenNewRec.Type := BLERec.Type;
                                                                        BLAutoGenNewRec.Consumption := BLERec.Consumption;
                                                                        BLAutoGenNewRec.WST := BLERec.WST;
                                                                        BLAutoGenNewRec.Rate := BLERec.Rate;
                                                                        BLAutoGenNewRec."Supplier No." := BLERec."Supplier No.";
                                                                        BLAutoGenNewRec."Supplier Name." := BLERec."Supplier Name.";
                                                                        BLAutoGenNewRec.AjstReq := BLERec.AjstReq;
                                                                        BLAutoGenNewRec.Qty := BLERec.Qty;
                                                                        BLAutoGenNewRec."Created User" := UserId;
                                                                        BLAutoGenNewRec."Created Date" := WorkDate();
                                                                        BLAutoGenNewRec."Stock Bal" := BLERec."Stock Bal";
                                                                        BLAutoGenNewRec."Size Sensitive" := false;
                                                                        BLAutoGenNewRec."Color Sensitive" := false;
                                                                        BLAutoGenNewRec."Country Sensitive" := false;
                                                                        BLAutoGenNewRec."PO Sensitive" := false;
                                                                        BLAutoGenNewRec.Reconfirm := false;
                                                                        BLAutoGenNewRec."Placement of GMT" := BLERec."Placement of GMT";
                                                                        BLAutoGenNewRec."GMT Color No." := BOMLine1Rec."GMT Color No.";
                                                                        BLAutoGenNewRec."GMT Color Name" := BOMLine1Rec."GMT Color Name.";
                                                                        BLAutoGenNewRec."Item Color No." := BOMLine1Rec."Item Color No.";
                                                                        BLAutoGenNewRec."Item Color Name" := BOMLine1Rec."Item Color Name.";
                                                                        BLAutoGenNewRec."GMT Size Name" := BOMLine2Rec."GMR Size Name";
                                                                        BLAutoGenNewRec."Country No." := BOMLine1Rec."Country Code";
                                                                        BLAutoGenNewRec."Country Name" := BOMLine1Rec."Country Name";
                                                                        BLAutoGenNewRec.PO := BOMLine4Rec."PO No.";
                                                                        BLAutoGenNewRec."Lot No." := BOMLine4Rec."lot No.";
                                                                        BLAutoGenNewRec."GMT Qty" := Total;

                                                                        if BLERec.Type = BLERec.Type::Pcs then
                                                                            Requirment := (BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100
                                                                        else
                                                                            if BLERec.Type = BLERec.Type::Doz then
                                                                                Requirment := ((BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100) / 12;

                                                                        if (ConvFactor <> 0) then
                                                                            Requirment := Requirment / ConvFactor;

                                                                        //Requirment := Round(Requirment, 1);

                                                                        if Requirment < 0 then
                                                                            Requirment := 1;

                                                                        Value := Requirment * BLERec.Rate;

                                                                        BLAutoGenNewRec.Requirment := Requirment;
                                                                        BLAutoGenNewRec.Value := Value;

                                                                        BLAutoGenNewRec.Insert();

                                                                        //Insert into AutoGenPRBOM
                                                                        InsertAutoGenProdBOM(BLERec."Item No.", LineNo);

                                                                        Total := 0;
                                                                    end;
                                                                end;

                                                            until BOMLine4Rec.Next() = 0;
                                                        end;
                                                    until BOMPOSelecRec.Next() = 0;
                                                end;
                                            until BOMLine2Rec.Next() = 0;
                                        end;
                                    until BOMLine1Rec.Next() = 0;
                                end;
                            end;

                            //Color,country and PO
                            if BLERec."Color Sensitive" and not BLERec."Size Sensitive" and BLERec."Country Sensitive" and BLERec."PO Sensitive" then begin

                                //color filter
                                BOMLine1Rec.Reset();
                                BOMLine1Rec.SetRange("No.", rec."No");
                                BOMLine1Rec.SetRange(Type, 1);
                                BOMLine1Rec.SetRange("Item No.", BLERec."Item No.");
                                BOMLine1Rec.SetRange(Placement, BLERec."Placement of GMT");
                                BOMLine1Rec.SetFilter(Select, '=%1', true);

                                if BOMLine1Rec.FindSet() then begin

                                    repeat

                                        //Country filter
                                        BOMLine3Rec.Reset();
                                        BOMLine3Rec.SetRange("No.", rec."No");
                                        BOMLine3Rec.SetRange(Type, 3);
                                        BOMLine3Rec.SetRange("Item No.", BLERec."Item No.");
                                        BOMLine3Rec.SetRange(Placement, BLERec."Placement of GMT");
                                        BOMLine3Rec.SetRange(Select, true);
                                        BOMLine3Rec.SetFilter(Select, '=%1', true);

                                        if BOMLine3Rec.FindSet() then begin

                                            repeat

                                                //PO filter
                                                BOMPOSelecRec.Reset();
                                                BOMPOSelecRec.SetRange("BOM No.", rec."No");
                                                BOMPOSelecRec.SetRange(Selection, true);

                                                if BOMPOSelecRec.FindSet() then begin

                                                    repeat

                                                        //Item po filter
                                                        BOMLine4Rec.Reset();
                                                        BOMLine4Rec.SetRange("No.", rec."No");
                                                        BOMLine4Rec.SetRange(Type, 4);
                                                        BOMLine4Rec.SetRange("Item No.", BOMLine1Rec."Item No.");
                                                        BOMLine4Rec.SetRange(Placement, BOMLine1Rec."Placement");
                                                        BOMLine4Rec.SetRange("lot No.", BOMPOSelecRec."lot No.");
                                                        BOMLine4Rec.SetRange(Select, true);

                                                        if BOMLine4Rec.FindSet() then begin

                                                            repeat

                                                                //Insert new line
                                                                AssortDetailsRec.Reset();
                                                                AssortDetailsRec.SetRange("Style No.", rec."Style No.");
                                                                AssortDetailsRec.SetRange("lot No.", BOMPOSelecRec."lot No.");
                                                                AssortDetailsRec.SetRange("Colour No", BOMLine1Rec."GMT Color No.");
                                                                AssortDetailsRec.SetRange("Country Code", BOMLine3Rec."Country Code");

                                                                if AssortDetailsRec.FindSet() then begin

                                                                    repeat

                                                                        if AssortDetailsRec."Colour No" <> '*' then begin
                                                                            Total += AssortDetailsRec.Total;
                                                                        end;

                                                                    until AssortDetailsRec.Next() = 0;

                                                                end;

                                                                LineNo += 1;
                                                                Value := 0;
                                                                Requirment := 0;

                                                                UOMRec.Reset();
                                                                UOMRec.SetRange(Code, BLERec."Unit N0.");
                                                                UOMRec.FindSet();
                                                                ConvFactor := UOMRec."Converion Parameter";

                                                                //Check whether already "po raised"items are there, then do not insert
                                                                BLAutoGenNewRec.Reset();
                                                                BLAutoGenNewRec.SetRange("No.", rec."No");
                                                                BLAutoGenNewRec.SetRange("Item No.", BLERec."Item No.");
                                                                BLAutoGenNewRec.SetRange("Placement of GMT", BLERec."Placement of GMT");
                                                                BLAutoGenNewRec.SetRange("GMT Color No.", BOMLine1Rec."GMT Color No.");
                                                                //BLAutoGenNewRec.SetRange("Item Color No.", BOMLine1Rec."Item Color No.");
                                                                BLAutoGenNewRec.SetRange("GMT Size Name", BOMLine1Rec."GMR Size Name");
                                                                BLAutoGenNewRec.SetRange("Country No.", BOMLine3Rec."Country Code");
                                                                BLAutoGenNewRec.SetRange(PO, BOMPOSelecRec."PO No.");
                                                                BLAutoGenNewRec.SetRange("Lot No.", BOMPOSelecRec."Lot No.");
                                                                BLAutoGenNewRec.SetRange("Article No.", BLERec."Article No.");
                                                                BLAutoGenNewRec.SetRange("Dimension No.", BLERec."Dimension No.");
                                                                BLAutoGenNewRec.SetRange("Supplier No.", BLERec."Supplier No.");

                                                                if Not BLAutoGenNewRec.FindSet() then begin
                                                                    if Total <> 0 then begin

                                                                        BLAutoGenNewRec.Init();
                                                                        BLAutoGenNewRec."No." := rec."No";
                                                                        BLAutoGenNewRec."Item No." := BLERec."Item No.";
                                                                        BLAutoGenNewRec."Item Name" := BLERec."Item Name";
                                                                        BLAutoGenNewRec."Line No." := LineNo;
                                                                        BLAutoGenNewRec."Main Category No." := BLERec."Main Category No.";
                                                                        BLAutoGenNewRec."Main Category Name" := BLERec."Main Category Name";
                                                                        BLAutoGenNewRec."Sub Category No." := SubCat;
                                                                        BLAutoGenNewRec."Sub Category Name" := SubCatDesc;
                                                                        BLAutoGenNewRec."Article No." := BLERec."Article No.";
                                                                        BLAutoGenNewRec."Article Name." := BLERec."Article Name.";
                                                                        BLAutoGenNewRec."Dimension No." := BLERec."Dimension No.";
                                                                        BLAutoGenNewRec."Dimension Name." := BLERec."Dimension Name.";
                                                                        BLAutoGenNewRec."Unit N0." := BLERec."Unit N0.";
                                                                        BLAutoGenNewRec.Type := BLERec.Type;
                                                                        BLAutoGenNewRec.Consumption := BLERec.Consumption;
                                                                        BLAutoGenNewRec.WST := BLERec.WST;
                                                                        BLAutoGenNewRec.Rate := BLERec.Rate;
                                                                        BLAutoGenNewRec."Supplier No." := BLERec."Supplier No.";
                                                                        BLAutoGenNewRec."Supplier Name." := BLERec."Supplier Name.";
                                                                        BLAutoGenNewRec.AjstReq := BLERec.AjstReq;
                                                                        BLAutoGenNewRec.Qty := BLERec.Qty;
                                                                        BLAutoGenNewRec."Created User" := UserId;
                                                                        BLAutoGenNewRec."Created Date" := WorkDate();
                                                                        BLAutoGenNewRec."Stock Bal" := BLERec."Stock Bal";
                                                                        BLAutoGenNewRec."Size Sensitive" := false;
                                                                        BLAutoGenNewRec."Color Sensitive" := false;
                                                                        BLAutoGenNewRec."Country Sensitive" := false;
                                                                        BLAutoGenNewRec."PO Sensitive" := false;
                                                                        BLAutoGenNewRec.Reconfirm := false;
                                                                        BLAutoGenNewRec."Placement of GMT" := BLERec."Placement of GMT";
                                                                        BLAutoGenNewRec."GMT Color No." := BOMLine1Rec."GMT Color No.";
                                                                        BLAutoGenNewRec."GMT Color Name" := BOMLine1Rec."GMT Color Name.";
                                                                        BLAutoGenNewRec."Item Color No." := BOMLine1Rec."Item Color No.";
                                                                        BLAutoGenNewRec."Item Color Name" := BOMLine1Rec."Item Color Name.";
                                                                        BLAutoGenNewRec."GMT Size Name" := BOMLine1Rec."GMR Size Name";
                                                                        BLAutoGenNewRec."Country No." := BOMLine3Rec."Country Code";
                                                                        BLAutoGenNewRec."Country Name" := BOMLine3Rec."Country Name";
                                                                        BLAutoGenNewRec.PO := BOMPOSelecRec."PO No.";
                                                                        BLAutoGenNewRec."Lot No." := BOMPOSelecRec."lot No.";
                                                                        BLAutoGenNewRec."GMT Qty" := Total;

                                                                        if BLERec.Type = BLERec.Type::Pcs then
                                                                            Requirment := (BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100
                                                                        else
                                                                            if BLERec.Type = BLERec.Type::Doz then
                                                                                Requirment := ((BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100) / 12;

                                                                        if (ConvFactor <> 0) then
                                                                            Requirment := Requirment / ConvFactor;

                                                                        //Requirment := Round(Requirment, 1);

                                                                        if Requirment < 0 then
                                                                            Requirment := 1;

                                                                        Value := Requirment * BLERec.Rate;

                                                                        BLAutoGenNewRec.Requirment := Requirment;
                                                                        BLAutoGenNewRec.Value := Value;

                                                                        BLAutoGenNewRec.Insert();

                                                                        //Insert into AutoGenPRBOM
                                                                        InsertAutoGenProdBOM(BLERec."Item No.", LineNo);

                                                                        Total := 0;
                                                                    end;
                                                                end;

                                                            until BOMLine4Rec.Next() = 0;
                                                        end;
                                                    until BOMPOSelecRec.Next() = 0;
                                                end;

                                            until BOMLine3Rec.Next() = 0;
                                        end;

                                    until BOMLine1Rec.Next() = 0;
                                end;
                            end;

                            //country and PO
                            if not BLERec."Color Sensitive" and not BLERec."Size Sensitive" and BLERec."Country Sensitive" and BLERec."PO Sensitive" then begin

                                //Country filter
                                BOMLine3Rec.Reset();
                                BOMLine3Rec.SetRange("No.", rec."No");
                                BOMLine3Rec.SetRange(Type, 3);
                                BOMLine3Rec.SetRange("Item No.", BLERec."Item No.");
                                BOMLine3Rec.SetRange(Placement, BLERec."Placement of GMT");
                                BOMLine3Rec.SetRange(Select, true);

                                if BOMLine3Rec.FindSet() then begin

                                    repeat

                                        //PO filter
                                        BOMPOSelecRec.Reset();
                                        BOMPOSelecRec.SetRange("BOM No.", rec."No");
                                        BOMPOSelecRec.SetRange(Selection, true);

                                        if BOMPOSelecRec.FindSet() then begin

                                            repeat

                                                //Item po filter
                                                BOMLine4Rec.Reset();
                                                BOMLine4Rec.SetRange("No.", rec."No");
                                                BOMLine4Rec.SetRange(Type, 4);
                                                BOMLine4Rec.SetRange("Item No.", BLERec."Item No.");
                                                BOMLine4Rec.SetRange(Placement, BLERec."Placement of GMT");
                                                BOMLine4Rec.SetRange("lot No.", BOMPOSelecRec."lot No.");
                                                BOMLine4Rec.SetRange(Select, true);

                                                if BOMLine4Rec.FindSet() then begin

                                                    repeat

                                                        //Insert new line
                                                        AssortDetailsRec.Reset();
                                                        AssortDetailsRec.SetRange("Style No.", rec."Style No.");
                                                        AssortDetailsRec.SetRange("lot No.", BOMPOSelecRec."lot No.");
                                                        AssortDetailsRec.SetRange("Country Code", BOMLine3Rec."Country Code");

                                                        if AssortDetailsRec.FindSet() then begin

                                                            repeat

                                                                if AssortDetailsRec."Colour No" <> '*' then begin
                                                                    Total += AssortDetailsRec.Total;
                                                                end;

                                                            until AssortDetailsRec.Next() = 0;

                                                        end;

                                                        LineNo += 1;
                                                        Value := 0;
                                                        Requirment := 0;

                                                        UOMRec.Reset();
                                                        UOMRec.SetRange(Code, BLERec."Unit N0.");
                                                        UOMRec.FindSet();
                                                        ConvFactor := UOMRec."Converion Parameter";

                                                        //Check whether already "po raised"items are there, then do not insert
                                                        BLAutoGenNewRec.Reset();
                                                        BLAutoGenNewRec.SetRange("No.", rec."No");
                                                        BLAutoGenNewRec.SetRange("Item No.", BLERec."Item No.");
                                                        BLAutoGenNewRec.SetRange("Placement of GMT", BLERec."Placement of GMT");
                                                        BLAutoGenNewRec.SetRange("Item Color No.", BOMLine3Rec."Item Color No.");
                                                        BLAutoGenNewRec.SetRange("GMT Size Name", BOMLine3Rec."GMR Size Name");
                                                        BLAutoGenNewRec.SetRange("Country No.", BOMLine3Rec."Country Code");
                                                        BLAutoGenNewRec.SetRange(PO, BOMPOSelecRec."PO No.");
                                                        BLAutoGenNewRec.SetRange("Lot No.", BOMPOSelecRec."Lot No.");
                                                        BLAutoGenNewRec.SetRange("Article No.", BLERec."Article No.");
                                                        BLAutoGenNewRec.SetRange("Dimension No.", BLERec."Dimension No.");
                                                        BLAutoGenNewRec.SetRange("Supplier No.", BLERec."Supplier No.");

                                                        if Not BLAutoGenNewRec.FindSet() then begin
                                                            if Total <> 0 then begin

                                                                BLAutoGenNewRec.Init();
                                                                BLAutoGenNewRec."No." := rec."No";
                                                                BLAutoGenNewRec."Item No." := BLERec."Item No.";
                                                                BLAutoGenNewRec."Item Name" := BLERec."Item Name";
                                                                BLAutoGenNewRec."Line No." := LineNo;
                                                                BLAutoGenNewRec."Main Category No." := BLERec."Main Category No.";
                                                                BLAutoGenNewRec."Main Category Name" := BLERec."Main Category Name";
                                                                BLAutoGenNewRec."Sub Category No." := SubCat;
                                                                BLAutoGenNewRec."Sub Category Name" := SubCatDesc;
                                                                BLAutoGenNewRec."Article No." := BLERec."Article No.";
                                                                BLAutoGenNewRec."Article Name." := BLERec."Article Name.";
                                                                BLAutoGenNewRec."Dimension No." := BLERec."Dimension No.";
                                                                BLAutoGenNewRec."Dimension Name." := BLERec."Dimension Name.";
                                                                BLAutoGenNewRec."Unit N0." := BLERec."Unit N0.";
                                                                BLAutoGenNewRec.Type := BLERec.Type;
                                                                BLAutoGenNewRec.Consumption := BLERec.Consumption;
                                                                BLAutoGenNewRec.WST := BLERec.WST;
                                                                BLAutoGenNewRec.Rate := BLERec.Rate;
                                                                BLAutoGenNewRec."Supplier No." := BLERec."Supplier No.";
                                                                BLAutoGenNewRec."Supplier Name." := BLERec."Supplier Name.";
                                                                BLAutoGenNewRec.AjstReq := BLERec.AjstReq;
                                                                BLAutoGenNewRec.Qty := BLERec.Qty;
                                                                BLAutoGenNewRec."Created User" := UserId;
                                                                BLAutoGenNewRec."Created Date" := WorkDate();
                                                                BLAutoGenNewRec."Stock Bal" := BLERec."Stock Bal";
                                                                BLAutoGenNewRec."Size Sensitive" := false;
                                                                BLAutoGenNewRec."Color Sensitive" := false;
                                                                BLAutoGenNewRec."Country Sensitive" := false;
                                                                BLAutoGenNewRec."PO Sensitive" := false;
                                                                BLAutoGenNewRec.Reconfirm := false;
                                                                BLAutoGenNewRec."Placement of GMT" := BLERec."Placement of GMT";
                                                                BLAutoGenNewRec."GMT Color No." := BOMLine3Rec."GMT Color No.";
                                                                BLAutoGenNewRec."GMT Color Name" := BOMLine3Rec."GMT Color Name.";
                                                                BLAutoGenNewRec."Item Color No." := BOMLine3Rec."Item Color No.";
                                                                BLAutoGenNewRec."Item Color Name" := BOMLine3Rec."Item Color Name.";
                                                                BLAutoGenNewRec."GMT Size Name" := BOMLine3Rec."GMR Size Name";
                                                                BLAutoGenNewRec."Country No." := BOMLine3Rec."Country Code";
                                                                BLAutoGenNewRec."Country Name" := BOMLine3Rec."Country Name";
                                                                BLAutoGenNewRec.PO := BOMPOSelecRec."PO No.";
                                                                BLAutoGenNewRec."Lot No." := BOMPOSelecRec."lot No.";
                                                                BLAutoGenNewRec."GMT Qty" := Total;

                                                                if BLERec.Type = BLERec.Type::Pcs then
                                                                    Requirment := (BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100
                                                                else
                                                                    if BLERec.Type = BLERec.Type::Doz then
                                                                        Requirment := ((BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100) / 12;

                                                                if (ConvFactor <> 0) then
                                                                    Requirment := Requirment / ConvFactor;

                                                                //Requirment := Round(Requirment, 1);

                                                                if Requirment < 0 then
                                                                    Requirment := 1;

                                                                Value := Requirment * BLERec.Rate;

                                                                BLAutoGenNewRec.Requirment := Requirment;
                                                                BLAutoGenNewRec.Value := Value;

                                                                BLAutoGenNewRec.Insert();

                                                                //Insert into AutoGenPRBOM
                                                                InsertAutoGenProdBOM(BLERec."Item No.", LineNo);

                                                                Total := 0;
                                                            end;
                                                        end;

                                                    until BOMLine4Rec.Next() = 0;
                                                end;
                                            until BOMPOSelecRec.Next() = 0;
                                        end;

                                    until BOMLine3Rec.Next() = 0;
                                end;


                            end;

                            //Size, Country and PO
                            if not BLERec."Color Sensitive" and BLERec."Size Sensitive" and BLERec."Country Sensitive" and BLERec."PO Sensitive" then begin

                                //Size filter
                                BOMLine2Rec.Reset();
                                BOMLine2Rec.SetRange("No.", rec."No");
                                BOMLine2Rec.SetRange(Type, 2);
                                BOMLine2Rec.SetRange("Item No.", BLERec."Item No.");
                                BOMLine2Rec.SetRange(Placement, BLERec."Placement of GMT");
                                BOMLine2Rec.SetFilter(Select, '=%1', true);

                                if BOMLine2Rec.FindSet() then begin

                                    repeat
                                        //Country filter
                                        BOMLine3Rec.Reset();
                                        BOMLine3Rec.SetRange("No.", rec."No");
                                        BOMLine3Rec.SetRange(Type, 3);
                                        BOMLine3Rec.SetRange("Item No.", BLERec."Item No.");
                                        BOMLine3Rec.SetRange(Placement, BLERec."Placement of GMT");
                                        BOMLine3Rec.SetRange(Select, true);

                                        if BOMLine3Rec.FindSet() then begin

                                            repeat

                                                //PO filter
                                                BOMPOSelecRec.Reset();
                                                BOMPOSelecRec.SetRange("BOM No.", rec."No");
                                                BOMPOSelecRec.SetRange(Selection, true);

                                                if BOMPOSelecRec.FindSet() then begin

                                                    repeat

                                                        //Item po filter
                                                        BOMLine4Rec.Reset();
                                                        BOMLine4Rec.SetRange("No.", rec."No");
                                                        BOMLine4Rec.SetRange(Type, 4);
                                                        BOMLine4Rec.SetRange("Item No.", BLERec."Item No.");
                                                        BOMLine4Rec.SetRange(Placement, BLERec."Placement of GMT");
                                                        BOMLine4Rec.SetRange("lot No.", BOMPOSelecRec."lot No.");
                                                        BOMLine4Rec.SetRange(Select, true);

                                                        if BOMLine4Rec.FindSet() then begin

                                                            repeat

                                                                //Insert new line
                                                                AssortDetailsRec.Reset();
                                                                AssortDetailsRec.SetRange("Style No.", rec."Style No.");
                                                                AssortDetailsRec.SetRange("lot No.", BOMLine4Rec."lot No.");
                                                                AssortDetailsRec.SetRange("Country Code", BOMLine3Rec."Country Code");

                                                                if AssortDetailsRec.FindSet() then begin

                                                                    repeat

                                                                        if AssortDetailsRec."Colour No" <> '*' then begin

                                                                            //Find the correct column for the GMT size
                                                                            AssortDetails1Rec.Reset();
                                                                            AssortDetails1Rec.SetRange("Style No.", rec."Style No.");
                                                                            AssortDetails1Rec.SetRange("lot No.", BOMLine4Rec."lot No.");
                                                                            AssortDetails1Rec.SetRange("Colour No", '*');
                                                                            AssortDetails1Rec.SetRange("Country Code", BOMLine3Rec."Country Code");

                                                                            AssortDetails1Rec.FindSet();

                                                                            FOR Count := 1 TO 64 DO begin

                                                                                case Count of
                                                                                    1:
                                                                                        if AssortDetails1Rec."1" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."1");
                                                                                            break;
                                                                                        end;
                                                                                    2:
                                                                                        if AssortDetails1Rec."2" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."2");
                                                                                            break;
                                                                                        end;
                                                                                    3:
                                                                                        if AssortDetails1Rec."3" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."3");
                                                                                            break;
                                                                                        end;
                                                                                    4:
                                                                                        if AssortDetails1Rec."4" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."4");
                                                                                            break;
                                                                                        end;
                                                                                    5:
                                                                                        if AssortDetails1Rec."5" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."5");
                                                                                            break;
                                                                                        end;
                                                                                    6:
                                                                                        if AssortDetails1Rec."6" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."6");
                                                                                            break;
                                                                                        end;
                                                                                    7:
                                                                                        if AssortDetails1Rec."7" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."7");
                                                                                            break;
                                                                                        end;
                                                                                    8:
                                                                                        if AssortDetails1Rec."8" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."8");
                                                                                            break;
                                                                                        end;
                                                                                    9:
                                                                                        if AssortDetails1Rec."9" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."9");
                                                                                            break;
                                                                                        end;
                                                                                    10:
                                                                                        if AssortDetails1Rec."10" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."10");
                                                                                            break;
                                                                                        end;
                                                                                    11:
                                                                                        if AssortDetails1Rec."11" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."11");
                                                                                            break;
                                                                                        end;
                                                                                    12:
                                                                                        if AssortDetails1Rec."12" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."12");
                                                                                            break;
                                                                                        end;
                                                                                    13:
                                                                                        if AssortDetails1Rec."13" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."13");
                                                                                            break;
                                                                                        end;
                                                                                    14:
                                                                                        if AssortDetails1Rec."14" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."14");
                                                                                            break;
                                                                                        end;
                                                                                    15:
                                                                                        if AssortDetails1Rec."15" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."15");
                                                                                            break;
                                                                                        end;
                                                                                    16:
                                                                                        if AssortDetails1Rec."16" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."16");
                                                                                            break;
                                                                                        end;
                                                                                    17:
                                                                                        if AssortDetails1Rec."17" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."17");
                                                                                            break;
                                                                                        end;
                                                                                    18:
                                                                                        if AssortDetails1Rec."18" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."18");
                                                                                            break;
                                                                                        end;
                                                                                    19:
                                                                                        if AssortDetails1Rec."19" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."19");
                                                                                            break;
                                                                                        end;
                                                                                    20:
                                                                                        if AssortDetails1Rec."20" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."20");
                                                                                            break;
                                                                                        end;
                                                                                    21:
                                                                                        if AssortDetails1Rec."21" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."21");
                                                                                            break;
                                                                                        end;
                                                                                    22:
                                                                                        if AssortDetails1Rec."22" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."22");
                                                                                            break;
                                                                                        end;
                                                                                    23:
                                                                                        if AssortDetails1Rec."23" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."23");
                                                                                            break;
                                                                                        end;
                                                                                    24:
                                                                                        if AssortDetails1Rec."24" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."24");
                                                                                            break;
                                                                                        end;
                                                                                    25:
                                                                                        if AssortDetails1Rec."25" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."25");
                                                                                            break;
                                                                                        end;
                                                                                    26:
                                                                                        if AssortDetails1Rec."26" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."26");
                                                                                            break;
                                                                                        end;
                                                                                    27:
                                                                                        if AssortDetails1Rec."27" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."27");
                                                                                            break;
                                                                                        end;
                                                                                    28:
                                                                                        if AssortDetails1Rec."28" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."28");
                                                                                            break;
                                                                                        end;
                                                                                    29:
                                                                                        if AssortDetails1Rec."29" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."29");
                                                                                            break;
                                                                                        end;
                                                                                    30:
                                                                                        if AssortDetails1Rec."30" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."30");
                                                                                            break;
                                                                                        end;
                                                                                    31:
                                                                                        if AssortDetails1Rec."31" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."31");
                                                                                            break;
                                                                                        end;
                                                                                    32:
                                                                                        if AssortDetails1Rec."32" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."32");
                                                                                            break;
                                                                                        end;
                                                                                    33:
                                                                                        if AssortDetails1Rec."33" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."33");
                                                                                            break;
                                                                                        end;
                                                                                    34:
                                                                                        if AssortDetails1Rec."34" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."34");
                                                                                            break;
                                                                                        end;
                                                                                    35:
                                                                                        if AssortDetails1Rec."35" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."35");
                                                                                            break;
                                                                                        end;
                                                                                    36:
                                                                                        if AssortDetails1Rec."36" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."36");
                                                                                            break;
                                                                                        end;
                                                                                    37:
                                                                                        if AssortDetails1Rec."37" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."37");
                                                                                            break;
                                                                                        end;
                                                                                    38:
                                                                                        if AssortDetails1Rec."38" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."38");
                                                                                            break;
                                                                                        end;
                                                                                    39:
                                                                                        if AssortDetails1Rec."39" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."39");
                                                                                            break;
                                                                                        end;
                                                                                    40:
                                                                                        if AssortDetails1Rec."40" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."40");
                                                                                            break;
                                                                                        end;
                                                                                    41:
                                                                                        if AssortDetails1Rec."41" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."41");
                                                                                            break;
                                                                                        end;
                                                                                    42:
                                                                                        if AssortDetails1Rec."42" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."42");
                                                                                            break;
                                                                                        end;
                                                                                    43:
                                                                                        if AssortDetails1Rec."43" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."43");
                                                                                            break;
                                                                                        end;
                                                                                    44:
                                                                                        if AssortDetails1Rec."44" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."44");
                                                                                            break;
                                                                                        end;
                                                                                    45:
                                                                                        if AssortDetails1Rec."45" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."45");
                                                                                            break;
                                                                                        end;
                                                                                    46:
                                                                                        if AssortDetails1Rec."46" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."46");
                                                                                            break;
                                                                                        end;
                                                                                    47:
                                                                                        if AssortDetails1Rec."47" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."47");
                                                                                            break;
                                                                                        end;
                                                                                    48:
                                                                                        if AssortDetails1Rec."48" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."48");
                                                                                            break;
                                                                                        end;
                                                                                    49:
                                                                                        if AssortDetails1Rec."49" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."49");
                                                                                            break;
                                                                                        end;
                                                                                    50:
                                                                                        if AssortDetails1Rec."50" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."50");
                                                                                            break;
                                                                                        end;
                                                                                    51:
                                                                                        if AssortDetails1Rec."51" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."51");
                                                                                            break;
                                                                                        end;
                                                                                    52:
                                                                                        if AssortDetails1Rec."52" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."52");
                                                                                            break;
                                                                                        end;
                                                                                    53:
                                                                                        if AssortDetails1Rec."53" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."53");
                                                                                            break;
                                                                                        end;
                                                                                    54:
                                                                                        if AssortDetails1Rec."54" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."54");
                                                                                            break;
                                                                                        end;
                                                                                    55:
                                                                                        if AssortDetails1Rec."55" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."55");
                                                                                            break;
                                                                                        end;
                                                                                    56:
                                                                                        if AssortDetails1Rec."56" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."56");
                                                                                            break;
                                                                                        end;
                                                                                    57:
                                                                                        if AssortDetails1Rec."57" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."57");
                                                                                            break;
                                                                                        end;
                                                                                    58:
                                                                                        if AssortDetails1Rec."58" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."58");
                                                                                            break;
                                                                                        end;
                                                                                    59:
                                                                                        if AssortDetails1Rec."59" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."59");
                                                                                            break;
                                                                                        end;
                                                                                    60:
                                                                                        if AssortDetails1Rec."60" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."60");
                                                                                            break;
                                                                                        end;
                                                                                    61:
                                                                                        if AssortDetails1Rec."61" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."61");
                                                                                            break;
                                                                                        end;
                                                                                    62:
                                                                                        if AssortDetails1Rec."62" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."62");
                                                                                            break;
                                                                                        end;
                                                                                    63:
                                                                                        if AssortDetails1Rec."63" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."63");
                                                                                            break;
                                                                                        end;
                                                                                    64:
                                                                                        if AssortDetails1Rec."64" = BOMLine2Rec."GMR Size Name" then begin
                                                                                            Evaluate(subTotal, AssortDetailsRec."64");
                                                                                            break;
                                                                                        end;
                                                                                end;

                                                                                total += SubTotal;
                                                                                SubTotal := 0;

                                                                            end;

                                                                        end;

                                                                    until AssortDetailsRec.Next() = 0;



                                                                    LineNo += 1;
                                                                    Value := 0;
                                                                    Requirment := 0;

                                                                    UOMRec.Reset();
                                                                    UOMRec.SetRange(Code, BLERec."Unit N0.");
                                                                    UOMRec.FindSet();
                                                                    ConvFactor := UOMRec."Converion Parameter";

                                                                    //Check whether already "po raised"items are there, then do not insert
                                                                    BLAutoGenNewRec.Reset();
                                                                    BLAutoGenNewRec.SetRange("No.", rec."No");
                                                                    BLAutoGenNewRec.SetRange("Item No.", BLERec."Item No.");
                                                                    BLAutoGenNewRec.SetRange("Placement of GMT", BLERec."Placement of GMT");
                                                                    BLAutoGenNewRec.SetRange("Item Color No.", BOMLine2Rec."Item Color No.");
                                                                    BLAutoGenNewRec.SetRange("GMT Size Name", BOMLine2Rec."GMR Size Name");
                                                                    BLAutoGenNewRec.SetRange("Country No.", BOMLine3Rec."Country Code");
                                                                    BLAutoGenNewRec.SetRange(PO, BOMLine4Rec."PO No.");
                                                                    BLAutoGenNewRec.SetRange("Lot No.", BOMLine4Rec."Lot No.");
                                                                    BLAutoGenNewRec.SetRange("Article No.", BLERec."Article No.");
                                                                    BLAutoGenNewRec.SetRange("Dimension No.", BOMLine2Rec."Dimension No.");
                                                                    BLAutoGenNewRec.SetRange("Supplier No.", BLERec."Supplier No.");

                                                                    if Not BLAutoGenNewRec.FindSet() then begin
                                                                        if Total <> 0 then begin

                                                                            BLAutoGenNewRec.Init();
                                                                            BLAutoGenNewRec."No." := rec."No";
                                                                            BLAutoGenNewRec."Item No." := BLERec."Item No.";
                                                                            BLAutoGenNewRec."Item Name" := BLERec."Item Name";
                                                                            BLAutoGenNewRec."Line No." := LineNo;
                                                                            BLAutoGenNewRec."Main Category No." := BLERec."Main Category No.";
                                                                            BLAutoGenNewRec."Main Category Name" := BLERec."Main Category Name";
                                                                            BLAutoGenNewRec."Sub Category No." := SubCat;
                                                                            BLAutoGenNewRec."Sub Category Name" := SubCatDesc;
                                                                            BLAutoGenNewRec."Article No." := BLERec."Article No.";
                                                                            BLAutoGenNewRec."Article Name." := BLERec."Article Name.";
                                                                            BLAutoGenNewRec."Dimension No." := BOMLine2Rec."Dimension No.";
                                                                            BLAutoGenNewRec."Dimension Name." := BOMLine2Rec."Dimension Name";
                                                                            BLAutoGenNewRec."Unit N0." := BLERec."Unit N0.";
                                                                            BLAutoGenNewRec.Type := BLERec.Type;
                                                                            BLAutoGenNewRec.Consumption := BLERec.Consumption;
                                                                            BLAutoGenNewRec.WST := BLERec.WST;
                                                                            BLAutoGenNewRec.Rate := BLERec.Rate;
                                                                            BLAutoGenNewRec."Supplier No." := BLERec."Supplier No.";
                                                                            BLAutoGenNewRec."Supplier Name." := BLERec."Supplier Name.";
                                                                            BLAutoGenNewRec.AjstReq := BLERec.AjstReq;
                                                                            BLAutoGenNewRec.Qty := BLERec.Qty;
                                                                            BLAutoGenNewRec."Created User" := UserId;
                                                                            BLAutoGenNewRec."Created Date" := WorkDate();
                                                                            BLAutoGenNewRec."Stock Bal" := BLERec."Stock Bal";
                                                                            BLAutoGenNewRec."Size Sensitive" := false;
                                                                            BLAutoGenNewRec."Color Sensitive" := false;
                                                                            BLAutoGenNewRec."Country Sensitive" := false;
                                                                            BLAutoGenNewRec."PO Sensitive" := false;
                                                                            BLAutoGenNewRec.Reconfirm := false;
                                                                            BLAutoGenNewRec."Placement of GMT" := BLERec."Placement of GMT";
                                                                            BLAutoGenNewRec."GMT Color No." := BOMLine2Rec."GMT Color No.";
                                                                            BLAutoGenNewRec."GMT Color Name" := BOMLine2Rec."GMT Color Name.";
                                                                            BLAutoGenNewRec."Item Color No." := BOMLine2Rec."Item Color No.";
                                                                            BLAutoGenNewRec."Item Color Name" := BOMLine2Rec."Item Color Name.";
                                                                            BLAutoGenNewRec."GMT Size Name" := BOMLine2Rec."GMR Size Name";
                                                                            BLAutoGenNewRec."Country No." := BOMLine3Rec."Country Code";
                                                                            BLAutoGenNewRec."Country Name" := BOMLine3Rec."Country Name";
                                                                            BLAutoGenNewRec.PO := BOMLine4Rec."PO No.";
                                                                            BLAutoGenNewRec."Lot No." := BOMLine4Rec."Lot No.";
                                                                            BLAutoGenNewRec."GMT Qty" := Total;

                                                                            if BLERec.Type = BLERec.Type::Pcs then
                                                                                Requirment := (BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100
                                                                            else
                                                                                if BLERec.Type = BLERec.Type::Doz then
                                                                                    Requirment := ((BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100) / 12;

                                                                            if (ConvFactor <> 0) then
                                                                                Requirment := Requirment / ConvFactor;

                                                                            //Requirment := Round(Requirment, 1);

                                                                            if Requirment < 0 then
                                                                                Requirment := 1;

                                                                            Value := Requirment * BLERec.Rate;

                                                                            BLAutoGenNewRec.Requirment := Requirment;
                                                                            BLAutoGenNewRec.Value := Value;

                                                                            BLAutoGenNewRec.Insert();

                                                                            //Insert into AutoGenPRBOM
                                                                            InsertAutoGenProdBOM(BLERec."Item No.", LineNo);
                                                                            Total := 0;
                                                                        end;
                                                                    end;
                                                                end;

                                                            until BOMLine4Rec.Next() = 0;

                                                        end;

                                                    until BOMPOSelecRec.Next() = 0;

                                                end;

                                            until BOMLine3Rec.Next() = 0;

                                        end;

                                    until BOMLine2Rec.Next() = 0;

                                end;

                            end;
                        //end;

                        until BLERec.Next() = 0;
                    end;

                    Message('Completed');
                end;
            }

            action("Write To MRP")
            {
                ApplicationArea = All;
                Image = PurchaseCreditMemo;

                trigger OnAction()
                var
                    SalesHeaderRec: Record "Sales Header";
                    Window: Dialog;
                    TextCon1: TextConst ENU = 'Creating Production Order ####1';
                    ProOrderNo: Code[20];
                    CodeUnitNavApp: Codeunit NavAppCodeUnit;
                    BOMLineAutoGenRec: Record "BOM Line AutoGen";
                    BOMLineAutoGenNewRec: Record "BOM Line AutoGen";
                    BOMLineEstimateRec: Record "BOM Line Estimate";
                    BOMLineEstimateNewRec: Record "BOM Line Estimate";
                    ProdBOMHeaderRec: Record "Production BOM Header";
                    ProdBOMLineRec: Record "Production BOM Line";
                    ProdBOMLine1Rec: Record "Production BOM Line";
                    ItemUinitRec: Record "Item Unit of Measure";
                    MainCateRec: Record "Main Category";
                    AssortDetailRec: Record AssorColorSizeRatio;
                    AssortDetail1Rec: Record AssorColorSizeRatio;
                    NoSeriesManagementCode: Codeunit NoSeriesManagement;
                    AutoGenRec: Record "BOM Line AutoGen";
                    StyleMasRec: Record "Style Master";
                    ItemMasterRec: Record Item;
                    LineNo: BigInteger;
                    ReqLineNo: BigInteger;
                    Description: Text[500];
                    NextBomNo: Text;
                    NextItemNo: Text;
                    Count: Integer;
                    StyleMasterRec: Record "Style Master";
                    ItemRec: Record Item;
                    NavAppSetupRec: Record "NavApp Setup";
                    RequLineRec: Record "Requisition Line";
                    //RequLineRec1: Record "Requisition Line";
                    Qty: Decimal;
                    ItemLedgerRec: Record "Item Ledger Entry";
                    QtyInStock: Decimal;
                    ItemNotemp: Code[50];
                begin

                    BOMLineAutoGenRec.Reset();
                    BOMLineAutoGenRec.SetRange("No.", rec."No");
                    BOMLineAutoGenRec.SetFilter("Include in PO", '=%1', true);
                    BOMLineAutoGenRec.SetFilter("Included in PO", '=%1', false);

                    if not BOMLineAutoGenRec.FindSet() then
                        Error('Records not selected for processing.');

                    LineNo := 0;
                    Description := '';

                    AssortDetailRec.Reset();
                    AssortDetailRec.SetRange("Style No.", rec."Style No.");
                    AssortDetailRec.SetFilter("Colour Name", '<>%1', '*');

                    if AssortDetailRec.FindSet() then begin
                        repeat

                            StatusGB := 0;

                            // Message('color :' + AssortDetailRec."Colour Name");
                            // Message('lot :' + AssortDetailRec."lot No.");


                            FOR Count := 1 TO 64 DO begin
                                Qty := 0;

                                case Count of
                                    1:
                                        if (AssortDetailRec."1" <> '') and (AssortDetailRec."1" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."1";
                                                Evaluate(Qty, AssortDetailRec."1");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."1");
                                            end;

                                            break;
                                        end;
                                    2:
                                        if (AssortDetailRec."2" <> '') and (AssortDetailRec."2" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."2";
                                                Evaluate(Qty, AssortDetailRec."2");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."2");
                                            end;

                                            break;
                                        end;
                                    3:
                                        if (AssortDetailRec."3" <> '') and (AssortDetailRec."3" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."3";
                                                Evaluate(Qty, AssortDetailRec."3");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."3");
                                            end;

                                            break;
                                        end;
                                    4:
                                        if (AssortDetailRec."4" <> '') and (AssortDetailRec."4" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."4";
                                                Evaluate(Qty, AssortDetailRec."4");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."4");
                                            end;

                                            break;
                                        end;
                                    5:
                                        if (AssortDetailRec."5" <> '') and (AssortDetailRec."5" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."5";
                                                Evaluate(Qty, AssortDetailRec."5");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."5");
                                            end;

                                            break;
                                        end;
                                    6:
                                        if (AssortDetailRec."6" <> '') and (AssortDetailRec."6" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."6";
                                                Evaluate(Qty, AssortDetailRec."6");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."6");
                                            end;

                                            break;
                                        end;
                                    7:
                                        if (AssortDetailRec."7" <> '') and (AssortDetailRec."7" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."7";
                                                Evaluate(Qty, AssortDetailRec."7");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."7");
                                            end;

                                            break;
                                        end;
                                    8:
                                        if (AssortDetailRec."8" <> '') and (AssortDetailRec."8" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."8";
                                                Evaluate(Qty, AssortDetailRec."8");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."8");
                                            end;

                                            break;
                                        end;
                                    9:
                                        if (AssortDetailRec."9" <> '') and (AssortDetailRec."9" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."9";
                                                Evaluate(Qty, AssortDetailRec."9");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."9");
                                            end;

                                            break;
                                        end;
                                    10:
                                        if (AssortDetailRec."10" <> '') and (AssortDetailRec."10" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."10";
                                                Evaluate(Qty, AssortDetailRec."10");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."10");
                                            end;

                                            break;
                                        end;
                                    11:
                                        if (AssortDetailRec."11" <> '') and (AssortDetailRec."11" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."11";
                                                Evaluate(Qty, AssortDetailRec."11");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."11");
                                            end;

                                            break;
                                        end;
                                    12:
                                        if (AssortDetailRec."12" <> '') and (AssortDetailRec."12" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."12";
                                                Evaluate(Qty, AssortDetailRec."12");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."12");
                                            end;

                                            break;
                                        end;
                                    13:
                                        if (AssortDetailRec."13" <> '') and (AssortDetailRec."13" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."13";
                                                Evaluate(Qty, AssortDetailRec."13");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."13");
                                            end;

                                            break;
                                        end;
                                    14:
                                        if (AssortDetailRec."14" <> '') and (AssortDetailRec."14" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."14";
                                                Evaluate(Qty, AssortDetailRec."14");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."14");
                                            end;

                                            break;
                                        end;
                                    15:
                                        if (AssortDetailRec."15" <> '') and (AssortDetailRec."15" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."15";
                                                Evaluate(Qty, AssortDetailRec."15");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."15");
                                            end;

                                            break;
                                        end;
                                    16:
                                        if (AssortDetailRec."16" <> '') and (AssortDetailRec."16" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."16";
                                                Evaluate(Qty, AssortDetailRec."16");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."16");
                                            end;

                                            break;
                                        end;
                                    17:
                                        if (AssortDetailRec."17" <> '') and (AssortDetailRec."17" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."17";
                                                Evaluate(Qty, AssortDetailRec."17");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."17");
                                            end;

                                            break;
                                        end;
                                    18:
                                        if (AssortDetailRec."18" <> '') and (AssortDetailRec."18" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."18";
                                                Evaluate(Qty, AssortDetailRec."18");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."18");
                                            end;

                                            break;
                                        end;
                                    19:
                                        if (AssortDetailRec."19" <> '') and (AssortDetailRec."19" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetailRec."19";
                                                Evaluate(Qty, AssortDetailRec."19");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."19");
                                            end;

                                            break;
                                        end;
                                    20:
                                        if (AssortDetailRec."20" <> '') and (AssortDetailRec."20" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."20";
                                                Evaluate(Qty, AssortDetailRec."20");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."20");
                                            end;

                                            break;
                                        end;
                                    21:
                                        if (AssortDetailRec."21" <> '') and (AssortDetailRec."21" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."21";
                                                Evaluate(Qty, AssortDetailRec."21");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."21");
                                            end;

                                            break;
                                        end;
                                    22:
                                        if (AssortDetailRec."22" <> '') and (AssortDetailRec."22" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."22";
                                                Evaluate(Qty, AssortDetailRec."22");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."22");
                                            end;

                                            break;
                                        end;
                                    23:
                                        if (AssortDetailRec."23" <> '') and (AssortDetailRec."23" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."23";
                                                Evaluate(Qty, AssortDetailRec."23");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."23");
                                            end;

                                            break;
                                        end;
                                    24:
                                        if (AssortDetailRec."24" <> '') and (AssortDetailRec."24" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."24";
                                                Evaluate(Qty, AssortDetailRec."24");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."24");
                                            end;

                                            break;
                                        end;
                                    25:
                                        if (AssortDetailRec."25" <> '') and (AssortDetailRec."25" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."25";
                                                Evaluate(Qty, AssortDetailRec."25");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."25");
                                            end;

                                            break;
                                        end;
                                    26:
                                        if (AssortDetailRec."26" <> '') and (AssortDetailRec."26" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."26";
                                                Evaluate(Qty, AssortDetailRec."26");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."26");
                                            end;

                                            break;
                                        end;
                                    27:
                                        if (AssortDetailRec."27" <> '') and (AssortDetailRec."27" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."27";
                                                Evaluate(Qty, AssortDetailRec."27");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."27");
                                            end;

                                            break;
                                        end;
                                    28:
                                        if (AssortDetailRec."28" <> '') and (AssortDetailRec."28" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."28";
                                                Evaluate(Qty, AssortDetailRec."28");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."28");
                                            end;

                                            break;
                                        end;
                                    29:
                                        if (AssortDetailRec."29" <> '') and (AssortDetailRec."29" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."29";
                                                Evaluate(Qty, AssortDetailRec."29");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."29");
                                            end;

                                            break;
                                        end;
                                    30:
                                        if (AssortDetailRec."30" <> '') and (AssortDetailRec."30" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."30";
                                                Evaluate(Qty, AssortDetailRec."30");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."30");
                                            end;

                                            break;
                                        end;
                                    31:
                                        if (AssortDetailRec."31" <> '') and (AssortDetailRec."31" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."31";
                                                Evaluate(Qty, AssortDetailRec."31");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."31");
                                            end;

                                            break;
                                        end;
                                    32:
                                        if (AssortDetailRec."32" <> '') and (AssortDetailRec."32" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."32";
                                                Evaluate(Qty, AssortDetailRec."32");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."32");
                                            end;

                                            break;
                                        end;
                                    33:
                                        if (AssortDetailRec."33" <> '') and (AssortDetailRec."33" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."33";
                                                Evaluate(Qty, AssortDetailRec."33");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."33");
                                            end;

                                            break;
                                        end;
                                    34:
                                        if (AssortDetailRec."34" <> '') and (AssortDetailRec."34" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."34";
                                                Evaluate(Qty, AssortDetailRec."34");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."34");
                                            end;

                                            break;
                                        end;
                                    35:
                                        if (AssortDetailRec."35" <> '') and (AssortDetailRec."35" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."35";
                                                Evaluate(Qty, AssortDetailRec."35");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."35");
                                            end;

                                            break;
                                        end;
                                    36:
                                        if (AssortDetailRec."36" <> '') and (AssortDetailRec."36" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."36";
                                                Evaluate(Qty, AssortDetailRec."36");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."36");
                                            end;

                                            break;
                                        end;
                                    37:
                                        if (AssortDetailRec."37" <> '') and (AssortDetailRec."37" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."37";
                                                Evaluate(Qty, AssortDetailRec."37");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."37");
                                            end;

                                            break;
                                        end;
                                    38:
                                        if (AssortDetailRec."38" <> '') and (AssortDetailRec."38" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."38";
                                                Evaluate(Qty, AssortDetailRec."38");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."38");
                                            end;

                                            break;
                                        end;
                                    39:
                                        if (AssortDetailRec."39" <> '') and (AssortDetailRec."39" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."39";
                                                Evaluate(Qty, AssortDetailRec."39");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."39");
                                            end;

                                            break;
                                        end;
                                    40:
                                        if (AssortDetailRec."40" <> '') and (AssortDetailRec."40" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."40";
                                                Evaluate(Qty, AssortDetailRec."40");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."40");
                                            end;

                                            break;
                                        end;
                                    41:
                                        if (AssortDetailRec."41" <> '') and (AssortDetailRec."41" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."41";
                                                Evaluate(Qty, AssortDetailRec."41");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."41");
                                            end;

                                            break;
                                        end;
                                    42:
                                        if (AssortDetailRec."42" <> '') and (AssortDetailRec."42" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."42";
                                                Evaluate(Qty, AssortDetailRec."42");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."42");
                                            end;

                                            break;
                                        end;
                                    43:
                                        if (AssortDetailRec."43" <> '') and (AssortDetailRec."43" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."43";
                                                Evaluate(Qty, AssortDetailRec."43");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."43");
                                            end;

                                            break;
                                        end;
                                    44:
                                        if (AssortDetailRec."44" <> '') and (AssortDetailRec."44" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."44";
                                                Evaluate(Qty, AssortDetailRec."44");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."44");
                                            end;

                                            break;
                                        end;
                                    45:
                                        if (AssortDetailRec."45" <> '') and (AssortDetailRec."45" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."45";
                                                Evaluate(Qty, AssortDetailRec."45");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."45");
                                            end;

                                            break;
                                        end;
                                    46:
                                        if (AssortDetailRec."46" <> '') and (AssortDetailRec."46" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."46";
                                                Evaluate(Qty, AssortDetailRec."46");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."46");
                                            end;

                                            break;
                                        end;
                                    47:
                                        if (AssortDetailRec."47" <> '') and (AssortDetailRec."47" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."47";
                                                Evaluate(Qty, AssortDetailRec."47");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."47");
                                            end;

                                            break;
                                        end;
                                    48:
                                        if (AssortDetailRec."48" <> '') and (AssortDetailRec."48" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."48";
                                                Evaluate(Qty, AssortDetailRec."48");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."48");
                                            end;

                                            break;
                                        end;
                                    49:
                                        if (AssortDetailRec."49" <> '') and (AssortDetailRec."49" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."49";
                                                Evaluate(Qty, AssortDetailRec."49");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."49");
                                            end;

                                            break;
                                        end;
                                    50:
                                        if (AssortDetailRec."50" <> '') and (AssortDetailRec."50" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."50";
                                                Evaluate(Qty, AssortDetailRec."50");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."50");
                                            end;

                                            break;
                                        end;
                                    51:
                                        if (AssortDetailRec."51" <> '') and (AssortDetailRec."51" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."51";
                                                Evaluate(Qty, AssortDetailRec."51");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."51");
                                            end;

                                            break;
                                        end;
                                    52:
                                        if (AssortDetailRec."52" <> '') and (AssortDetailRec."52" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."52";
                                                Evaluate(Qty, AssortDetailRec."52");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."52");
                                            end;

                                            break;
                                        end;
                                    53:
                                        if (AssortDetailRec."53" <> '') and (AssortDetailRec."53" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."53";
                                                Evaluate(Qty, AssortDetailRec."53");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."53");
                                            end;

                                            break;
                                        end;
                                    54:
                                        if (AssortDetailRec."54" <> '') and (AssortDetailRec."54" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."54";
                                                Evaluate(Qty, AssortDetailRec."54");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."54");
                                            end;

                                            break;
                                        end;
                                    55:
                                        if (AssortDetailRec."55" <> '') and (AssortDetailRec."55" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."55";
                                                Evaluate(Qty, AssortDetailRec."55");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."55");
                                            end;

                                            break;
                                        end;
                                    56:
                                        if (AssortDetailRec."56" <> '') and (AssortDetailRec."56" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."56";
                                                Evaluate(Qty, AssortDetailRec."56");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."56");
                                            end;

                                            break;
                                        end;
                                    57:
                                        if (AssortDetailRec."57" <> '') and (AssortDetailRec."57" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."57";
                                                Evaluate(Qty, AssortDetailRec."57");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."57");
                                            end;

                                            break;
                                        end;
                                    58:
                                        if (AssortDetailRec."58" <> '') and (AssortDetailRec."58" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."58";
                                                Evaluate(Qty, AssortDetailRec."58");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."58");
                                            end;

                                            break;
                                        end;
                                    59:
                                        if (AssortDetailRec."59" <> '') and (AssortDetailRec."59" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."59";
                                                Evaluate(Qty, AssortDetailRec."59");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."59");
                                            end;

                                            break;
                                        end;
                                    60:
                                        if (AssortDetailRec."60" <> '') and (AssortDetailRec."60" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."60";
                                                Evaluate(Qty, AssortDetailRec."60");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."60");
                                            end;

                                            break;
                                        end;
                                    61:
                                        if (AssortDetailRec."61" <> '') and (AssortDetailRec."61" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."61";
                                                Evaluate(Qty, AssortDetailRec."61");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."61");
                                            end;

                                            break;
                                        end;
                                    62:
                                        if (AssortDetailRec."62" <> '') and (AssortDetailRec."62" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."62";
                                                Evaluate(Qty, AssortDetailRec."62");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."62");
                                            end;

                                            break;
                                        end;
                                    63:
                                        if (AssortDetailRec."63" <> '') and (AssortDetailRec."63" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."63";
                                                Evaluate(Qty, AssortDetailRec."63");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."63");
                                            end;

                                            break;
                                        end;
                                    64:
                                        if (AssortDetailRec."64" <> '') and (AssortDetailRec."64" <> '0') then begin

                                            AssortDetail1Rec.Reset();
                                            AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                            AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                            AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                            if AssortDetail1Rec.FindSet() then begin
                                                Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."64";
                                                Evaluate(Qty, AssortDetailRec."64");
                                                CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."64");
                                            end;

                                            break;
                                        end;
                                end;

                                StatusGB := 1;
                            end;

                        until AssortDetailRec.Next() = 0;

                        AutoGenRec.Reset();
                        AutoGenRec.SetRange("No.", rec."No");
                        AutoGenRec.SetFilter("Include in PO", '=%1', true);
                        if AutoGenRec.FindSet() then
                            AutoGenRec.ModifyAll("Included in PO", true);


                        AutoGenRec.Reset();
                        AutoGenRec.SetRange("No.", rec."No");
                        AutoGenRec.SetFilter("Include in PO", '=%1', true);
                        if AutoGenRec.FindSet() then
                            AutoGenRec.ModifyAll("Include in PO", false);


                        //Create Prod orders                       
                        SalesHeaderRec.Reset();
                        SalesHeaderRec."Document Type" := SalesHeaderRec."Document Type"::Order;
                        SalesHeaderRec.SetRange("Style No", rec."Style No.");
                        SalesHeaderRec.SetRange(EntryType, SalesHeaderRec.EntryType::FG);
                        if SalesHeaderRec.FindSet() then begin

                            //Window.Open(TextCon1);
                            repeat
                                ProOrderNo := CodeUnitNavApp.CreateProdOrder(SalesHeaderRec."No.", 'Bulk');
                            //Window.Update(1, ProOrderNo);
                            //Sleep(100);
                            until SalesHeaderRec.Next() = 0;
                            //Window.Close();

                        end;


                        // NavAppSetupRec.Reset();
                        // NavAppSetupRec.FindSet();

                        // //Adjust planning worksheet order qty based on in hand stock
                        // //Get planning worksheet recods  
                        // RequLineRec.Reset();
                        // RequLineRec.SetCurrentKey("Worksheet Template Name", "Journal Batch Name", "No.");
                        // RequLineRec.SetRange("Worksheet Template Name", NavAppSetupRec."Worksheet Template Name");
                        // RequLineRec.SetRange("Journal Batch Name", NavAppSetupRec."Journal Batch Name");
                        // RequLineRec.SetRange(StyleNo, "Style No.");

                        // if RequLineRec.FindSet() then begin
                        //     repeat

                        //         if ItemNotemp <> RequLineRec."No." then begin
                        //             //Get qty in stock for first time only
                        //             QtyInStock := 0;
                        //             ItemLedgerRec.Reset();
                        //             ItemLedgerRec.SetRange("Item No.", RequLineRec."No.");

                        //             if ItemLedgerRec.FindSet() then begin
                        //                 repeat
                        //                     QtyInStock += ItemLedgerRec."Remaining Quantity";
                        //                 until ItemLedgerRec.Next() = 0;
                        //             end;

                        //             //Validate qty
                        //             if RequLineRec.Quantity > QtyInStock then begin   //order balance qty
                        //                 RequLineRec.Quantity := RequLineRec.Quantity - QtyInStock;
                        //                 RequLineRec.Modify();
                        //                 QtyInStock := 0;
                        //             end
                        //             else begin
                        //                 if RequLineRec.Quantity <= QtyInStock then begin  //No need to order.make zero qty                                            
                        //                     QtyInStock := QtyInStock - RequLineRec.Quantity;
                        //                     RequLineRec.Quantity := 0;
                        //                     RequLineRec.Modify();
                        //                 end;
                        //             end;

                        //             ItemNotemp := RequLineRec."No.";
                        //         end
                        //         else begin

                        //             //Validate qty
                        //             if RequLineRec.Quantity > QtyInStock then begin   //order balance qty
                        //                 RequLineRec.Quantity := RequLineRec.Quantity - QtyInStock;
                        //                 RequLineRec.Modify();
                        //                 QtyInStock := 0;
                        //             end
                        //             else begin
                        //                 if RequLineRec.Quantity <= QtyInStock then begin  //No need to order.make zero qty                                           
                        //                     QtyInStock := QtyInStock - RequLineRec.Quantity;
                        //                     RequLineRec.Quantity := 0;
                        //                     RequLineRec.Modify();
                        //                 end;
                        //             end;

                        //             ItemNotemp := RequLineRec."No.";
                        //         end;

                        //     until RequLineRec.Next() = 0;

                        // end;


                        // //Delete zero qty records
                        // RequLineRec.Reset();
                        // RequLineRec.SetCurrentKey("Worksheet Template Name", "Journal Batch Name", "No.");
                        // RequLineRec.SetRange("Worksheet Template Name", NavAppSetupRec."Worksheet Template Name");
                        // RequLineRec.SetRange("Journal Batch Name", NavAppSetupRec."Journal Batch Name");
                        // RequLineRec.SetRange(StyleNo, "Style No.");
                        // RequLineRec.SetFilter(Quantity, '=%1', 0);

                        // if RequLineRec.FindSet() then begin
                        //     RequLineRec.DeleteAll();
                        // end;

                        Message('Completed');
                    end;

                end;
            }

            action("Reverse MRP")
            {
                ApplicationArea = All;
                Image = ReverseLines;

                trigger OnAction()
                var
                    PurchLineRec: Record "Purchase Line";
                    PurchLine1Rec: Record "Purchase Line";
                    PurchHeaderRec: Record "Purchase Header";
                    PoPurchReceRec: Record "Purch. Rcpt. Line";
                    PoPurchInvLRec: Record "Purch. Inv. Line";
                    PoPurchInvHRec: Record "Purch. Inv. Header";
                    RequLineRec: Record "Requisition Line";
                    ProdBOMHeaderRec: Record "Production BOM Header";
                    ProdBOMLineRec: Record "Production BOM Line";
                    NavAppSetupRec: Record "NavApp Setup";
                    BOMLineAutoGenRec: Record "BOM Line AutoGen";
                    BOMLineAutoGenPRBOMRec: Record "BOM Line AutoGen ProdBOM";
                    SalesShipLRec: Record "Sales Shipment Line";
                    SalesShipHeRec: Record "Sales Shipment Header";
                    SalesInvHeRec: Record "Sales Invoice Header";
                    SalesOrderHRec: Record "Sales Header";
                    SalesOrderLRec: Record "Sales Line";
                    AssoRec: Record AssorColorSizeRatio;
                    PurchCMRec: Record "Purch. Cr. Memo Hdr.";
                    SalesCMRec: Record "Sales Cr.Memo Header";
                    ItemRec: Record Item;
                    GRNQty: Decimal;
                    ShippedQty: Decimal;
                    PONo: Code[20];
                    ProOrderHedRec: Record "Production Order";
                    ProOrderLineRec: Record "Prod. Order Line";
                begin

                    //Get Worksheet line no
                    NavAppSetupRec.Reset();
                    NavAppSetupRec.FindSet();

                    //Step 1 : Check Purchase invoice Reversal (credit note)
                    PoPurchInvLRec.Reset();
                    PoPurchInvLRec.SetRange(StyleNo, rec."Style No.");
                    PoPurchInvLRec.SetFilter(EntryType, '=%1', PoPurchReceRec.EntryType::FG);

                    if PoPurchInvLRec.FindSet() then begin
                        repeat begin
                            PurchCMRec.Reset();
                            PurchCMRec.SetRange("Applies-to Doc. No.", PoPurchInvLRec."Document No.");
                            if not PurchCMRec.FindSet() then
                                Error('Cannot reveres MRP. Purchase Invoice : %1 is not cancelled.', PoPurchInvLRec."Document No.");


                            // PoPurchInvHRec.Reset();
                            // PoPurchInvHRec.SetRange("No.", PoPurchInvLRec."Document No.");
                            // if PoPurchInvHRec.FindSet() then begin
                            //     if PoPurchInvHRec.Cancelled = false then
                            //         Error('Cannot reveres MRP. Purchase Invoice : %1 is not cancelled.', PoPurchInvLRec."Document No.");
                            // end;
                        end;
                        until PoPurchInvLRec.Next() = 0;
                    end;


                    //Step 2 : Check GRN /GRN Reversal
                    PoPurchReceRec.Reset();
                    PoPurchReceRec.SetRange(StyleNo, rec."Style No.");
                    PoPurchReceRec.SetFilter(EntryType, '=%1', PoPurchReceRec.EntryType::FG);

                    if PoPurchReceRec.FindSet() then begin
                        repeat begin
                            GRNQty := GRNQty + PoPurchReceRec.Quantity;
                        end;
                        until PoPurchReceRec.Next() = 0;

                        if GRNQty > 0 then
                            Error('Cannot reveres MRP. GRN :  %1 is not reversed.', PoPurchReceRec."Document No.");
                    end;


                    //Step 3 : Delete PO
                    PurchLineRec.Reset();
                    PurchLineRec.SetRange(StyleNo, rec."Style No.");
                    PurchLineRec.SetFilter(EntryType, '=%1', PoPurchReceRec.EntryType::FG);
                    PurchLineRec.SetCurrentKey("Document No.");
                    PurchLineRec.Ascending(true);

                    if PurchLineRec.FindSet() then begin
                        repeat begin
                            if PONo <> PurchLineRec."Document No." then begin

                                //Delete PO lines
                                PurchLine1Rec.Reset();
                                PurchLine1Rec.SetRange("Document No.", PurchLineRec."Document No.");
                                if PurchLine1Rec.FindSet() then
                                    PurchLine1Rec.DeleteAll();

                                //Delete PO Header
                                PurchHeaderRec.Reset();
                                PurchHeaderRec.SetRange("No.", PurchLineRec."Document No.");
                                if PurchHeaderRec.FindSet() then
                                    PurchHeaderRec.DeleteAll();
                            end;
                            PONo := PurchLineRec."Document No.";
                        end;
                        until PoPurchReceRec.Next() = 0;
                    end;


                    //Step 4 : Delete Planning worksheet
                    RequLineRec.Reset();
                    RequLineRec.SetCurrentKey("Worksheet Template Name", "Journal Batch Name", "No.");
                    RequLineRec.SetRange("Worksheet Template Name", NavAppSetupRec."Worksheet Template Name");
                    RequLineRec.SetRange("Journal Batch Name", NavAppSetupRec."Journal Batch Name");
                    RequLineRec.SetFilter(EntryType, '=%1', RequLineRec.EntryType::FG);
                    RequLineRec.SetRange(StyleNo, rec."Style No.");

                    if RequLineRec.FindSet() then
                        RequLineRec.DeleteAll();



                    //Step 5 : Check Sales invoice Reversal (credit note)
                    SalesInvHeRec.Reset();
                    SalesInvHeRec.SetRange("Style No", rec."Style No.");
                    SalesInvHeRec.SetFilter(EntryType, '=%1', SalesInvHeRec.EntryType::FG);
                    if SalesInvHeRec.FindSet() then
                        repeat begin
                            SalesCMRec.Reset();
                            SalesCMRec.SetRange("Applies-to Doc. No.", SalesInvHeRec."No.");
                            if not SalesCMRec.FindSet() then
                                Error('Cannot reveres MRP. Sales Invoice : %1 is not cancelled.', SalesInvHeRec."No.");
                        end;
                        until SalesInvHeRec.Next() = 0;

                    // SalesInvHeRec.Reset();
                    // SalesInvHeRec.SetRange("Style No", "Style No.");
                    // SalesInvHeRec.SetFilter(EntryType, '=%1', SalesInvHeRec.EntryType::FG);
                    // SalesInvHeRec.SetFilter(Cancelled, '=%1', false);
                    // if SalesInvHeRec.FindSet() then
                    //     Error('Cannot reveres MRP. Sales Invoice is not reversed.');




                    //Step 6 : Check shipment /shipment Reversal
                    SalesShipHeRec.Reset();
                    SalesShipHeRec.SetRange("Style No", rec."Style No.");
                    SalesShipHeRec.SetFilter(EntryType, '=%1', SalesShipHeRec.EntryType::FG);
                    SalesShipHeRec.SetCurrentKey("No.");

                    if SalesShipHeRec.FindSet() then begin
                        repeat begin
                            SalesShipLRec.Reset();
                            SalesShipLRec.SetRange("Document No.", SalesShipHeRec."No.");
                            if SalesShipLRec.FindSet() then begin
                                repeat begin
                                    ShippedQty := ShippedQty + SalesShipLRec.Quantity;
                                end;
                                until SalesShipHeRec.Next() = 0;

                                if ShippedQty > 0 then
                                    Error('Cannot reveres MRP. Sales Shipment is not reversed.');
                            end;
                            ShippedQty := 0;

                        end;
                        until SalesShipHeRec.Next() = 0;
                    end;



                    //Step 9 : Delete SO header/line
                    SalesOrderHRec.Reset();
                    SalesOrderHRec.SetRange("Style No", rec."Style No.");
                    SalesOrderHRec.SetFilter(EntryType, '=%1', PoPurchReceRec.EntryType::FG);

                    if SalesOrderHRec.FindSet() then begin
                        repeat begin

                            //Step 9.1 : Delete Production orders
                            ProOrderHedRec.Reset();
                            ProOrderHedRec.SetRange("Source Type", ProOrderHedRec."Source Type"::"Sales Header");
                            ProOrderHedRec.SetRange("Source No.", SalesOrderHRec."No.");

                            if ProOrderHedRec.FindSet() then begin
                                //Delete Prod order lines
                                ProOrderLineRec.Reset();
                                ProOrderLineRec.SetRange("Prod. Order No.", ProOrderHedRec."No.");
                                if ProOrderLineRec.FindSet() then
                                    ProOrderLineRec.DeleteAll();

                                ProOrderHedRec.Delete();
                            end;

                            //Delete SO lines
                            SalesOrderLRec.Reset();
                            SalesOrderLRec.SetRange("Document No.", SalesOrderHRec."No.");
                            if SalesOrderLRec.FindSet() then
                                SalesOrderLRec.DeleteAll();

                            //Delete SO Header
                            SalesOrderHRec.Delete();
                        end;
                        until SalesOrderHRec.Next() = 0;
                    end;


                    //Step 10 : remove SO
                    AssoRec.Reset();
                    AssoRec.SetRange("Style No.", rec."Style No.");
                    if AssoRec.FindSet() then
                        AssoRec.ModifyAll(SalesOrderNo, '');



                    //Step 11 : Set status to release
                    BOMLineAutoGenPRBOMRec.Reset();
                    BOMLineAutoGenPRBOMRec.SetRange("No.", rec.No);
                    if BOMLineAutoGenPRBOMRec.FindSet() then
                        repeat begin
                            if BOMLineAutoGenPRBOMRec."Production BOM No." <> '' then begin
                                ProdBOMHeaderRec.Reset();
                                ProdBOMHeaderRec.SetRange("No.", BOMLineAutoGenPRBOMRec."Production BOM No.");
                                if ProdBOMHeaderRec.FindSet() then begin
                                    ProdBOMHeaderRec.Validate(Status, 0);
                                    ProdBOMHeaderRec.Modify();
                                end;
                            end;
                        end;
                        until BOMLineAutoGenPRBOMRec.Next() = 0;




                    //Step 12 : Delete BOM details
                    //BOM Line
                    BOMLineAutoGenPRBOMRec.Reset();
                    BOMLineAutoGenPRBOMRec.SetRange("No.", rec.No);
                    if BOMLineAutoGenPRBOMRec.FindSet() then
                        repeat begin
                            if BOMLineAutoGenPRBOMRec."Production BOM No." <> '' then begin
                                ProdBOMLineRec.Reset();
                                ProdBOMLineRec.SetRange("Production BOM No.", BOMLineAutoGenPRBOMRec."Production BOM No.");
                                if ProdBOMLineRec.FindSet() then
                                    ProdBOMLineRec.DeleteAll();
                            end;
                        end;
                        until BOMLineAutoGenPRBOMRec.Next() = 0;




                    //BOM Header
                    BOMLineAutoGenPRBOMRec.Reset();
                    BOMLineAutoGenPRBOMRec.SetRange("No.", rec.No);
                    if BOMLineAutoGenPRBOMRec.FindSet() then
                        repeat begin
                            if BOMLineAutoGenPRBOMRec."Production BOM No." <> '' then begin
                                ProdBOMHeaderRec.Reset();
                                ProdBOMHeaderRec.SetRange("No.", BOMLineAutoGenPRBOMRec."Production BOM No.");
                                if ProdBOMHeaderRec.FindSet() then
                                    ProdBOMHeaderRec.Delete();
                            end;

                            //Modify prod bom no in item master
                            ItemRec.Reset();
                            ItemRec.SetRange("Production BOM No.", BOMLineAutoGenPRBOMRec."Production BOM No.");
                            if ItemRec.FindSet() then
                                ItemRec.ModifyAll("Production BOM No.", '');


                            //Blank Autogene record
                            //BOMLineAutoGenPRBOMRec."Production BOM No." := '';
                            BOMLineAutoGenPRBOMRec.Delete();

                        end;
                        until BOMLineAutoGenPRBOMRec.Next() = 0;


                    BOMLineAutoGenRec.Reset();
                    BOMLineAutoGenRec.SetRange("No.", rec.No);
                    if BOMLineAutoGenRec.FindSet() then begin
                        repeat
                            BOMLineAutoGenRec."Include in PO" := false;
                            BOMLineAutoGenRec."Included in PO" := false;
                            BOMLineAutoGenRec.Modify();
                        until BOMLineAutoGenRec.Next() = 0;
                    end;

                    Message('Completed');

                end;
            }
        }
    }


    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."BOM1 Nos.", xRec."No", rec."No") THEN BEGIN
            NoSeriesMngment.SetSeries(rec."No");
            CurrPage.Update();
            EXIT(TRUE);
        END;
    end;

    trigger OnDeleteRecord(): Boolean
    var
        BOMPOSelectionRec: Record BOMPOSelection;
        BOMLineEstRec: Record "BOM Line Estimate";
        BOMLineRec: Record "BOM Line";
        BOMRec: Record BOM;
        BOMAUTORec: Record "BOM Line AutoGen";
        BOMAUTOProdBOMRec: Record "BOM Line AutoGen ProdBOM";
    begin

        BOMAUTOProdBOMRec.Reset();
        BOMAUTOProdBOMRec.SetRange("No.", rec.No);

        if BOMAUTOProdBOMRec.FindSet() then
            Error('"Write TO MRP" process has been completed. You cannot delete the BOM.');

        BOMPOSelectionRec.SetRange("BOM No.", rec."No");
        BOMPOSelectionRec.DeleteAll();

        BOMLineEstRec.SetRange("No.", rec."No");
        BOMLineEstRec.DeleteAll();

        BOMLineRec.SetRange("No.", rec."No");
        BOMLineRec.DeleteAll();

        BOMAUTORec.SetRange("No.", rec."No");
        BOMAUTORec.DeleteAll();

        BOMRec.SetRange("No", rec."No");
        BOMRec.DeleteAll();
    end;

    procedure ColorSensitivity()
    var
        BOMLIneEstimateRec: Record "BOM Line Estimate";
        BOMLineColorRec: Record "BOM Line";
        BOMLineColorNewRec: Record "BOM Line";
        BOMAssortRec: Record AssortmentDetails;
        BOMLInePORec: Record BOMPOSelection; //
        LineNo: Integer;
    begin

        //Delete old records        
        BOMLineColorRec.Reset();
        BOMLineColorRec.SetRange("No.", rec."No");
        BOMLineColorRec.SetRange(Type, 1);
        BOMLineColorRec.DeleteAll();

        //Get Max Lineno
        BOMLineColorRec.Reset();
        BOMLineColorRec.SetRange("No.", rec."No");
        BOMLineColorRec.SetRange(Type, 1);

        if BOMLineColorRec.FindLast() then
            LineNo := BOMLineColorRec."Line No";

        //Get Selected colors from BOM
        BOMLIneEstimateRec.Reset();
        BOMLIneEstimateRec.SetRange("No.", rec."No");
        BOMLIneEstimateRec.SetRange("Color Sensitive", true);

        if BOMLIneEstimateRec.FindSet() then begin
            repeat

                BOMLInePORec.Reset();//
                BOMLInePORec.SetRange("BOM No.", rec."No");//
                BOMLInePORec.SetRange(Selection, true);//

                if BOMLInePORec.FindSet() then begin  //

                    repeat //
                           //Get Style Colors
                        BOMAssortRec.Reset();
                        BOMAssortRec.SetRange("Style No.", rec."Style No.");
                        BOMAssortRec.SetRange(Type, '1');
                        BOMAssortRec.SetRange("lot No.", BOMLInePORec."lot No."); //
                        BOMAssortRec.SetCurrentKey("Style No.", "lot No.", "Colour No");  //
                        BOMAssortRec.FindSet();

                        //Check whether Item already existed in the color sensivity table
                        BOMLineColorRec.Reset();
                        BOMLineColorRec.SetRange("No.", rec."No");
                        BOMLineColorRec.SetRange(Type, 1);
                        BOMLineColorRec.SetRange("Item No.", BOMLIneEstimateRec."Item No.");
                        BOMLineColorRec.SetRange("GMT Color No.", BOMAssortRec."Colour No");
                        BOMLineColorRec.SetRange(Placement, BOMLIneEstimateRec."Placement of GMT");

                        if not BOMLineColorRec.FindSet() then begin
                            GrpColor := '';
                            repeat

                                if GrpColor <> BOMAssortRec."Colour No" then begin
                                    GrpColor := BOMAssortRec."Colour No";

                                    LineNo += 10000;
                                    BOMLineColorNewRec.Init();
                                    BOMLineColorNewRec."No." := rec."No";
                                    BOMLineColorNewRec.Type := 1;
                                    BOMLineColorNewRec."Line No" := LineNo;
                                    BOMLineColorNewRec."Item No." := BOMLIneEstimateRec."Item No.";
                                    BOMLineColorNewRec."Item Name" := BOMLIneEstimateRec."Item Name";
                                    BOMLineColorNewRec."Main Category No." := BOMLIneEstimateRec."Main Category No.";
                                    BOMLineColorNewRec."Main Category Name" := BOMLIneEstimateRec."Main Category Name";
                                    BOMLineColorNewRec."GMT Color No." := BOMAssortRec."Colour No";
                                    BOMLineColorNewRec."GMT Color Name." := BOMAssortRec."Colour Name";
                                    BOMLineColorNewRec."Construction No." := BOMLIneEstimateRec."Article No.";
                                    BOMLineColorNewRec."Construction Name." := BOMLIneEstimateRec."Article Name.";
                                    BOMLineColorNewRec."Dimension No." := BOMLIneEstimateRec."Dimension No.";
                                    BOMLineColorNewRec."Dimension Name" := BOMLIneEstimateRec."Dimension Name.";
                                    BOMLineColorNewRec."Item Color No." := BOMAssortRec."Colour No";
                                    BOMLineColorNewRec."Item Color Name." := BOMAssortRec."Colour Name";
                                    BOMLineColorNewRec.Placement := BOMLIneEstimateRec."Placement of GMT";
                                    BOMLineColorNewRec."Created User" := UserId;
                                    BOMLineColorNewRec."Created Date" := WorkDate();
                                    BOMLineColorNewRec."PO No." := BOMAssortRec."PO No.";
                                    BOMLineColorNewRec."Lot No." := BOMAssortRec."Lot No.";
                                    BOMLineColorNewRec.Select := true;
                                    BOMLineColorNewRec.Insert();
                                end;
                            until BOMAssortRec.Next() = 0;
                        end;
                    until BOMLInePORec.Next() = 0;
                end;
            until BOMLIneEstimateRec.Next() = 0;
        end;
    end;

    procedure SizeSensitivity()
    var
        BOMLIneEstimateRec: Record "BOM Line Estimate";
        BOMLineSizeRec: Record "BOM Line";
        BOMLineSizeNewRec: Record "BOM Line";
        BOMAssortRec: Record AssortmentDetailsInseam;
        BOMLInePORec: Record BOMPOSelection;
        LineNo: Integer;
    begin

        //Delete old records        
        BOMLineSizeRec.Reset();
        BOMLineSizeRec.SetRange("No.", rec."No");
        BOMLineSizeRec.SetRange(Type, 2);
        BOMLineSizeRec.DeleteAll();


        //Get Max Lineno
        BOMLineSizeRec.Reset();
        BOMLineSizeRec.SetRange("No.", rec."No");
        BOMLineSizeRec.SetRange(Type, 2);

        if BOMLineSizeRec.FindLast() then
            LineNo := BOMLineSizeRec."Line No";

        //Get Selected sizes from BOM
        BOMLIneEstimateRec.Reset();
        BOMLIneEstimateRec.SetRange("No.", rec."No");
        BOMLIneEstimateRec.SetRange("size Sensitive", true);


        if BOMLIneEstimateRec.FindSet() then begin
            repeat

                BOMLInePORec.Reset();
                BOMLInePORec.SetRange("BOM No.", rec."No");
                BOMLInePORec.SetRange(Selection, true);

                if BOMLInePORec.FindSet() then begin

                    repeat
                        //Get Style Sizes
                        BOMAssortRec.Reset();
                        BOMAssortRec.SetRange("Style No.", rec."Style No.");
                        BOMAssortRec.SetRange("lot No.", BOMLInePORec."lot No.");
                        BOMAssortRec.SetCurrentKey("Style No.", "lot No.", "GMT Size");
                        BOMAssortRec.FindSet();

                        //Check whether Item already existed in the size sensivity table
                        BOMLineSizeRec.Reset();
                        BOMLineSizeRec.SetRange("No.", rec."No");
                        BOMLineSizeRec.SetRange(Type, 2);
                        BOMLineSizeRec.SetRange("Item No.", BOMLIneEstimateRec."Item No.");
                        BOMLineSizeRec.SetRange("GMR Size Name", BOMAssortRec."GMT Size");
                        BOMLineSizeRec.SetRange(Placement, BOMLIneEstimateRec."Placement of GMT");

                        if BOMAssortRec."GMT Size" <> '' then begin
                            if not BOMLineSizeRec.FindSet() then begin
                                GrpSize := '';
                                repeat

                                    if GrpSize <> BOMAssortRec."GMT Size" then begin
                                        GrpSize := BOMAssortRec."GMT Size";

                                        LineNo += 10000;
                                        BOMLineSizeNewRec.Init();
                                        BOMLineSizeNewRec."No." := rec."No";
                                        BOMLineSizeNewRec.Type := 2;
                                        BOMLineSizeNewRec."Line No" := LineNo;
                                        BOMLineSizeNewRec."Item No." := BOMLIneEstimateRec."Item No.";
                                        BOMLineSizeNewRec."Item Name" := BOMLIneEstimateRec."Item Name";
                                        BOMLineSizeNewRec."Main Category No." := BOMLIneEstimateRec."Main Category No.";
                                        BOMLineSizeNewRec."Main Category Name" := BOMLIneEstimateRec."Main Category Name";
                                        BOMLineSizeNewRec."GMR Size Name" := BOMAssortRec."GMT Size";
                                        BOMLineSizeNewRec."Main Cat size Name" := BOMAssortRec."GMT Size";
                                        BOMLineSizeNewRec.Placement := BOMLIneEstimateRec."Placement of GMT";
                                        BOMLineSizeNewRec.Price := BOMLIneEstimateRec.Rate;
                                        BOMLineSizeNewRec.WST := BOMLIneEstimateRec.WST;
                                        BOMLineSizeNewRec."Created User" := UserId;
                                        BOMLineSizeNewRec."Created Date" := WorkDate();
                                        BOMLineSizeNewRec."PO No." := BOMAssortRec."PO No.";
                                        BOMLineSizeNewRec."Lot No." := BOMAssortRec."Lot No.";
                                        BOMLineSizeNewRec.Select := true;
                                        BOMLineSizeNewRec.Insert();
                                    end;

                                until BOMAssortRec.Next() = 0;
                            end;
                        end;

                    until BOMLInePORec.Next() = 0;
                end;
            until BOMLIneEstimateRec.Next() = 0;
        end;

    end;

    procedure CountrySensitivity()
    var
        BOMLIneEstimateRec: Record "BOM Line Estimate";
        BOMLineCountryRec: Record "BOM Line";
        BOMLineCountryNewRec: Record "BOM Line";
        BOMAssortRec: Record AssortmentDetails;
        BOMLInePORec: Record BOMPOSelection;
        LineNo: Integer;
    begin

        //Delete old records        
        BOMLineCountryRec.Reset();
        BOMLineCountryRec.SetRange("No.", rec."No");
        BOMLineCountryRec.SetRange(Type, 3);
        BOMLineCountryRec.DeleteAll();

        //Get Max Lineno
        BOMLineCountryRec.Reset();
        BOMLineCountryRec.SetRange("No.", rec."No");
        BOMLineCountryRec.SetRange(Type, 3);

        if BOMLineCountryRec.FindLast() then
            LineNo := BOMLineCountryRec."Line No";

        //Get Selected country from BOM
        BOMLIneEstimateRec.Reset();
        BOMLIneEstimateRec.SetRange("No.", rec."No");
        BOMLIneEstimateRec.SetRange("Country Sensitive", true);


        if BOMLIneEstimateRec.FindSet() then begin
            repeat

                BOMLInePORec.Reset();//
                BOMLInePORec.SetRange("BOM No.", rec."No");//
                BOMLInePORec.SetRange(Selection, true);//

                if BOMLInePORec.FindSet() then begin  //

                    repeat //    
                           //Get Style country
                        BOMAssortRec.Reset();
                        BOMAssortRec.SetRange("Style No.", rec."Style No.");
                        BOMAssortRec.SetRange(Type, '2');
                        BOMAssortRec.SetRange("lot No.", BOMLInePORec."lot No."); //
                        BOMAssortRec.SetCurrentKey("Style No.", "lot No.", "Country Code");  //     
                        BOMAssortRec.FindSet();

                        //Check whether Item already existed in the country sensitivity table
                        BOMLineCountryRec.Reset();
                        BOMLineCountryRec.SetRange("No.", rec."No");
                        BOMLineCountryRec.SetRange(Type, 3);
                        BOMLineCountryRec.SetRange("Item No.", BOMLIneEstimateRec."Item No.");
                        BOMLineCountryRec.SetRange("Country Code", BOMAssortRec."Country Code");
                        BOMLineCountryRec.SetRange(Placement, BOMLIneEstimateRec."Placement of GMT");

                        if not BOMLineCountryRec.FindSet() then begin
                            GrpCountry := '';
                            repeat

                                if GrpCountry <> BOMAssortRec."Country Code" then begin
                                    GrpCountry := BOMAssortRec."Country Code";
                                    //Message(Format(BOMAssortRec."Colour No"));
                                    LineNo += 10000;
                                    BOMLineCountryNewRec.Init();
                                    BOMLineCountryNewRec."No." := rec."No";
                                    BOMLineCountryNewRec.Type := 3;
                                    BOMLineCountryNewRec."Line No" := LineNo;
                                    BOMLineCountryNewRec."Item No." := BOMLIneEstimateRec."Item No.";
                                    BOMLineCountryNewRec."Item Name" := BOMLIneEstimateRec."Item Name";
                                    BOMLineCountryNewRec."Main Category No." := BOMLIneEstimateRec."Main Category No.";
                                    BOMLineCountryNewRec."Main Category Name" := BOMLIneEstimateRec."Main Category Name";
                                    BOMLineCountryNewRec."Country Code" := BOMAssortRec."Country Code";
                                    BOMLineCountryNewRec."Country Name" := BOMAssortRec."Country Name";
                                    BOMLineCountryNewRec.Placement := BOMLIneEstimateRec."Placement of GMT";
                                    BOMLineCountryNewRec."Created User" := UserId;
                                    BOMLineCountryNewRec."Created Date" := WorkDate();
                                    BOMLineCountryNewRec."PO No." := BOMAssortRec."PO No.";
                                    BOMLineCountryNewRec."Lot No." := BOMAssortRec."Lot No.";
                                    BOMLineCountryNewRec.Select := true;
                                    BOMLineCountryNewRec.Insert();
                                end;
                            until BOMAssortRec.Next() = 0;
                        end;
                    until BOMLInePORec.Next() = 0;
                end;
            until BOMLIneEstimateRec.Next() = 0;
        end;
    end;

    procedure ItemPOSensitivity()
    var
        BOMLIneEstimateRec: Record "BOM Line Estimate";
        BOMLineItemPORec: Record "BOM Line";
        BOMLineItemPONewRec: Record "BOM Line";
        StyleMasterPORec: Record "Style Master PO";
        BOMLInePORec: Record BOMPOSelection;
        LineNo: Integer;
    begin

        //Delete old records        
        BOMLineItemPORec.Reset();
        BOMLineItemPORec.SetRange("No.", rec."No");
        BOMLineItemPORec.SetRange(Type, 4);
        BOMLineItemPORec.DeleteAll();

        //Get Max Lineno
        BOMLineItemPORec.Reset();
        BOMLineItemPORec.SetRange("No.", rec."No");
        BOMLineItemPORec.SetRange(Type, 4);

        if BOMLineItemPORec.FindLast() then
            LineNo := BOMLineItemPORec."Line No";

        //Get Selected PO from BOM
        BOMLIneEstimateRec.Reset();
        BOMLIneEstimateRec.SetRange("No.", rec."No");
        BOMLIneEstimateRec.SetRange("PO Sensitive", true);


        if BOMLIneEstimateRec.FindSet() then begin
            repeat
                BOMLInePORec.Reset();//
                BOMLInePORec.SetRange("BOM No.", rec."No");//
                BOMLInePORec.SetRange(Selection, true);//

                if BOMLInePORec.FindSet() then begin  //

                    repeat //    
                           //Get Style country
                        StyleMasterPORec.Reset();
                        StyleMasterPORec.SetRange("Style No.", rec."Style No.");
                        StyleMasterPORec.SetRange("lot No.", BOMLInePORec."lot No."); //
                        StyleMasterPORec.SetCurrentKey("Style No.", "lot No.");  //     
                        StyleMasterPORec.FindSet();

                        //Check whether Item already existed in the country sensitivity table
                        BOMLineItemPORec.Reset();
                        BOMLineItemPORec.SetRange("No.", rec."No");
                        BOMLineItemPORec.SetRange(Type, 4);
                        BOMLineItemPORec.SetRange("Item No.", BOMLIneEstimateRec."Item No.");
                        BOMLineItemPORec.SetRange("lot No.", StyleMasterPORec."lot No.");
                        BOMLineItemPORec.SetRange(Placement, BOMLIneEstimateRec."Placement of GMT");

                        if not BOMLineItemPORec.FindSet() then begin
                            repeat
                                LineNo += 10000;
                                BOMLineItemPONewRec.Init();
                                BOMLineItemPONewRec."No." := rec."No";
                                BOMLineItemPONewRec.Type := 4;
                                BOMLineItemPONewRec."Line No" := LineNo;
                                BOMLineItemPONewRec."Item No." := BOMLIneEstimateRec."Item No.";
                                BOMLineItemPONewRec."Item Name" := BOMLIneEstimateRec."Item Name";
                                BOMLineItemPONewRec."Main Category No." := BOMLIneEstimateRec."Main Category No.";
                                BOMLineItemPONewRec."Main Category Name" := BOMLIneEstimateRec."Main Category Name";
                                BOMLineItemPONewRec."Lot No." := StyleMasterPORec."Lot No.";
                                BOMLineItemPONewRec."PO No." := StyleMasterPORec."PO No.";
                                BOMLineItemPONewRec.Placement := BOMLIneEstimateRec."Placement of GMT";
                                BOMLineItemPONewRec."Created User" := UserId;
                                BOMLineItemPONewRec."Created Date" := WorkDate();
                                BOMLineItemPONewRec.Select := true;
                                BOMLineItemPONewRec.Insert();
                            until StyleMasterPORec.Next() = 0;
                        end;
                    until BOMLInePORec.Next() = 0;
                end;
            until BOMLIneEstimateRec.Next() = 0;
        end;
    end;

    procedure CreateFGItems(ItemDesc: Text[500]; Lot: Code[20]; Qty: Integer; Color: Code[20]; Size: Code[20])
    var
        NoSeriesManagementCode: Codeunit NoSeriesManagement;
        //SalesHeaderRec: Record "Sales Header";
        //SalesLineRec: Record "Sales Line";
        //ProdBOMHeaderRec: Record "Production BOM Header";
        //ProdBOMLineRec: Record "Production BOM Line";
        NavAppSetupRec: Record "NavApp Setup";
        ItemMasterRec: Record Item;
        ItemUinitRec: Record "Item Unit of Measure";
        ColorRec: Record Colour;
        BOMEstimateRec: Record "BOM Estimate Cost";
        FOBPcsPrice: Decimal;
        ItemRec: Record Item;
        NextItemNo: Code[20];
        ItemNo: Code[20];
        SalesDocNo: Code[20];
        ProdBOM: Code[20];
    begin

        //Get FOB Pcs price
        FOBPcsPrice := 0;
        BOMEstimateRec.Reset();
        BOMEstimateRec.SetRange("Style No.", rec."Style No.");
        BOMEstimateRec.FindSet();
        FOBPcsPrice := BOMEstimateRec."FOB Pcs";

        NavAppSetupRec.Reset();
        NavAppSetupRec.FindSet();

        //Check for item existance
        ItemMasterRec.Reset();
        ItemMasterRec.SetRange(Description, ItemDesc);

        if not ItemMasterRec.FindSet() then begin   //If new item

            //Get next Item no
            NextItemNo := NoSeriesManagementCode.GetNextNo(NavAppSetupRec."FG Item Nos.", Today(), true);

            //Create new item
            ItemRec.Init();
            ItemRec."No." := NextItemNo;
            ItemRec.Description := ItemDesc;
            ItemRec.Type := ItemRec.Type::Inventory;
            ItemRec."Gen. Prod. Posting Group" := NavAppSetupRec."Gen Posting Group-FG";
            ItemRec."Inventory Posting Group" := NavAppSetupRec."Inventory Posting Group-FG";
            ItemRec."VAT Prod. Posting Group" := 'ZERO';
            //ItemRec."VAT Bus. Posting " := 'ZERO';
            ItemRec."Color No." := Color;

            ColorRec.Reset();
            ColorRec.SetRange("No.", Color);
            ColorRec.FindSet();
            ItemRec."Color Name" := ColorRec."Colour Name";

            ItemRec."Size Range No." := Size;
            ItemRec."Rounding Precision" := 0.00001;

            //Insert into Item unit of measure
            ItemUinitRec.Init();
            ItemUinitRec."Item No." := NextItemNo;
            ItemUinitRec.Code := 'PCS';
            ItemUinitRec."Qty. per Unit of Measure" := 1;
            ItemUinitRec.Insert();

            ItemRec.Validate("Base Unit of Measure", 'PCS');
            ItemRec.Validate("Replenishment System", 1);
            ItemRec.Validate("Manufacturing Policy", 1);
            ItemRec."Production BOM No." := '';
            ItemRec."Unit Price" := FOBPcsPrice;
            ItemRec."Routing No." := NavAppSetupRec.Routing;
            ItemRec.Insert(true);

            //Create new sales order
            CreateSalesOrder(NextItemNo, Lot, Qty, FOBPcsPrice);

            //Create new Prod BOM
            CreateProdBOM(Color, size, Lot, NextItemNo, ItemDesc);

        end
        else begin   //If old item - Delete existing data and insert again

            ItemNo := ItemMasterRec."No.";
            ProdBOM := ItemMasterRec."Production BOM No.";

            // //Delete sales order
            // SalesLineRec.Reset();
            // SalesLineRec.SetCurrentKey("No.");
            // SalesLineRec.SetRange("No.", ItemNo);

            // if SalesLineRec.FindSet() then begin
            //     SalesDocNo := SalesLineRec."Document No.";

            //     SalesLineRec.Reset();
            //     SalesLineRec.SetCurrentKey("Document No.");
            //     SalesLineRec.SetRange("Document No.", SalesDocNo);
            //     SalesLineRec.DeleteAll();

            //     // SalesHeaderRec.Reset();
            //     // SalesHeaderRec.SetCurrentKey("Document Type", "No.");
            //     // SalesHeaderRec.SetRange("Document Type", 1);
            //     // SalesHeaderRec.SetRange("No.", SalesDocNo);
            //     // SalesHeaderRec.DeleteAll();
            // end;

            // if ProdBOM <> '' then begin
            //     //Delete Prod BOm      
            //     ProdBOMLineRec.Reset();
            //     ProdBOMLineRec.SetRange("Production BOM No.", ProdBOM);
            //     ProdBOMLineRec.DeleteAll();

            //     ProdBOMHeaderRec.Reset();
            //     ProdBOMHeaderRec.SetRange("No.", ProdBOM);
            //     ProdBOMHeaderRec.DeleteAll();
            // end;

            // //Delete FG from Item master
            // ItemMasterRec.Reset();
            // ItemMasterRec.SetRange("No.", ItemNo);
            // ItemMasterRec.DeleteAll();


            ////////////Insert New Item

            //Get next Item no
            //NextItemNo := NoSeriesManagementCode.GetNextNo('Item4', Today(), true);

            // // Create new item
            // ItemRec.Init();
            // ItemRec."No." := NextItemNo;
            // ItemRec.Description := ItemDesc;
            // ItemRec.Type := 0;
            // ItemRec."Gen. Prod. Posting Group" := NavAppSetupRec."Gen Posting Group-FG";
            // ItemRec."Inventory Posting Group" := NavAppSetupRec."Inventory Posting Group-FG";
            // ItemRec.Validate("Color No.", Color);

            // //Insert into Item unit of measure
            // ItemUinitRec.Init();
            // ItemUinitRec."Item No." := NextItemNo;
            // ItemUinitRec.Code := 'PCS';
            // ItemUinitRec."Qty. per Unit of Measure" := 1;
            // ItemUinitRec.Insert();

            // ItemRec.Validate("Base Unit of Measure", 'PCS');
            // ItemRec.Validate("Replenishment System", 1);
            // ItemRec.Validate("Manufacturing Policy", 1);
            // ItemRec."Production BOM No." := '';
            // ItemRec."Unit Price" := FOBPcsPrice;
            // ItemRec.Insert(true);

            //Create new sales order
            //CreateSalesOrder(NextItemNo, Lot, Qty, FOBPcsPrice);

            //Edit Prod BOM
            // if ProdBOM = '' then
            //     Error('Blank ProdBOM No for the Item %1. Cannot proceed', ItemDesc);

            // UpdateProdBOM(Color, size, Lot, ItemNo, ProdBOM);



            if ProdBOM = '' then begin
                CreateSalesOrder(ItemNo, Lot, Qty, FOBPcsPrice);
                CreateProdBOM(Color, size, Lot, ItemNo, ItemDesc);
            end
            else
                UpdateProdBOM(Color, size, Lot, ItemNo, ProdBOM);

        end;

    end;

    procedure CreateSalesOrder(Item: code[20]; Lot: Code[20]; Qty: Integer; Price: Decimal)
    var
        SalesHeaderRec: Record "Sales Header";
        AssoRec: Record AssorColorSizeRatio;
        SalesLineRec: Record "Sales Line";
        SalesLineRec1: Record "Sales Line";
        NavAppSetupRec: Record "NavApp Setup";
        NoSeriesManagementCode: Codeunit NoSeriesManagement;
        StyMasterPORec: Record "Style Master PO";
        StyMasterRec: Record "Style Master";
        LoginSessionsRec: Record LoginSessions;
        LoginRec: Page "Login Card";
    begin

        //Get Worksheet line no
        NavAppSetupRec.Reset();
        NavAppSetupRec.FindSet();

        //Get location for the style
        StyMasterRec.Reset();
        StyMasterRec.SetRange("No.", rec."Style No.");
        StyMasterRec.FindSet();

        if StyMasterRec."Factory Code" = '' then
            Error('Factory is not assigned for the style : #1', StyMasterRec."Style No.");

        //Get ship date
        StyMasterPORec.Reset();
        StyMasterPORec.SetRange("Style No.", rec."Style No.");
        StyMasterPORec.SetRange("Lot No.", Lot);
        StyMasterPORec.FindSet();

        //if SalesHeaderGenerated = false then begin

        AssoRec.Reset();
        AssoRec.SetRange("Style No.", rec."Style No.");
        AssoRec.SetRange("Lot No.", Lot);
        AssoRec.SetFilter("Colour Name", '<>%1', '*');

        if AssoRec.FindSet() then begin

            if AssoRec.SalesOrderNo <> '' then begin // Sales order already created

                NextOrderNo := AssoRec.SalesOrderNo;

                //Get Max Lineno
                SalesLineRec1.Reset();
                SalesLineRec1.SetCurrentKey("Document Type", "Document No.");
                SalesLineRec1.SetRange("Document No.", NextOrderNo);
                SalesLineRec1.SetRange("Document Type", 1);

                if SalesLineRec1.FindLast() then
                    LineNo := SalesLineRec1."Line No.";

                //Insert Line
                LineNo += 10;
                SalesLineRec.Init();
                SalesLineRec."Document Type" := SalesLineRec."Document Type"::Order;
                SalesLineRec."Document No." := NextOrderNo;
                SalesLineRec."Line No." := LineNo;
                SalesLineRec.Type := SalesLineRec.Type::Item;
                SalesLineRec."VAT Bus. Posting Group" := 'ZERO';
                SalesLineRec."VAT Prod. Posting Group" := 'ZERO';
                SalesLineRec.validate("No.", Item);
                SalesLineRec.validate(Quantity, Qty);
                SalesLineRec."Gen. Prod. Posting Group" := 'RETAIL';
                SalesLineRec."Gen. Bus. Posting Group" := 'EU';
                SalesLineRec.validate("Unit Price", Price);
                SalesLineRec."Planned Delivery Date" := StyMasterPORec."Ship Date";
                SalesLineRec."Planned Shipment Date" := StyMasterPORec."Ship Date";
                SalesLineRec."Shipment Date" := StyMasterPORec."Ship Date";
                SalesLineRec."Tax Group Code" := NavAppSetupRec.TaxGroupCode;
                SalesLineRec.Validate("Location Code", StyMasterRec."Factory Code");
                SalesLineRec.INSERT();
            end
            else begin  //create new sales order

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

                //Insert Header
                NextOrderNo := NoSeriesManagementCode.GetNextNo(NavAppSetupRec."FG SO Nos.", Today(), true);
                LineNo := 10;
                SalesHeaderRec.Init();
                SalesHeaderRec."Document Type" := SalesHeaderRec."Document Type"::Order;
                SalesHeaderRec."No." := NextOrderNo;
                SalesHeaderRec."Posting Date" := WorkDate();
                SalesHeaderRec."Requested Delivery Date" := StyMasterPORec."Ship Date";
                SalesHeaderRec."Order Date" := WorkDate();
                SalesHeaderRec.Validate("Sell-to Customer No.", rec."Buyer No.");
                //SalesHeaderRec.Validate("Bill-to Customer No.", "Buyer No.");                
                SalesHeaderRec."Document Date" := WORKDATE;
                SalesHeaderRec."Due Date" := StyMasterPORec."Ship Date";
                SalesHeaderRec."Shipping No. Series" := 'S-SHPT';
                SalesHeaderRec."Posting No. Series" := 'S-INV+';
                SalesHeaderRec."Style No" := rec."Style No.";
                SalesHeaderRec."Style Name" := rec."Style Name";
                SalesHeaderRec."PO No" := StyMasterPORec."PO No.";
                SalesHeaderRec.Validate("Location Code", StyMasterRec."Factory Code");
                SalesHeaderRec.EntryType := SalesHeaderRec.EntryType::FG;
                SalesHeaderRec.Lot := Lot;
                SalesHeaderRec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                SalesHeaderRec.INSERT();

                //Insert Line
                SalesLineRec.Init();
                SalesLineRec."Document Type" := SalesLineRec."Document Type"::Order;
                SalesLineRec."Document No." := NextOrderNo;
                SalesLineRec."Line No." := LineNo;
                SalesLineRec.Type := SalesLineRec.Type::Item;
                SalesLineRec."VAT Bus. Posting Group" := 'ZERO';
                SalesLineRec."VAT Prod. Posting Group" := 'ZERO';
                SalesLineRec.validate("No.", Item);
                SalesLineRec.validate(Quantity, Qty);
                SalesLineRec."Gen. Prod. Posting Group" := 'RETAIL';
                SalesLineRec."Gen. Bus. Posting Group" := 'EU';
                SalesLineRec.validate("Unit Price", Price);
                SalesLineRec."Planned Delivery Date" := StyMasterPORec."Ship Date";
                SalesLineRec."Planned Shipment Date" := StyMasterPORec."Ship Date";
                SalesLineRec."Shipment Date" := StyMasterPORec."Ship Date";
                SalesLineRec."Tax Group Code" := NavAppSetupRec.TaxGroupCode;
                SalesLineRec.Validate("Location Code", StyMasterRec."Factory Code");
                SalesLineRec.INSERT();

                //update with new sales order
                AssoRec.ModifyAll(SalesOrderNo, NextOrderNo);

            end;

        end;

    end;

    procedure CreateProdBOM(Color: code[20]; Size: Code[20]; Lot: Code[20]; FGItem: Code[20]; ItemDesc: Text[500])
    var
        NextBOMNo: Code[20];
        ItemCategoryRec: Record "Item Category";
        NoSeriesManagementCode: Codeunit NoSeriesManagement;
        ProdBOMHeaderRec: Record "Production BOM Header";
        ProdBOMLineRec: Record "Production BOM Line";
        ProdBOMLine1Rec: Record "Production BOM Line";
        AutoGenRec: Record "BOM Line AutoGen";
        AutoGenPrBOMRec: Record "BOM Line AutoGen ProdBOM";
        BOMLineEstimateRec: Record "BOM Line Estimate";
        MainCateRec: Record "Main Category";
        NavAppSetupRec: Record "NavApp Setup";
        ItemUinitRec: Record "Item Unit of Measure";
        LoginSessionsRec: Record LoginSessions;
        LoginRec: Page "Login Card";
        LineNo: Integer;
        ItemMasterRec: Record item;
        Description: Text[500];
        NextItemNo: Code[20];
        HeaderGenerated: Boolean;
        UOMRec: Record "Unit of Measure";
        StyMasterPORec: Record "Style Master PO";
        ConvFactor: Decimal;
        ConsumptionTot: Decimal;
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


        //Get Worksheet line no
        NavAppSetupRec.Reset();
        NavAppSetupRec.FindSet();

        // //Get  date
        // StyMasterPORec.Reset();
        // StyMasterPORec.SetRange("Style No.", "Style No.");
        // StyMasterPORec.SetRange("Lot No.", Lot);
        // StyMasterPORec.FindSet();

        //Generate Prod BOM Header
        if HeaderGenerated = false then begin

            //Generate Production BOM Header                                            
            NextBomNo := NoSeriesManagementCode.GetNextNo(NavAppSetupRec."FG ProdBOM Nos.", Today(), true);
            ProdBOMHeaderRec.Init();
            ProdBOMHeaderRec."No." := NextBomNo;
            ProdBOMHeaderRec.Description := ItemDesc;
            ProdBOMHeaderRec.Validate("Unit of Measure Code", 'PCS');
            ProdBOMHeaderRec.Validate("Low-Level Code", 0);
            ProdBOMHeaderRec.Validate(Status, 0);
            ProdBOMHeaderRec."Creation Date" := WorkDate();
            ProdBOMHeaderRec."Last Date Modified" := WorkDate();
            ProdBOMHeaderRec."No. Series" := 'PRODBOM';
            ProdBOMHeaderRec."Style No." := rec."Style No.";
            ProdBOMHeaderRec."Style Name" := rec."Style Name";
            ProdBOMHeaderRec.Lot := Lot;
            ProdBOMHeaderRec.EntryType := ProdBOMHeaderRec.EntryType::FG;
            ProdBOMHeaderRec."BOM Type" := ProdBOMHeaderRec."BOM Type"::"Bulk";
            ProdBOMHeaderRec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
            ProdBOMHeaderRec.Insert(true);
            HeaderGenerated := true;

            //Update Prod BOm No in item master
            ItemMasterRec.Reset();
            ItemMasterRec.SetRange("No.", FGItem);

            if ItemMasterRec.FindSet() then
                ItemMasterRec.ModifyAll("Production BOM No.", NextBomNo);

        end;

        AutoGenRec.Reset();
        AutoGenRec.SetCurrentKey("Main Category No.", "Item No.", "GMT Color No.", "GMT Size Name", "Lot No.");
        AutoGenRec.Ascending(true);
        AutoGenRec.SetRange("No.", rec."No");
        AutoGenRec.SetRange("Lot No.", lot);
        AutoGenRec.SetRange("GMT Color No.", Color);
        //AutoGenRec.SetRange("GMT Size Name", Size);

        if AutoGenRec.FindSet() then begin

            repeat

                if AutoGenRec."Article Name." = '-' then
                    Error('Invalid Article : %1', AutoGenRec."Article Name.");

                if AutoGenRec."Dimension Name." = '-' then
                    Error('Invalid Dimension : %1', AutoGenRec."Dimension Name.");


                if (AutoGenRec."Include in PO" = true) or (AutoGenRec."Included in PO" = true) then begin

                    BOMLineEstimateRec.Reset();
                    BOMLineEstimateRec.SetRange("No.", rec."No");
                    BOMLineEstimateRec.SetRange("Item No.", AutoGenRec."Item No.");
                    BOMLineEstimateRec.SetRange("Placement of GMT", AutoGenRec."Placement of GMT");

                    if BOMLineEstimateRec.FindSet() then begin

                        if BOMLineEstimateRec.Reconfirm = false then begin

                            if (AutoGenRec."GMT Size Name" = Size) or (AutoGenRec."GMT Size Name" = '') then begin
                                //if (AutoGenRec."GMT Size Name" = Size) or ((AutoGenRec."GMT Size Name" = '') and (StatusGB = 0)) then begin

                                //Get Dimenion only status
                                MainCateRec.Reset();
                                MainCateRec.SetRange("No.", AutoGenRec."Main Category No.");
                                if MainCateRec.FindSet() then begin
                                    if MainCateRec."Inv. Posting Group Code" = '' then
                                        Error('Inventory Posting Group is not setup for the Main Category : %1. Cannot proceed.', AutoGenRec."Main Category Name");

                                    if MainCateRec."Prod. Posting Group Code" = '' then
                                        Error('Product Posting Group is not setup for the Main Category : %1. Cannot proceed.', AutoGenRec."Main Category Name");

                                end
                                else
                                    Error('Cannot find Main Category details.');


                                //Generate description
                                Description := AutoGenRec."Item Name";

                                if AutoGenRec."Item Color Name" <> '' then
                                    Description := Description + ' / ' + AutoGenRec."Item Color Name";

                                if AutoGenRec."Article Name." <> '' then
                                    Description := Description + ' / ' + AutoGenRec."Article Name.";

                                if MainCateRec.DimensionOnly then begin
                                    if AutoGenRec."Dimension Name." <> '' then
                                        Description := Description + ' / ' + AutoGenRec."Dimension Name.";
                                end
                                else begin
                                    if AutoGenRec."GMT Size Name" <> '' then
                                        Description := Description + ' / ' + AutoGenRec."GMT Size Name";
                                end;

                                // if Description = 'COTTON/POLY/STRETCH DENIM / BROOK GREEN / -' then
                                //     Message(format(AutoGenRec.Requirment));

                                //Check whether item exists
                                ItemMasterRec.Reset();
                                ItemMasterRec.SetRange(Description, Description);

                                if ItemMasterRec.FindSet() then begin
                                    NextItemNo := ItemMasterRec."No.";

                                    ItemUinitRec.Reset();
                                    ItemUinitRec.SetRange("Item No.", NextItemNo);
                                    ItemUinitRec.SetRange(Code, AutoGenRec."Unit N0.");

                                    if not ItemUinitRec.FindSet() then begin
                                        //Insert into Item unit of measure
                                        ItemUinitRec.Init();
                                        ItemUinitRec."Item No." := NextItemNo;
                                        ItemUinitRec.Code := AutoGenRec."Unit N0.";
                                        ItemUinitRec."Qty. per Unit of Measure" := 1;
                                        ItemUinitRec.Insert();
                                    end;

                                    ItemMasterRec.validate("Gen. Prod. Posting Group", MainCateRec."Prod. Posting Group Code");
                                    ItemMasterRec.validate("Inventory Posting Group", MainCateRec."Inv. Posting Group Code");
                                    ItemMasterRec.Modify();
                                end
                                else begin

                                    NextItemNo := NoSeriesManagementCode.GetNextNo(NavAppSetupRec."RM Nos.", Today(), true);

                                    ItemMasterRec.Init();
                                    ItemMasterRec."No." := NextItemNo;
                                    ItemMasterRec.Description := Description;
                                    ItemMasterRec."Main Category No." := AutoGenRec."Main Category No.";
                                    ItemMasterRec."Main Category Name" := AutoGenRec."Main Category Name";
                                    ItemMasterRec."Sub Category No." := AutoGenRec."Sub Category No.";
                                    ItemMasterRec."Sub Category Name" := AutoGenRec."Sub Category Name";
                                    ItemMasterRec."Rounding Precision" := 0.00001;

                                    //Check for Item category
                                    ItemCategoryRec.Reset();
                                    ItemCategoryRec.SetRange(Code, AutoGenRec."Main Category No.");
                                    if not ItemCategoryRec.FindSet() then begin
                                        ItemCategoryRec.Init();
                                        ItemCategoryRec.Code := AutoGenRec."Main Category No.";
                                        ItemCategoryRec.Description := AutoGenRec."Main Category Name";
                                        ItemCategoryRec.Insert();
                                    end;

                                    ItemMasterRec."Item Category Code" := AutoGenRec."Main Category No.";
                                    ItemMasterRec."Color No." := AutoGenRec."Item Color No.";
                                    ItemMasterRec."Color Name" := AutoGenRec."Item Color Name";

                                    if MainCateRec.DimensionOnly then
                                        ItemMasterRec."Size Range No." := AutoGenRec."Dimension Name."
                                    else
                                        ItemMasterRec."Size Range No." := AutoGenRec."GMT Size Name";

                                    ItemMasterRec."Article No." := AutoGenRec."Article No.";
                                    ItemMasterRec."Article" := AutoGenRec."Article Name.";
                                    ItemMasterRec."Dimension Width No." := AutoGenRec."Dimension No.";
                                    ItemMasterRec."Dimension Width" := AutoGenRec."Dimension Name.";
                                    ItemMasterRec.Type := ItemMasterRec.Type::Inventory;
                                    ItemMasterRec."Unit Cost" := AutoGenRec.Rate;
                                    ItemMasterRec."Unit Price" := AutoGenRec.Rate;
                                    ItemMasterRec."Last Direct Cost" := AutoGenRec.Rate;
                                    ItemMasterRec.validate("Gen. Prod. Posting Group", MainCateRec."Prod. Posting Group Code");
                                    ItemMasterRec.validate("Inventory Posting Group", MainCateRec."Inv. Posting Group Code");
                                    //ItemMasterRec."Inventory Posting Group" := NavAppSetupRec."Inventory Posting Group-RM";
                                    ItemMasterRec."VAT Prod. Posting Group" := 'ZERO';
                                    //ItemMasterRec."VAT Bus. Posting Gr. (Price)" := 'ZERO';


                                    if MainCateRec.LOTTracking then begin
                                        ItemMasterRec.Validate("Item Tracking Code", NavAppSetupRec."LOT Tracking Code");
                                        ItemMasterRec."Lot Nos." := NavAppSetupRec."LOTTracking Nos.";
                                    end;

                                    //Insert into Item unit of measure
                                    ItemUinitRec.Init();
                                    ItemUinitRec."Item No." := NextItemNo;
                                    ItemUinitRec.Code := AutoGenRec."Unit N0.";
                                    ItemUinitRec."Qty. per Unit of Measure" := 1;

                                    ItemUinitRec.Insert();

                                    ItemMasterRec.Validate("Base Unit of Measure", AutoGenRec."Unit N0.");
                                    ItemMasterRec.Validate("Replenishment System", 0);
                                    ItemMasterRec.Validate("Manufacturing Policy", 1);
                                    //ItemMasterRec."Location Filter" Validate();
                                    ItemMasterRec.Insert(true);

                                end;

                                UOMRec.Reset();
                                UOMRec.SetRange(Code, AutoGenRec."Unit N0.");
                                UOMRec.FindSet();
                                ConvFactor := UOMRec."Converion Parameter";

                                if ConvFactor = 0 then
                                    ConvFactor := 1;

                                if (AutoGenRec.Type = AutoGenRec.Type::Doz) and (AutoGenRec."Unit N0." = 'DOZ') then
                                    ConvFactor := 1;


                                //Generate Production BOM Lines
                                ProdBOMLineRec.Reset();
                                ProdBOMLineRec.SetCurrentKey("Production BOM No.", Description);
                                ProdBOMLineRec.SetRange("Production BOM No.", NextBomNo);
                                ProdBOMLineRec.SetRange(Description, Description);

                                if not ProdBOMLineRec.FindSet() then begin    //Not existing bom item

                                    LineNo += 10000;
                                    ProdBOMLine1Rec.Init();
                                    ProdBOMLine1Rec."Production BOM No." := NextBomNo;
                                    //ProdBOMLine1Rec.Validate("Main Category Name", AutoGenRec."Main Category Name");
                                    ProdBOMLine1Rec.Validate("Main Category Code", AutoGenRec."Main Category No.");
                                    ProdBOMLine1Rec."Line No." := LineNo;
                                    ProdBOMLine1Rec.Type := ProdBOMLine1Rec.Type::Item;
                                    ProdBOMLine1Rec.Validate("No.", NextItemNo);
                                    ProdBOMLine1Rec.Description := Description;
                                    ProdBOMLine1Rec.Validate("Unit of Measure Code", AutoGenRec."Unit N0.");
                                    //ProdBOMLine1Rec.Validate(Quantity, AutoGenRec.Consumption);  

                                    if AutoGenRec.Type = AutoGenRec.Type::Pcs then
                                        ConsumptionTot := AutoGenRec.Consumption + (AutoGenRec.Consumption * AutoGenRec.WST) / 100
                                    else
                                        if AutoGenRec.Type = AutoGenRec.Type::Doz then
                                            ConsumptionTot := (AutoGenRec.Consumption + (AutoGenRec.Consumption * AutoGenRec.WST) / 100) / 12;

                                    if ConvFactor <> 0 then
                                        ConsumptionTot := ConsumptionTot / ConvFactor;

                                    if ConsumptionTot = 0 then
                                        ConsumptionTot := 1;

                                    ProdBOMLine1Rec.Quantity := ConsumptionTot;
                                    ProdBOMLine1Rec."Quantity per" := ConsumptionTot;
                                    ProdBOMLine1Rec.Insert(true);

                                end
                                else begin  // Update existing item qty

                                    if AutoGenRec.Type = AutoGenRec.Type::Pcs then
                                        ConsumptionTot := AutoGenRec.Consumption + (AutoGenRec.Consumption * AutoGenRec.WST) / 100
                                    else
                                        if AutoGenRec.Type = AutoGenRec.Type::Doz then
                                            ConsumptionTot := (AutoGenRec.Consumption + (AutoGenRec.Consumption * AutoGenRec.WST) / 100) / 12;

                                    if ConvFactor <> 0 then
                                        ConsumptionTot := ConsumptionTot / ConvFactor;

                                    if ConsumptionTot = 0 then
                                        ConsumptionTot := 1;


                                    //ProdBOMLineRec.Validate(Quantity, ProdBOMLineRec."Quantity" + AutoGenRec.Consumption);
                                    ProdBOMLineRec."Quantity" := ProdBOMLineRec."Quantity" + ConsumptionTot;
                                    ProdBOMLineRec."Quantity per" := ProdBOMLineRec."Quantity per" + ConsumptionTot;
                                    ProdBOMLineRec.Modify();

                                end;

                                //Create Worksheet Entry
                                CreateWorksheetEntry(NextItemNo, AutoGenRec."Supplier No.", AutoGenRec.Requirment, AutoGenRec.Rate, Lot, AutoGenRec.PO, AutoGenRec."Main Category Name");

                                //Update Auto generate
                                // AutoGenRec."Included in PO" := true;
                                // AutoGenRec."Include in PO" := false;
                                //AutoGenRec."Production BOM No." := NextBomNo;
                                AutoGenRec."New Item No." := NextItemNo;
                                AutoGenRec.Modify();

                                //Update Prod BOm No in item master
                                ItemMasterRec.Reset();
                                ItemMasterRec.SetRange("No.", FGItem);

                                if ItemMasterRec.FindSet() then
                                    ItemMasterRec.ModifyAll("Production BOM No.", NextBomNo);


                                //insert Autogen prod bom table
                                AutoGenPrBOMRec.Init();
                                AutoGenPrBOMRec."No." := rec."No";
                                AutoGenPrBOMRec."Item No." := AutoGenRec."Item No.";
                                AutoGenPrBOMRec."Line No." := AutoGenRec."Line No.";
                                AutoGenPrBOMRec."Created User" := UserId;
                                AutoGenPrBOMRec."Created Date" := WorkDate();
                                AutoGenPrBOMRec."Production BOM No." := NextBomNo;
                                AutoGenPrBOMRec.Insert();

                                // AutoGenPrBOMRec.Insert()();
                                // AutoGenPrBOMRec.SetRange("No.", AutoGenRec."No.");
                                // AutoGenPrBOMRec.SetRange("Item No.", AutoGenRec."Item No.");
                                // AutoGenPrBOMRec.SetRange("Line No.", AutoGenRec."Line No.");

                                // if AutoGenPrBOMRec.FindSet() then begin
                                //     AutoGenPrBOMRec."Production BOM No." := NextBomNo;
                                //     AutoGenPrBOMRec.Modify();
                                // end;                                

                            end;
                        end;

                    end;

                end;

            until AutoGenRec.Next() = 0;

            //StatusGB := 1;

            //Update Status of the BOM to released
            ProdBOMHeaderRec.Reset();
            ProdBOMHeaderRec.SetRange("No.", NextBOMNo);
            if ProdBOMHeaderRec.FindSet() then begin
                ProdBOMHeaderRec.Validate(Status, 1);
                ProdBOMHeaderRec.Modify();
            end;

        end;

    end;

    procedure UpdateProdBOM(Color: code[20]; Size: Code[20]; Lot: Code[20]; FGItem: Code[20]; ProdBOM: Code[20])
    var
        //NextBOMNo: Code[20];
        ItemCategoryRec: Record "Item Category";
        NoSeriesManagementCode: Codeunit NoSeriesManagement;
        ProdBOMHeaderRec: Record "Production BOM Header";
        ProdBOMLineRec: Record "Production BOM Line";
        ProdBOMLine1Rec: Record "Production BOM Line";
        AutoGenRec: Record "BOM Line AutoGen";
        AutoGenPrBOMRec: Record "BOM Line AutoGen ProdBOM";
        BOMLineEstimateRec: Record "BOM Line Estimate";
        MainCateRec: Record "Main Category";
        NavAppSetupRec: Record "NavApp Setup";
        ItemUinitRec: Record "Item Unit of Measure";
        LineNo: Integer;
        ItemMasterRec: Record item;
        Description: Text[500];
        NextItemNo: Code[20];
        UOMRec: Record "Unit of Measure";
        ConvFactor: Decimal;
        ConsumptionTot: Decimal;
    //HeaderGenerated: Boolean;
    begin

        //Get Worksheet line no
        NavAppSetupRec.Reset();
        NavAppSetupRec.FindSet();

        AutoGenRec.Reset();
        AutoGenRec.SetCurrentKey("Main Category No.", "Item No.", "GMT Color No.", "GMT Size Name", "Lot No.");
        AutoGenRec.Ascending(true);
        AutoGenRec.SetRange("No.", rec."No");
        AutoGenRec.SetRange("Lot No.", lot);
        AutoGenRec.SetRange("GMT Color No.", Color);
        //AutoGenRec.SetRange("GMT Size Name", Size);

        if AutoGenRec.FindSet() then begin

            repeat

                if (AutoGenRec."Include in PO" = true) and (AutoGenRec."Included in PO" = false) then begin

                    BOMLineEstimateRec.Reset();
                    BOMLineEstimateRec.SetRange("No.", rec."No");
                    BOMLineEstimateRec.SetRange("Item No.", AutoGenRec."Item No.");
                    BOMLineEstimateRec.SetRange("Placement of GMT", AutoGenRec."Placement of GMT");

                    if BOMLineEstimateRec.FindSet() then begin

                        if BOMLineEstimateRec.Reconfirm = false then begin

                            // if HeaderGenerated = false then begin

                            //     //Generate Production BOM Header                                            
                            //     NextBomNo := NoSeriesManagementCode.GetNextNo('PRODBOM', Today(), true);
                            //     ProdBOMHeaderRec.Init();
                            //     ProdBOMHeaderRec."No." := NextBomNo;
                            //     ProdBOMHeaderRec.Description := "Style Name";
                            //     ProdBOMHeaderRec.Validate("Unit of Measure Code", 'PCS');
                            //     ProdBOMHeaderRec.Validate("Low-Level Code", 0);
                            //     ProdBOMHeaderRec.Validate(Status, 0);
                            //     ProdBOMHeaderRec."Creation Date" := WorkDate();
                            //     ProdBOMHeaderRec."Last Date Modified" := WorkDate();
                            //     ProdBOMHeaderRec."No. Series" := 'PRODBOM';
                            //     ProdBOMHeaderRec.Insert(true);
                            //     HeaderGenerated := true;

                            // end;

                            if (AutoGenRec."GMT Size Name" = Size) or (AutoGenRec."GMT Size Name" = '') then begin

                                //Get Dimenion only status
                                MainCateRec.Reset();
                                MainCateRec.SetRange("No.", AutoGenRec."Main Category No.");
                                if MainCateRec.FindSet() then begin
                                    if MainCateRec."Inv. Posting Group Code" = '' then
                                        Error('Inventory Posting Group is not setup for the Main Category : %1. Cannot proceed.', AutoGenRec."Main Category Name");

                                    if MainCateRec."Prod. Posting Group Code" = '' then
                                        Error('Product Posting Group is not setup for the Main Category : %1. Cannot proceed.', AutoGenRec."Main Category Name");
                                end
                                else
                                    Error('Cannot find Main Category details.');

                                //Generate description
                                Description := AutoGenRec."Item Name";

                                if AutoGenRec."Item Color Name" <> '' then
                                    Description := Description + ' / ' + AutoGenRec."Item Color Name";

                                if AutoGenRec."Article Name." <> '' then
                                    Description := Description + ' / ' + AutoGenRec."Article Name.";

                                if MainCateRec.DimensionOnly then begin
                                    if AutoGenRec."Dimension Name." <> '' then
                                        Description := Description + ' / ' + AutoGenRec."Dimension Name.";
                                end
                                else begin
                                    if AutoGenRec."GMT Size Name" <> '' then
                                        Description := Description + ' / ' + AutoGenRec."GMT Size Name";
                                end;


                                //Check whether item exists
                                ItemMasterRec.Reset();
                                ItemMasterRec.SetRange(Description, Description);

                                if ItemMasterRec.FindSet() then begin
                                    NextItemNo := ItemMasterRec."No.";

                                    ItemUinitRec.Reset();
                                    ItemUinitRec.SetRange("Item No.", NextItemNo);
                                    ItemUinitRec.SetRange(Code, AutoGenRec."Unit N0.");

                                    if not ItemUinitRec.FindSet() then begin
                                        //Insert into Item unit of measure
                                        ItemUinitRec.Init();
                                        ItemUinitRec."Item No." := NextItemNo;
                                        ItemUinitRec.Code := AutoGenRec."Unit N0.";
                                        ItemUinitRec."Qty. per Unit of Measure" := 1;
                                        ItemUinitRec.Insert();
                                    end;

                                    ItemMasterRec.validate("Gen. Prod. Posting Group", MainCateRec."Prod. Posting Group Code");
                                    ItemMasterRec.validate("Inventory Posting Group", MainCateRec."Inv. Posting Group Code");
                                    ItemMasterRec.Modify();
                                end
                                else begin

                                    NextItemNo := NoSeriesManagementCode.GetNextNo(NavAppSetupRec."RM Nos.", Today(), true);

                                    ItemMasterRec.Init();
                                    ItemMasterRec."No." := NextItemNo;
                                    ItemMasterRec.Description := Description;
                                    ItemMasterRec."Main Category No." := AutoGenRec."Main Category No.";
                                    ItemMasterRec."Main Category Name" := AutoGenRec."Main Category Name";
                                    ItemMasterRec."Rounding Precision" := 0.00001;

                                    //Check for Item category
                                    ItemCategoryRec.Reset();
                                    ItemCategoryRec.SetRange(Code, AutoGenRec."Main Category No.");
                                    if not ItemCategoryRec.FindSet() then begin
                                        ItemCategoryRec.Init();
                                        ItemCategoryRec.Code := AutoGenRec."Main Category No.";
                                        ItemCategoryRec.Description := AutoGenRec."Main Category Name";
                                        ItemCategoryRec.Insert();
                                    end;

                                    ItemMasterRec."Item Category Code" := AutoGenRec."Main Category No.";

                                    ItemMasterRec."Sub Category No." := AutoGenRec."Sub Category No.";
                                    ItemMasterRec."Sub Category Name" := AutoGenRec."Sub Category Name";
                                    ItemMasterRec."Color No." := AutoGenRec."Item Color No.";
                                    ItemMasterRec."Color Name" := AutoGenRec."Item Color Name";

                                    if MainCateRec.DimensionOnly then
                                        ItemMasterRec."Size Range No." := AutoGenRec."Dimension Name."
                                    else
                                        ItemMasterRec."Size Range No." := AutoGenRec."GMT Size Name";

                                    ItemMasterRec."Article No." := AutoGenRec."Article No.";
                                    ItemMasterRec."Dimension Width No." := AutoGenRec."Dimension No.";
                                    ItemMasterRec.Type := ItemMasterRec.Type::Inventory;
                                    ItemMasterRec."Unit Cost" := AutoGenRec.Rate;
                                    ItemMasterRec."Unit Price" := AutoGenRec.Rate;
                                    ItemMasterRec."Last Direct Cost" := AutoGenRec.Rate;
                                    ItemMasterRec.validate("Gen. Prod. Posting Group", MainCateRec."Prod. Posting Group Code");
                                    ItemMasterRec.validate("Inventory Posting Group", MainCateRec."Inv. Posting Group Code");
                                    //ItemMasterRec."Inventory Posting Group" := NavAppSetupRec."Inventory Posting Group-RM";
                                    ItemMasterRec."VAT Prod. Posting Group" := 'ZERO';
                                    //ItemMasterRec."VAT Bus. Posting Gr. (Price)" := 'ZERO';

                                    if MainCateRec.LOTTracking then begin
                                        ItemMasterRec.Validate("Item Tracking Code", NavAppSetupRec."LOT Tracking Code");
                                        ItemMasterRec."Lot Nos." := NavAppSetupRec."LOTTracking Nos.";
                                    end;

                                    //Insert into Item unit of measure
                                    ItemUinitRec.Init();
                                    ItemUinitRec."Item No." := NextItemNo;
                                    ItemUinitRec.Code := AutoGenRec."Unit N0.";
                                    ItemUinitRec."Qty. per Unit of Measure" := 1;

                                    ItemUinitRec.Insert();

                                    ItemMasterRec.Validate("Base Unit of Measure", AutoGenRec."Unit N0.");
                                    ItemMasterRec.Validate("Replenishment System", 0);
                                    ItemMasterRec.Validate("Manufacturing Policy", 1);
                                    ItemMasterRec.Insert(true);

                                end;


                                //Update Status of the BOM to New
                                ProdBOMHeaderRec.Reset();
                                ProdBOMHeaderRec.SetRange("No.", ProdBOM);
                                if ProdBOMHeaderRec.FindSet() then begin
                                    ProdBOMHeaderRec.Validate(Status, 0);
                                    ProdBOMHeaderRec.Modify();
                                end;

                                //get max line no
                                ProdBOMLineRec.Reset();
                                ProdBOMLineRec.SetRange("Production BOM No.", ProdBOM);

                                if ProdBOMLineRec.FindLast() then
                                    LineNo := ProdBOMLineRec."Line No.";


                                UOMRec.Reset();
                                UOMRec.SetRange(Code, AutoGenRec."Unit N0.");
                                UOMRec.FindSet();
                                ConvFactor := UOMRec."Converion Parameter";

                                if ConvFactor = 0 then
                                    ConvFactor := 1;

                                if (AutoGenRec.Type = AutoGenRec.Type::Doz) and (AutoGenRec."Unit N0." = 'DOZ') then
                                    ConvFactor := 1;


                                //Generate Production BOM Lines
                                ProdBOMLineRec.Reset();
                                ProdBOMLineRec.SetCurrentKey("Production BOM No.", Description);
                                ProdBOMLineRec.SetRange("Production BOM No.", ProdBOM);
                                ProdBOMLineRec.SetRange(Description, Description);

                                if not ProdBOMLineRec.FindSet() then begin    //Not existing bom item

                                    LineNo += 10000;
                                    ProdBOMLine1Rec.Init();
                                    ProdBOMLine1Rec."Production BOM No." := ProdBOM;
                                    ProdBOMLine1Rec."Line No." := LineNo;
                                    ProdBOMLine1Rec.Type := ProdBOMLine1Rec.Type::Item;
                                    //ProdBOMLine1Rec.Validate("Main Category Name", AutoGenRec."Main Category Name");
                                    ProdBOMLine1Rec.Validate("Main Category Code", AutoGenRec."Main Category No.");
                                    ProdBOMLine1Rec.Validate("No.", NextItemNo);
                                    ProdBOMLine1Rec.Description := Description;
                                    ProdBOMLine1Rec.Validate("Unit of Measure Code", AutoGenRec."Unit N0.");
                                    //ProdBOMLine1Rec.Validate(Quantity, AutoGenRec.Consumption);

                                    if AutoGenRec.Type = AutoGenRec.Type::Pcs then
                                        ConsumptionTot := AutoGenRec.Consumption + (AutoGenRec.Consumption * AutoGenRec.WST) / 100
                                    else
                                        if AutoGenRec.Type = AutoGenRec.Type::Doz then
                                            ConsumptionTot := (AutoGenRec.Consumption + (AutoGenRec.Consumption * AutoGenRec.WST) / 100) / 12;

                                    if ConvFactor <> 0 then
                                        ConsumptionTot := ConsumptionTot / ConvFactor;

                                    if ConsumptionTot = 0 then
                                        ConsumptionTot := 1;

                                    ProdBOMLine1Rec.Quantity := ConsumptionTot;
                                    ProdBOMLine1Rec."Quantity per" := ConsumptionTot;
                                    ProdBOMLine1Rec.Insert(true);

                                    //ProdBOMLine1Rec.Quantity := AutoGenRec.Consumption;
                                    //ProdBOMLine1Rec."Quantity per" := AutoGenRec.Consumption / ConvFactor;
                                    //ProdBOMLine1Rec.Insert(true);

                                end
                                else begin  // Update existing item qty

                                    if AutoGenRec.Type = AutoGenRec.Type::Pcs then
                                        ConsumptionTot := AutoGenRec.Consumption + (AutoGenRec.Consumption * AutoGenRec.WST) / 100
                                    else
                                        if AutoGenRec.Type = AutoGenRec.Type::Doz then
                                            ConsumptionTot := (AutoGenRec.Consumption + (AutoGenRec.Consumption * AutoGenRec.WST) / 100) / 12;

                                    if ConvFactor <> 0 then
                                        ConsumptionTot := ConsumptionTot / ConvFactor;

                                    if ConsumptionTot = 0 then
                                        ConsumptionTot := 1;

                                    ProdBOMLineRec."Quantity" := ProdBOMLineRec."Quantity" + ConsumptionTot;
                                    ProdBOMLineRec."Quantity per" := ProdBOMLineRec."Quantity per" + ConsumptionTot;
                                    ProdBOMLineRec.Modify();

                                    // ProdBOMLineRec."Quantity" := ProdBOMLineRec."Quantity" + AutoGenRec.Consumption / ConvFactor;
                                    // ProdBOMLineRec."Quantity per" := ProdBOMLineRec."Quantity per" + AutoGenRec.Consumption / ConvFactor;
                                    // //ProdBOMLineRec.Validate(Quantity, ProdBOMLineRec."Quantity" + AutoGenRec.Consumption);
                                    // ProdBOMLineRec.Modify();

                                end;


                                //Set status to release
                                ProdBOMHeaderRec.Reset();
                                ProdBOMHeaderRec.SetRange("No.", ProdBOM);
                                if ProdBOMHeaderRec.FindSet() then begin
                                    ProdBOMHeaderRec.Validate(Status, 1);
                                    ProdBOMHeaderRec.Modify();
                                end;


                                //Create Worksheet Entry
                                CreateWorksheetEntry(NextItemNo, AutoGenRec."Supplier No.", AutoGenRec.Requirment, AutoGenRec.Rate, Lot, AutoGenRec.PO, AutoGenRec."Main Category Name");

                                //Update Auto generate
                                // AutoGenRec."Included in PO" := true;
                                // AutoGenRec."Include in PO" := false;
                                //AutoGenRec."Production BOM No." := ProdBOM;
                                AutoGenRec."New Item No." := NextItemNo;
                                AutoGenRec.Modify();


                                //insert Autogen prod bom table
                                AutoGenPrBOMRec.Init();
                                AutoGenPrBOMRec."No." := rec."No";
                                AutoGenPrBOMRec."Item No." := AutoGenRec."Item No.";
                                AutoGenPrBOMRec."Line No." := AutoGenRec."Line No.";
                                AutoGenPrBOMRec."Created User" := UserId;
                                AutoGenPrBOMRec."Created Date" := WorkDate();
                                AutoGenPrBOMRec."Production BOM No." := ProdBOM;
                                AutoGenPrBOMRec.Insert();

                                // //update Autogen prod bom table
                                // AutoGenPrBOMRec.Reset();
                                // AutoGenPrBOMRec.SetRange("No.", AutoGenRec."No.");
                                // AutoGenPrBOMRec.SetRange("Item No.", AutoGenRec."Item No.");
                                // AutoGenPrBOMRec.SetRange("Line No.", AutoGenRec."Line No.");

                                // if AutoGenPrBOMRec.FindSet() then begin
                                //     AutoGenPrBOMRec."Production BOM No." := ProdBOM;
                                //     AutoGenPrBOMRec.Modify();
                                // end;

                                //StatusGB := 1;

                            end;
                        end;

                    end;

                end;

            until AutoGenRec.Next() = 0;

        end;

    end;

    procedure CreateWorksheetEntry(Item: code[20]; Supplier: Code[20]; Qty: Decimal; Rate: Decimal; Lot: Code[20]; PONo: Code[20]; MainCat: Code[20])
    var
        NoSeriesManagementCode: Codeunit NoSeriesManagement;
        NavAppSetupRec: Record "NavApp Setup";
        RequLineRec: Record "Requisition Line";
        RequLineRec1: Record "Requisition Line";
        StyMasterRec: Record "Style Master";
        ReqLineNo: Integer;
        ItemRec: Record Item;
        NextLotNo: Code[20];
        LoginSessionsRec: Record LoginSessions;
        LoginRec: Page "Login Card";
        UserSetupRec: Record "User Setup";
    begin

        UserSetupRec.Reset();
        UserSetupRec.SetRange("User ID", UserId);

        if not UserSetupRec.FindSet() then
            Error('Cannot find user setup details');

        if UserSetupRec."Merchandizer Group Name" = '' then
            Error('Merchandiser Group Name not setup for the user.');

        //Get Worksheet line no
        NavAppSetupRec.Reset();
        NavAppSetupRec.FindSet();

        //Get location for the style
        StyMasterRec.Reset();
        StyMasterRec.SetRange("No.", rec."Style No.");
        StyMasterRec.FindSet();

        if StyMasterRec."Factory Code" = '' then
            Error('Factory is not assigned for the Style : %1', StyMasterRec."Style No.");


        //Get max line no
        RequLineRec.Reset();
        RequLineRec.SetRange("Worksheet Template Name", NavAppSetupRec."Worksheet Template Name");
        RequLineRec.SetRange("Journal Batch Name", NavAppSetupRec."Journal Batch Name");

        if RequLineRec.FindLast() then
            ReqLineNo := RequLineRec."Line No.";


        RequLineRec.Reset();
        RequLineRec.SetCurrentKey("Worksheet Template Name", "Journal Batch Name", "No.");
        RequLineRec.SetRange("Worksheet Template Name", NavAppSetupRec."Worksheet Template Name");
        RequLineRec.SetRange("Journal Batch Name", NavAppSetupRec."Journal Batch Name");
        RequLineRec.SetRange("Vendor No.", Supplier);
        RequLineRec.SetRange(StyleNo, rec."Style No.");
        RequLineRec.SetRange(Lot, Lot);
        RequLineRec.SetRange("No.", Item);

        if not RequLineRec.FindSet() then begin    //Not existing items

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

            ReqLineNo += 100;
            RequLineRec1.Init();
            RequLineRec1."Worksheet Template Name" := NavAppSetupRec."Worksheet Template Name";
            RequLineRec1."Journal Batch Name" := NavAppSetupRec."Journal Batch Name";
            RequLineRec1."Line No." := ReqLineNo;
            RequLineRec1."Main Category" := MainCat;
            RequLineRec1.Type := RequLineRec.Type::Item;
            RequLineRec1.Validate("No.", Item);
            RequLineRec1."Buyer No." := rec."Buyer No.";
            RequLineRec1."Buyer Name" := rec."Buyer Name";
            RequLineRec1.Validate("Vendor No.", Supplier);
            RequLineRec1."Action Message" := RequLineRec."Action Message"::New;
            RequLineRec1."Accept Action Message" := false;
            RequLineRec1."Ending Date" := Today + 7;
            RequLineRec1.Quantity := Qty;
            RequLineRec1."Direct Unit Cost" := Rate;
            RequLineRec1."Unit Cost" := Rate;
            RequLineRec1.StyleNo := rec."Style No.";
            RequLineRec1.StyleName := rec."Style Name";
            RequLineRec1.PONo := PONo;
            RequLineRec1.Lot := Lot;
            RequLineRec1.Validate("Global Dimension Code", StyMasterRec."Global Dimension Code");
            RequLineRec1.Validate("Location Code", StyMasterRec."Factory Code");
            RequLineRec1.Validate("Shortcut Dimension 1 Code", StyMasterRec."Global Dimension Code");
            RequLineRec1.EntryType := RequLineRec1.EntryType::FG;
            RequLineRec1."Secondary UserID" := LoginSessionsRec."Secondary UserID";
            RequLineRec1."Merchandizer Group Name" := UserSetupRec."Merchandizer Group Name";
            RequLineRec1.Insert();


            //Update Rates
            RequLineRec1.Reset();
            RequLineRec1.SetRange("Worksheet Template Name", NavAppSetupRec."Worksheet Template Name");
            RequLineRec1.SetRange("Journal Batch Name", NavAppSetupRec."Journal Batch Name");
            RequLineRec1.SetRange("No.", Item);
            RequLineRec1.SetRange("Line No.", ReqLineNo);
            if RequLineRec1.FindSet() then begin
                RequLineRec1."Direct Unit Cost" := Rate;
                RequLineRec1."Unit Cost" := Rate;
                RequLineRec1.Modify();
            end

        end
        else begin  // Update existing item
            RequLineRec."Quantity" := RequLineRec."Quantity" + Qty;
            RequLineRec.Modify();
        end;



        // //Get No series for LOT
        // ItemRec.Reset();
        // ItemRec.SetRange("No.", Item);
        // ItemRec.FindSet();

        // NextLotNo := NoSeriesManagementCode.GetNextNo(ItemRec."Lot Nos.", Today(), true);

        // //Insert to the reservaton entry table
        // InsertResvEntry(true, Item, StyMasterRec."Factory Code", Qty, 246, 0, NavAppSetupRec."Worksheet Template Name",
        // NavAppSetupRec."Journal Batch Name", 1000, Today, NextLotNo);

    end;


    local procedure InsertResvEntry(PassPos: Boolean; PassItemNo: Code[20]; PassLocation: Code[20]; PassQty: Decimal; PassSourceType: Integer;
    PassSubType: Integer; PassSourceID: Text[20]; PassBatch: Text[20]; PassRefNo: Integer; PassDate: Date; PassLotNo: Code[50])
    var
        ResvEntry: Record "Reservation Entry";
        LastEntryNo: Integer;
    begin
        if ResvEntry.FindLast() then
            LastEntryNo := ResvEntry."Entry No." + 1
        else
            LastEntryNo := 1;

        ResvEntry.LockTable();

        Clear(ResvEntry);
        ResvEntry.Init();
        ResvEntry."Entry No." := LastEntryNo;
        ResvEntry.Positive := PassPos;
        ResvEntry.Validate("Item No.", PassItemNo);
        ResvEntry.Validate("Location Code", PassLocation);
        ResvEntry.Validate("Quantity (Base)", PassQty);
        ResvEntry."Reservation Status" := ResvEntry."Reservation Status"::Tracking;
        ResvEntry."Creation Date" := Today;
        ResvEntry."Source Type" := PassSourceType;
        ResvEntry."Source Subtype" := PassSubType;
        ResvEntry."Source ID" := PassSourceID;
        ResvEntry."Source Batch Name" := PassBatch;
        ResvEntry."Source Ref. No." := PassRefNo;
        ResvEntry."Expected Receipt Date" := PassDate;
        ResvEntry."Created By" := UserId;
        ResvEntry.validate("Qty. per Unit of Measure", 1);
        ResvEntry."Lot No." := PassLotNo;
        ResvEntry."Item Tracking" := ResvEntry."Item Tracking"::"Lot No.";
        ResvEntry.Insert(true);
    end;

    procedure InsertAutoGenProdBOM(ItemNo: Code[20]; LineNo: Integer)
    var
        BLAutoGenPRBOMRec: Record "BOM Line AutoGen ProdBOM";
    begin
        // BLAutoGenPRBOMRec.Init();
        // BLAutoGenPRBOMRec."No." := "No";
        // BLAutoGenPRBOMRec."Item No." := ItemNo;
        // BLAutoGenPRBOMRec."Line No." := LineNo;
        // BLAutoGenPRBOMRec."Created User" := UserId;
        // BLAutoGenPRBOMRec."Created Date" := WorkDate();
        // BLAutoGenPRBOMRec."Production BOM No." := '';
        // BLAutoGenPRBOMRec.Insert();
    end;


    //Local variables
    var
        GrpSize: Text[50];
        GrpColor: code[20];
        GrpCountry: code[20];
        SalesHeaderGenerated: Boolean;
        NextOrderNo: Code[20];
        LineNo: Integer;
        StatusGB: Integer;

}
