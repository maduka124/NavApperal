page 71012671 AssoColourSizeListPart
{
    PageType = ListPart;
    AutoSplitKey = true;
    SourceTable = AssortmentDetails;
    SourceTableView = where(Type = filter('1'));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Colour No"; Rec."Colour No")
                {
                    ApplicationArea = All;
                    Caption = 'Color Code';

                    trigger OnValidate()
                    var
                        ColourRec: Record Colour;
                        StyleRec: Record "Style Master PO";
                        AssoDetRec: Record AssortmentDetails;
                        BOMRec: Record BOM;
                        BOMAutoGenRec: Record "BOM Line AutoGen";
                    begin

                        if Rec."Lot No." = '' then
                            Error('Invalid Lot No');

                        //Check for whether BOm created for the style
                        BOMRec.SetRange("Style No.", Rec."Style No.");
                        if BOMRec.FindSet() then begin
                            BOMAutoGenRec.Reset();
                            BOMAutoGenRec.SetRange("No.", BOMRec.No);
                            if BOMAutoGenRec.FindSet() then begin
                                repeat
                                    if BOMAutoGenRec."Included in PO" = true then
                                        Error('MRP Posting has been completed for BOM : %1. To add new color, run the Reverse MRP process for BOM : %1.', BOMRec.No);
                                until BOMAutoGenRec.Next() = 0;
                            end;
                        end;

                        //Check Duplicates
                        AssoDetRec.Reset();
                        AssoDetRec.SetRange("Style No.", Rec."Style No.");
                        AssoDetRec.SetRange("Colour No", Rec."Colour No");
                        AssoDetRec.SetRange("Lot No.", Rec."Lot No.");
                        AssoDetRec.SetFilter(Type, '=%1', '1');

                        if AssoDetRec.FindSet() then
                            Error('Color already defined.');

                        ColourRec.get(Rec."Colour No");
                        Rec."Colour Name" := ColourRec."Colour Name";

                        StyleRec.Reset();
                        StyleRec.SetRange("Style No.", Rec."Style No.");
                        StyleRec.SetRange("Lot No.", Rec."Lot No.");
                        StyleRec.FindLast();

                        Rec."PO No." := StyleRec."PO No.";
                    end;
                }

                field("Colour Name"; Rec."Colour Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Color';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Change Colour")
            {
                ApplicationArea = All;
                Image = Change;

                trigger OnAction()
                var
                    ChangeColour: Page "Change Colour Card";
                begin

                    Clear(ChangeColour);
                    ChangeColour.LookupMode(true);
                    ChangeColour.PassParameters(Rec."Style No.", Rec."Lot No.");
                    ChangeColour.RunModal();

                end;
            }
        }
    }

    trigger OnOpenPage()
    var
    begin
        Rec.Type := '1';
    end;


    trigger OnDeleteRecord(): Boolean
    var
        BOMRec: Record BOM;
        Style1Rec: Record "Style Master";
        AssorDetailsRec: Record AssortmentDetails;
        AssorColorSizeRatioRec: Record AssorColorSizeRatio;
        AssorColorSizeRatioView: Record AssorColorSizeRatioView;
        AssorColorSizeRatioPriceRec: Record AssorColorSizeRatioPrice;
        Confirm: Boolean;
        LotTemp: Code[20];
        Question: Text;
        Text: Label 'Quantity has been entered for the Color : %1 in LOT : %2 . Do you want to delete color from all POs.?';
    begin

        //Check for whether BOM created for the style
        BOMRec.SetRange("Style No.", Rec."Style No.");
        if BOMRec.FindSet() then
            Error('Style %1 already assigned for the BOM %2 . You cannot delete colors.', Style1Rec."Style No.", BOMRec.No)
        else begin

            //Inform user about color usage in other pos
            AssorColorSizeRatioRec.Reset();
            AssorColorSizeRatioRec.SetRange("Style No.", Rec."Style No.");
            AssorColorSizeRatioRec.SetRange("Colour No", Rec."Colour No");
            AssorColorSizeRatioRec.SetCurrentKey("lot No.");
            AssorColorSizeRatioRec.SetFilter("Lot No.", '<>%1', Rec."Lot No.");

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
                if (Dialog.Confirm(Question, true, Rec."Colour Name", LotTemp) = true) then
                    Confirm := true
                else
                    Confirm := false;
            end
            else begin

                if (Dialog.CONFIRM('"Do you want to delete color from all POs.?', true) = true) then
                    Confirm := true
                else
                    Confirm := false;
            end;


            //Delete from color TAB (Other POs)
            if Confirm = true then begin
                AssorDetailsRec.Reset();
                AssorDetailsRec.SetRange("Style No.", Rec."Style No.");
                AssorDetailsRec.SetRange("Colour No", Rec."Colour No");

                if AssorDetailsRec.FindSet() then
                    AssorDetailsRec.DeleteAll();
            end;


            //Delete from color size ratio TAB
            AssorColorSizeRatioRec.Reset();
            AssorColorSizeRatioRec.SetRange("Style No.", Rec."Style No.");
            AssorColorSizeRatioRec.SetRange("Colour No", Rec."Colour No");

            if Confirm = false then
                AssorColorSizeRatioRec.SetRange("lot No.", Rec."Lot No.");

            if AssorColorSizeRatioRec.FindSet() then
                AssorColorSizeRatioRec.DeleteAll();


            //Delete from Quantity breakdown TAB
            AssorColorSizeRatioView.Reset();
            AssorColorSizeRatioView.SetRange("Style No.", Rec."Style No.");
            AssorColorSizeRatioView.SetRange("Colour No", Rec."Colour No");

            if Confirm = false then
                AssorColorSizeRatioView.SetRange("lot No.", Rec."Lot No.");

            if AssorColorSizeRatioView.FindSet() then
                AssorColorSizeRatioView.DeleteAll();


            //Delete from color wise price TAB
            AssorColorSizeRatioPriceRec.Reset();
            AssorColorSizeRatioPriceRec.SetRange("Style No.", Rec."Style No.");
            AssorColorSizeRatioPriceRec.SetRange("Colour No", Rec."Colour No");

            if Confirm = false then
                AssorColorSizeRatioPriceRec.SetRange("lot No.", Rec."Lot No.");

            if AssorColorSizeRatioPriceRec.FindSet() then
                AssorColorSizeRatioPriceRec.DeleteAll();

            exit(true);
        end;
    end;

}