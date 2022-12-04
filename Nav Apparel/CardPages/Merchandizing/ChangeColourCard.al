page 71012808 "Change Colour Card"
{
    PageType = Card;
    Caption = 'Change Colour';
    SourceTable = "Change Colour";

    layout
    {
        area(Content)
        {
            field("From Colour Name"; rec."From Colour Name")
            {
                ApplicationArea = All;
                Caption = 'From Colour';

                trigger OnValidate()
                var
                    ColorRec: Record Colour;
                begin
                    ColorRec.Reset();
                    ColorRec.SetRange("Colour Name", rec."From Colour Name");
                    if ColorRec.FindSet() then
                        rec."From Colour No" := ColorRec."No.";
                end;
            }

            field("To Colour Name"; rec."To Colour Name")
            {
                ApplicationArea = All;
                Caption = 'To Colour';

                trigger OnValidate()
                var
                    ColorRec: Record Colour;
                begin
                    ColorRec.Reset();
                    ColorRec.SetRange("Colour Name", rec."To Colour Name");
                    if ColorRec.FindSet() then
                        rec."To Colour No" := ColorRec."No.";
                end;
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
                    BOMRec: Record BOM;
                    Style1Rec: Record "Style Master";
                    AssoDetRec: Record AssortmentDetails;
                    AssorColorSizeRatioRec: Record AssorColorSizeRatio;
                    AssorColorSizeRatioView: Record AssorColorSizeRatioView;
                    AssorColorSizeRatioPriceRec: Record AssorColorSizeRatioPrice;
                    Confirm: Boolean;
                    LotTemp: Code[20];
                    Question: Text;
                    Text: Label 'Quantity has been entered for the Color : %1 in LOT : %2 . Do you want to change color in all POs.?';
                begin

                    BOMRec.SetRange("Style No.", rec."Style No.");
                    if BOMRec.FindSet() then
                        Error('Style %1 already assigned for the BOM %2 . You cannot change colors.', Style1Rec."Style No.", BOMRec.No);

                    if rec."From Colour Name" = '' then
                        Error('Invalid From Colour');

                    if rec."To Colour Name" = '' then
                        Error('Invalid To Colour');

                    if rec."From Colour Name" = rec."To Colour Name" then
                        Error('You cannot put same colour');

                    //Check for existance
                    AssoDetRec.Reset();
                    AssoDetRec.SetRange("Style No.", rec."Style No.");
                    AssoDetRec.SetRange("Colour No", rec."To Colour No");
                    AssoDetRec.SetRange("Lot No.", rec."Lot No.");
                    AssoDetRec.SetFilter(Type, '=%1', '1');

                    if AssoDetRec.FindSet() then
                        Error('Color already defined.');


                    //Inform user about color usage in other pos
                    AssorColorSizeRatioRec.Reset();
                    AssorColorSizeRatioRec.SetRange("Style No.", rec."Style No.");
                    AssorColorSizeRatioRec.SetRange("Colour No", rec."From Colour No");
                    AssorColorSizeRatioRec.SetCurrentKey("lot No.");
                    AssorColorSizeRatioRec.SetFilter("Lot No.", '<>%1', rec."Lot No.");

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
                        if (Dialog.Confirm(Question, true, rec."From Colour Name", LotTemp) = true) then
                            Confirm := true
                        else
                            Confirm := false;
                    end
                    else begin

                        if (Dialog.CONFIRM('"Do you want to change color in all POs.?', true) = true) then
                            Confirm := true
                        else
                            Confirm := false;
                    end;


                    //update color TAB
                    AssoDetRec.Reset();
                    AssoDetRec.SetRange("Style No.", rec."Style No.");
                    AssoDetRec.SetRange("Colour No", rec."From Colour No");

                    if Confirm = false then
                        AssoDetRec.SetRange("Lot No.", rec."Lot No.");

                    AssoDetRec.SetFilter(Type, '=%1', '1');

                    if AssoDetRec.FindSet() then begin
                        repeat
                            AssoDetRec."Colour No" := rec."To Colour No";
                            AssoDetRec."Colour Name" := rec."To Colour Name";
                            AssoDetRec.Modify();
                        until AssoDetRec.Next() = 0;
                    end;


                    //update Color size TAB
                    AssorColorSizeRatioRec.Reset();
                    AssorColorSizeRatioRec.Reset();
                    AssorColorSizeRatioRec.SetRange("Style No.", rec."Style No.");
                    AssorColorSizeRatioRec.SetRange("Colour No", rec."From Colour No");

                    if Confirm = false then
                        AssorColorSizeRatioRec.SetRange("Lot No.", rec."Lot No.");

                    if AssorColorSizeRatioRec.FindSet() then begin
                        repeat
                            AssorColorSizeRatioRec."Colour No" := rec."To Colour No";
                            AssorColorSizeRatioRec."Colour Name" := rec."To Colour Name";
                            AssorColorSizeRatioRec.Modify();
                        until AssorColorSizeRatioRec.Next() = 0;
                    end;


                    //update Quantity breakdown TAB
                    AssorColorSizeRatioView.Reset();
                    AssorColorSizeRatioView.Reset();
                    AssorColorSizeRatioView.SetRange("Style No.", rec."Style No.");
                    AssorColorSizeRatioView.SetRange("Colour No", rec."From Colour No");

                    if Confirm = false then
                        AssorColorSizeRatioView.SetRange("Lot No.", rec."Lot No.");

                    if AssorColorSizeRatioView.FindSet() then begin
                        repeat
                            AssorColorSizeRatioView."Colour No" := rec."To Colour No";
                            AssorColorSizeRatioView."Colour Name" := rec."To Colour Name";
                            AssorColorSizeRatioView.Modify();
                        until AssorColorSizeRatioView.Next() = 0;
                    end;


                    //update price TAB
                    AssorColorSizeRatioPriceRec.Reset();
                    AssorColorSizeRatioPriceRec.Reset();
                    AssorColorSizeRatioPriceRec.SetRange("Style No.", rec."Style No.");
                    AssorColorSizeRatioPriceRec.SetRange("Colour No", rec."From Colour No");

                    if Confirm = false then
                        AssorColorSizeRatioPriceRec.SetRange("Lot No.", rec."Lot No.");

                    if AssorColorSizeRatioPriceRec.FindSet() then begin
                        repeat
                            AssorColorSizeRatioPriceRec."Colour No" := rec."To Colour No";
                            AssorColorSizeRatioPriceRec."Colour Name" := rec."To Colour Name";
                            AssorColorSizeRatioPriceRec.Modify();
                        until AssorColorSizeRatioPriceRec.Next() = 0;
                    end;

                    Message('Colour change completed');
                end;
            }
        }
    }

    var
        StyleNo: Code[20];
        LotNo: Code[20];
        AllPO: Boolean;


    procedure PassParameters(StyleNoPara: Code[20]; LotNoPara: Code[20]);
    var
    begin
        StyleNo := StyleNoPara;
        LotNo := LotNoPara;
    end;


    trigger OnOpenPage()
    var
    begin
        rec."Style No." := StyleNo;
        rec."Lot No." := LotNo;
        CurrPage.Update();
    end;

}