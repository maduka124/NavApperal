page 51276 Bundlecard
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = BundleCardTable;
    Caption = 'Bundle Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Bundle Card No"; Rec."Bundle Card No")
                {
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Bundle Guide Header No"; Rec."Bundle Guide Header No")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    var
                        GMTPartList: Record GarmentPartsBundleCard;
                    begin
                        GMTPartList.Reset();
                        if GMTPartList.FindSet() then begin
                            repeat
                                GMTPartList.BundleCardNo := Rec."Bundle Card No";
                                GMTPartList.Modify();
                            until GMTPartList.Next() = 0;
                            CurrPage.Update();
                        end;
                    end;
                }

                field("Style Name"; Rec."Style Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
            }

            group(" ")
            {
                part(BundleCardGMTPartListPart; BundleCardGMTPartListPart)
                {
                    ApplicationArea = all;
                }

                part(BundleCardGMTPartListPart2; BundleCardGMTPartListPart2)
                {
                    ApplicationArea = all;
                    SubPageLink = BundleCardNo = field("Bundle Card No");
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(BundleCardReport)
            {
                Caption = 'Print Bundle Card';
                Image = Report;

                trigger OnAction()
                var
                    BundleCardReport: Report BundleCardReport;
                begin
                    BundleCardReport.PassParameters(Rec."Bundle Guide Header No");
                    BundleCardReport.RunModal();
                end;
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        GMTPartsBdlCard2Rec: Record GarmentPartsBundleCard2;
    begin
        GMTPartsBdlCard2Rec.reset();
        GMTPartsBdlCard2Rec.SetRange(BundleCardNo, rec."Bundle Card No");
        if GMTPartsBdlCard2Rec.FindSet() then
            GMTPartsBdlCard2Rec.DeleteAll();
    end;


    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."BundleGuideCard Nos.", xRec."Bundle Card No", Rec."Bundle Card No") THEN BEGIN
            NoSeriesMngment.SetSeries(rec."Bundle Card No");
            CurrPage.Update();
            EXIT(TRUE);
        END;
    end;

}