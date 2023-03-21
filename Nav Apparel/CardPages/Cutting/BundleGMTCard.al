page 51280 BundleCardGMTType
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = BundleGMTPart;
    Caption = 'Bundle GMT Part Card';
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
    // actions
    // {
    //     area(Processing)
    //     {
    //         action(ActionName)
    //         {
    //             ApplicationArea = All;

    //             trigger OnAction()
    //             begin

    //             end;
    //         }
    //     }
    // }

    var
        myInt: Integer;
}