page 51277 GarmentPartsBundleCard
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = GarmentPartsBundleCard;
    Caption = 'Garment Parts - Bundle Card';

    layout
    {
        area(Content)
        {
            group(General)
            {

                Editable = EditableGB;

                field("No."; Rec.No)
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'GMT Part Name';

                    trigger OnValidate()
                    var
                        UserRec: Record "User Setup";
                    begin

                        //Done By Sachith on 03/04/23 
                        UserRec.Reset();
                        UserRec.Get(UserId);

                        if UserRec."Factory Code" <> '' then begin
                            Rec."Factory Code" := UserRec."Factory Code";
                            CurrPage.Update();
                        end
                        else
                            Error('Factory not assigned for the user.');
                    end;
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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."BundleCardGMTType Nos.", xRec.No, Rec.No) THEN BEGIN
            NoSeriesMngment.SetSeries(rec.No);
            CurrPage.Update();
            EXIT(TRUE);
        END;
    end;

    //Done By Sachith on 03/04/23 
    trigger OnOpenPage()
    var
        UserRec: Record "User Setup";
    begin

        UserRec.Reset();
        UserRec.Get(UserId);

        if rec."Factory Code" <> '' then begin
            if (UserRec."Factory Code" <> '') then begin
                if (UserRec."Factory Code" = rec."Factory Code") then
                    EditableGB := true
                else
                    EditableGB := false;
            end
            else
                EditableGB := false;
        end
        else
            if (UserRec."Factory Code" = '') then begin
                Error('Factory not assigned for the user.');
                EditableGB := false;
            end
            else
                EditableGB := true;
    end;


    //Done By sachith on 06/04/23
    trigger OnDeleteRecord(): Boolean
    var
        UserRec: Record "User Setup";
    begin

        UserRec.Reset();
        UserRec.Get(UserId);

        if UserRec."Factory Code" <> '' then begin
            if (UserRec."Factory Code" <> rec."Factory Code") then
                Error('You are not authorized to delete this record.')
        end
        else
            Error('You are not authorized to delete records.');

    end;

    var
        EditableGB: Boolean;
}