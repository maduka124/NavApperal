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

                //Done By sachith on 03/04/23
                Editable = EditableGB;

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
                        GMTPartListLeft: Record GarmentPartsBundleCardLeft;
                        UserRec: Record "User Setup";
                    begin
                        GMTPartList.Reset();
                        if GMTPartList.FindSet() then begin
                            repeat
                                GMTPartListLeft.Reset();
                                GMTPartListLeft.SetRange(BundleCardNo, Rec."Bundle Card No");
                                GMTPartListLeft.SetRange(No, GMTPartList.No);
                                if not GMTPartListLeft.FindSet() then begin
                                    GMTPartListLeft.Init();
                                    GMTPartListLeft.BundleCardNo := Rec."Bundle Card No";
                                    GMTPartListLeft.No := GMTPartList.No;
                                    GMTPartListLeft.Description := GMTPartList.Description;
                                    GMTPartListLeft.Select := false;
                                    GMTPartListLeft."Created Date" := WorkDate();
                                    GMTPartListLeft."Created User" := UserId;
                                    GMTPartListLeft.Insert();
                                end;
                            until GMTPartList.Next() = 0;
                            CurrPage.Update();
                        end;

                        UserRec.Reset();

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

                field("Style Name"; Rec."Style Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Type1; Rec.Type1)
                {
                    ApplicationArea = All;
                    Caption = 'Type';
                }
            }

            group(" ")
            {
                part(BundleCardGMTPartListPart; BundleCardGMTPartListPart)
                {
                    ApplicationArea = all;
                    Editable = EditableGB;
                    SubPageLink = BundleCardNo = field("Bundle Card No");
                }

                part(BundleCardGMTPartListPart2; BundleCardGMTPartListPart2)
                {
                    ApplicationArea = all;
                    Editable = EditableGB;
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
        GMTPartsBdlCard2Rec: Record GarmentPartsBundleCard2Right;
        GMTPartsBdlCardLeftRec: Record GarmentPartsBundleCardLeft;
        UserRec: Record "User Setup";
    begin

        //Done By sachith on 03/04/23
        UserRec.Reset();
        UserRec.Get(UserId);

        if UserRec."Factory Code" <> '' then begin
            if (UserRec."Factory Code" <> rec."Factory Code") then
                Error('You are not authorized to delete this record.')
        end
        else
            Error('You are not authorized to delete records.');

        GMTPartsBdlCard2Rec.reset();
        GMTPartsBdlCard2Rec.SetRange(BundleCardNo, rec."Bundle Card No");
        if GMTPartsBdlCard2Rec.FindSet() then
            GMTPartsBdlCard2Rec.DeleteAll();

        GMTPartsBdlCardLeftRec.reset();
        GMTPartsBdlCardLeftRec.SetRange(BundleCardNo, rec."Bundle Card No");
        if GMTPartsBdlCardLeftRec.FindSet() then
            GMTPartsBdlCardLeftRec.DeleteAll();
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

    var
        EditableGB: Boolean;

}