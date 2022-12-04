page 50516 HourlyProductionListPart
{
    PageType = ListPart;
    AutoSplitKey = true;
    SourceTable = "Hourly Production Lines";
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                    Caption = 'Style';
                }

                field("Work Center Name"; rec."Work Center Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Line';
                }

                field(Item; rec.Item)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Hour 01"; rec."Hour 01")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("Hour 02"; rec."Hour 02")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }
                field("Hour 03"; rec."Hour 03")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("Hour 04"; rec."Hour 04")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("Hour 05"; rec."Hour 05")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("Hour 06"; rec."Hour 06")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("Hour 07"; rec."Hour 07")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("Hour 08"; rec."Hour 08")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("Hour 09"; rec."Hour 09")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("Hour 10"; rec."Hour 10")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("Hour 11"; rec."Hour 11")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("Hour 12"; rec."Hour 12")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("Hour 13"; rec."Hour 13")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field(Total; rec.Total)
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = 'StrongAccent';
                }
            }
        }
    }


    procedure CalTotal()
    var
        HourlyProdLinesRec: Record "Hourly Production Lines";
        HourlyProdLines1Rec: Record "Hourly Production Lines";
        TotPassPcsHour1: Integer;
        TotPassPcsHour2: Integer;
        TotPassPcsHour3: Integer;
        TotPassPcsHour4: Integer;
        TotPassPcsHour5: Integer;
        TotPassPcsHour6: Integer;
        TotPassPcsHour7: Integer;
        TotPassPcsHour8: Integer;
        TotPassPcsHour9: Integer;
        TotPassPcsHour10: Integer;
        TotPassPcsHour11: Integer;
        TotPassPcsHour12: Integer;
        TotPassPcsHour13: Integer;
        TotDefectPcsHour1: Integer;
        TotDefectPcsHour2: Integer;
        TotDefectPcsHour3: Integer;
        TotDefectPcsHour4: Integer;
        TotDefectPcsHour5: Integer;
        TotDefectPcsHour6: Integer;
        TotDefectPcsHour7: Integer;
        TotDefectPcsHour8: Integer;
        TotDefectPcsHour9: Integer;
        TotDefectPcsHour10: Integer;
        TotDefectPcsHour11: Integer;
        TotDefectPcsHour12: Integer;
        TotDefectPcsHour13: Integer;
        TotDHUPcsHour1: Integer;
        TotDHUPcsHour2: Integer;
        TotDHUPcsHour3: Integer;
        TotDHUPcsHour4: Integer;
        TotDHUPcsHour5: Integer;
        TotDHUPcsHour6: Integer;
        TotDHUPcsHour7: Integer;
        TotDHUPcsHour8: Integer;
        TotDHUPcsHour9: Integer;
        TotDHUPcsHour10: Integer;
        TotDHUPcsHour11: Integer;
        TotDHUPcsHour12: Integer;
        TotDHUPcsHour13: Integer;
    begin
        //Line totals
        CurrPage.Update();
        rec.Total := rec."Hour 01" + rec."Hour 02" + rec."Hour 03" + rec."Hour 04" + rec."Hour 05" + rec."Hour 06" +
        rec."Hour 07" + rec."Hour 08" + rec."Hour 09" + rec."Hour 10" + rec."Hour 11" + rec."Hour 12" + rec."Hour 13";

        //Sub totals
        HourlyProdLinesRec.Reset();
        HourlyProdLinesRec.SetRange("No.", rec."No.");
        HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

        if HourlyProdLinesRec.FindSet() then begin
            repeat
                if HourlyProdLinesRec.Item = 'PASS PCS' then begin
                    TotPassPcsHour1 += HourlyProdLinesRec."Hour 01";
                    TotPassPcsHour2 += HourlyProdLinesRec."Hour 02";
                    TotPassPcsHour3 += HourlyProdLinesRec."Hour 03";
                    TotPassPcsHour4 += HourlyProdLinesRec."Hour 04";
                    TotPassPcsHour5 += HourlyProdLinesRec."Hour 05";
                    TotPassPcsHour6 += HourlyProdLinesRec."Hour 06";
                    TotPassPcsHour7 += HourlyProdLinesRec."Hour 07";
                    TotPassPcsHour8 += HourlyProdLinesRec."Hour 08";
                    TotPassPcsHour9 += HourlyProdLinesRec."Hour 09";
                    TotPassPcsHour10 += HourlyProdLinesRec."Hour 10";
                    TotPassPcsHour11 += HourlyProdLinesRec."Hour 11";
                    TotPassPcsHour12 += HourlyProdLinesRec."Hour 12";
                    TotPassPcsHour13 += HourlyProdLinesRec."Hour 13";
                end;

                if HourlyProdLinesRec.Item = 'DEFECT PCS' then begin
                    TotDefectPcsHour1 += HourlyProdLinesRec."Hour 01";
                    TotDefectPcsHour2 += HourlyProdLinesRec."Hour 02";
                    TotDefectPcsHour3 += HourlyProdLinesRec."Hour 03";
                    TotDefectPcsHour4 += HourlyProdLinesRec."Hour 04";
                    TotDefectPcsHour5 += HourlyProdLinesRec."Hour 05";
                    TotDefectPcsHour6 += HourlyProdLinesRec."Hour 06";
                    TotDefectPcsHour7 += HourlyProdLinesRec."Hour 07";
                    TotDefectPcsHour8 += HourlyProdLinesRec."Hour 08";
                    TotDefectPcsHour9 += HourlyProdLinesRec."Hour 09";
                    TotDefectPcsHour10 += HourlyProdLinesRec."Hour 10";
                    TotDefectPcsHour11 += HourlyProdLinesRec."Hour 11";
                    TotDefectPcsHour12 += HourlyProdLinesRec."Hour 12";
                    TotDefectPcsHour13 += HourlyProdLinesRec."Hour 13";
                end;

                if HourlyProdLinesRec.Item = 'DHU' then begin
                    TotDHUPcsHour1 += HourlyProdLinesRec."Hour 01";
                    TotDHUPcsHour2 += HourlyProdLinesRec."Hour 02";
                    TotDHUPcsHour3 += HourlyProdLinesRec."Hour 03";
                    TotDHUPcsHour4 += HourlyProdLinesRec."Hour 04";
                    TotDHUPcsHour5 += HourlyProdLinesRec."Hour 05";
                    TotDHUPcsHour6 += HourlyProdLinesRec."Hour 06";
                    TotDHUPcsHour7 += HourlyProdLinesRec."Hour 07";
                    TotDHUPcsHour8 += HourlyProdLinesRec."Hour 08";
                    TotDHUPcsHour9 += HourlyProdLinesRec."Hour 09";
                    TotDHUPcsHour10 += HourlyProdLinesRec."Hour 10";
                    TotDHUPcsHour11 += HourlyProdLinesRec."Hour 11";
                    TotDHUPcsHour12 += HourlyProdLinesRec."Hour 12";
                    TotDHUPcsHour13 += HourlyProdLinesRec."Hour 13";
                end;

            until HourlyProdLinesRec.Next() = 0;

            //Update PASS Pcs
            HourlyProdLines1Rec.Reset();
            HourlyProdLines1Rec.SetRange("No.", rec."No.");
            HourlyProdLines1Rec.SetFilter("Factory No.", '=%1', '');
            HourlyProdLines1Rec.SetRange("Style Name", 'PASS PCS (Total)');
            HourlyProdLines1Rec.FindSet();

            HourlyProdLines1Rec."Hour 01" := TotPassPcsHour1;
            HourlyProdLines1Rec."Hour 02" := TotPassPcsHour2;
            HourlyProdLines1Rec."Hour 03" := TotPassPcsHour3;
            HourlyProdLines1Rec."Hour 04" := TotPassPcsHour4;
            HourlyProdLines1Rec."Hour 05" := TotPassPcsHour5;
            HourlyProdLines1Rec."Hour 06" := TotPassPcsHour6;
            HourlyProdLines1Rec."Hour 07" := TotPassPcsHour7;
            HourlyProdLines1Rec."Hour 08" := TotPassPcsHour8;
            HourlyProdLines1Rec."Hour 09" := TotPassPcsHour9;
            HourlyProdLines1Rec."Hour 10" := TotPassPcsHour10;
            HourlyProdLines1Rec."Hour 11" := TotPassPcsHour11;
            HourlyProdLines1Rec."Hour 12" := TotPassPcsHour12;
            HourlyProdLines1Rec."Hour 13" := TotPassPcsHour13;
            HourlyProdLines1Rec.Modify();

            //Update DEFECTS Pcs
            HourlyProdLines1Rec.Reset();
            HourlyProdLines1Rec.SetRange("No.", rec."No.");
            HourlyProdLines1Rec.SetFilter("Factory No.", '=%1', '');
            HourlyProdLines1Rec.SetRange("Style Name", 'DEFECT PCS (Total)');
            HourlyProdLines1Rec.FindSet();

            HourlyProdLines1Rec."Hour 01" := TotDefectPcsHour1;
            HourlyProdLines1Rec."Hour 02" := TotDefectPcsHour2;
            HourlyProdLines1Rec."Hour 03" := TotDefectPcsHour3;
            HourlyProdLines1Rec."Hour 04" := TotDefectPcsHour4;
            HourlyProdLines1Rec."Hour 05" := TotDefectPcsHour5;
            HourlyProdLines1Rec."Hour 06" := TotDefectPcsHour6;
            HourlyProdLines1Rec."Hour 07" := TotDefectPcsHour7;
            HourlyProdLines1Rec."Hour 08" := TotDefectPcsHour8;
            HourlyProdLines1Rec."Hour 09" := TotDefectPcsHour9;
            HourlyProdLines1Rec."Hour 10" := TotDefectPcsHour10;
            HourlyProdLines1Rec."Hour 11" := TotDefectPcsHour11;
            HourlyProdLines1Rec."Hour 12" := TotDefectPcsHour12;
            HourlyProdLines1Rec."Hour 13" := TotDefectPcsHour13;
            HourlyProdLines1Rec.Modify();

            //Update DHU
            HourlyProdLines1Rec.Reset();
            HourlyProdLines1Rec.SetRange("No.", rec."No.");
            HourlyProdLines1Rec.SetFilter("Factory No.", '=%1', '');
            HourlyProdLines1Rec.SetRange("Style Name", 'DHU (Total)');
            HourlyProdLines1Rec.FindSet();

            HourlyProdLines1Rec."Hour 01" := TotDHUPcsHour1;
            HourlyProdLines1Rec."Hour 02" := TotDHUPcsHour2;
            HourlyProdLines1Rec."Hour 03" := TotDHUPcsHour3;
            HourlyProdLines1Rec."Hour 04" := TotDHUPcsHour4;
            HourlyProdLines1Rec."Hour 05" := TotDHUPcsHour5;
            HourlyProdLines1Rec."Hour 06" := TotDHUPcsHour6;
            HourlyProdLines1Rec."Hour 07" := TotDHUPcsHour7;
            HourlyProdLines1Rec."Hour 08" := TotDHUPcsHour8;
            HourlyProdLines1Rec."Hour 09" := TotDHUPcsHour9;
            HourlyProdLines1Rec."Hour 10" := TotDHUPcsHour10;
            HourlyProdLines1Rec."Hour 11" := TotDHUPcsHour11;
            HourlyProdLines1Rec."Hour 12" := TotDHUPcsHour12;
            HourlyProdLines1Rec."Hour 13" := TotDHUPcsHour13;
            HourlyProdLines1Rec.Modify();


        end;

        CurrPage.Update();

    end;


    trigger OnAfterGetRecord()
    var
    begin
        StyleExprTxt := ChangeColor.ChangeHourlyProduction(Rec);

        if rec."Factory No." = '' then begin
            Clear(SetEdit);
            SetEdit := false;
        end
        ELSE begin
            Clear(SetEdit);
            SetEdit := true;
        end;
    end;

    var
        StyleExprTxt: Text[50];
        ChangeColor: Codeunit NavAppCodeUnit;
        SetEdit: Boolean;

}