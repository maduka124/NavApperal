page 71012673 AssoPackCountryListPart
{
    PageType = ListPart;
    AutoSplitKey = true;
    SourceTable = AssortmentDetails;
    SourceTableView = where(Type = filter('2'));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Country Name"; "Country Name")
                {
                    ApplicationArea = All;
                    Caption = 'Country';
                    //ShowMandatory = true;

                    trigger OnValidate()
                    var
                        CountryRec: Record "Country/Region";
                        StyleRec: Record "Style Master PO";
                        AssoDetRec: Record AssortmentDetails;
                        BOMRec: Record BOM;
                        BOMAutoGenRec: Record "BOM Line AutoGen";
                    begin
                        if "Lot No." = '' then
                            Error('Invalid Lot No');

                        //Check for whether BOm created for the style
                        BOMRec.SetRange("Style No.", "Style No.");
                        if BOMRec.FindSet() then begin
                            BOMAutoGenRec.Reset();
                            BOMAutoGenRec.SetRange("No.", BOMRec.No);
                            if BOMAutoGenRec.FindSet() then begin
                                repeat
                                    if BOMAutoGenRec."Included in PO" = true then
                                        Error('MRP Posting has been completed for BOM : %1. To add new Country, run the Reverse MRP process for BOM : %1.', BOMRec.No);
                                until BOMAutoGenRec.Next() = 0;
                            end;
                        end;


                        CountryRec.Reset();
                        CountryRec.SetRange("Name", "Country Name");
                        if CountryRec.FindSet() then
                            "Country Code" := CountryRec.Code;

                        //CurrPage.Update();
                        //Check Duplicates
                        AssoDetRec.Reset();
                        AssoDetRec.SetRange("Style No.", "Style No.");
                        AssoDetRec.SetRange("Country Code", "Country Code");
                        AssoDetRec.SetRange("Lot No.", "Lot No.");
                        AssoDetRec.SetFilter(Type, '=%1', '2');

                        if AssoDetRec.FindSet() then
                            Error('Country already defined.');

                        StyleRec.Reset();
                        StyleRec.SetRange("Style No.", "Style No.");
                        StyleRec.SetRange("Lot No.", "Lot No.");
                        StyleRec.FindLast();

                        "PO No." := StyleRec."PO No.";
                    end;
                }

                field(Pack; Pack)
                {
                    ApplicationArea = All;
                    //ShowMandatory = true;

                    trigger OnValidate()
                    var
                        PackRec: Record Pack;
                        BOMRec: Record BOM;
                        BOMAutoGenRec: Record "BOM Line AutoGen";
                    begin
                        if "Lot No." = '' then
                            Error('Invalid Lot No');

                        // Check for whether BOm created for the style
                        BOMRec.SetRange("Style No.", "Style No.");
                        if BOMRec.FindSet() then begin
                            BOMAutoGenRec.Reset();
                            BOMAutoGenRec.SetRange("No.", BOMRec.No);
                            if BOMAutoGenRec.FindSet() then begin
                                repeat
                                    if BOMAutoGenRec."Included in PO" = true then
                                        Error('MRP Posting has been completed for BOM : %1. To add new Country, run the Reverse MRP process for BOM : %1.', BOMRec.No);
                                until BOMAutoGenRec.Next() = 0;
                            end;
                        end;

                        PackRec.Reset();
                        PackRec.SetRange(Pack, Pack);
                        if PackRec.FindSet() then
                            "Pack No" := PackRec."No.";
                    end;
                }

                field(Category; Category)
                {
                    ApplicationArea = All;
                    Caption = 'Type';
                }

                field("SID/REF No"; "SID/REF No")
                {
                    ApplicationArea = All;
                }

                field("No Pack"; "No Pack")
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
            action("Copy Size/Colour/Country To All PO")
            {
                ApplicationArea = All;
                Image = CopyCosttoGLBudget;

                trigger OnAction();
                var
                    AssorDetailsRec: Record AssortmentDetails;
                    AssorDetailsNewRec: Record AssortmentDetails;
                    AssorDetailsInseamNewRec: Record AssortmentDetailsInseam;
                    AssorDetailsInseamRec: Record AssortmentDetailsInseam;
                    PORec: Record "Style Master PO";
                    LineNo: Integer;
                begin
                    //Color
                    AssorDetailsRec.Reset();
                    AssorDetailsRec.SetRange("Style No.", "Style No.");
                    AssorDetailsRec.SetRange("lot No.", "lot No.");
                    AssorDetailsRec.SetRange(Type, '1');

                    //Size
                    AssorDetailsInseamRec.Reset();
                    AssorDetailsInseamRec.SetRange("Style No.", "Style No.");
                    AssorDetailsInseamRec.SetRange("lot No.", "lot No.");

                    /////////////////////Copying Colors
                    PORec.Reset();
                    PORec.SetRange("Style No.", "Style No.");
                    PORec.FindSet();

                    if not AssorDetailsRec.FINDSET() then
                        Message('Cannot find color details for PO NO %1', "PO No.")
                    else begin
                        repeat
                            LineNo := 0;
                            if "Lot No." <> PORec."Lot No." then begin
                                //Delete Existing records                                    
                                AssorDetailsNewRec.Reset();
                                AssorDetailsNewRec.SetRange("Style No.", "Style No.");
                                AssorDetailsNewRec.SetRange("Lot No.", PORec."Lot No.");
                                AssorDetailsNewRec.SetRange(Type, '1');
                                AssorDetailsNewRec.DeleteAll();

                                repeat
                                    //Add new record
                                    LineNo += 10000;
                                    AssorDetailsNewRec.Init();
                                    AssorDetailsNewRec."Style No." := "Style No.";
                                    AssorDetailsNewRec."PO No." := PORec."PO No.";
                                    AssorDetailsNewRec."Lot No." := PORec."Lot No.";
                                    AssorDetailsNewRec.Type := '1';
                                    AssorDetailsNewRec."Line No." := LineNo;
                                    AssorDetailsNewRec."Colour No" := AssorDetailsRec."Colour No";
                                    AssorDetailsNewRec."Colour Name" := AssorDetailsRec."Colour Name";
                                    AssorDetailsNewRec.Qty := AssorDetailsRec.Qty;
                                    AssorDetailsNewRec."Created User" := UserId;
                                    AssorDetailsNewRec."Created Date" := WorkDate();
                                    AssorDetailsNewRec.Insert();
                                until AssorDetailsRec.Next() = 0;
                                AssorDetailsRec.FindFirst();
                            end;
                        until PORec.Next() = 0;
                    end;


                    /////////////////////Copying Size
                    PORec.Reset();
                    PORec.SetRange("Style No.", "Style No.");
                    PORec.FindSet();

                    if not AssorDetailsInseamRec.FINDSET() then
                        Message('Cannot find size information for PO NO %1', "PO No.")
                    else begin
                        repeat
                            LineNo := 0;

                            if "Lot No." <> PORec."Lot No." then begin
                                //Delete Existing records                                    
                                AssorDetailsInseamNewRec.Reset();
                                AssorDetailsInseamNewRec.SetRange("Style No.", "Style No.");
                                AssorDetailsInseamNewRec.SetRange("Lot No.", PORec."Lot No.");
                                AssorDetailsInseamNewRec.DeleteAll();

                                repeat
                                    //Add new record
                                    LineNo += 10000;
                                    AssorDetailsInseamNewRec.Init();
                                    AssorDetailsInseamNewRec."Style No." := "Style No.";
                                    AssorDetailsInseamNewRec."Lot No." := PORec."Lot No.";
                                    AssorDetailsInseamNewRec."PO No." := PORec."PO No.";
                                    AssorDetailsInseamNewRec."Line No." := LineNo;
                                    AssorDetailsInseamNewRec."Com Size" := AssorDetailsInseamRec."Com Size";
                                    AssorDetailsInseamNewRec.InSeam := AssorDetailsInseamRec.InSeam;
                                    AssorDetailsInseamNewRec."GMT Size" := AssorDetailsInseamRec."GMT Size";
                                    AssorDetailsInseamNewRec."Created User" := UserId;
                                    AssorDetailsInseamNewRec."Created Date" := WorkDate();
                                    AssorDetailsInseamNewRec.Insert();
                                until AssorDetailsInseamRec.Next() = 0;
                                AssorDetailsInseamRec.FindFirst();
                            end;
                        until PORec.Next() = 0;
                    end;


                    /////////////////////Copying Country
                    AssorDetailsRec.Reset();
                    AssorDetailsRec.SetRange("Style No.", "Style No.");
                    AssorDetailsRec.SetRange("lot No.", "lot No.");
                    AssorDetailsRec.SetRange(Type, '2');

                    PORec.Reset();
                    PORec.SetRange("Style No.", "Style No.");
                    PORec.FindSet();

                    if not AssorDetailsRec.FINDSET() then
                        Message('Cannot find country details for PO NO %1', "PO No.")
                    else begin
                        repeat
                            LineNo := 0;
                            if "Lot No." <> PORec."Lot No." then begin
                                //Delete Existing records                                    
                                AssorDetailsNewRec.Reset();
                                AssorDetailsNewRec.SetRange("Style No.", "Style No.");
                                AssorDetailsNewRec.SetRange("Lot No.", PORec."Lot No.");
                                AssorDetailsNewRec.SetRange(Type, '2');
                                AssorDetailsNewRec.DeleteAll();

                                repeat

                                    if AssorDetailsRec."Country Code" = '' then
                                        Error('Invalid country');

                                    if AssorDetailsRec."Pack No" = '' then
                                        Error('Invalid Pack');

                                    //Add new record
                                    LineNo += 10000;
                                    AssorDetailsNewRec.Init();
                                    AssorDetailsNewRec."Style No." := "Style No.";
                                    AssorDetailsNewRec."PO No." := PORec."PO No.";
                                    AssorDetailsNewRec."Lot No." := PORec."Lot No.";
                                    AssorDetailsNewRec.Type := '2';
                                    AssorDetailsNewRec."Line No." := LineNo;
                                    AssorDetailsNewRec."Country Code" := AssorDetailsRec."Country Code";
                                    AssorDetailsNewRec."Country Name" := AssorDetailsRec."Country Name";
                                    AssorDetailsNewRec."Pack No" := AssorDetailsRec."Pack No";
                                    AssorDetailsNewRec."Pack" := AssorDetailsRec."Pack";
                                    AssorDetailsNewRec.Type := AssorDetailsRec.Type;
                                    AssorDetailsNewRec."SID/REF No" := AssorDetailsRec."SID/REF No";
                                    AssorDetailsNewRec."No Pack" := AssorDetailsRec."No Pack";
                                    AssorDetailsNewRec.Qty := AssorDetailsRec.Qty;
                                    AssorDetailsNewRec."Created User" := UserId;
                                    AssorDetailsNewRec."Created Date" := WorkDate();
                                    AssorDetailsNewRec.Insert();
                                until AssorDetailsRec.Next() = 0;
                                AssorDetailsRec.FindFirst();
                            end;
                        until PORec.Next() = 0;
                    end;


                    Message('Size/Color/Country copied to all PO');
                    CurrPage.Update();
                end;
            }
        }
    }


    trigger OnOpenPage()
    var
    begin
        Type := '2';
    end;


    trigger OnAfterGetCurrRecord()
    var
        AssorCardPage: page "Assortment Card";
        StyleMasterRec: Record "Style Master";
    begin
        // StyleMasterRec.Reset();
        // StyleMasterRec.SetRange("No.", "Style No.");
        // StyleMasterRec.ModifyAll("Pack No", "Pack No");
        AssorCardPage.xxx();
    end;


    trigger OnDeleteRecord(): Boolean
    var
        BOMRec: Record BOM;
        Style1Rec: Record "Style Master";
        AssorDetailsRec: Record AssortmentDetails;
        AssorColorSizeRatioRec: Record AssorColorSizeRatio;
        AssorColorSizeRatioView: Record AssorColorSizeRatioView;
        AssorColorSizeRatioPriceRec: Record AssorColorSizeRatioPrice;
        AssorCardPage: page "Assortment Card";
        Confirm: Boolean;
        LotTemp: Code[20];
        Question: Text;
        Text: Label 'Quantity has been entered for the Country : %1 in LOT : %2 . Do you want to delete Country from all POs.?';
    begin

        //Check for whether BOM created for the style
        BOMRec.SetRange("Style No.", "Style No.");
        if BOMRec.FindSet() then
            Error('Style %1 already assigned for the BOM %2 . You cannot delete Country.', Style1Rec."Style No.", BOMRec.No)
        else begin

            //Inform user about Country usage in other pos
            AssorColorSizeRatioRec.Reset();
            AssorColorSizeRatioRec.SetRange("Style No.", "Style No.");
            AssorColorSizeRatioRec.SetRange("Country Code", "Country Code");
            AssorColorSizeRatioRec.SetCurrentKey("lot No.");
            AssorColorSizeRatioRec.SetFilter("Lot No.", '<>%1', "Lot No.");

            if AssorColorSizeRatioRec.FindSet() then begin
                repeat
                    if AssorColorSizeRatioRec.Total <> '0' then begin
                        LotTemp := AssorColorSizeRatioRec."Lot No.";
                        break;
                    end;
                until AssorColorSizeRatioRec.Next() = 0;
            end;

            if LotTemp <> '' then begin
                Question := Text;
                if (Dialog.Confirm(Question, true, "Country Name", LotTemp) = true) then
                    Confirm := true
                else
                    Confirm := false;
            end
            else begin

                if (Dialog.CONFIRM('"Do you want to delete Country from all POs.?', true) = true) then
                    Confirm := true
                else
                    Confirm := false;
            end;


            //Delete Country from TAB (Other POs)
            if Confirm = true then begin
                AssorDetailsRec.Reset();
                AssorDetailsRec.SetRange("Style No.", "Style No.");
                AssorDetailsRec.SetRange("Country Code", "Country Code");

                if AssorDetailsRec.FindSet() then
                    AssorDetailsRec.DeleteAll();
            end;


            //Delete Country from size ratio TAB
            AssorColorSizeRatioRec.Reset();
            AssorColorSizeRatioRec.SetRange("Style No.", "Style No.");
            AssorColorSizeRatioRec.SetRange("Country Code", "Country Code");

            if Confirm = false then
                AssorColorSizeRatioRec.SetRange("lot No.", "Lot No.");

            if AssorColorSizeRatioRec.FindSet() then
                AssorColorSizeRatioRec.DeleteAll();


            //Delete Country from Quantity breakdown TAB
            AssorColorSizeRatioView.Reset();
            AssorColorSizeRatioView.SetRange("Style No.", "Style No.");
            AssorColorSizeRatioView.SetRange("Country Code", "Country Code");

            if Confirm = false then
                AssorColorSizeRatioView.SetRange("lot No.", "Lot No.");

            if AssorColorSizeRatioView.FindSet() then
                AssorColorSizeRatioView.DeleteAll();


            //Delete Country from price TAB
            AssorColorSizeRatioPriceRec.Reset();
            AssorColorSizeRatioPriceRec.SetRange("Style No.", "Style No.");
            AssorColorSizeRatioPriceRec.SetRange("Country Code", "Country Code");

            if Confirm = false then
                AssorColorSizeRatioPriceRec.SetRange("lot No.", "Lot No.");

            if AssorColorSizeRatioPriceRec.FindSet() then
                AssorColorSizeRatioPriceRec.DeleteAll();

            exit(true);

        end;
    end;


}