page 71012808 "Change Colour Card"
{
    PageType = Card;
    Caption = 'Change Colour';
    SourceTable = "Change Colour";

    layout
    {
        area(Content)
        {
            field("From Colour Name"; "From Colour Name")
            {
                ApplicationArea = All;
                Caption = 'From Colour';

                trigger OnValidate()
                var
                    ColorRec: Record Colour;
                begin
                    ColorRec.Reset();
                    ColorRec.SetRange("Colour Name", "From Colour Name");
                    if ColorRec.FindSet() then
                        "From Colour No" := ColorRec."No.";
                end;
            }

            field("To Colour Name"; "To Colour Name")
            {
                ApplicationArea = All;
                Caption = 'To Colour';

                trigger OnValidate()
                var
                    ColorRec: Record Colour;
                begin
                    ColorRec.Reset();
                    ColorRec.SetRange("Colour Name", "To Colour Name");
                    if ColorRec.FindSet() then
                        "To Colour No" := ColorRec."No.";
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

                    BOMRec.SetRange("Style No.", "Style No.");
                    if BOMRec.FindSet() then
                        Error('Style %1 already assigned for the BOM %2 . You cannot change colors.', Style1Rec."Style No.", BOMRec.No);

                    if "From Colour Name" = '' then
                        Error('Invalid From Colour');

                    if "To Colour Name" = '' then
                        Error('Invalid To Colour');

                    if "From Colour Name" = "To Colour Name" then
                        Error('You cannot put same colour');

                    //Check for existance
                    AssoDetRec.Reset();
                    AssoDetRec.SetRange("Style No.", "Style No.");
                    AssoDetRec.SetRange("Colour No", "To Colour No");
                    AssoDetRec.SetRange("Lot No.", "Lot No.");
                    AssoDetRec.SetFilter(Type, '=%1', '1');

                    if AssoDetRec.FindSet() then
                        Error('Color already defined.');


                    //Inform user about color usage in other pos
                    AssorColorSizeRatioRec.Reset();
                    AssorColorSizeRatioRec.SetRange("Style No.", "Style No.");
                    AssorColorSizeRatioRec.SetRange("Colour No", "From Colour No");
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
                        if (Dialog.Confirm(Question, true, "From Colour Name", LotTemp) = true) then
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
                    AssoDetRec.SetRange("Style No.", "Style No.");
                    AssoDetRec.SetRange("Colour No", "From Colour No");

                    if Confirm = false then
                        AssoDetRec.SetRange("Lot No.", "Lot No.");

                    AssoDetRec.SetFilter(Type, '=%1', '1');

                    if AssoDetRec.FindSet() then begin
                        repeat
                            AssoDetRec."Colour No" := "To Colour No";
                            AssoDetRec."Colour Name" := "To Colour Name";
                            AssoDetRec.Modify();
                        until AssoDetRec.Next() = 0;
                    end;


                    //update Color size TAB
                    AssorColorSizeRatioRec.Reset();
                    AssorColorSizeRatioRec.Reset();
                    AssorColorSizeRatioRec.SetRange("Style No.", "Style No.");
                    AssorColorSizeRatioRec.SetRange("Colour No", "From Colour No");

                    if Confirm = false then
                        AssorColorSizeRatioRec.SetRange("Lot No.", "Lot No.");

                    if AssorColorSizeRatioRec.FindSet() then begin
                        repeat
                            AssorColorSizeRatioRec."Colour No" := "To Colour No";
                            AssorColorSizeRatioRec."Colour Name" := "To Colour Name";
                            AssorColorSizeRatioRec.Modify();
                        until AssorColorSizeRatioRec.Next() = 0;
                    end;


                    //update Quantity breakdown TAB
                    AssorColorSizeRatioView.Reset();
                    AssorColorSizeRatioView.Reset();
                    AssorColorSizeRatioView.SetRange("Style No.", "Style No.");
                    AssorColorSizeRatioView.SetRange("Colour No", "From Colour No");

                    if Confirm = false then
                        AssorColorSizeRatioView.SetRange("Lot No.", "Lot No.");

                    if AssorColorSizeRatioView.FindSet() then begin
                        repeat
                            AssorColorSizeRatioView."Colour No" := "To Colour No";
                            AssorColorSizeRatioView."Colour Name" := "To Colour Name";
                            AssorColorSizeRatioView.Modify();
                        until AssorColorSizeRatioView.Next() = 0;
                    end;


                    //update price TAB
                    AssorColorSizeRatioPriceRec.Reset();
                    AssorColorSizeRatioPriceRec.Reset();
                    AssorColorSizeRatioPriceRec.SetRange("Style No.", "Style No.");
                    AssorColorSizeRatioPriceRec.SetRange("Colour No", "From Colour No");

                    if Confirm = false then
                        AssorColorSizeRatioPriceRec.SetRange("Lot No.", "Lot No.");

                    if AssorColorSizeRatioPriceRec.FindSet() then begin
                        repeat
                            AssorColorSizeRatioPriceRec."Colour No" := "To Colour No";
                            AssorColorSizeRatioPriceRec."Colour Name" := "To Colour Name";
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
        "Style No." := StyleNo;
        "Lot No." := LotNo;
        CurrPage.Update();
    end;

}