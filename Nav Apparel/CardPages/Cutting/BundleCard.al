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
                        BundleGRec: Record BundleGuideHeader;
                        BundleCardRec: Record BundleCardTable;
                        GMTPartList: Record GarmentPartsBundleCard;
                        GMTPartListLeft: Record GarmentPartsBundleCardLeft;
                        GMTPartListRight1Rec: Record GarmentPartsBundleCard2Right;
                        GMTPartListRight2Rec: Record GarmentPartsBundleCard2Right;
                        UserRec: Record "User Setup";
                    begin
                        //Fill Header fields
                        BundleGRec.Reset();
                        BundleGRec.SetRange("BundleGuideNo.", rec."Bundle Guide Header No");
                        if BundleGRec.FindSet() then begin
                            rec."Style Name" := BundleGRec."Style Name";
                            rec."Style No" := BundleGRec."Style No.";
                            rec.PoNo := BundleGRec."PO No.";
                            rec.Type1 := BundleGRec."Component Group";
                        end;


                        //Get the latets bundle no for the style
                        BundleCardRec.Reset();
                        BundleCardRec.SetRange("Style No", rec."Style No");
                        BundleCardRec.SetFilter("Bundle Card No", '<>%1', rec."Bundle Card No");
                        BundleCardRec.SetCurrentKey("Bundle Card No");
                        BundleCardRec.Ascending(false);
                        if BundleCardRec.FindFirst() then begin

                            //Fill right side listpart with same style gparts
                            GMTPartListRight1Rec.Reset();
                            GMTPartListRight1Rec.SetRange(BundleCardNo, BundleCardRec."Bundle Card No");
                            if GMTPartListRight1Rec.FindSet() then begin
                                repeat
                                    GMTPartListRight2Rec.Reset();
                                    GMTPartListRight2Rec.SetRange("No.", GMTPartListRight1Rec."No.");
                                    GMTPartListRight2Rec.SetRange(BundleCardNo, rec."Bundle Card No");
                                    if not GMTPartListRight2Rec.FindSet() then begin
                                        GMTPartListRight2Rec.Init();
                                        GMTPartListRight2Rec."No." := GMTPartListRight1Rec."No.";
                                        GMTPartListRight2Rec.BundleCardNo := rec."Bundle Card No";
                                        GMTPartListRight2Rec.Description := GMTPartListRight1Rec.Description;
                                        GMTPartListRight2Rec."Bundle Guide Header No" := rec."Bundle Guide Header No";
                                        GMTPartListRight2Rec.Insert();
                                    end;
                                until GMTPartListRight1Rec.Next() = 0;
                            end
                        end;


                        //Fil left side listpart
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

                field(PoNo; rec.PoNo)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'PO No';
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
                    UserRec: Record "User Setup";
                begin
                    //Done By sachith on 18/04/23
                    UserRec.Reset();
                    UserRec.Get(UserId);
                    if UserRec."Factory Code" <> '' then begin
                        if (UserRec."Factory Code" <> rec."Factory Code") then
                            Error('You are not authorized to Print Bundle Card.')
                    end
                    else
                        Error('Factory not assigned for the user.');

                    BundleCardReport.PassParameters(Rec."Bundle Card No");
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