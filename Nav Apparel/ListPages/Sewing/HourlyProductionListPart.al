page 50516 HourlyProductionListPart
{
    PageType = ListPart;
    AutoSplitKey = true;
    SourceTable = "Hourly Production Lines";
    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTableView = sorting("Work Center Seq No") order(ascending);

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

                        HourlyProdLinesRec: Record "Hourly Production Lines";
                        TempPASSPCS: Decimal;
                        TempDEFECTS: Decimal;
                        TempDHU: Decimal;
                    begin

                        CurrPage.Update();
                        HourlyProdLinesRec.Reset();
                        HourlyProdLinesRec.SetRange("No.", rec."No.");
                        HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                        HourlyProdLinesRec.SetFilter(item, '=%1', 'PASS PCS');
                        HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                        if HourlyProdLinesRec.FindSet() then begin
                            if HourlyProdLinesRec."Hour 01" <> 0 then begin

                                TempPASSPCS := HourlyProdLinesRec."Hour 01";

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DEFECT PCS');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    TempDEFECTS := HourlyProdLinesRec."Hour 01";
                                end;

                                //Calculate DHU and update
                                TempDHU := (TempDEFECTS / TempPASSPCS) * 100;

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DHU');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    HourlyProdLinesRec."Hour 01" := round(TempDHU, 1);
                                    HourlyProdLinesRec.Modify();
                                end;

                            end
                            else begin
                                TempDHU := 0;

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DHU');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    HourlyProdLinesRec."Hour 01" := TempDHU;
                                    HourlyProdLinesRec.Modify();
                                end;
                            end;

                        end;

                        CalTotal();
                        CalcTarget();

                    end;

                }

                field("Hour 02"; rec."Hour 02")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                        HourlyProdLinesRec: Record "Hourly Production Lines";
                        TempPASSPCS: Decimal;
                        TempDEFECTS: Decimal;
                        TempDHU: Decimal;
                    begin

                        CurrPage.Update();
                        HourlyProdLinesRec.Reset();
                        HourlyProdLinesRec.SetRange("No.", rec."No.");
                        HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                        HourlyProdLinesRec.SetFilter(item, '=%1', 'PASS PCS');
                        HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                        if HourlyProdLinesRec.FindSet() then begin
                            if HourlyProdLinesRec."Hour 02" <> 0 then begin

                                TempPASSPCS := HourlyProdLinesRec."Hour 02";

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DEFECT PCS');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    TempDEFECTS := HourlyProdLinesRec."Hour 02";
                                end;

                                //Calculate DHU and update
                                TempDHU := (TempDEFECTS / TempPASSPCS) * 100;

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DHU');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    HourlyProdLinesRec."Hour 02" := round(TempDHU, 1);
                                    HourlyProdLinesRec.Modify();
                                end;

                            end
                            else begin
                                TempDHU := 0;

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DHU');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    HourlyProdLinesRec."Hour 02" := TempDHU;
                                    HourlyProdLinesRec.Modify();
                                end;
                            end;

                        end;
                        CalcTarget();
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
                        HourlyProdLinesRec: Record "Hourly Production Lines";
                        TempPASSPCS: Decimal;
                        TempDEFECTS: Decimal;
                        TempDHU: Decimal;
                    begin

                        CurrPage.Update();
                        HourlyProdLinesRec.Reset();
                        HourlyProdLinesRec.SetRange("No.", rec."No.");
                        HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                        HourlyProdLinesRec.SetFilter(item, '=%1', 'PASS PCS');
                        HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                        if HourlyProdLinesRec.FindSet() then begin
                            if HourlyProdLinesRec."Hour 03" <> 0 then begin

                                TempPASSPCS := HourlyProdLinesRec."Hour 03";

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DEFECT PCS');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    TempDEFECTS := HourlyProdLinesRec."Hour 03";
                                end;

                                //Calculate DHU and update
                                TempDHU := (TempDEFECTS / TempPASSPCS) * 100;

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DHU');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    HourlyProdLinesRec."Hour 03" := round(TempDHU, 1);
                                    HourlyProdLinesRec.Modify();
                                end;

                            end
                            else begin
                                TempDHU := 0;

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DHU');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    HourlyProdLinesRec."Hour 03" := TempDHU;
                                    HourlyProdLinesRec.Modify();
                                end;
                            end;

                        end;
                        CalcTarget();
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
                        HourlyProdLinesRec: Record "Hourly Production Lines";
                        TempPASSPCS: Decimal;
                        TempDEFECTS: Decimal;
                        TempDHU: Decimal;
                    begin

                        CurrPage.Update();
                        HourlyProdLinesRec.Reset();
                        HourlyProdLinesRec.SetRange("No.", rec."No.");
                        HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                        HourlyProdLinesRec.SetFilter(item, '=%1', 'PASS PCS');
                        HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                        if HourlyProdLinesRec.FindSet() then begin
                            if HourlyProdLinesRec."Hour 04" <> 0 then begin

                                TempPASSPCS := HourlyProdLinesRec."Hour 04";

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DEFECT PCS');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    TempDEFECTS := HourlyProdLinesRec."Hour 04";
                                end;

                                //Calculate DHU and update
                                TempDHU := (TempDEFECTS / TempPASSPCS) * 100;

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DHU');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    HourlyProdLinesRec."Hour 04" := round(TempDHU, 1);
                                    HourlyProdLinesRec.Modify();
                                end;

                            end
                            else begin
                                TempDHU := 0;

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DHU');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    HourlyProdLinesRec."Hour 04" := TempDHU;
                                    HourlyProdLinesRec.Modify();
                                end;
                            end;

                        end;
                        CalcTarget();
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
                        HourlyProdLinesRec: Record "Hourly Production Lines";
                        TempPASSPCS: Decimal;
                        TempDEFECTS: Decimal;
                        TempDHU: Decimal;
                    begin

                        CurrPage.Update();
                        HourlyProdLinesRec.Reset();
                        HourlyProdLinesRec.SetRange("No.", rec."No.");
                        HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                        HourlyProdLinesRec.SetFilter(item, '=%1', 'PASS PCS');
                        HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                        if HourlyProdLinesRec.FindSet() then begin
                            if HourlyProdLinesRec."Hour 05" <> 0 then begin

                                TempPASSPCS := HourlyProdLinesRec."Hour 05";

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DEFECT PCS');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    TempDEFECTS := HourlyProdLinesRec."Hour 05";
                                end;

                                //Calculate DHU and update
                                TempDHU := (TempDEFECTS / TempPASSPCS) * 100;

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DHU');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    HourlyProdLinesRec."Hour 05" := round(TempDHU, 1);
                                    HourlyProdLinesRec.Modify();
                                end;

                            end
                            else begin
                                TempDHU := 0;

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DHU');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    HourlyProdLinesRec."Hour 05" := TempDHU;
                                    HourlyProdLinesRec.Modify();
                                end;
                            end;

                        end;
                        CalcTarget();
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
                        HourlyProdLinesRec: Record "Hourly Production Lines";
                        TempPASSPCS: Decimal;
                        TempDEFECTS: Decimal;
                        TempDHU: Decimal;
                    begin

                        CurrPage.Update();
                        HourlyProdLinesRec.Reset();
                        HourlyProdLinesRec.SetRange("No.", rec."No.");
                        HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                        HourlyProdLinesRec.SetFilter(item, '=%1', 'PASS PCS');
                        HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                        if HourlyProdLinesRec.FindSet() then begin
                            if HourlyProdLinesRec."Hour 06" <> 0 then begin

                                TempPASSPCS := HourlyProdLinesRec."Hour 06";

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DEFECT PCS');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    TempDEFECTS := HourlyProdLinesRec."Hour 06";
                                end;

                                //Calculate DHU and update
                                TempDHU := (TempDEFECTS / TempPASSPCS) * 100;

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DHU');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    HourlyProdLinesRec."Hour 06" := round(TempDHU, 1);
                                    HourlyProdLinesRec.Modify();
                                end;

                            end
                            else begin
                                TempDHU := 0;

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DHU');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    HourlyProdLinesRec."Hour 06" := TempDHU;
                                    HourlyProdLinesRec.Modify();
                                end;
                            end;

                        end;
                        CalcTarget();
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
                        HourlyProdLinesRec: Record "Hourly Production Lines";
                        TempPASSPCS: Decimal;
                        TempDEFECTS: Decimal;
                        TempDHU: Decimal;
                    begin

                        CurrPage.Update();
                        HourlyProdLinesRec.Reset();
                        HourlyProdLinesRec.SetRange("No.", rec."No.");
                        HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                        HourlyProdLinesRec.SetFilter(item, '=%1', 'PASS PCS');
                        HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                        if HourlyProdLinesRec.FindSet() then begin
                            if HourlyProdLinesRec."Hour 07" <> 0 then begin

                                TempPASSPCS := HourlyProdLinesRec."Hour 07";

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DEFECT PCS');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    TempDEFECTS := HourlyProdLinesRec."Hour 07";
                                end;

                                //Calculate DHU and update
                                TempDHU := (TempDEFECTS / TempPASSPCS) * 100;

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DHU');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    HourlyProdLinesRec."Hour 07" := round(TempDHU, 1);
                                    HourlyProdLinesRec.Modify();
                                end;

                            end
                            else begin
                                TempDHU := 0;

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DHU');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    HourlyProdLinesRec."Hour 07" := TempDHU;
                                    HourlyProdLinesRec.Modify();
                                end;
                            end;

                        end;
                        CalcTarget();
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
                        HourlyProdLinesRec: Record "Hourly Production Lines";
                        TempPASSPCS: Decimal;
                        TempDEFECTS: Decimal;
                        TempDHU: Decimal;
                    begin

                        CurrPage.Update();
                        HourlyProdLinesRec.Reset();
                        HourlyProdLinesRec.SetRange("No.", rec."No.");
                        HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                        HourlyProdLinesRec.SetFilter(item, '=%1', 'PASS PCS');
                        HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                        if HourlyProdLinesRec.FindSet() then begin
                            if HourlyProdLinesRec."Hour 08" <> 0 then begin

                                TempPASSPCS := HourlyProdLinesRec."Hour 08";

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DEFECT PCS');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    TempDEFECTS := HourlyProdLinesRec."Hour 08";
                                end;

                                //Calculate DHU and update
                                TempDHU := (TempDEFECTS / TempPASSPCS) * 100;

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DHU');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    HourlyProdLinesRec."Hour 08" := round(TempDHU, 1);
                                    HourlyProdLinesRec.Modify();
                                end;

                            end
                            else begin
                                TempDHU := 0;

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DHU');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    HourlyProdLinesRec."Hour 08" := TempDHU;
                                    HourlyProdLinesRec.Modify();
                                end;
                            end;

                        end;
                        CalcTarget();
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
                        HourlyProdLinesRec: Record "Hourly Production Lines";
                        TempPASSPCS: Decimal;
                        TempDEFECTS: Decimal;
                        TempDHU: Decimal;
                    begin

                        CurrPage.Update();
                        HourlyProdLinesRec.Reset();
                        HourlyProdLinesRec.SetRange("No.", rec."No.");
                        HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                        HourlyProdLinesRec.SetFilter(item, '=%1', 'PASS PCS');
                        HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                        if HourlyProdLinesRec.FindSet() then begin
                            if HourlyProdLinesRec."Hour 09" <> 0 then begin

                                TempPASSPCS := HourlyProdLinesRec."Hour 09";

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DEFECT PCS');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    TempDEFECTS := HourlyProdLinesRec."Hour 09";
                                end;

                                //Calculate DHU and update
                                TempDHU := (TempDEFECTS / TempPASSPCS) * 100;

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DHU');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    HourlyProdLinesRec."Hour 09" := round(TempDHU, 1);
                                    HourlyProdLinesRec.Modify();
                                end;

                            end
                            else begin
                                TempDHU := 0;

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DHU');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    HourlyProdLinesRec."Hour 09" := TempDHU;
                                    HourlyProdLinesRec.Modify();
                                end;
                            end;

                        end;
                        CalcTarget();
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
                        HourlyProdLinesRec: Record "Hourly Production Lines";
                        TempPASSPCS: Decimal;
                        TempDEFECTS: Decimal;
                        TempDHU: Decimal;
                    begin

                        CurrPage.Update();
                        HourlyProdLinesRec.Reset();
                        HourlyProdLinesRec.SetRange("No.", rec."No.");
                        HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                        HourlyProdLinesRec.SetFilter(item, '=%1', 'PASS PCS');
                        HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                        if HourlyProdLinesRec.FindSet() then begin
                            if HourlyProdLinesRec."Hour 10" <> 0 then begin

                                TempPASSPCS := HourlyProdLinesRec."Hour 10";

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DEFECT PCS');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    TempDEFECTS := HourlyProdLinesRec."Hour 10";
                                end;

                                //Calculate DHU and update
                                TempDHU := (TempDEFECTS / TempPASSPCS) * 100;

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DHU');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    HourlyProdLinesRec."Hour 10" := round(TempDHU, 1);
                                    HourlyProdLinesRec.Modify();
                                end;

                            end
                            else begin
                                TempDHU := 0;

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DHU');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    HourlyProdLinesRec."Hour 10" := TempDHU;
                                    HourlyProdLinesRec.Modify();
                                end;
                            end;

                        end;
                        CalcTarget();
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
                        HourlyProdLinesRec: Record "Hourly Production Lines";
                        TempPASSPCS: Decimal;
                        TempDEFECTS: Decimal;
                        TempDHU: Decimal;
                    begin

                        CurrPage.Update();
                        HourlyProdLinesRec.Reset();
                        HourlyProdLinesRec.SetRange("No.", rec."No.");
                        HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                        HourlyProdLinesRec.SetFilter(item, '=%1', 'PASS PCS');
                        HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                        if HourlyProdLinesRec.FindSet() then begin
                            if HourlyProdLinesRec."Hour 11" <> 0 then begin

                                TempPASSPCS := HourlyProdLinesRec."Hour 11";

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DEFECT PCS');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    TempDEFECTS := HourlyProdLinesRec."Hour 11";
                                end;

                                //Calculate DHU and update
                                TempDHU := (TempDEFECTS / TempPASSPCS) * 100;

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DHU');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    HourlyProdLinesRec."Hour 11" := round(TempDHU, 1);
                                    HourlyProdLinesRec.Modify();
                                end;

                            end
                            else begin
                                TempDHU := 0;

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DHU');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    HourlyProdLinesRec."Hour 11" := TempDHU;
                                    HourlyProdLinesRec.Modify();
                                end;
                            end;

                        end;
                        CalcTarget();
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
                        HourlyProdLinesRec: Record "Hourly Production Lines";
                        TempPASSPCS: Decimal;
                        TempDEFECTS: Decimal;
                        TempDHU: Decimal;
                    begin

                        CurrPage.Update();
                        HourlyProdLinesRec.Reset();
                        HourlyProdLinesRec.SetRange("No.", rec."No.");
                        HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                        HourlyProdLinesRec.SetFilter(item, '=%1', 'PASS PCS');
                        HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                        if HourlyProdLinesRec.FindSet() then begin
                            if HourlyProdLinesRec."Hour 12" <> 0 then begin

                                TempPASSPCS := HourlyProdLinesRec."Hour 12";

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DEFECT PCS');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    TempDEFECTS := HourlyProdLinesRec."Hour 12";
                                end;

                                //Calculate DHU and update
                                TempDHU := (TempDEFECTS / TempPASSPCS) * 100;

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DHU');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    HourlyProdLinesRec."Hour 12" := round(TempDHU, 1);
                                    HourlyProdLinesRec.Modify();
                                end;

                            end
                            else begin
                                TempDHU := 0;

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DHU');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    HourlyProdLinesRec."Hour 12" := TempDHU;
                                    HourlyProdLinesRec.Modify();
                                end;
                            end;

                        end;
                        CalcTarget();
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
                        HourlyProdLinesRec: Record "Hourly Production Lines";
                        TempPASSPCS: Decimal;
                        TempDEFECTS: Decimal;
                        TempDHU: Decimal;
                    begin

                        CurrPage.Update();
                        HourlyProdLinesRec.Reset();
                        HourlyProdLinesRec.SetRange("No.", rec."No.");
                        HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                        HourlyProdLinesRec.SetFilter(item, '=%1', 'PASS PCS');
                        HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                        if HourlyProdLinesRec.FindSet() then begin
                            if HourlyProdLinesRec."Hour 13" <> 0 then begin

                                TempPASSPCS := HourlyProdLinesRec."Hour 13";

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DEFECT PCS');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    TempDEFECTS := HourlyProdLinesRec."Hour 13";
                                end;

                                //Calculate DHU and update
                                TempDHU := (TempDEFECTS / TempPASSPCS) * 100;

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DHU');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    HourlyProdLinesRec."Hour 13" := round(TempDHU, 1);
                                    HourlyProdLinesRec.Modify();
                                end;

                            end
                            else begin
                                TempDHU := 0;

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DHU');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    HourlyProdLinesRec."Hour 13" := TempDHU;
                                    HourlyProdLinesRec.Modify();
                                end;
                            end;

                        end;
                        CalcTarget();
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
    procedure CalcTarget()
    var
        LCH: Decimal;
        Time: Time;
        WorkingHrs: Decimal;
        ResCapacityEntryRec: Record "Calendar Entry";
        CheckValue: Decimal;
        TotNavaHours: Decimal;
        TimeVariable: Time;
        StyleLC1: Code[20];
        LineLC1: Code[20];
        StyleLC: Code[20];
        LineLC: Code[20];
        NavAppProdRec: Record "NavApp Prod Plans Details";
        DayTarget: Decimal;
    begin
        DayTarget := 0;
        NavAppProdRec.Reset();
        NavAppProdRec.SetRange(PlanDate, Rec."Prod Date");
        NavAppProdRec.SetRange("Style No.", Rec."Style No.");
        NavAppProdRec.SetRange("Factory No.", Rec."Factory No.");
        NavAppProdRec.SetRange("Resource No.", rec."Work Center No.");
        if NavAppProdRec.FindSet() then begin
            repeat
                DayTarget += NavAppProdRec.Qty;
            until NavAppProdRec.Next() = 0;

            if (NavAppProdRec."Style No." = StyleLC) and (NavAppProdRec."Resource No." = LineLC) then begin
                DayTarget := 0;
            end;
            StyleLC := NavAppProdRec."Style No.";
            LineLC := NavAppProdRec."Resource No.";
        end;
        Rec.Target := DayTarget;
        Rec.Modify();

        WorkingHrs := 0;
        ResCapacityEntryRec.Reset();
        ResCapacityEntryRec.SETRANGE("No.", Rec."Work Center No.");
        ResCapacityEntryRec.SETRANGE(Date, Rec."Prod Date");
        if ResCapacityEntryRec.FindSet() then begin
            repeat
                WorkingHrs += (ResCapacityEntryRec."Capacity (Total)") / ResCapacityEntryRec.Capacity;
            until ResCapacityEntryRec.Next() = 0;
        end;

        TotNavaHours := 0;
        NavAppProdRec.Reset();
        NavAppProdRec.SetRange("Resource No.", Rec."Work Center No.");
        NavAppProdRec.SetRange("Factory No.", Rec."Factory No.");
        NavAppProdRec.SetRange("Style No.", Rec."Style No.");
        NavAppProdRec.SetRange(PlanDate, Rec."Prod Date");
        if NavAppProdRec.FindSet() then begin
            // repeat
            //     TotNavaHours += NavAppProdRec.HoursPerDay;
            // until NavAppProdRec.Next() = 0;

            TotNavaHours := WorkingHrs;

            if (NavAppProdRec."Style No." = StyleLC1) and (NavAppProdRec."Resource No." = LineLC1) then begin
                TotNavaHours := 0;
            end;
            StyleLC1 := NavAppProdRec."Style No.";
            LineLC1 := NavAppProdRec."Resource No.";


            TimeVariable := 0T;
            Time := 0T;
            if NavAppProdRec."LCurve Start Time" <> 0T then
                Time := NavAppProdRec."LCurve Start Time" + (60 * 60 * 1000 * NavAppProdRec."LCurve Hours Per Day");

            LCH := 0;
            if NavAppProdRec."LCurve Hours Per Day" = 0 then
                LCH := 0;
            if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) then
                LCH := 1;
            if (NavAppProdRec."LCurve Hours Per Day" > 1) and (NavAppProdRec."LCurve Hours Per Day" < 2) then
                LCH := 1;
            if (NavAppProdRec."LCurve Hours Per Day" > 2) and (NavAppProdRec."LCurve Hours Per Day" < 3) then
                LCH := 2;
            if (NavAppProdRec."LCurve Hours Per Day" > 3) and (NavAppProdRec."LCurve Hours Per Day" < 4) then
                LCH := 3;
            if (NavAppProdRec."LCurve Hours Per Day" > 4) and (NavAppProdRec."LCurve Hours Per Day" < 5) then
                LCH := 4;
            if (NavAppProdRec."LCurve Hours Per Day" > 5) and (NavAppProdRec."LCurve Hours Per Day" < 6) then
                LCH := 5;
            if (NavAppProdRec."LCurve Hours Per Day" > 6) and (NavAppProdRec."LCurve Hours Per Day" < 7) then
                LCH := 6;
            if (NavAppProdRec."LCurve Hours Per Day" > 7) and (NavAppProdRec."LCurve Hours Per Day" < 8) then
                LCH := 7;
            if (NavAppProdRec."LCurve Hours Per Day" > 8) and (NavAppProdRec."LCurve Hours Per Day" < 9) then
                LCH := 8;
            if (NavAppProdRec."LCurve Hours Per Day" > 9) and (NavAppProdRec."LCurve Hours Per Day" < 10) then
                LCH := 9;
            if (NavAppProdRec."LCurve Hours Per Day" > 10) and (NavAppProdRec."LCurve Hours Per Day" < 11) then
                LCH := 10;



            TotNavaHours := WorkingHrs - LCH;

            if Time = 000000T then
                TimeVariable := Time;

            if (Time > 080000T) and (Time < 090000T) then begin
                TimeVariable := 080000T;
            end;
            if (Time > 090000T) and (Time < 100000T) then begin
                TimeVariable := 090000T;
            end;
            if (Time > 100000T) and (Time < 110000T) then begin
                TimeVariable := 100000T;
            end;
            if (Time > 110000T) and (Time < 120000T) then begin
                TimeVariable := 110000T;
            end;
            if (Time > 120000T) and (Time < 130000T) then begin
                TimeVariable := 120000T;
            end;
            if (Time > 130000T) and (Time < 140000T) then begin
                TimeVariable := 130000T;
            end;
            if (Time > 140000T) and (Time < 150000T) then begin
                TimeVariable := 140000T;
            end;
            if (Time > 150000T) and (Time < 160000T) then begin
                TimeVariable := 150000T;
            end;
            if (Time > 160000T) and (Time < 170000T) then begin
                TimeVariable := 160000T;
            end;
            if (Time > 170000T) and (Time < 180000T) then begin
                TimeVariable := 170000T;
            end;


            // if NavAppProdRec."Resource No." = 'VDL-01' then begin
            //     Message('VDL6');
            Rec."Target_Hour 09" := 0;
            Rec."Target_Hour 10" := 0;
            // end;
            // if NavAppProdRec."Resource No." = 'PAL-01' then begin
            //     Message('VDL7');
            // end;
            // if NavAppProdRec."Resource No." = 'PAL-08' then begin
            //     Message('VDL7');
            // end;
            if NavAppProdRec."LCurve Start Time" = 080000T then begin
                if NavAppProdRec."Learning Curve No." > 1 then begin
                    if TimeVariable = 090000T then begin

                        Rec."Target_Hour 01" := 0;
                        rec.Modify();
                        if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                            CheckValue := 0;
                            CheckValue := TotNavaHours - 2;
                            if CheckValue < 1 then begin
                                Rec."Target_Hour 03" := (DayTarget / TotNavaHours) * CheckValue;
                                rec.Modify();
                            end;
                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                Rec."Target_Hour 02" := DayTarget;
                                rec.Modify();
                            end else
                                Rec."Target_Hour 02" := (DayTarget / TotNavaHours);
                            rec.Modify();


                            CheckValue := 0;
                            CheckValue := TotNavaHours - 3;
                            if CheckValue < 1 then begin
                                Rec."Target_Hour 04" := (DayTarget / TotNavaHours) * CheckValue;
                                rec.Modify();
                            end;
                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                Rec."Target_Hour 03" := DayTarget;
                                rec.Modify();
                            end else
                                Rec."Target_Hour 03" := (DayTarget / TotNavaHours);
                            rec.Modify();



                            CheckValue := 0;
                            CheckValue := TotNavaHours - 4;
                            if CheckValue < 1 then begin
                                Rec."Target_Hour 05" := (DayTarget / TotNavaHours) * CheckValue;
                                rec.Modify();
                            end;
                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                Rec."Target_Hour 04" := DayTarget;
                                rec.Modify();
                            end else
                                Rec."Target_Hour 04" := (DayTarget / TotNavaHours);
                            rec.Modify();


                            CheckValue := 0;
                            CheckValue := TotNavaHours - 5;
                            if CheckValue < 1 then begin
                                Rec."Target_Hour 06" := (DayTarget / TotNavaHours) * CheckValue;
                                rec.Modify();
                            end;
                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                Rec."Target_Hour 05" := DayTarget;
                                rec.Modify();
                            end else
                                Rec."Target_Hour 05" := (DayTarget / TotNavaHours);
                            rec.Modify();

                            CheckValue := 0;
                            CheckValue := TotNavaHours - 6;
                            if CheckValue < 1 then begin
                                Rec."Target_Hour 07" := (DayTarget / TotNavaHours) * CheckValue;
                                rec.Modify();
                            end;
                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                Rec."Target_Hour 06" := DayTarget;
                                rec.Modify();
                            end else
                                Rec."Target_Hour 06" := (DayTarget / TotNavaHours);
                            rec.Modify();

                            CheckValue := 0;
                            CheckValue := TotNavaHours - 7;
                            if CheckValue < 1 then begin
                                Rec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                rec.Modify();
                            end;
                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                Rec."Target_Hour 07" := DayTarget;
                                rec.Modify();
                            end else
                                Rec."Target_Hour 07" := (DayTarget / TotNavaHours);
                            rec.Modify();


                            CheckValue := 0;
                            CheckValue := TotNavaHours - 8;
                            if CheckValue < 1 then begin
                                Rec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                rec.Modify();
                            end;
                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                Rec."Target_Hour 08" := DayTarget;
                                rec.Modify();
                            end else
                                Rec."Target_Hour 08" := (DayTarget / TotNavaHours);
                            rec.Modify();

                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                CheckValue := 0;
                                CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                if CheckValue < 1 then begin
                                    Rec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                    rec.Modify();
                                end;
                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                    Rec."Target_Hour 09" := DayTarget;
                                    rec.Modify();
                                end else
                                    Rec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                rec.Modify();
                            end
                            else begin
                                // Rec."Target_Hour 09" := 0;
                                rec.Modify();
                            end;

                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                    Rec."Target_Hour 10" := DayTarget;
                                    rec.Modify();
                                end else
                                    Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                rec.Modify();
                            end
                            else begin
                                // Rec."Target_Hour 10" := 0;
                                rec.Modify();
                            end;
                        end;
                    end;

                    if TimeVariable = 100000T then begin
                        Rec."Target_Hour 01" := 0;
                        Rec."Target_Hour 02" := 0;
                        rec.Modify();
                        if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                            CheckValue := 0;
                            CheckValue := TotNavaHours - 3;
                            if CheckValue < 1 then begin
                                Rec."Target_Hour 04" := (DayTarget / TotNavaHours) * CheckValue;
                                rec.Modify();
                            end;
                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                Rec."Target_Hour 03" := DayTarget;
                                rec.Modify();
                            end else
                                Rec."Target_Hour 03" := (DayTarget / TotNavaHours);
                            rec.Modify();


                            CheckValue := 0;
                            CheckValue := TotNavaHours - 4;
                            if CheckValue < 1 then begin
                                Rec."Target_Hour 05" := (DayTarget / TotNavaHours) * CheckValue;
                                rec.Modify();
                            end;
                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                Rec."Target_Hour 04" := DayTarget;
                                rec.Modify();
                            end else
                                Rec."Target_Hour 04" := (DayTarget / TotNavaHours);
                            rec.Modify();


                            CheckValue := 0;
                            CheckValue := TotNavaHours - 5;
                            if CheckValue < 1 then begin
                                Rec."Target_Hour 06" := (DayTarget / TotNavaHours) * CheckValue;
                                rec.Modify();
                            end;
                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                Rec."Target_Hour 05" := DayTarget;
                                rec.Modify();
                            end else
                                Rec."Target_Hour 05" := (DayTarget / TotNavaHours);
                            rec.Modify();


                            CheckValue := 0;
                            CheckValue := TotNavaHours - 6;
                            if CheckValue < 1 then begin
                                Rec."Target_Hour 07" := (DayTarget / TotNavaHours) * CheckValue;
                                rec.Modify();
                            end;
                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                Rec."Target_Hour 06" := DayTarget;
                                rec.Modify();
                            end else
                                Rec."Target_Hour 06" := (DayTarget / TotNavaHours);
                            rec.Modify();


                            CheckValue := 0;
                            CheckValue := TotNavaHours - 7;
                            if CheckValue < 1 then begin
                                Rec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                rec.Modify();
                            end;
                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                Rec."Target_Hour 07" := DayTarget;
                                rec.Modify();
                            end else
                                Rec."Target_Hour 07" := (DayTarget / TotNavaHours);
                            rec.Modify();



                            CheckValue := 0;
                            CheckValue := TotNavaHours - 8;
                            if CheckValue < 1 then begin
                                Rec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                rec.Modify();
                            end;
                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                Rec."Target_Hour 08" := DayTarget;
                                rec.Modify();
                            end else
                                Rec."Target_Hour 08" := (DayTarget / TotNavaHours);
                            rec.Modify();

                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                CheckValue := 0;
                                CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                if CheckValue < 1 then begin
                                    Rec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                    rec.Modify();
                                end;
                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                    Rec."Target_Hour 09" := DayTarget;
                                    rec.Modify();
                                end else
                                    Rec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                rec.Modify();
                            end
                            else begin
                                // Rec."Target_Hour 09" := 0;
                                rec.Modify();
                            end;

                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                    Rec."Target_Hour 10" := DayTarget;
                                    rec.Modify();
                                end else
                                    Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                rec.Modify();
                            end
                            else begin
                                // Rec."Target_Hour 10" := 0;
                                rec.Modify();
                            end;
                        end;
                    end;
                    if TimeVariable = 110000T then begin
                        Rec."Target_Hour 01" := 0;
                        Rec."Target_Hour 02" := 0;
                        Rec."Target_Hour 03" := 0;
                        rec.Modify();
                        if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                            CheckValue := 0;
                            CheckValue := TotNavaHours - 4;
                            if CheckValue < 1 then begin
                                Rec."Target_Hour 05" := (DayTarget / TotNavaHours) * CheckValue;
                                rec.Modify();
                            end;
                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                Rec."Target_Hour 04" := DayTarget;
                                rec.Modify();
                            end else
                                Rec."Target_Hour 04" := (DayTarget / TotNavaHours);
                            rec.Modify();


                            CheckValue := 0;
                            CheckValue := TotNavaHours - 5;
                            if CheckValue < 1 then begin
                                Rec."Target_Hour 06" := (DayTarget / TotNavaHours) * CheckValue;
                                rec.Modify();
                            end;
                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                Rec."Target_Hour 05" := DayTarget;
                                rec.Modify();
                            end else
                                Rec."Target_Hour 05" := (DayTarget / TotNavaHours);
                            rec.Modify();


                            CheckValue := 0;
                            CheckValue := TotNavaHours - 6;
                            if CheckValue < 1 then begin
                                Rec."Target_Hour 07" := (DayTarget / TotNavaHours) * CheckValue;
                                rec.Modify();
                            end;
                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                Rec."Target_Hour 06" := DayTarget;
                                rec.Modify();
                            end else
                                Rec."Target_Hour 06" := (DayTarget / TotNavaHours);
                            rec.Modify();



                            CheckValue := 0;
                            CheckValue := TotNavaHours - 7;
                            if CheckValue < 1 then begin
                                Rec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                rec.Modify();
                            end;
                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                Rec."Target_Hour 07" := DayTarget;
                                rec.Modify();
                            end else
                                Rec."Target_Hour 07" := (DayTarget / TotNavaHours);
                            rec.Modify();



                            CheckValue := 0;
                            CheckValue := TotNavaHours - 8;
                            if CheckValue < 1 then begin
                                Rec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                rec.Modify();
                            end;
                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                Rec."Target_Hour 08" := DayTarget;
                                rec.Modify();
                            end else
                                Rec."Target_Hour 08" := (DayTarget / TotNavaHours);
                            rec.Modify();

                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                CheckValue := 0;
                                CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                if CheckValue < 1 then begin
                                    Rec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                    rec.Modify();
                                end;
                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                    Rec."Target_Hour 09" := DayTarget;
                                    rec.Modify();
                                end else
                                    Rec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                rec.Modify();
                            end
                            else begin
                                // Rec."Target_Hour 09" := 0;
                                rec.Modify();
                            end;

                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                    Rec."Target_Hour 10" := DayTarget;
                                    rec.Modify();
                                end else
                                    Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                rec.Modify();
                            end
                            else begin
                                // Rec."Target_Hour 10" := 0;
                                rec.Modify();
                            end;
                        end;
                    end;
                    if TimeVariable = 120000T then begin
                        Rec."Target_Hour 01" := 0;
                        Rec."Target_Hour 02" := 0;
                        Rec."Target_Hour 03" := 0;
                        Rec."Target_Hour 04" := 0;
                        rec.Modify();
                        if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                            CheckValue := 0;
                            CheckValue := TotNavaHours - 5;
                            if CheckValue < 1 then begin
                                Rec."Target_Hour 06" := (DayTarget / TotNavaHours) * CheckValue;
                                rec.Modify();
                            end;
                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                Rec."Target_Hour 05" := DayTarget;
                                rec.Modify();
                            end else
                                Rec."Target_Hour 05" := (DayTarget / TotNavaHours);
                            rec.Modify();


                            CheckValue := 0;
                            CheckValue := TotNavaHours - 6;
                            if CheckValue < 1 then begin
                                Rec."Target_Hour 07" := (DayTarget / TotNavaHours) * CheckValue;
                                rec.Modify();
                            end;
                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                Rec."Target_Hour 06" := DayTarget;
                                rec.Modify();
                            end else
                                Rec."Target_Hour 06" := (DayTarget / TotNavaHours);
                            rec.Modify();

                            CheckValue := 0;
                            CheckValue := TotNavaHours - 7;
                            if CheckValue < 1 then begin
                                Rec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                rec.Modify();
                            end;
                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                Rec."Target_Hour 07" := DayTarget;
                                rec.Modify();
                            end else
                                Rec."Target_Hour 07" := (DayTarget / TotNavaHours);
                            rec.Modify();



                            CheckValue := 0;
                            CheckValue := TotNavaHours - 8;
                            if CheckValue < 1 then begin
                                Rec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                rec.Modify();
                            end;
                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                Rec."Target_Hour 08" := DayTarget;
                            end else
                                Rec."Target_Hour 08" := (DayTarget / TotNavaHours);
                            rec.Modify();

                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                CheckValue := 0;
                                CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                if CheckValue < 1 then begin
                                    Rec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                    rec.Modify();
                                end;
                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                    Rec."Target_Hour 09" := DayTarget;
                                    rec.Modify();
                                end else
                                    Rec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                rec.Modify();
                            end
                            else begin
                                // Rec."Target_Hour 09" := 0;
                                rec.Modify();
                            end;

                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                    Rec."Target_Hour 10" := DayTarget;
                                    rec.Modify();
                                end else
                                    Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                rec.Modify();
                            end
                            else begin
                                // Rec."Target_Hour 10" := 0;
                                rec.Modify();
                            end;
                        end;
                    end;
                    if TimeVariable = 130000T then begin
                        Rec."Target_Hour 01" := 0;
                        Rec."Target_Hour 02" := 0;
                        Rec."Target_Hour 03" := 0;
                        Rec."Target_Hour 04" := 0;
                        Rec."Target_Hour 05" := 0;
                        rec.Modify();
                        if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                            CheckValue := 0;
                            CheckValue := TotNavaHours - 6;
                            if CheckValue < 1 then begin
                                Rec."Target_Hour 07" := (DayTarget / TotNavaHours) * CheckValue;
                                rec.Modify();
                            end;
                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                Rec."Target_Hour 06" := DayTarget;
                                rec.Modify();
                            end else
                                Rec."Target_Hour 06" := (DayTarget / TotNavaHours);
                            rec.Modify();


                            CheckValue := 0;
                            CheckValue := TotNavaHours - 7;
                            if CheckValue < 1 then begin
                                Rec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                rec.Modify();
                            end;
                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                Rec."Target_Hour 07" := DayTarget;
                                rec.Modify();
                            end else
                                Rec."Target_Hour 07" := (DayTarget / TotNavaHours);
                            rec.Modify();



                            CheckValue := 0;
                            CheckValue := TotNavaHours - 8;
                            if CheckValue < 1 then begin
                                Rec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                            end;
                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                Rec."Target_Hour 08" := DayTarget;
                                rec.Modify();
                            end else
                                Rec."Target_Hour 08" := (DayTarget / TotNavaHours);
                            rec.Modify();

                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                CheckValue := 0;
                                CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                if CheckValue < 1 then begin
                                    Rec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                    rec.Modify();
                                end;
                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                    Rec."Target_Hour 09" := DayTarget;
                                    rec.Modify();
                                end else
                                    Rec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                rec.Modify();
                            end
                            else begin
                                // Rec."Target_Hour 09" := 0;
                                rec.Modify();
                            end;

                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                    Rec."Target_Hour 10" := DayTarget;
                                    rec.Modify();
                                end else
                                    Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                rec.Modify();
                            end
                            else begin
                                // Rec."Target_Hour 10" := 0;
                                rec.Modify();
                            end;
                        end;
                    end;
                    if TimeVariable = 140000T then begin
                        Rec."Target_Hour 01" := 0;
                        Rec."Target_Hour 02" := 0;
                        Rec."Target_Hour 03" := 0;
                        Rec."Target_Hour 04" := 0;
                        Rec."Target_Hour 05" := 0;
                        Rec."Target_Hour 06" := 0;
                        rec.Modify();
                        if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                            CheckValue := 0;
                            CheckValue := TotNavaHours - 7;
                            if CheckValue < 1 then begin
                                Rec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                rec.Modify();
                            end;
                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                Rec."Target_Hour 07" := DayTarget;
                                rec.Modify();
                            end else
                                Rec."Target_Hour 07" := (DayTarget / TotNavaHours);
                            rec.Modify();



                            CheckValue := 0;
                            CheckValue := TotNavaHours - 8;
                            if CheckValue < 1 then begin
                                Rec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                rec.Modify();
                            end;
                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                Rec."Target_Hour 08" := DayTarget;
                                rec.Modify();
                            end else
                                Rec."Target_Hour 08" := (DayTarget / TotNavaHours);
                            rec.Modify();

                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                CheckValue := 0;
                                CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                if CheckValue < 1 then begin
                                    Rec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                    rec.Modify();
                                end;
                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                    Rec."Target_Hour 09" := DayTarget;
                                    rec.Modify();
                                end else
                                    Rec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                rec.Modify();
                            end
                            else begin
                                // Rec."Target_Hour 09" := 0;
                                rec.Modify();
                            end;

                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                    Rec."Target_Hour 10" := DayTarget;
                                end else
                                    Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                rec.Modify();
                            end
                            else begin
                                // Rec."Target_Hour 10" := 0;
                                rec.Modify();
                            end;
                        end;
                    end;
                    if TimeVariable = 150000T then begin
                        Rec."Target_Hour 01" := 0;
                        Rec."Target_Hour 02" := 0;
                        Rec."Target_Hour 03" := 0;
                        Rec."Target_Hour 04" := 0;
                        Rec."Target_Hour 05" := 0;
                        Rec."Target_Hour 06" := 0;
                        Rec."Target_Hour 07" := 0;
                        rec.Modify();
                        if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                            CheckValue := 0;
                            CheckValue := TotNavaHours - 8;
                            if CheckValue < 1 then begin
                                Rec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                rec.Modify();
                            end;
                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                Rec."Target_Hour 08" := DayTarget;
                                rec.Modify();
                            end else
                                Rec."Target_Hour 08" := (DayTarget / TotNavaHours);
                            rec.Modify();

                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                CheckValue := 0;
                                CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                if CheckValue < 1 then begin
                                    Rec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                    rec.Modify();
                                end;
                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                    Rec."Target_Hour 09" := DayTarget;
                                    rec.Modify();
                                end else
                                    Rec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                rec.Modify();
                            end
                            else begin
                                // Rec."Target_Hour 09" := 0;
                            end;

                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                    Rec."Target_Hour 10" := DayTarget;
                                    rec.Modify();
                                end else
                                    Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                rec.Modify();
                            end
                            else begin
                                // Rec."Target_Hour 10" := 0;
                                rec.Modify();
                            end;
                        end;
                    end;
                    if TimeVariable = 160000T then begin
                        Rec."Target_Hour 01" := 0;
                        Rec."Target_Hour 02" := 0;
                        Rec."Target_Hour 03" := 0;
                        Rec."Target_Hour 04" := 0;
                        Rec."Target_Hour 05" := 0;
                        Rec."Target_Hour 06" := 0;
                        Rec."Target_Hour 07" := 0;
                        Rec."Target_Hour 08" := 0;
                        rec.Modify();
                        if (TotNavaHours <> 0) and (DayTarget <> 0) then begin
                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                CheckValue := 0;
                                CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                if CheckValue < 1 then begin
                                    Rec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                    rec.Modify();
                                end;
                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                    Rec."Target_Hour 09" := DayTarget;
                                    rec.Modify();
                                end else
                                    Rec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                rec.Modify();
                            end
                            else begin
                                // Rec."Target_Hour 09" := 0;
                                rec.Modify();
                            end;

                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                    Rec."Target_Hour 10" := DayTarget;
                                    rec.Modify();
                                end else
                                    Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                rec.Modify();
                            end
                            else begin
                                // Rec."Target_Hour 10" := 0;
                                rec.Modify();
                            end;
                        end;
                    end;
                    if TimeVariable = 170000T then begin
                        Rec."Target_Hour 01" := 0;
                        Rec."Target_Hour 02" := 0;
                        Rec."Target_Hour 03" := 0;
                        Rec."Target_Hour 04" := 0;
                        Rec."Target_Hour 05" := 0;
                        Rec."Target_Hour 06" := 0;
                        Rec."Target_Hour 07" := 0;
                        Rec."Target_Hour 08" := 0;
                        Rec."Target_Hour 09" := 0;
                        rec.Modify();
                        if (TotNavaHours <> 0) and (DayTarget <> 0) then begin
                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                    Rec."Target_Hour 10" := DayTarget;
                                    rec.Modify();
                                end else
                                    Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                rec.Modify();
                            end
                            else begin
                                // Rec."Target_Hour 10" := 0;
                                rec.Modify();
                            end;
                        end;
                    end;
                end;
            end
            else begin
                //coorect
                if NavAppProdRec."LCurve Start Time" = 090000T then begin
                    if NavAppProdRec."Learning Curve No." > 1 then begin
                        if TimeVariable = 100000T then begin
                            Rec."Target_Hour 02" := 0;
                            if (TotNavaHours <> 0) and (DayTarget <> 0) then begin
                                rec.Modify();

                                CheckValue := 0;
                                CheckValue := TotNavaHours - 3;
                                if CheckValue < 1 then begin
                                    Rec."Target_Hour 04" := (DayTarget / TotNavaHours) * CheckValue;
                                    rec.Modify();
                                end;
                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                    Rec."Target_Hour 03" := DayTarget;
                                    rec.Modify();
                                end else
                                    Rec."Target_Hour 03" := (DayTarget / TotNavaHours);
                                rec.Modify();



                                CheckValue := 0;
                                CheckValue := TotNavaHours - 4;
                                if CheckValue < 1 then begin
                                    Rec."Target_Hour 05" := (DayTarget / TotNavaHours) * CheckValue;
                                    rec.Modify();
                                end;
                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                    Rec."Target_Hour 04" := DayTarget;
                                    rec.Modify();
                                end else
                                    Rec."Target_Hour 04" := (DayTarget / TotNavaHours);
                                rec.Modify();


                                CheckValue := 0;
                                CheckValue := TotNavaHours - 5;
                                if CheckValue < 1 then begin
                                    Rec."Target_Hour 06" := (DayTarget / TotNavaHours) * CheckValue;
                                    rec.Modify();
                                end;
                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                    Rec."Target_Hour 05" := DayTarget;
                                    rec.Modify();
                                end else
                                    Rec."Target_Hour 05" := (DayTarget / TotNavaHours);
                                rec.Modify();


                                CheckValue := 0;
                                CheckValue := TotNavaHours - 6;
                                if CheckValue < 1 then begin
                                    Rec."Target_Hour 07" := (DayTarget / TotNavaHours) * CheckValue;
                                    rec.Modify();
                                end;
                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                    Rec."Target_Hour 06" := DayTarget;
                                    rec.Modify();
                                end else
                                    Rec."Target_Hour 06" := (DayTarget / TotNavaHours);
                                rec.Modify();


                                CheckValue := 0;
                                CheckValue := TotNavaHours - 7;
                                if CheckValue < 1 then begin
                                    Rec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                    rec.Modify();
                                end;
                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                    Rec."Target_Hour 07" := DayTarget;
                                    rec.Modify();
                                end else
                                    Rec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                rec.Modify();



                                CheckValue := 0;
                                CheckValue := TotNavaHours - 8;
                                if CheckValue < 1 then begin
                                    Rec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                    rec.Modify();
                                end;
                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                    Rec."Target_Hour 08" := DayTarget;
                                    rec.Modify();
                                end else
                                    Rec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                rec.Modify();

                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                    CheckValue := 0;
                                    CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                    if CheckValue < 1 then begin
                                        Rec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                        rec.Modify();
                                    end;
                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                        Rec."Target_Hour 09" := DayTarget;
                                        rec.Modify();
                                    end else
                                        Rec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                    rec.Modify();
                                end
                                else begin
                                    // Rec."Target_Hour 09" := 0;
                                    rec.Modify();
                                end;

                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                        Rec."Target_Hour 10" := DayTarget;
                                        rec.Modify();
                                    end else
                                        Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                    rec.Modify();
                                end
                                else begin
                                    // Rec."Target_Hour 10" := 0;
                                    rec.Modify();

                                end;
                            end;
                        end;
                        if TimeVariable = 110000T then begin
                            Rec."Target_Hour 02" := 0;
                            Rec."Target_Hour 03" := 0;
                            rec.Modify();
                            if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                CheckValue := 0;
                                CheckValue := TotNavaHours - 4;
                                if CheckValue < 1 then begin
                                    Rec."Target_Hour 05" := (DayTarget / TotNavaHours) * CheckValue;
                                    rec.Modify();
                                end;
                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                    Rec."Target_Hour 04" := DayTarget;
                                    rec.Modify();
                                end else
                                    Rec."Target_Hour 04" := (DayTarget / TotNavaHours);
                                rec.Modify();

                                CheckValue := 0;
                                CheckValue := TotNavaHours - 5;
                                if CheckValue < 1 then begin
                                    Rec."Target_Hour 06" := (DayTarget / TotNavaHours) * CheckValue;
                                    rec.Modify();
                                end;
                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                    Rec."Target_Hour 05" := DayTarget;
                                    rec.Modify();
                                end else
                                    Rec."Target_Hour 05" := (DayTarget / TotNavaHours);
                                rec.Modify();

                                CheckValue := 0;
                                CheckValue := TotNavaHours - 6;
                                if CheckValue < 1 then begin
                                    Rec."Target_Hour 07" := (DayTarget / TotNavaHours) * CheckValue;
                                    rec.Modify();
                                end;
                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                    Rec."Target_Hour 06" := DayTarget;
                                    rec.Modify();
                                end else
                                    Rec."Target_Hour 06" := (DayTarget / TotNavaHours);
                                rec.Modify();


                                CheckValue := 0;
                                CheckValue := TotNavaHours - 7;
                                if CheckValue < 1 then begin
                                    Rec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                    rec.Modify();
                                end;
                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                    Rec."Target_Hour 07" := DayTarget;
                                    rec.Modify();
                                end else
                                    Rec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                rec.Modify();



                                CheckValue := 0;
                                CheckValue := TotNavaHours - 8;
                                if CheckValue < 1 then begin
                                    Rec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                    rec.Modify();
                                end;
                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                    Rec."Target_Hour 08" := DayTarget;
                                    rec.Modify();
                                end else
                                    Rec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                rec.Modify();

                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                    CheckValue := 0;
                                    CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                    if CheckValue < 1 then begin
                                        Rec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                        rec.Modify();
                                    end;
                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                        Rec."Target_Hour 09" := DayTarget;
                                        rec.Modify();
                                    end else
                                        Rec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                    rec.Modify();
                                end
                                else begin
                                    // Rec."Target_Hour 09" := 0;
                                    rec.Modify();
                                end;

                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                        Rec."Target_Hour 10" := DayTarget;
                                        rec.Modify();
                                    end else
                                        Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                    rec.Modify();
                                end
                                else begin
                                    // Rec."Target_Hour 10" := 0;
                                    rec.Modify();
                                end;
                            end;
                        end;
                        if TimeVariable = 120000T then begin
                            Rec."Target_Hour 02" := 0;
                            Rec."Target_Hour 03" := 0;
                            Rec."Target_Hour 04" := 0;
                            rec.Modify();
                            if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                CheckValue := 0;
                                CheckValue := TotNavaHours - 5;
                                if CheckValue < 1 then begin
                                    Rec."Target_Hour 06" := (DayTarget / TotNavaHours) * CheckValue;
                                    rec.Modify();
                                end;
                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                    Rec."Target_Hour 05" := DayTarget;
                                    rec.Modify();
                                end else
                                    Rec."Target_Hour 05" := (DayTarget / TotNavaHours);
                                rec.Modify();


                                CheckValue := 0;
                                CheckValue := TotNavaHours - 6;
                                if CheckValue < 1 then begin
                                    Rec."Target_Hour 07" := (DayTarget / TotNavaHours) * CheckValue;
                                    rec.Modify();
                                end;
                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                    Rec."Target_Hour 06" := DayTarget;
                                    rec.Modify();
                                end else
                                    Rec."Target_Hour 06" := (DayTarget / TotNavaHours);
                                rec.Modify();

                                CheckValue := 0;
                                CheckValue := TotNavaHours - 7;
                                if CheckValue < 1 then begin
                                    Rec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                    rec.Modify();
                                end;
                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                    Rec."Target_Hour 07" := DayTarget;
                                    rec.Modify();
                                end else
                                    Rec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                rec.Modify();



                                CheckValue := 0;
                                CheckValue := TotNavaHours - 8;
                                if CheckValue < 1 then begin
                                    Rec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                    rec.Modify();
                                end;
                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                    Rec."Target_Hour 08" := DayTarget;
                                    rec.Modify();
                                end else
                                    Rec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                rec.Modify();

                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                    CheckValue := 0;
                                    CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                    if CheckValue < 1 then begin
                                        Rec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                        rec.Modify();
                                    end;
                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                        Rec."Target_Hour 09" := DayTarget;
                                        rec.Modify();
                                    end else
                                        Rec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                    rec.Modify();
                                end
                                else begin
                                    // Rec."Target_Hour 09" := 0;
                                    rec.Modify();
                                end;

                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                        Rec."Target_Hour 10" := DayTarget;
                                        rec.Modify();
                                    end else
                                        Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                    rec.Modify();
                                end
                                else begin
                                    // Rec."Target_Hour 10" := 0;
                                    rec.Modify();
                                end;
                            end;
                        end;
                        if TimeVariable = 130000T then begin
                            Rec."Target_Hour 02" := 0;
                            Rec."Target_Hour 03" := 0;
                            Rec."Target_Hour 04" := 0;
                            Rec."Target_Hour 05" := 0;
                            rec.Modify();
                            if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                CheckValue := 0;
                                CheckValue := TotNavaHours - 6;
                                if CheckValue < 1 then begin
                                    Rec."Target_Hour 07" := (DayTarget / TotNavaHours) * CheckValue;
                                    rec.Modify();
                                end;
                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                    Rec."Target_Hour 06" := DayTarget;
                                    rec.Modify();
                                end else
                                    Rec."Target_Hour 06" := (DayTarget / TotNavaHours);
                                rec.Modify();


                                CheckValue := 0;
                                CheckValue := TotNavaHours - 7;
                                if CheckValue < 1 then begin
                                    Rec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                    rec.Modify();
                                end;
                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                    Rec."Target_Hour 07" := DayTarget;
                                    rec.Modify();
                                end else
                                    Rec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                rec.Modify();



                                CheckValue := 0;
                                CheckValue := TotNavaHours - 8;
                                if CheckValue < 1 then begin
                                    Rec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                    rec.Modify();
                                end;
                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                    Rec."Target_Hour 08" := DayTarget;
                                    rec.Modify();
                                end else
                                    Rec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                rec.Modify();

                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                    CheckValue := 0;
                                    CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                    if CheckValue < 1 then begin
                                        Rec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                        rec.Modify();
                                    end;
                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                        Rec."Target_Hour 09" := DayTarget;
                                        rec.Modify();
                                    end else
                                        Rec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                    rec.Modify();
                                end
                                else begin
                                    // Rec."Target_Hour 09" := 0;
                                    rec.Modify();
                                end;

                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                        Rec."Target_Hour 10" := DayTarget;
                                        rec.Modify();
                                    end else
                                        Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                    rec.Modify();
                                end
                                else begin
                                    Rec."Target_Hour 10" := 0;
                                    rec.Modify();
                                end;
                            end;
                        end;
                        if TimeVariable = 140000T then begin
                            Rec."Target_Hour 02" := 0;
                            Rec."Target_Hour 03" := 0;
                            Rec."Target_Hour 04" := 0;
                            Rec."Target_Hour 05" := 0;
                            Rec."Target_Hour 06" := 0;
                            rec.Modify();
                            if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                CheckValue := 0;
                                CheckValue := TotNavaHours - 7;
                                if CheckValue < 1 then begin
                                    Rec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                    rec.Modify();
                                end;
                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                    Rec."Target_Hour 07" := DayTarget;
                                    rec.Modify();
                                end else
                                    Rec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                rec.Modify();



                                CheckValue := 0;
                                CheckValue := TotNavaHours - 8;
                                if CheckValue < 1 then begin
                                    Rec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                    rec.Modify();
                                end;
                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                    Rec."Target_Hour 08" := DayTarget;
                                    rec.Modify();
                                end else
                                    Rec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                rec.Modify();

                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                    CheckValue := 0;
                                    CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                    if CheckValue < 1 then begin
                                        Rec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                        rec.Modify();
                                    end;
                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                        Rec."Target_Hour 09" := DayTarget;
                                        rec.Modify();
                                    end else
                                        Rec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                    rec.Modify();
                                end
                                else begin
                                    // Rec."Target_Hour 09" := 0;
                                    rec.Modify();
                                end;

                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                        Rec."Target_Hour 10" := DayTarget;
                                        rec.Modify();
                                    end else
                                        Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                    rec.Modify();
                                end
                                else begin
                                    // Rec."Target_Hour 10" := 0;
                                    rec.Modify();
                                end;
                            end;
                        end;
                        if TimeVariable = 150000T then begin
                            Rec."Target_Hour 02" := 0;
                            Rec."Target_Hour 03" := 0;
                            Rec."Target_Hour 04" := 0;
                            Rec."Target_Hour 05" := 0;
                            Rec."Target_Hour 06" := 0;
                            Rec."Target_Hour 07" := 0;
                            rec.Modify();
                            if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                CheckValue := 0;
                                CheckValue := TotNavaHours - 8;
                                if CheckValue < 1 then begin
                                    Rec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                    rec.Modify();
                                end;
                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                    Rec."Target_Hour 08" := DayTarget;
                                    rec.Modify();
                                end else
                                    Rec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                rec.Modify();

                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                    CheckValue := 0;
                                    CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                    if CheckValue < 1 then begin
                                        Rec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                        rec.Modify();
                                    end;
                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                        Rec."Target_Hour 09" := DayTarget;
                                        rec.Modify();
                                    end else
                                        Rec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                    rec.Modify();
                                end
                                else begin
                                    Rec."Target_Hour 09" := 0;
                                    rec.Modify();
                                end;

                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                        Rec."Target_Hour 10" := DayTarget;
                                        rec.Modify();
                                    end else
                                        Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                    rec.Modify();
                                end
                                else begin
                                    // Rec."Target_Hour 10" := 0;
                                    rec.Modify();
                                end;
                            end;

                        end;
                        if TimeVariable = 160000T then begin
                            Rec."Target_Hour 02" := 0;
                            Rec."Target_Hour 03" := 0;
                            Rec."Target_Hour 04" := 0;
                            Rec."Target_Hour 05" := 0;
                            Rec."Target_Hour 06" := 0;
                            Rec."Target_Hour 07" := 0;
                            Rec."Target_Hour 08" := 0;
                            rec.Modify();
                            if (TotNavaHours <> 0) and (DayTarget <> 0) then begin
                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                    CheckValue := 0;
                                    CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                    if CheckValue < 1 then begin
                                        Rec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                        rec.Modify();
                                    end;
                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                        Rec."Target_Hour 09" := DayTarget;
                                        rec.Modify();
                                    end else
                                        Rec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                    rec.Modify();
                                end
                                else begin
                                    // Rec."Target_Hour 09" := 0;
                                    rec.Modify();
                                end;

                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                        Rec."Target_Hour 10" := DayTarget;
                                        rec.Modify();
                                    end else
                                        Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                    rec.Modify();
                                end
                                else begin
                                    // Rec."Target_Hour 10" := 0;
                                    rec.Modify();
                                end;
                            end;
                        end;
                        if TimeVariable = 170000T then begin
                            Rec."Target_Hour 02" := 0;
                            Rec."Target_Hour 03" := 0;
                            Rec."Target_Hour 04" := 0;
                            Rec."Target_Hour 05" := 0;
                            Rec."Target_Hour 06" := 0;
                            Rec."Target_Hour 07" := 0;
                            Rec."Target_Hour 08" := 0;
                            Rec."Target_Hour 09" := 0;
                            rec.Modify();
                            if (TotNavaHours <> 0) and (DayTarget <> 0) then begin
                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                        Rec."Target_Hour 10" := DayTarget;
                                        rec.Modify();
                                    end else
                                        Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                    rec.Modify();
                                end
                                else begin
                                    // Rec."Target_Hour 10" := 0;
                                    rec.Modify();
                                end;
                            end;
                        end;
                    end;
                end
                else begin

                    //Correct

                    if NavAppProdRec."LCurve Start Time" = 100000T then begin
                        if NavAppProdRec."Learning Curve No." > 1 then begin
                            if TimeVariable = 110000T then begin
                                Rec."Target_Hour 03" := 0;
                                rec.Modify();
                                if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                    CheckValue := 0;
                                    CheckValue := TotNavaHours - 4;
                                    if CheckValue < 1 then begin
                                        Rec."Target_Hour 05" := (DayTarget / TotNavaHours) * CheckValue;
                                        rec.Modify();
                                    end;
                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                        Rec."Target_Hour 04" := DayTarget;
                                        rec.Modify();
                                    end else
                                        Rec."Target_Hour 04" := (DayTarget / TotNavaHours);
                                    rec.Modify();

                                    CheckValue := 0;
                                    CheckValue := TotNavaHours - 5;
                                    if CheckValue < 1 then begin
                                        Rec."Target_Hour 06" := (DayTarget / TotNavaHours) * CheckValue;
                                        rec.Modify();
                                    end;
                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                        Rec."Target_Hour 05" := DayTarget;
                                        rec.Modify();
                                    end else
                                        Rec."Target_Hour 05" := (DayTarget / TotNavaHours);
                                    rec.Modify();

                                    CheckValue := 0;
                                    CheckValue := TotNavaHours - 6;
                                    if CheckValue < 1 then begin
                                        Rec."Target_Hour 07" := (DayTarget / TotNavaHours) * CheckValue;
                                        rec.Modify();
                                    end;
                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                        Rec."Target_Hour 06" := DayTarget;
                                        rec.Modify();
                                    end else
                                        Rec."Target_Hour 06" := (DayTarget / TotNavaHours);
                                    rec.Modify();

                                    CheckValue := 0;
                                    CheckValue := TotNavaHours - 7;
                                    if CheckValue < 1 then begin
                                        Rec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                        rec.Modify();
                                    end;
                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                        Rec."Target_Hour 07" := DayTarget;
                                    end else
                                        Rec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                    rec.Modify();



                                    CheckValue := 0;
                                    CheckValue := TotNavaHours - 8;
                                    if CheckValue < 1 then begin
                                        Rec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                        rec.Modify();
                                    end;
                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                        Rec."Target_Hour 08" := DayTarget;
                                        rec.Modify();
                                    end else
                                        Rec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                    rec.Modify();

                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                        CheckValue := 0;
                                        CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                        if CheckValue < 1 then begin
                                            Rec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                            rec.Modify();
                                        end;
                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                            Rec."Target_Hour 09" := DayTarget;
                                            rec.Modify();
                                        end else
                                            Rec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                        rec.Modify();
                                    end
                                    else begin
                                        // Rec."Target_Hour 09" := 0;
                                        rec.Modify();
                                    end;

                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                            Rec."Target_Hour 10" := DayTarget;
                                            rec.Modify();
                                        end else
                                            Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                        rec.Modify();
                                    end
                                    else begin
                                        // Rec."Target_Hour 10" := 0;
                                        rec.Modify();
                                    end;
                                end;
                            end;
                            if TimeVariable = 120000T then begin
                                Rec."Target_Hour 03" := 0;
                                Rec."Target_Hour 04" := 0;
                                rec.Modify();
                                if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                    CheckValue := 0;
                                    CheckValue := TotNavaHours - 5;
                                    if CheckValue < 1 then begin
                                        Rec."Target_Hour 06" := (DayTarget / TotNavaHours) * CheckValue;
                                        rec.Modify();
                                    end;
                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                        Rec."Target_Hour 05" := DayTarget;
                                        rec.Modify();
                                    end else
                                        Rec."Target_Hour 05" := (DayTarget / TotNavaHours);
                                    rec.Modify();


                                    CheckValue := 0;
                                    CheckValue := TotNavaHours - 6;
                                    if CheckValue < 1 then begin
                                        Rec."Target_Hour 07" := (DayTarget / TotNavaHours) * CheckValue;
                                        rec.Modify();
                                    end;
                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                        Rec."Target_Hour 06" := DayTarget;
                                        rec.Modify();
                                    end else
                                        Rec."Target_Hour 06" := (DayTarget / TotNavaHours);
                                    rec.Modify();

                                    CheckValue := 0;
                                    CheckValue := TotNavaHours - 7;
                                    if CheckValue < 1 then begin
                                        Rec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                        rec.Modify();
                                    end;
                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                        Rec."Target_Hour 07" := DayTarget;
                                        rec.Modify();
                                    end else
                                        Rec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                    rec.Modify();



                                    CheckValue := 0;
                                    CheckValue := TotNavaHours - 8;
                                    if CheckValue < 1 then begin
                                        Rec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                        rec.Modify();
                                    end;
                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                        Rec."Target_Hour 08" := DayTarget;
                                        rec.Modify();
                                    end else
                                        Rec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                    rec.Modify();

                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                        CheckValue := 0;
                                        CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                        if CheckValue < 1 then begin
                                            Rec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                            rec.Modify();
                                        end;
                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                            Rec."Target_Hour 09" := DayTarget;
                                            rec.Modify();
                                        end else
                                            Rec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                        rec.Modify();
                                    end
                                    else begin
                                        Rec."Target_Hour 09" := 0;
                                        rec.Modify();
                                    end;

                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                            Rec."Target_Hour 10" := DayTarget;
                                            rec.Modify();
                                        end else
                                            Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                        rec.Modify();
                                    end
                                    else begin
                                        Rec."Target_Hour 10" := 0;
                                        rec.Modify();
                                    end;
                                end;
                            end;
                            if TimeVariable = 130000T then begin
                                Rec."Target_Hour 03" := 0;
                                Rec."Target_Hour 04" := 0;
                                Rec."Target_Hour 05" := 0;
                                rec.Modify();
                                if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                    CheckValue := 0;
                                    CheckValue := TotNavaHours - 6;
                                    if CheckValue < 1 then begin
                                        Rec."Target_Hour 07" := (DayTarget / TotNavaHours) * CheckValue;
                                        rec.Modify();
                                    end;
                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                        Rec."Target_Hour 06" := DayTarget;
                                        rec.Modify();
                                    end else
                                        Rec."Target_Hour 06" := (DayTarget / TotNavaHours);
                                    rec.Modify();


                                    CheckValue := 0;
                                    CheckValue := TotNavaHours - 7;
                                    if CheckValue < 1 then begin
                                        Rec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                        rec.Modify();
                                    end;
                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                        Rec."Target_Hour 07" := DayTarget;
                                        rec.Modify();
                                    end else
                                        Rec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                    rec.Modify();


                                    CheckValue := 0;
                                    CheckValue := TotNavaHours - 8;
                                    if CheckValue < 1 then begin
                                        Rec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                        rec.Modify();
                                    end;
                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                        Rec."Target_Hour 08" := DayTarget;
                                        rec.Modify();
                                    end else
                                        Rec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                    rec.Modify();

                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                        CheckValue := 0;
                                        CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                        if CheckValue < 1 then begin
                                            Rec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                            rec.Modify();
                                        end;
                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                            Rec."Target_Hour 09" := DayTarget;
                                            rec.Modify();
                                        end else
                                            Rec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                        rec.Modify();
                                    end
                                    else begin
                                        Rec."Target_Hour 09" := 0;
                                        rec.Modify();
                                    end;

                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                            Rec."Target_Hour 10" := DayTarget;
                                            rec.Modify();
                                        end else
                                            Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                        rec.Modify();
                                    end
                                    else begin
                                        Rec."Target_Hour 10" := 0;
                                        rec.Modify();
                                    end;
                                end;
                            end;
                            if TimeVariable = 140000T then begin
                                Rec."Target_Hour 03" := 0;
                                Rec."Target_Hour 04" := 0;
                                Rec."Target_Hour 05" := 0;
                                Rec."Target_Hour 06" := 0;
                                rec.Modify();
                                if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                    CheckValue := 0;
                                    CheckValue := TotNavaHours - 7;
                                    if CheckValue < 1 then begin
                                        Rec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                        rec.Modify();
                                    end;
                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                        Rec."Target_Hour 07" := DayTarget;
                                        rec.Modify();
                                    end else
                                        Rec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                    rec.Modify();


                                    CheckValue := 0;
                                    CheckValue := TotNavaHours - 8;
                                    if CheckValue < 1 then begin
                                        Rec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                        rec.Modify();
                                    end;
                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                        Rec."Target_Hour 08" := DayTarget;
                                        rec.Modify();
                                    end else
                                        Rec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                    rec.Modify();

                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                        CheckValue := 0;
                                        CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                        if CheckValue < 1 then begin
                                            Rec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                            rec.Modify();
                                        end;
                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                            Rec."Target_Hour 09" := DayTarget;
                                            rec.Modify();
                                        end else
                                            Rec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                        rec.Modify();
                                    end
                                    else begin
                                        // Rec."Target_Hour 09" := 0;
                                        rec.Modify();
                                    end;

                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                            Rec."Target_Hour 10" := DayTarget;
                                            rec.Modify();
                                        end else
                                            Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                        rec.Modify();
                                    end
                                    else begin
                                        // Rec."Target_Hour 10" := 0;
                                        rec.Modify();
                                    end;
                                end;
                            end;
                            if TimeVariable = 150000T then begin
                                Rec."Target_Hour 03" := 0;
                                Rec."Target_Hour 04" := 0;
                                Rec."Target_Hour 05" := 0;
                                Rec."Target_Hour 06" := 0;
                                Rec."Target_Hour 07" := 0;
                                rec.Modify();
                                if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                    CheckValue := 0;
                                    CheckValue := TotNavaHours - 8;
                                    if CheckValue < 1 then begin
                                        Rec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                        rec.Modify();
                                    end;
                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                        Rec."Target_Hour 08" := DayTarget;
                                        rec.Modify();
                                    end else
                                        Rec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                    rec.Modify();

                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                        CheckValue := 0;
                                        CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                        if CheckValue < 1 then begin
                                            Rec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                            rec.Modify();
                                        end;
                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                            Rec."Target_Hour 09" := DayTarget;
                                            rec.Modify();
                                        end else
                                            Rec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                        rec.Modify();
                                    end
                                    else begin
                                        // Rec."Target_Hour 09" := 0;
                                        rec.Modify();
                                    end;

                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                            Rec."Target_Hour 10" := DayTarget;
                                            rec.Modify();
                                        end else
                                            Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                        rec.Modify();
                                    end
                                    else begin
                                        // Rec."Target_Hour 10" := 0;
                                        rec.Modify();
                                    end;
                                end;
                            end;
                            if TimeVariable = 160000T then begin
                                Rec."Target_Hour 03" := 0;
                                Rec."Target_Hour 04" := 0;
                                Rec."Target_Hour 05" := 0;
                                Rec."Target_Hour 06" := 0;
                                Rec."Target_Hour 07" := 0;
                                Rec."Target_Hour 08" := 0;
                                rec.Modify();
                                if (TotNavaHours <> 0) and (DayTarget <> 0) then begin
                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                        CheckValue := 0;
                                        CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                        if CheckValue < 1 then begin
                                            Rec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                            rec.Modify();
                                        end;
                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                            Rec."Target_Hour 09" := DayTarget;
                                            rec.Modify();
                                        end else
                                            Rec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                        rec.Modify();
                                    end
                                    else begin
                                        // Rec."Target_Hour 09" := 0;
                                        rec.Modify();
                                    end;

                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                            Rec."Target_Hour 10" := DayTarget;
                                            rec.Modify();
                                        end else
                                            Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                        rec.Modify();
                                    end
                                    else begin
                                        // Rec."Target_Hour 10" := 0;
                                        rec.Modify();
                                    end;
                                end;
                            end;
                            if TimeVariable = 170000T then begin
                                Rec."Target_Hour 03" := 0;
                                Rec."Target_Hour 04" := 0;
                                Rec."Target_Hour 05" := 0;
                                Rec."Target_Hour 06" := 0;
                                Rec."Target_Hour 07" := 0;
                                Rec."Target_Hour 08" := 0;
                                Rec."Target_Hour 09" := 0;
                                rec.Modify();
                                if (TotNavaHours <> 0) and (DayTarget <> 0) then begin
                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                            Rec."Target_Hour 10" := DayTarget;
                                            rec.Modify();
                                        end else
                                            Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                        rec.Modify();
                                    end
                                    else begin
                                        // Rec."Target_Hour 10" := 0;
                                        rec.Modify();
                                    end;
                                end;
                            end;
                        end;
                    end
                    else begin

                        //Correct
                        if NavAppProdRec."LCurve Start Time" = 110000T then begin
                            if NavAppProdRec."Learning Curve No." > 1 then begin
                                if TimeVariable = 120000T then begin
                                    Rec."Target_Hour 04" := 0;
                                    rec.Modify();
                                    if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                        CheckValue := 0;
                                        CheckValue := TotNavaHours - 5;
                                        if CheckValue < 1 then begin
                                            Rec."Target_Hour 06" := (DayTarget / TotNavaHours) * CheckValue;
                                            rec.Modify();
                                        end;
                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                            Rec."Target_Hour 05" := DayTarget;
                                            rec.Modify();
                                        end else
                                            Rec."Target_Hour 05" := (DayTarget / TotNavaHours);
                                        rec.Modify();


                                        CheckValue := 0;
                                        CheckValue := TotNavaHours - 6;
                                        if CheckValue < 1 then begin
                                            Rec."Target_Hour 07" := (DayTarget / TotNavaHours) * CheckValue;
                                            rec.Modify();
                                        end;
                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                            Rec."Target_Hour 06" := DayTarget;
                                            rec.Modify();
                                        end else
                                            Rec."Target_Hour 06" := (DayTarget / TotNavaHours);
                                        rec.Modify();


                                        CheckValue := 0;
                                        CheckValue := TotNavaHours - 7;
                                        if CheckValue < 1 then begin
                                            Rec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                            rec.Modify();
                                        end;
                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                            Rec."Target_Hour 07" := DayTarget;
                                            rec.Modify();
                                        end else
                                            Rec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                        rec.Modify();



                                        CheckValue := 0;
                                        CheckValue := TotNavaHours - 8;
                                        if CheckValue < 1 then begin
                                            Rec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                            rec.Modify();
                                        end;
                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                            Rec."Target_Hour 08" := DayTarget;
                                            rec.Modify();
                                        end else
                                            Rec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                        rec.Modify();

                                        if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                            CheckValue := 0;
                                            CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                            if CheckValue < 1 then begin
                                                Rec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                rec.Modify();
                                            end;
                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                Rec."Target_Hour 09" := DayTarget;
                                                rec.Modify();
                                            end else
                                                Rec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                            rec.Modify();
                                        end
                                        else begin
                                            // Rec."Target_Hour 09" := 0;
                                            rec.Modify();
                                        end;

                                        if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                Rec."Target_Hour 10" := DayTarget;
                                                rec.Modify();
                                            end else
                                                Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                            rec.Modify();
                                        end
                                        else begin
                                            // Rec."Target_Hour 10" := 0;
                                            rec.Modify();
                                        end;
                                    end;
                                end;
                                if TimeVariable = 130000T then begin
                                    Rec."Target_Hour 04" := 0;
                                    Rec."Target_Hour 05" := 0;
                                    if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                        CheckValue := 0;
                                        CheckValue := TotNavaHours - 6;
                                        if CheckValue < 1 then begin
                                            Rec."Target_Hour 07" := (DayTarget / TotNavaHours) * CheckValue;
                                            rec.Modify();
                                        end;
                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                            Rec."Target_Hour 06" := DayTarget;
                                            rec.Modify();
                                        end else
                                            Rec."Target_Hour 06" := (DayTarget / TotNavaHours);
                                        rec.Modify();


                                        CheckValue := 0;
                                        CheckValue := TotNavaHours - 7;
                                        if CheckValue < 1 then begin
                                            Rec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                            rec.Modify();
                                        end;
                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                            Rec."Target_Hour 07" := DayTarget;
                                            rec.Modify();
                                        end else
                                            Rec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                        rec.Modify();



                                        CheckValue := 0;
                                        CheckValue := TotNavaHours - 8;
                                        if CheckValue < 1 then begin
                                            Rec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                            rec.Modify();
                                        end;
                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                            Rec."Target_Hour 08" := DayTarget;
                                            rec.Modify();
                                        end else
                                            Rec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                        rec.Modify();

                                        if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                            CheckValue := 0;
                                            CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                            if CheckValue < 1 then begin
                                                Rec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                rec.Modify();
                                            end;
                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                Rec."Target_Hour 09" := DayTarget;
                                                rec.Modify();
                                            end else
                                                Rec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                            rec.Modify();
                                        end
                                        else begin
                                            Rec."Target_Hour 09" := 0;
                                            rec.Modify();
                                        end;

                                        if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                Rec."Target_Hour 10" := DayTarget;
                                                rec.Modify();
                                            end else
                                                Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                            rec.Modify();
                                        end
                                        else begin
                                            // Rec."Target_Hour 10" := 0;
                                            rec.Modify();
                                        end;
                                    end;
                                end;
                                if TimeVariable = 140000T then begin
                                    Rec."Target_Hour 04" := 0;
                                    Rec."Target_Hour 05" := 0;
                                    Rec."Target_Hour 06" := 0;
                                    rec.Modify();
                                    if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                        CheckValue := 0;
                                        CheckValue := TotNavaHours - 7;
                                        if CheckValue < 1 then begin
                                            Rec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                            rec.Modify();
                                        end;
                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                            Rec."Target_Hour 07" := DayTarget;
                                            rec.Modify();
                                        end else
                                            Rec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                        rec.Modify();


                                        CheckValue := 0;
                                        CheckValue := TotNavaHours - 8;
                                        if CheckValue < 1 then begin
                                            Rec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                            rec.Modify();
                                        end;
                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                            Rec."Target_Hour 08" := DayTarget;
                                            rec.Modify();
                                        end else
                                            Rec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                        rec.Modify();

                                        if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                            CheckValue := 0;
                                            CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                            if CheckValue < 1 then begin
                                                Rec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                rec.Modify();
                                            end;
                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                Rec."Target_Hour 09" := DayTarget;
                                                rec.Modify();
                                            end else
                                                Rec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                            rec.Modify();
                                        end
                                        else begin
                                            // Rec."Target_Hour 09" := 0;
                                            rec.Modify();
                                        end;

                                        if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                Rec."Target_Hour 10" := DayTarget;
                                                rec.Modify();
                                            end else
                                                Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                            rec.Modify();
                                        end
                                        else begin
                                            // Rec."Target_Hour 10" := 0;
                                            rec.Modify();
                                        end;
                                    end;
                                end;
                                if TimeVariable = 150000T then begin
                                    Rec."Target_Hour 04" := 0;
                                    Rec."Target_Hour 05" := 0;
                                    Rec."Target_Hour 06" := 0;
                                    Rec."Target_Hour 07" := 0;
                                    rec.Modify();
                                    if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                        CheckValue := 0;
                                        CheckValue := TotNavaHours - 8;
                                        if CheckValue < 1 then begin
                                            Rec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                            rec.Modify();
                                        end;
                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                            Rec."Target_Hour 08" := DayTarget;
                                            rec.Modify();
                                        end else
                                            Rec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                        rec.Modify();

                                        if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                            CheckValue := 0;
                                            CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                            if CheckValue < 1 then begin
                                                Rec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                rec.Modify();
                                            end;
                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                Rec."Target_Hour 09" := DayTarget;
                                                rec.Modify();
                                            end else
                                                Rec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                            rec.Modify();
                                        end
                                        else begin
                                            // Rec."Target_Hour 09" := 0;
                                            rec.Modify();
                                        end;

                                        if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                Rec."Target_Hour 10" := DayTarget;
                                                rec.Modify();
                                            end else
                                                Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                            rec.Modify();
                                        end
                                        else begin
                                            // Rec."Target_Hour 10" := 0;
                                            rec.Modify();
                                        end;
                                    end;
                                end;
                                if TimeVariable = 160000T then begin
                                    Rec."Target_Hour 04" := 0;
                                    Rec."Target_Hour 05" := 0;
                                    Rec."Target_Hour 06" := 0;
                                    Rec."Target_Hour 07" := 0;
                                    Rec."Target_Hour 08" := 0;
                                    rec.Modify();
                                    if (TotNavaHours <> 0) and (DayTarget <> 0) then begin
                                        if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                            CheckValue := 0;
                                            CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                            if CheckValue < 1 then begin
                                                Rec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                rec.Modify();
                                            end;
                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                Rec."Target_Hour 09" := DayTarget;
                                                rec.Modify();
                                            end else
                                                Rec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                            rec.Modify();
                                        end
                                        else begin
                                            // Rec."Target_Hour 09" := 0;
                                            rec.Modify();
                                        end;

                                        if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                Rec."Target_Hour 10" := DayTarget;
                                                rec.Modify();
                                            end else
                                                Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                            rec.Modify();
                                        end
                                        else begin
                                            // Rec."Target_Hour 10" := 0;
                                            rec.Modify();
                                        end;
                                    end;
                                end;
                                if TimeVariable = 170000T then begin
                                    Rec."Target_Hour 04" := 0;
                                    Rec."Target_Hour 05" := 0;
                                    Rec."Target_Hour 06" := 0;
                                    Rec."Target_Hour 07" := 0;
                                    Rec."Target_Hour 08" := 0;
                                    Rec."Target_Hour 09" := 0;
                                    rec.Modify();
                                    if (TotNavaHours <> 0) and (DayTarget <> 0) then begin
                                        if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                Rec."Target_Hour 10" := DayTarget;
                                                rec.Modify();
                                            end else
                                                Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                            rec.Modify();
                                        end
                                        else begin
                                            // Rec."Target_Hour 10" := 0;
                                            rec.Modify();
                                        end;
                                    end;
                                end;
                            end;
                        end
                        else begin



                            //Correct
                            if NavAppProdRec."LCurve Start Time" = 120000T then begin
                                if NavAppProdRec."Learning Curve No." > 1 then begin
                                    if TimeVariable = 130000T then begin
                                        Rec."Target_Hour 05" := 0;
                                        if (TotNavaHours <> 0) and (DayTarget <> 0) then begin
                                            rec.Modify();

                                            CheckValue := 0;
                                            CheckValue := TotNavaHours - 6;
                                            if CheckValue < 1 then begin
                                                Rec."Target_Hour 07" := (DayTarget / TotNavaHours) * CheckValue;
                                                rec.Modify();
                                            end;
                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                Rec."Target_Hour 06" := DayTarget;
                                                rec.Modify();
                                            end else
                                                Rec."Target_Hour 06" := (DayTarget / TotNavaHours);
                                            rec.Modify();


                                            CheckValue := 0;
                                            CheckValue := TotNavaHours - 7;
                                            if CheckValue < 1 then begin
                                                Rec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                                rec.Modify();
                                            end;
                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                Rec."Target_Hour 07" := DayTarget;
                                                rec.Modify();
                                            end else
                                                Rec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                            rec.Modify();



                                            CheckValue := 0;
                                            CheckValue := TotNavaHours - 8;
                                            if CheckValue < 1 then begin
                                                Rec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                                rec.Modify();
                                            end;
                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                Rec."Target_Hour 08" := DayTarget;
                                                rec.Modify();
                                            end else
                                                Rec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                            rec.Modify();

                                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                CheckValue := 0;
                                                CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                if CheckValue < 1 then begin
                                                    Rec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                    rec.Modify();
                                                end;
                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                    Rec."Target_Hour 09" := DayTarget;
                                                    rec.Modify();
                                                end else
                                                    Rec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                rec.Modify();
                                            end
                                            else begin
                                                // Rec."Target_Hour 09" := 0;
                                                rec.Modify();
                                            end;

                                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                    Rec."Target_Hour 10" := DayTarget;
                                                    rec.Modify();
                                                end else
                                                    Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                rec.Modify();
                                            end
                                            else begin
                                                // Rec."Target_Hour 10" := 0;
                                                rec.Modify();
                                            end;
                                        end;
                                    end;
                                    if TimeVariable = 140000T then begin
                                        Rec."Target_Hour 05" := 0;
                                        Rec."Target_Hour 06" := 0;
                                        rec.Modify();
                                        if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                            CheckValue := 0;
                                            CheckValue := TotNavaHours - 7;
                                            if CheckValue < 1 then begin
                                                Rec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                                rec.Modify();
                                            end;
                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                Rec."Target_Hour 07" := DayTarget;
                                                rec.Modify();
                                            end else
                                                Rec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                            rec.Modify();



                                            CheckValue := 0;
                                            CheckValue := TotNavaHours - 8;
                                            if CheckValue < 1 then begin
                                                Rec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                                rec.Modify();
                                            end;
                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                Rec."Target_Hour 08" := DayTarget;
                                                rec.Modify();
                                            end else
                                                Rec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                            rec.Modify();

                                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                CheckValue := 0;
                                                CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                if CheckValue < 1 then begin
                                                    Rec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                    rec.Modify();
                                                end;
                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                    Rec."Target_Hour 09" := DayTarget;
                                                    rec.Modify();
                                                end else
                                                    Rec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                rec.Modify();
                                            end
                                            else begin
                                                // Rec."Target_Hour 09" := 0;
                                                rec.Modify();
                                            end;

                                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                    Rec."Target_Hour 10" := DayTarget;
                                                    rec.Modify();
                                                end else
                                                    Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                rec.Modify();
                                            end
                                            else begin
                                                // Rec."Target_Hour 10" := 0;
                                                rec.Modify();
                                            end;
                                        end;
                                    end;
                                    if TimeVariable = 150000T then begin
                                        Rec."Target_Hour 05" := 0;
                                        Rec."Target_Hour 06" := 0;
                                        Rec."Target_Hour 07" := 0;
                                        rec.Modify();
                                        if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                            CheckValue := 0;
                                            CheckValue := TotNavaHours - 8;
                                            if CheckValue < 1 then begin
                                                Rec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                                rec.Modify();
                                            end;
                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                Rec."Target_Hour 08" := DayTarget;
                                                rec.Modify();
                                            end else
                                                Rec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                            rec.Modify();

                                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                CheckValue := 0;
                                                CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                if CheckValue < 1 then begin
                                                    Rec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                    rec.Modify();
                                                end;
                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                    Rec."Target_Hour 09" := DayTarget;
                                                    rec.Modify();
                                                end else
                                                    Rec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                rec.Modify();
                                            end
                                            else begin
                                                // Rec."Target_Hour 09" := 0;
                                                rec.Modify();
                                            end;
                                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                    Rec."Target_Hour 10" := DayTarget;
                                                    rec.Modify();
                                                end else
                                                    Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                rec.Modify();
                                            end
                                            else begin
                                                // Rec."Target_Hour 10" := 0;
                                                rec.Modify();
                                            end;
                                        end;
                                    end;
                                    //
                                    if TimeVariable = 160000T then begin
                                        Rec."Target_Hour 05" := 0;
                                        Rec."Target_Hour 06" := 0;
                                        Rec."Target_Hour 07" := 0;
                                        Rec."Target_Hour 08" := 0;
                                        rec.Modify();
                                        if (TotNavaHours <> 0) and (DayTarget <> 0) then begin
                                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                CheckValue := 0;
                                                CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                if CheckValue < 1 then begin
                                                    Rec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                    rec.Modify();
                                                end;
                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                    Rec."Target_Hour 09" := DayTarget;
                                                    rec.Modify();
                                                end else
                                                    Rec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                rec.Modify();
                                            end
                                            else begin
                                                // Rec."Target_Hour 09" := 0;
                                                rec.Modify();
                                            end;
                                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                    Rec."Target_Hour 10" := DayTarget;
                                                    rec.Modify();
                                                end else
                                                    Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                rec.Modify();
                                            end
                                            else begin
                                                // Rec."Target_Hour 10" := 0;
                                                rec.Modify();
                                            end;
                                        end;
                                    end;
                                    if TimeVariable = 170000T then begin
                                        Rec."Target_Hour 05" := 0;
                                        Rec."Target_Hour 06" := 0;
                                        Rec."Target_Hour 07" := 0;
                                        Rec."Target_Hour 08" := 0;
                                        Rec."Target_Hour 09" := 0;
                                        rec.Modify();
                                        if (TotNavaHours <> 0) and (DayTarget <> 0) then begin
                                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                    Rec."Target_Hour 10" := DayTarget;
                                                    rec.Modify();
                                                end else
                                                    Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                rec.Modify();
                                            end
                                            else begin
                                                // Rec."Target_Hour 10" := 0;
                                                rec.Modify();
                                            end;
                                        end;
                                    end;
                                end;
                            end
                            else begin


                                //Correct
                                if NavAppProdRec."LCurve Start Time" = 130000T then begin
                                    if NavAppProdRec."Learning Curve No." > 1 then begin
                                        if TimeVariable = 140000T then begin
                                            Rec."Target_Hour 06" := 0;
                                            rec.Modify();
                                            if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                CheckValue := 0;
                                                CheckValue := TotNavaHours - 7;
                                                if CheckValue < 1 then begin
                                                    Rec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                                    rec.Modify();
                                                end;
                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                    Rec."Target_Hour 07" := DayTarget;
                                                    rec.Modify();
                                                end else
                                                    Rec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                                rec.Modify();


                                                CheckValue := 0;
                                                CheckValue := TotNavaHours - 8;
                                                if CheckValue < 1 then begin
                                                    Rec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                                    rec.Modify();
                                                end;
                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                    Rec."Target_Hour 08" := DayTarget;
                                                    rec.Modify();
                                                end else
                                                    Rec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                                rec.Modify();

                                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                    CheckValue := 0;
                                                    CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                    if CheckValue < 1 then begin
                                                        Rec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                        rec.Modify();
                                                    end;
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        Rec."Target_Hour 09" := DayTarget;
                                                        rec.Modify();
                                                    end else
                                                        Rec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                    rec.Modify();
                                                end
                                                else begin
                                                    Rec."Target_Hour 09" := 0;
                                                    rec.Modify();
                                                end;

                                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        Rec."Target_Hour 10" := DayTarget;
                                                        rec.Modify();
                                                    end else
                                                        Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                    rec.Modify();
                                                end
                                                else begin
                                                    Rec."Target_Hour 10" := 0;
                                                    rec.Modify();
                                                end;
                                            end;
                                        end;
                                        if TimeVariable = 150000T then begin
                                            Rec."Target_Hour 06" := 0;
                                            Rec."Target_Hour 07" := 0;
                                            if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                CheckValue := 0;
                                                CheckValue := TotNavaHours - 8;
                                                if CheckValue < 1 then begin
                                                    Rec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                                    rec.Modify();
                                                end;
                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                    Rec."Target_Hour 08" := DayTarget;
                                                    rec.Modify();
                                                end else
                                                    Rec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                                rec.Modify();

                                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                    CheckValue := 0;
                                                    CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                    if CheckValue < 1 then begin
                                                        Rec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                        rec.Modify();
                                                    end;
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        Rec."Target_Hour 09" := DayTarget;
                                                        rec.Modify();
                                                    end else
                                                        Rec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                    rec.Modify();
                                                end
                                                else begin
                                                    // Rec."Target_Hour 09" := 0;
                                                    rec.Modify();
                                                end;

                                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        Rec."Target_Hour 10" := DayTarget;
                                                        rec.Modify();
                                                    end else
                                                        Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                    rec.Modify();
                                                end
                                                else begin
                                                    Rec."Target_Hour 10" := 0;
                                                    rec.Modify();
                                                end;
                                            end;
                                        end;
                                        if TimeVariable = 160000T then begin
                                            Rec."Target_Hour 06" := 0;
                                            Rec."Target_Hour 07" := 0;
                                            Rec."Target_Hour 08" := 0;
                                            rec.Modify();
                                            if (TotNavaHours <> 0) and (DayTarget <> 0) then begin
                                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                    CheckValue := 0;
                                                    CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                    if CheckValue < 1 then begin
                                                        Rec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                        rec.Modify();
                                                    end;
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        Rec."Target_Hour 09" := DayTarget;
                                                        rec.Modify();
                                                    end else
                                                        Rec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                    rec.Modify();
                                                end;

                                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        Rec."Target_Hour 10" := DayTarget;
                                                        rec.Modify();
                                                    end else
                                                        Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                    rec.Modify();
                                                end;
                                            end;

                                        end;
                                        if TimeVariable = 170000T then begin
                                            Rec."Target_Hour 06" := 0;
                                            Rec."Target_Hour 07" := 0;
                                            Rec."Target_Hour 08" := 0;
                                            Rec."Target_Hour 09" := 0;
                                            rec.Modify();
                                            if (TotNavaHours <> 0) and (DayTarget <> 0) then begin
                                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        Rec."Target_Hour 10" := DayTarget;
                                                        rec.Modify();
                                                    end else
                                                        Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                    rec.Modify();
                                                end
                                                else begin
                                                    // Rec."Target_Hour 10" := 0;
                                                    rec.Modify();
                                                end;
                                            end;
                                        end;
                                    end;
                                end
                                else begin


                                    //correct
                                    if NavAppProdRec."LCurve Start Time" = 140000T then begin
                                        if NavAppProdRec."Learning Curve No." > 1 then begin
                                            if TimeVariable = 150000T then begin
                                                Rec."Target_Hour 07" := 0;
                                                rec.Modify();
                                                if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                    CheckValue := 0;
                                                    CheckValue := TotNavaHours - 8;
                                                    if CheckValue < 1 then begin
                                                        Rec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                                        rec.Modify();
                                                    end;
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        Rec."Target_Hour 08" := DayTarget;
                                                        rec.Modify();
                                                    end else
                                                        Rec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                                    rec.Modify();

                                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                        CheckValue := 0;
                                                        CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                        if CheckValue < 1 then begin
                                                            Rec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                            rec.Modify();
                                                        end;
                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                            Rec."Target_Hour 09" := DayTarget;
                                                            rec.Modify();
                                                        end else
                                                            Rec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                        rec.Modify();
                                                    end;

                                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                            Rec."Target_Hour 10" := DayTarget;
                                                            rec.Modify();
                                                        end else
                                                            Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                        rec.Modify();
                                                    end
                                                    else begin
                                                        // Rec."Target_Hour 09" := 0;
                                                        // Rec."Target_Hour 10" := 0;
                                                        rec.Modify();
                                                    end;
                                                end;
                                            end;
                                            if TimeVariable = 160000T then begin
                                                Rec."Target_Hour 07" := 0;
                                                Rec."Target_Hour 08" := 0;
                                                rec.Modify();
                                                if (TotNavaHours <> 0) and (DayTarget <> 0) then begin
                                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                        CheckValue := 0;
                                                        CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                        if CheckValue < 1 then begin
                                                            Rec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                            rec.Modify();
                                                        end;
                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                            Rec."Target_Hour 09" := DayTarget;
                                                            rec.Modify();
                                                        end else
                                                            Rec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                        rec.Modify();
                                                    end;

                                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                            Rec."Target_Hour 10" := DayTarget;
                                                            rec.Modify();
                                                        end else
                                                            Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                        rec.Modify();
                                                    end
                                                    else begin
                                                        // Rec."Target_Hour 09" := 0;
                                                        // Rec."Target_Hour 10" := 0;
                                                        rec.Modify();
                                                    end;
                                                end;
                                            end;
                                            if TimeVariable = 170000T then begin
                                                Rec."Target_Hour 07" := 0;
                                                Rec."Target_Hour 08" := 0;
                                                Rec."Target_Hour 09" := 0;
                                                rec.Modify();
                                                if (TotNavaHours <> 0) and (DayTarget <> 0) then begin
                                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                            Rec."Target_Hour 10" := DayTarget;
                                                            rec.Modify();
                                                        end else
                                                            Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                        rec.Modify();
                                                    end
                                                    else begin
                                                        // Rec."Target_Hour 10" := 0;
                                                        rec.Modify();
                                                    end;
                                                end;
                                            end;
                                        end;
                                    end
                                    else begin


                                        //correct
                                        if NavAppProdRec."LCurve Start Time" = 150000T then begin
                                            if NavAppProdRec."Learning Curve No." > 1 then
                                                if TimeVariable = 160000T then begin
                                                    Rec."Target_Hour 08" := 0;
                                                    rec.Modify();
                                                    if (TotNavaHours <> 0) and (DayTarget <> 0) then begin
                                                        if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                            CheckValue := 0;
                                                            CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                            if CheckValue < 1 then begin
                                                                Rec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                                rec.Modify();
                                                            end;
                                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                Rec."Target_Hour 09" := DayTarget;
                                                                rec.Modify();
                                                            end else
                                                                Rec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                            rec.Modify();

                                                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                    Rec."Target_Hour 10" := DayTarget;
                                                                    rec.Modify();
                                                                end else
                                                                    Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                rec.Modify();
                                                            end;
                                                        end
                                                        else begin
                                                            // Rec."Target_Hour 09" := 0;
                                                            // Rec."Target_Hour 10" := 0;
                                                            rec.Modify();
                                                        end;
                                                    end;
                                                end;
                                            if TimeVariable = 170000T then begin
                                                Rec."Target_Hour 08" := 0;
                                                Rec."Target_Hour 09" := 0;
                                                rec.Modify();
                                                if (TotNavaHours <> 0) and (DayTarget <> 0) then begin
                                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                            Rec."Target_Hour 10" := DayTarget;
                                                            rec.Modify();
                                                        end else
                                                            Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                        rec.Modify();
                                                    end;
                                                end;
                                            end;
                                        end
                                        else begin

                                            //correct
                                            if NavAppProdRec."LCurve Start Time" = 160000T then begin
                                                if NavAppProdRec."Learning Curve No." > 1 then
                                                    if TimeVariable = 170000T then begin
                                                        Rec."Target_Hour 09" := 0;
                                                        rec.Modify();
                                                        if (TotNavaHours <> 0) and (DayTarget <> 0) then begin
                                                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                    Rec."Target_Hour 10" := DayTarget;
                                                                    rec.Modify();
                                                                end else
                                                                    Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                rec.Modify();
                                                            end;
                                                        end;

                                                    end;
                                            end
                                            else begin

                                                if NavAppProdRec."LCurve Start Time" = 170000T then begin
                                                    if NavAppProdRec."Learning Curve No." > 1 then
                                                        Rec."Target_Hour 10" := 0;
                                                    rec.Modify();
                                                end
                                                else begin


                                                    //correct
                                                    if (TotNavaHours <> 0) and (DayTarget <> 0) then begin
                                                        if TotNavaHours >= 0 then begin
                                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                Rec."Target_Hour 01" := DayTarget;
                                                                rec.Modify();
                                                            end else
                                                                Rec."Target_Hour 01" := (DayTarget / TotNavaHours);
                                                            rec.Modify();
                                                        end;
                                                        if TotNavaHours >= 1 then begin
                                                            CheckValue := 0;
                                                            CheckValue := TotNavaHours - 1;
                                                            if CheckValue < 1 then begin
                                                                Rec."Target_Hour 02" := (DayTarget / TotNavaHours) * CheckValue;
                                                                Rec."Target_Hour 03" := 0;
                                                                Rec."Target_Hour 04" := 0;
                                                                Rec."Target_Hour 05" := 0;
                                                                Rec."Target_Hour 06" := 0;
                                                                Rec."Target_Hour 07" := 0;
                                                                Rec."Target_Hour 08" := 0;
                                                                Rec."Target_Hour 09" := 0;
                                                                Rec."Target_Hour 10" := 0;

                                                                rec.Modify();
                                                            end;
                                                        end;

                                                        if TotNavaHours >= 2 then begin
                                                            CheckValue := 0;
                                                            CheckValue := TotNavaHours - 2;
                                                            if CheckValue < 1 then begin
                                                                Rec."Target_Hour 03" := (DayTarget / TotNavaHours) * CheckValue;
                                                                Rec."Target_Hour 04" := 0;
                                                                Rec."Target_Hour 05" := 0;
                                                                Rec."Target_Hour 06" := 0;
                                                                Rec."Target_Hour 07" := 0;
                                                                Rec."Target_Hour 08" := 0;
                                                                Rec."Target_Hour 09" := 0;
                                                                Rec."Target_Hour 10" := 0;
                                                                rec.Modify();
                                                            end;
                                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                Rec."Target_Hour 02" := DayTarget;
                                                                rec.Modify();
                                                            end else
                                                                Rec."Target_Hour 02" := (DayTarget / TotNavaHours);
                                                            rec.Modify();
                                                        end;

                                                        if TotNavaHours >= 3 then begin
                                                            CheckValue := 0;
                                                            CheckValue := TotNavaHours - 3;
                                                            if CheckValue < 1 then begin
                                                                Rec."Target_Hour 04" := (DayTarget / TotNavaHours) * CheckValue;
                                                                Rec."Target_Hour 05" := 0;
                                                                Rec."Target_Hour 06" := 0;
                                                                Rec."Target_Hour 07" := 0;
                                                                Rec."Target_Hour 08" := 0;
                                                                Rec."Target_Hour 09" := 0;
                                                                Rec."Target_Hour 10" := 0;
                                                                rec.Modify();
                                                            end;
                                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                Rec."Target_Hour 03" := DayTarget;
                                                                rec.Modify();
                                                            end else
                                                                Rec."Target_Hour 03" := (DayTarget / TotNavaHours);
                                                            rec.Modify();
                                                        end;

                                                        if TotNavaHours >= 4 then begin
                                                            CheckValue := 0;
                                                            CheckValue := TotNavaHours - 4;
                                                            if CheckValue < 1 then begin
                                                                Rec."Target_Hour 05" := (DayTarget / TotNavaHours) * CheckValue;
                                                                Rec."Target_Hour 06" := 0;
                                                                Rec."Target_Hour 07" := 0;
                                                                Rec."Target_Hour 08" := 0;
                                                                Rec."Target_Hour 09" := 0;
                                                                Rec."Target_Hour 10" := 0;
                                                                rec.Modify();
                                                            end;
                                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                Rec."Target_Hour 04" := DayTarget;
                                                                rec.Modify();
                                                            end else
                                                                Rec."Target_Hour 04" := (DayTarget / TotNavaHours);
                                                            rec.Modify();
                                                        end;

                                                        if TotNavaHours >= 5 then begin
                                                            CheckValue := 0;
                                                            CheckValue := TotNavaHours - 5;
                                                            if CheckValue < 1 then begin
                                                                Rec."Target_Hour 06" := (DayTarget / TotNavaHours) * CheckValue;
                                                                Rec."Target_Hour 07" := 0;
                                                                Rec."Target_Hour 08" := 0;
                                                                Rec."Target_Hour 09" := 0;
                                                                Rec."Target_Hour 10" := 0;
                                                                rec.Modify();
                                                            end;
                                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                Rec."Target_Hour 05" := DayTarget;
                                                                rec.Modify();
                                                            end else
                                                                Rec."Target_Hour 05" := (DayTarget / TotNavaHours);
                                                            rec.Modify();
                                                        end;

                                                        if TotNavaHours >= 6 then begin
                                                            CheckValue := 0;
                                                            CheckValue := TotNavaHours - 6;
                                                            if CheckValue < 1 then begin
                                                                Rec."Target_Hour 07" := (DayTarget / TotNavaHours) * CheckValue;
                                                                Rec."Target_Hour 08" := 0;
                                                                Rec."Target_Hour 09" := 0;
                                                                Rec."Target_Hour 10" := 0;
                                                                rec.Modify();
                                                            end;
                                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                Rec."Target_Hour 06" := DayTarget;
                                                                rec.Modify();
                                                            end else
                                                                Rec."Target_Hour 06" := (DayTarget / TotNavaHours);
                                                            rec.Modify();
                                                        end;

                                                        if TotNavaHours >= 7 then begin
                                                            CheckValue := 0;
                                                            CheckValue := TotNavaHours - 7;
                                                            if CheckValue < 1 then begin
                                                                Rec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                                                Rec."Target_Hour 09" := 0;
                                                                Rec."Target_Hour 10" := 0;
                                                                rec.Modify();
                                                            end;
                                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                Rec."Target_Hour 07" := DayTarget;
                                                                rec.Modify();
                                                            end else
                                                                Rec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                                            rec.Modify();
                                                        end;

                                                        if TotNavaHours >= 8 then begin
                                                            CheckValue := 0;
                                                            CheckValue := TotNavaHours - 8;
                                                            if CheckValue < 1 then begin
                                                                Rec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                                                Rec."Target_Hour 10" := 0;
                                                                rec.Modify();
                                                            end;
                                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                Rec."Target_Hour 08" := DayTarget;
                                                                rec.Modify();
                                                            end else
                                                                Rec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                                            rec.Modify();
                                                        end;

                                                        if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                            CheckValue := 0;
                                                            CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                            if CheckValue < 1 then begin
                                                                Rec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                                rec.Modify();
                                                            end;
                                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                Rec."Target_Hour 09" := DayTarget;
                                                                rec.Modify();
                                                            end else
                                                                Rec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                            rec.Modify();
                                                        end;

                                                        if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                Rec."Target_Hour 10" := DayTarget;
                                                                rec.Modify();
                                                            end else
                                                                Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                            rec.Modify();
                                                        end;
                                                    end;
                                                end;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;

        // if NavAppProdRec."LCurve Start Time" <> 0T then begin
        //     // if NavAppProdRec."Learning Curve No." > 1 then begin
        //     if (TotNavaHours <> 0) and (DayTarget <> 0) then begin
        //         if TotNavaHours >= 0 then begin
        //             if (DayTarget / TotNavaHours) > DayTarget then begin
        //                 Rec."Target_Hour 01" := DayTarget;
        //                 rec.Modify();
        //             end else begin
        //                 Rec."Target_Hour 01" := (DayTarget / TotNavaHours);
        //                 rec.Modify();
        //             end;
        //         end;
        //         if TotNavaHours >= 1 then begin
        //             CheckValue := 0;
        //             CheckValue := TotNavaHours - 1;
        //             if CheckValue < 1 then begin
        //                 Rec."Target_Hour 02" := (DayTarget / TotNavaHours) * CheckValue;
        //                 rec.Modify();
        //             end;
        //         end;

        //         if TotNavaHours >= 2 then begin
        //             CheckValue := 0;
        //             CheckValue := TotNavaHours - 2;
        //             if CheckValue < 1 then begin
        //                 Rec."Target_Hour 03" := (DayTarget / TotNavaHours) * CheckValue;
        //                 rec.Modify();
        //             end;
        //             if (DayTarget / TotNavaHours) > DayTarget then begin
        //                 Rec."Target_Hour 02" := DayTarget;
        //                 rec.Modify();
        //             end else begin
        //                 Rec."Target_Hour 02" := (DayTarget / TotNavaHours);
        //                 rec.Modify();
        //             end;
        //         end;

        //         if TotNavaHours >= 3 then begin
        //             CheckValue := 0;
        //             CheckValue := TotNavaHours - 3;
        //             if CheckValue < 1 then begin
        //                 Rec."Target_Hour 04" := (DayTarget / TotNavaHours) * CheckValue;
        //                 rec.Modify();
        //             end;
        //             if (DayTarget / TotNavaHours) > DayTarget then begin
        //                 Rec."Target_Hour 03" := DayTarget;
        //                 rec.Modify();
        //             end else begin
        //                 Rec."Target_Hour 03" := (DayTarget / TotNavaHours);
        //                 rec.Modify();
        //             end;
        //         end;

        //         if TotNavaHours >= 4 then begin
        //             CheckValue := 0;
        //             CheckValue := TotNavaHours - 4;
        //             if CheckValue < 1 then begin
        //                 Rec."Target_Hour 05" := (DayTarget / TotNavaHours) * CheckValue;
        //                 rec.Modify();
        //             end;
        //             if (DayTarget / TotNavaHours) > DayTarget then begin
        //                 Rec."Target_Hour 04" := DayTarget;
        //                 rec.Modify();
        //             end else begin
        //                 Rec."Target_Hour 04" := (DayTarget / TotNavaHours);
        //                 rec.Modify();
        //             end;
        //         end;

        //         if TotNavaHours >= 5 then begin
        //             CheckValue := 0;
        //             CheckValue := TotNavaHours - 5;
        //             if CheckValue < 1 then begin
        //                 Rec."Target_Hour 06" := (DayTarget / TotNavaHours) * CheckValue;
        //                 rec.Modify();
        //             end;
        //             if (DayTarget / TotNavaHours) > DayTarget then begin
        //                 Rec."Target_Hour 05" := DayTarget;
        //                 rec.Modify();
        //             end else begin
        //                 Rec."Target_Hour 05" := (DayTarget / TotNavaHours);
        //                 rec.Modify();
        //             end;
        //         end;

        //         if TotNavaHours >= 6 then begin
        //             CheckValue := 0;
        //             CheckValue := TotNavaHours - 6;
        //             if CheckValue < 1 then begin
        //                 Rec."Target_Hour 07" := (DayTarget / TotNavaHours) * CheckValue;
        //                 rec.Modify();
        //             end;
        //             if (DayTarget / TotNavaHours) > DayTarget then begin
        //                 Rec."Target_Hour 06" := DayTarget;
        //                 rec.Modify();
        //             end else
        //                 Rec."Target_Hour 06" := (DayTarget / TotNavaHours);
        //             rec.Modify();
        //         end;

        //         if TotNavaHours >= 7 then begin
        //             CheckValue := 0;
        //             CheckValue := TotNavaHours - 7;
        //             if CheckValue < 1 then begin
        //                 Rec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
        //                 rec.Modify();
        //             end;
        //             if (DayTarget / TotNavaHours) > DayTarget then begin
        //                 Rec."Target_Hour 07" := DayTarget;
        //                 rec.Modify();
        //             end else
        //                 Rec."Target_Hour 07" := (DayTarget / TotNavaHours);
        //             rec.Modify();
        //         end;

        //         if TotNavaHours >= 8 then begin
        //             CheckValue := 0;
        //             CheckValue := TotNavaHours - 8;
        //             if CheckValue < 1 then begin
        //                 Rec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
        //                 rec.Modify();
        //             end;
        //             if (DayTarget / TotNavaHours) > DayTarget then begin
        //                 Rec."Target_Hour 08" := DayTarget;
        //                 rec.Modify();
        //             end else
        //                 Rec."Target_Hour 08" := (DayTarget / TotNavaHours);
        //             rec.Modify();
        //         end;

        //         if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
        //             CheckValue := 0;
        //              CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
        //             if CheckValue < 1 then begin
        //                 Rec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
        //                 rec.Modify();
        //             end;
        //             if (DayTarget / TotNavaHours) > DayTarget then begin
        //                 Rec."Target_Hour 09" := DayTarget;
        //                 rec.Modify();
        //             end else
        //                 Rec."Target_Hour 09" := (DayTarget / TotNavaHours);
        //             rec.Modify();
        //         end;

        //         if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
        //             if (DayTarget / TotNavaHours) > DayTarget then begin
        //                 Rec."Target_Hour 10" := DayTarget;
        //                 rec.Modify();
        //             end else
        //                 Rec."Target_Hour 10" := (DayTarget / TotNavaHours);
        //             rec.Modify();
        //         end;
        //         // end;
        //     end;
        // end;

    end;

    procedure CalTotal()
    var
        HourlyProdLinesRec: Record "Hourly Production Lines";
        HourlyProdLines1Rec: Record "Hourly Production Lines";
        ProductionOutLine: Record ProductionOutLine;
        ProdOutHeaderRec: Record ProductionOutHeader;
        InputQtyVar: Decimal;
        OutQtyVar: Decimal;
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
        CurrPage.Update();

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
            repeat
                TotPass := 0;
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
                TotPass += TotPassPcsHour1 + TotPassPcsHour2 + TotPassPcsHour3 + TotPassPcsHour4 + TotPassPcsHour5 + TotPassPcsHour6 + TotPassPcsHour7 + TotPassPcsHour8 + TotPassPcsHour9 + TotPassPcsHour10 + TotPassPcsHour11 + TotPassPcsHour12 + TotPassPcsHour13;
                HourlyProdLines1Rec.Total := TotPass;
                HourlyProdLines1Rec.Modify();
            until HourlyProdLines1Rec.Next() = 0;
            //Update DEFECTS Pcs
            HourlyProdLines1Rec.Reset();
            HourlyProdLines1Rec.SetRange("No.", rec."No.");
            HourlyProdLines1Rec.SetFilter("Factory No.", '=%1', '');
            HourlyProdLines1Rec.SetRange("Style Name", 'DEFECT PCS (Total)');
            HourlyProdLines1Rec.FindSet();

            TotDefect := 0;
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
            TotDefect += TotDefectPcsHour1 + TotDefectPcsHour2 + TotDefectPcsHour3 + TotDefectPcsHour4 + TotDefectPcsHour5 + TotDefectPcsHour6 + TotDefectPcsHour7 + TotDefectPcsHour8 + TotDefectPcsHour9 + TotDefectPcsHour10 + TotDefectPcsHour11 + TotDefectPcsHour12 + TotDefectPcsHour13;
            HourlyProdLines1Rec.Total := TotDefect;
            HourlyProdLines1Rec.Modify();

            //Update DHU
            HourlyProdLines1Rec.Reset();
            HourlyProdLines1Rec.SetRange("No.", rec."No.");
            HourlyProdLines1Rec.SetFilter("Factory No.", '=%1', '');
            HourlyProdLines1Rec.SetRange("Style Name", 'DHU (Total)');
            HourlyProdLines1Rec.FindSet();

            TotDHU := 0;
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
            TotDHU += TotDHUPcsHour1 + TotDHUPcsHour2 + TotDHUPcsHour3 + TotDHUPcsHour4 + TotDHUPcsHour5 + TotDHUPcsHour6 + TotDHUPcsHour7 + TotDHUPcsHour8 + TotDHUPcsHour9 + TotDHUPcsHour10 + TotDHUPcsHour11 + TotDHUPcsHour12 + TotDHUPcsHour13;
            HourlyProdLines1Rec.Total := TotDHU;
            HourlyProdLines1Rec.Modify();



        end;


        //Get sewing line in qty/out qty
        InputQtyVar := 0;
        OutQtyVar := 0;
        ProdOutHeaderRec.Reset();
        ProdOutHeaderRec.SetRange("Resource No.", rec."Work Center No.");
        ProdOutHeaderRec.SetRange("Factory Code", Rec."Factory No.");
        ProdOutHeaderRec.SetRange("Style No.", Rec."Style No.");

        if rec.Type = rec.Type::Sewing then
            ProdOutHeaderRec.SetFilter(Type, '=%1', ProdOutHeaderRec.Type::Saw);

        if rec.Type = rec.Type::Finishing then
            ProdOutHeaderRec.SetFilter(Type, '=%1', ProdOutHeaderRec.Type::Fin);

        if ProdOutHeaderRec.FindSet() then begin
            repeat
                InputQtyVar += ProdOutHeaderRec."Input Qty";
                OutQtyVar += ProdOutHeaderRec."Output Qty";
            until ProdOutHeaderRec.Next() = 0;
        end;

        if (InputQtyVar - OutQtyVar) < rec.Total then
            Error('Hourly Production Total is greater than balance Sew. In Qty/Sew. Out Qty.');

        CurrPage.Update();

    end;


    trigger OnAfterGetRecord()
    var
    begin
        StyleExprTxt := ChangeColor.ChangeHourlyProduction(Rec);

        if (rec."Factory No." = '') or (rec.Item = 'DHU') then begin
            Clear(SetEdit);
            SetEdit := false;
        end
        ELSE begin
            Clear(SetEdit);
            SetEdit := true;
        end;
    end;

    var
        TotPass: Integer;
        TotDHU: Integer;
        TotDefect: Integer;
        StyleExprTxt: Text[50];
        ChangeColor: Codeunit NavAppCodeUnit;
        SetEdit: Boolean;


}