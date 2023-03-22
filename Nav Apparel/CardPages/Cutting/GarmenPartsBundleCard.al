page 51280 GarmenPartsBundleCard
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
            group(GroupName)
            {
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

}