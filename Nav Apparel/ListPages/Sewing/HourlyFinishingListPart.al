page 51381 HourlyFinishingListPart
{
    PageType = ListPart;
    SourceTable = "Hourly Production Lines";
    // DeleteAllowed = false;
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
                    // Editable = false;
                    Caption = 'Line';
                    ShowMandatory = true;
                    Editable = EditableGB;


                    trigger OnLookup(var text: Text): Boolean
                    var
                        HourlyLineRec3: Record "Hourly Production Lines";
                        HourlyLineRec2: Record "Hourly Production Lines";
                        HourlyLineRec: Record "Hourly Production Lines";
                        HourlymasterRec: Record "Hourly Production Master";
                        WorkCenterRec: Record "Work Center";
                    begin
                        HourlymasterRec.Reset();
                        HourlymasterRec.SetRange("No.", Rec."No.");
                        HourlymasterRec.SetRange("Factory No.", Rec."Factory No.");
                        if HourlymasterRec.FindSet() then begin
                            WorkCenterRec.Reset();
                            WorkCenterRec.SetRange("Factory No.", HourlymasterRec."Factory No.");
                            if WorkCenterRec.FindSet() then begin
                                if Page.RunModal(99000755, WorkCenterRec) = Action::LookupOK then begin
                                    Rec."Work Center Seq No" := WorkCenterRec."Work Center Seq No";
                                    Rec."Work Center No." := WorkCenterRec."No.";
                                    Rec."Work Center Name" := WorkCenterRec.Name;

                                    HourlyLineRec.Reset();
                                    HourlyLineRec.SetRange("No.", Rec."No.");
                                    HourlyLineRec.SetRange("Style No.", Rec."Style No.");
                                    HourlyLineRec.SetRange("Line No.", Rec."Line No." - 1);
                                    if HourlyLineRec.FindSet() then begin
                                        HourlyLineRec."Work Center Seq No" := WorkCenterRec."Work Center Seq No";
                                    end;
                                end;
                                HourlyLineRec.Modify();
                                CurrPage.Update();
                            end;
                        end;
                        CurrPage.Update();
                    end;




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
                        HourlyProdLinesRec.SetRange(Type, Rec.Type);
                        HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                        HourlyProdLinesRec.SetFilter(item, '=%1', 'PASS PCS');
                        HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                        if HourlyProdLinesRec.FindSet() then begin
                            if HourlyProdLinesRec."Hour 01" <> 0 then begin

                                TempPASSPCS := HourlyProdLinesRec."Hour 01";

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange(Type, Rec.Type);
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DEFECT PCS');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    TempDEFECTS := HourlyProdLinesRec."Hour 01";
                                end;

                                //Calculate DHU and update
                                TempDHU := (TempDEFECTS / TempPASSPCS) * 100;

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange(Type, Rec.Type);
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
                                HourlyProdLinesRec.SetRange(Type, Rec.Type);
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DHU');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    HourlyProdLinesRec."Hour 01" := TempDHU;
                                    HourlyProdLinesRec.Modify();
                                end;
                            end;

                        end;
                        CheckValue();
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
                        HourlyProdLinesRec: Record "Hourly Production Lines";
                        TempPASSPCS: Decimal;
                        TempDEFECTS: Decimal;
                        TempDHU: Decimal;
                    begin

                        CurrPage.Update();
                        HourlyProdLinesRec.Reset();
                        HourlyProdLinesRec.SetRange("No.", rec."No.");
                        HourlyProdLinesRec.SetRange(Type, Rec.Type);
                        HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                        HourlyProdLinesRec.SetFilter(item, '=%1', 'PASS PCS');
                        HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                        if HourlyProdLinesRec.FindSet() then begin
                            if HourlyProdLinesRec."Hour 02" <> 0 then begin

                                TempPASSPCS := HourlyProdLinesRec."Hour 02";

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange(Type, Rec.Type);
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DEFECT PCS');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    TempDEFECTS := HourlyProdLinesRec."Hour 02";
                                end;

                                //Calculate DHU and update
                                TempDHU := (TempDEFECTS / TempPASSPCS) * 100;

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange(Type, Rec.Type);
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
                                HourlyProdLinesRec.SetRange(Type, Rec.Type);
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DHU');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    HourlyProdLinesRec."Hour 02" := TempDHU;
                                    HourlyProdLinesRec.Modify();
                                end;
                            end;

                        end;
                        CheckValue();
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
                        HourlyProdLinesRec.SetRange(Type, Rec.Type);
                        HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                        HourlyProdLinesRec.SetFilter(item, '=%1', 'PASS PCS');
                        HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                        if HourlyProdLinesRec.FindSet() then begin
                            if HourlyProdLinesRec."Hour 03" <> 0 then begin

                                TempPASSPCS := HourlyProdLinesRec."Hour 03";

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange(Type, Rec.Type);
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DEFECT PCS');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    TempDEFECTS := HourlyProdLinesRec."Hour 03";
                                end;

                                //Calculate DHU and update
                                TempDHU := (TempDEFECTS / TempPASSPCS) * 100;

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange(Type, Rec.Type);
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
                                HourlyProdLinesRec.SetRange(Type, Rec.Type);
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DHU');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    HourlyProdLinesRec."Hour 03" := TempDHU;
                                    HourlyProdLinesRec.Modify();
                                end;
                            end;

                        end;
                        CheckValue();
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
                        HourlyProdLinesRec.SetRange(Type, Rec.Type);
                        HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                        HourlyProdLinesRec.SetFilter(item, '=%1', 'PASS PCS');
                        HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                        if HourlyProdLinesRec.FindSet() then begin
                            if HourlyProdLinesRec."Hour 04" <> 0 then begin

                                TempPASSPCS := HourlyProdLinesRec."Hour 04";

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange(Type, Rec.Type);
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DEFECT PCS');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    TempDEFECTS := HourlyProdLinesRec."Hour 04";
                                end;

                                //Calculate DHU and update
                                TempDHU := (TempDEFECTS / TempPASSPCS) * 100;

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange(Type, Rec.Type);
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
                                HourlyProdLinesRec.SetRange(Type, Rec.Type);
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DHU');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    HourlyProdLinesRec."Hour 04" := TempDHU;
                                    HourlyProdLinesRec.Modify();
                                end;
                            end;

                        end;
                        CheckValue();
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
                        HourlyProdLinesRec.SetRange(Type, Rec.Type);
                        HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                        HourlyProdLinesRec.SetFilter(item, '=%1', 'PASS PCS');
                        HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                        if HourlyProdLinesRec.FindSet() then begin
                            if HourlyProdLinesRec."Hour 05" <> 0 then begin

                                TempPASSPCS := HourlyProdLinesRec."Hour 05";

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange(Type, Rec.Type);
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DEFECT PCS');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    TempDEFECTS := HourlyProdLinesRec."Hour 05";
                                end;

                                //Calculate DHU and update
                                TempDHU := (TempDEFECTS / TempPASSPCS) * 100;

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange(Type, Rec.Type);
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
                                HourlyProdLinesRec.SetRange(Type, Rec.Type);
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DHU');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    HourlyProdLinesRec."Hour 05" := TempDHU;
                                    HourlyProdLinesRec.Modify();
                                end;
                            end;

                        end;
                        CheckValue();
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
                        HourlyProdLinesRec.SetRange(Type, Rec.Type);
                        HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                        HourlyProdLinesRec.SetFilter(item, '=%1', 'PASS PCS');
                        HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                        if HourlyProdLinesRec.FindSet() then begin
                            if HourlyProdLinesRec."Hour 06" <> 0 then begin

                                TempPASSPCS := HourlyProdLinesRec."Hour 06";

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange(Type, Rec.Type);
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DEFECT PCS');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    TempDEFECTS := HourlyProdLinesRec."Hour 06";
                                end;

                                //Calculate DHU and update
                                TempDHU := (TempDEFECTS / TempPASSPCS) * 100;

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange(Type, Rec.Type);
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
                                HourlyProdLinesRec.SetRange(Type, Rec.Type);
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DHU');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    HourlyProdLinesRec."Hour 06" := TempDHU;
                                    HourlyProdLinesRec.Modify();
                                end;
                            end;

                        end;
                        CheckValue();
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
                        HourlyProdLinesRec.SetRange(Type, Rec.Type);
                        HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                        HourlyProdLinesRec.SetFilter(item, '=%1', 'PASS PCS');
                        HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                        if HourlyProdLinesRec.FindSet() then begin
                            if HourlyProdLinesRec."Hour 07" <> 0 then begin

                                TempPASSPCS := HourlyProdLinesRec."Hour 07";

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange(Type, Rec.Type);
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DEFECT PCS');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    TempDEFECTS := HourlyProdLinesRec."Hour 07";
                                end;

                                //Calculate DHU and update
                                TempDHU := (TempDEFECTS / TempPASSPCS) * 100;

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange(Type, Rec.Type);
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
                                HourlyProdLinesRec.SetRange(Type, Rec.Type);
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DHU');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    HourlyProdLinesRec."Hour 07" := TempDHU;
                                    HourlyProdLinesRec.Modify();
                                end;
                            end;

                        end;
                        CheckValue();
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
                        HourlyProdLinesRec.SetRange(Type, Rec.Type);
                        HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                        HourlyProdLinesRec.SetFilter(item, '=%1', 'PASS PCS');
                        HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                        if HourlyProdLinesRec.FindSet() then begin
                            if HourlyProdLinesRec."Hour 08" <> 0 then begin

                                TempPASSPCS := HourlyProdLinesRec."Hour 08";

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange(Type, Rec.Type);
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DEFECT PCS');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    TempDEFECTS := HourlyProdLinesRec."Hour 08";
                                end;

                                //Calculate DHU and update
                                TempDHU := (TempDEFECTS / TempPASSPCS) * 100;

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange(Type, Rec.Type);
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
                                HourlyProdLinesRec.SetRange(Type, Rec.Type);
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DHU');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    HourlyProdLinesRec."Hour 08" := TempDHU;
                                    HourlyProdLinesRec.Modify();
                                end;
                            end;

                        end;
                        CheckValue();
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
                        HourlyProdLinesRec.SetRange(Type, Rec.Type);
                        HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                        HourlyProdLinesRec.SetFilter(item, '=%1', 'PASS PCS');
                        HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                        if HourlyProdLinesRec.FindSet() then begin
                            if HourlyProdLinesRec."Hour 09" <> 0 then begin

                                TempPASSPCS := HourlyProdLinesRec."Hour 09";

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange(Type, Rec.Type);
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DEFECT PCS');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    TempDEFECTS := HourlyProdLinesRec."Hour 09";
                                end;

                                //Calculate DHU and update
                                TempDHU := (TempDEFECTS / TempPASSPCS) * 100;

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange(Type, Rec.Type);
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
                                HourlyProdLinesRec.SetRange(Type, Rec.Type);
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DHU');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    HourlyProdLinesRec."Hour 09" := TempDHU;
                                    HourlyProdLinesRec.Modify();
                                end;
                            end;

                        end;
                        CheckValue();
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
                        HourlyProdLinesRec.SetRange(Type, Rec.Type);
                        HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                        HourlyProdLinesRec.SetFilter(item, '=%1', 'PASS PCS');
                        HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                        if HourlyProdLinesRec.FindSet() then begin
                            if HourlyProdLinesRec."Hour 10" <> 0 then begin

                                TempPASSPCS := HourlyProdLinesRec."Hour 10";

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange(Type, Rec.Type);
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DEFECT PCS');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    TempDEFECTS := HourlyProdLinesRec."Hour 10";
                                end;

                                //Calculate DHU and update
                                TempDHU := (TempDEFECTS / TempPASSPCS) * 100;

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange(Type, Rec.Type);
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
                                HourlyProdLinesRec.SetRange(Type, Rec.Type);
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DHU');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    HourlyProdLinesRec."Hour 10" := TempDHU;
                                    HourlyProdLinesRec.Modify();
                                end;
                            end;

                        end;
                        CheckValue();
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
                        HourlyProdLinesRec.SetRange(Type, Rec.Type);
                        HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                        HourlyProdLinesRec.SetFilter(item, '=%1', 'PASS PCS');
                        HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                        if HourlyProdLinesRec.FindSet() then begin
                            if HourlyProdLinesRec."Hour 11" <> 0 then begin

                                TempPASSPCS := HourlyProdLinesRec."Hour 11";

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange(Type, Rec.Type);
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DEFECT PCS');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    TempDEFECTS := HourlyProdLinesRec."Hour 11";
                                end;

                                //Calculate DHU and update
                                TempDHU := (TempDEFECTS / TempPASSPCS) * 100;

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange(Type, Rec.Type);
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
                                HourlyProdLinesRec.SetRange(Type, Rec.Type);
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DHU');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    HourlyProdLinesRec."Hour 11" := TempDHU;
                                    HourlyProdLinesRec.Modify();
                                end;
                            end;

                        end;
                        CheckValue();
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
                        HourlyProdLinesRec.SetRange(Type, Rec.Type);
                        HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                        HourlyProdLinesRec.SetFilter(item, '=%1', 'PASS PCS');
                        HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                        if HourlyProdLinesRec.FindSet() then begin
                            if HourlyProdLinesRec."Hour 12" <> 0 then begin

                                TempPASSPCS := HourlyProdLinesRec."Hour 12";

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange(Type, Rec.Type);
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DEFECT PCS');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    TempDEFECTS := HourlyProdLinesRec."Hour 12";
                                end;

                                //Calculate DHU and update
                                TempDHU := (TempDEFECTS / TempPASSPCS) * 100;

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange(Type, Rec.Type);
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
                                HourlyProdLinesRec.SetRange(Type, Rec.Type);
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DHU');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    HourlyProdLinesRec."Hour 12" := TempDHU;
                                    HourlyProdLinesRec.Modify();
                                end;
                            end;

                        end;
                        CheckValue();
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
                        HourlyProdLinesRec.SetRange(Type, Rec.Type);
                        HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                        HourlyProdLinesRec.SetFilter(item, '=%1', 'PASS PCS');
                        HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                        if HourlyProdLinesRec.FindSet() then begin
                            if HourlyProdLinesRec."Hour 13" <> 0 then begin

                                TempPASSPCS := HourlyProdLinesRec."Hour 13";

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange(Type, Rec.Type);
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DEFECT PCS');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    TempDEFECTS := HourlyProdLinesRec."Hour 13";
                                end;

                                //Calculate DHU and update
                                TempDHU := (TempDEFECTS / TempPASSPCS) * 100;

                                HourlyProdLinesRec.SetRange("No.", rec."No.");
                                HourlyProdLinesRec.SetRange(Type, Rec.Type);
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
                                HourlyProdLinesRec.SetRange(Type, Rec.Type);
                                HourlyProdLinesRec.SetRange("Work Center No.", rec."Work Center No.");
                                HourlyProdLinesRec.SetFilter(item, '=%1', 'DHU');
                                HourlyProdLinesRec.SetFilter("Factory No.", '<>%1', '');

                                if HourlyProdLinesRec.FindSet() then begin
                                    HourlyProdLinesRec."Hour 13" := TempDHU;
                                    HourlyProdLinesRec.Modify();
                                end;
                            end;

                        end;
                        CheckValue();
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
    actions
    {
        area(Processing)
        {

            action("add")
            {
                ApplicationArea = All;
                Caption = 'Add New Style';
                Image = Add;


                trigger OnAction()
                var

                    NavSetupRec: Record "NavApp Setup";
                    StylePoRec: Record "Style Master PO";
                    WorkSeqNo: Integer;
                    HourlymasterRec: Record "Hourly Production Master";
                    NavAppProdRec: Record "NavApp Prod Plans Details";
                    HourlyRec2: Record "Hourly Production Lines";
                    HourlyRec1: Record "Hourly Production Lines";
                    StyleRec: Record "Style Master";
                    HourlyRec: Record "Hourly Production Lines";
                    Line: Integer;
                    StyleNo: Code[20];
                    ShDate: Date;
                begin
                    // HourlyRec.Reset();
                    // HourlyRec.FindSet();
                    // HourlyRec.DeleteAll();

                    HourlyRec.Reset();
                    HourlyRec.SetRange("No.", Rec."No.");
                    HourlyRec.SetRange(Type, HourlyRec.Type::Finishing);
                    HourlyRec.SetRange(Item, '=%1', 'PASS PCS');
                    if HourlyRec.FindSet() then begin
                        repeat
                            if HourlyRec."Work Center Seq No" = 0 then
                                Error('Please Enter Line No');
                        until HourlyRec.Next() = 0;
                    end;

                    Line := 0;

                    HourlymasterRec.Reset();
                    HourlymasterRec.SetRange("No.", Rec."No.");
                    HourlymasterRec.SetRange(Type, HourlymasterRec.Type::Finishing);
                    HourlymasterRec.FindSet();

                    NavSetupRec.Reset();
                    NavSetupRec.FindSet();

                    StylePoRec.Reset();
                    StylePoRec.SetCurrentKey("Ship Date");
                    StylePoRec.Ascending(true);
                    StylePoRec.FindSet();

                    NavAppProdRec.Reset();
                    // NavAppProdRec.SetRange(PlanDate, HourlymasterRec."Prod Date");
                    NavAppProdRec.SetRange("Factory No.", HourlymasterRec."Factory No.");
                    if NavAppProdRec.FindSet() then begin

                        HourlyRec2.Reset();
                        HourlyRec2.SetRange("No.", Rec."No.");
                        if HourlyRec2.FindLast() then begin
                            Line := HourlyRec2."Line No.";
                        end;
                        repeat

                            StylePoRec.Reset();
                            StylePoRec.SetCurrentKey("Ship Date");
                            StylePoRec.Ascending(true);
                            StylePoRec.SetRange("Style No.", NavAppProdRec."Style No.");
                            if StylePoRec.FindFirst() then begin
                                repeat
                                    ShDate := Today - NavSetupRec."Base On Min Ship Days";
                                    if ShDate <= StylePoRec."Ship Date" then
                                        NavAppProdRec.Mark(true);

                                until StylePoRec.Next() = 0;
                            end;
                        until NavAppProdRec.Next() = 0;

                        NavAppProdRec.MarkedOnly(true);
                        if Page.RunModal(51380, NavAppProdRec) = Action::LookupOK then begin

                            StyleRec.Reset();
                            StyleRec.SetRange("No.", NavAppProdRec."Style No.");
                            StyleRec.FindSet();

                            HourlyRec.Reset();
                            HourlyRec.SetRange("No.", Rec."No.");
                            HourlyRec.SetRange(Type, HourlyRec.Type::Finishing);
                            if HourlyRec.FindSet() then begin

                                if (HourlyRec."Style No." <> StyleRec."No.") OR (HourlyRec."Work Center Seq No" <> WorkSeqNo) then begin
                                    Line += 1;
                                    HourlyRec.Init();
                                    HourlyRec."No." := Rec."No.";
                                    HourlyRec."Line No." := Line;
                                    HourlyRec.Type := Rec.Type;
                                    HourlyRec."Style Name" := StyleRec."Style No.";
                                    HourlyRec."Style No." := StyleRec."No.";
                                    HourlyRec.Insert();
                                    WorkSeqNo := HourlyRec."Work Center Seq No";

                                end;

                                Line += 1;

                                HourlyRec.Init();
                                HourlyRec."No." := Rec."No.";
                                HourlyRec."Line No." := Line;
                                HourlyRec."Factory No." := HourlymasterRec."Factory No.";
                                HourlyRec."Prod Date" := HourlymasterRec."Prod Date";
                                HourlyRec.Type := Rec.Type;
                                HourlyRec."Work Center No." := '';
                                HourlyRec."Style No." := StyleRec."No.";
                                HourlyRec."Work Center Name" := '';
                                HourlyRec.Item := 'PASS PCS';
                                HourlyRec.Insert();

                            end
                            else begin
                                if (HourlyRec."Style No." <> StyleRec."No.") OR (HourlyRec."Work Center Seq No" <> WorkSeqNo) then begin
                                    Line += 1;
                                    HourlyRec.Init();
                                    HourlyRec."No." := Rec."No.";
                                    HourlyRec."Line No." := Line;
                                    HourlyRec.Type := Rec.Type;
                                    HourlyRec."Style Name" := StyleRec."Style No.";
                                    HourlyRec."Style No." := StyleRec."No.";
                                    HourlyRec.Insert();
                                    WorkSeqNo := HourlyRec."Work Center Seq No";

                                end;

                                Line += 1;

                                HourlyRec.Init();
                                HourlyRec."No." := Rec."No.";
                                HourlyRec."Line No." := Line;
                                HourlyRec."Factory No." := HourlymasterRec."Factory No.";
                                HourlyRec."Prod Date" := HourlymasterRec."Prod Date";
                                HourlyRec.Type := Rec.Type;
                                HourlyRec."Work Center No." := '';
                                HourlyRec."Style No." := StyleRec."No.";
                                HourlyRec."Work Center Name" := '';
                                HourlyRec.Item := 'PASS PCS';
                                HourlyRec.Insert();


                                HourlyRec1.Reset();
                                HourlyRec1.SetRange("No.", HourlyRec."No.");
                                // HourlyRec1.SetRange("Prod Date", HourlyRec."Prod Date");
                                // HourlyRec1.SetRange("Factory No.", HourlyRec."Factory No.");
                                HourlyRec1.SetRange(Type, HourlyRec1.Type::Sewing);
                                HourlyRec1.SetFilter("Style Name", '=%1', 'PASS PCS (Total)');
                                if not HourlyRec1.FindSet() then begin
                                    //Add Sub totals
                                    Line += 1;
                                    HourlyRec1.Init();
                                    HourlyRec1."No." := rec."No.";
                                    HourlyRec1."Line No." := Line;
                                    HourlyRec1."Style Name" := 'PASS PCS (Total)';
                                    HourlyRec1."Work Center Seq No" := 100;
                                    HourlyRec1.Insert();

                                end;


                            end;

                            CurrPage.Update();
                        end;


                    end;
                end;


            }
        }
    }
    procedure CheckValue()
    var
        HourlyProdLinesRec: Record "Hourly Production Lines";
        StylePoRec: Record "Style Master PO";
    begin

        HourlyProdLinesRec.Reset();
        // HourlyProdLinesRec.SetRange("Factory No.", Rec."Factory No.");
        HourlyProdLinesRec.SetRange("Style No.", Rec."Style No.");
        HourlyProdLinesRec.SetFilter(Item, '=%1', 'PASS PCS');
        HourlyProdLinesRec.SetFilter(Type, '=%1', HourlyProdLinesRec.Type::Finishing);
        if HourlyProdLinesRec.FindSet() then begin

            HourlyProdLinesRec.CalcSums("Hour 01");
            F1Tot := HourlyProdLinesRec."Hour 01";

            HourlyProdLinesRec.CalcSums("Hour 02");
            F2Tot := HourlyProdLinesRec."Hour 02";

            HourlyProdLinesRec.CalcSums("Hour 03");
            F3Tot := HourlyProdLinesRec."Hour 03";

            HourlyProdLinesRec.CalcSums("Hour 04");
            F4Tot := HourlyProdLinesRec."Hour 04";

            HourlyProdLinesRec.CalcSums("Hour 05");
            F5Tot := HourlyProdLinesRec."Hour 05";

            HourlyProdLinesRec.CalcSums("Hour 06");
            F6Tot := HourlyProdLinesRec."Hour 06";

            HourlyProdLinesRec.CalcSums("Hour 07");
            F7Tot := HourlyProdLinesRec."Hour 07";

            HourlyProdLinesRec.CalcSums("Hour 08");
            F8Tot := HourlyProdLinesRec."Hour 08";

            HourlyProdLinesRec.CalcSums("Hour 09");
            F9Tot := HourlyProdLinesRec."Hour 09";

            HourlyProdLinesRec.CalcSums("Hour 10");
            F10Tot := HourlyProdLinesRec."Hour 10";

            HourlyProdLinesRec.CalcSums("Hour 11");
            F11Tot := HourlyProdLinesRec."Hour 11";

            HourlyProdLinesRec.CalcSums("Hour 12");
            F12Tot := HourlyProdLinesRec."Hour 12";

            HourlyProdLinesRec.CalcSums("Hour 13");
            F13Tot := HourlyProdLinesRec."Hour 13";

            FinTotal := F1Tot + F2Tot + F3Tot + F4Tot + F5Tot + F6Tot + F7Tot + F8Tot + F9Tot + F10Tot + F11Tot + F12Tot + F13Tot;

            StylePoRec.Reset();
            StylePoRec.SetRange("Style No.", Rec."Style No.");
            if StylePoRec.FindSet() then begin
                StylePoRec.CalcSums("Sawing Out Qty");
                HTotal := StylePoRec."Sawing Out Qty";
            end;

            if FinTotal > HTotal then begin
                Error('Hourly Finishing Value greater than Hourly Sewing');
            end;


        end;


        HourlyProdLinesRec.Reset();
        // HourlyProdLinesRec.SetRange("Factory No.", Rec."Factory No.");
        HourlyProdLinesRec.SetRange("Style No.", Rec."Style No.");
        HourlyProdLinesRec.SetFilter(Item, '=%1', 'DEFECT PCS');
        HourlyProdLinesRec.SetFilter(Type, '=%1', HourlyProdLinesRec.Type::Finishing);
        if HourlyProdLinesRec.FindSet() then begin

            HourlyProdLinesRec.CalcSums("Hour 01");
            FD1Tot := HourlyProdLinesRec."Hour 01";

            HourlyProdLinesRec.CalcSums("Hour 02");
            FD2Tot := HourlyProdLinesRec."Hour 02";

            HourlyProdLinesRec.CalcSums("Hour 03");
            FD3Tot := HourlyProdLinesRec."Hour 03";

            HourlyProdLinesRec.CalcSums("Hour 04");
            FD4Tot := HourlyProdLinesRec."Hour 04";

            HourlyProdLinesRec.CalcSums("Hour 05");
            FD5Tot := HourlyProdLinesRec."Hour 05";

            HourlyProdLinesRec.CalcSums("Hour 06");
            FD6Tot := HourlyProdLinesRec."Hour 06";

            HourlyProdLinesRec.CalcSums("Hour 07");
            FD7Tot := HourlyProdLinesRec."Hour 07";

            HourlyProdLinesRec.CalcSums("Hour 08");
            FD8Tot := HourlyProdLinesRec."Hour 08";

            HourlyProdLinesRec.CalcSums("Hour 09");
            FD9Tot := HourlyProdLinesRec."Hour 09";

            HourlyProdLinesRec.CalcSums("Hour 10");
            FD10Tot := HourlyProdLinesRec."Hour 10";

            HourlyProdLinesRec.CalcSums("Hour 11");
            FD11Tot := HourlyProdLinesRec."Hour 11";

            HourlyProdLinesRec.CalcSums("Hour 12");
            FD12Tot := HourlyProdLinesRec."Hour 12";

            HourlyProdLinesRec.CalcSums("Hour 13");
            FD13Tot := HourlyProdLinesRec."Hour 13";

            FinDTotal := FD1Tot + FD2Tot + FD3Tot + FD4Tot + FD5Tot + FD6Tot + FD7Tot + FD8Tot + FD9Tot + FD10Tot + FD11Tot + FD12Tot + FD13Tot;

            StylePoRec.Reset();
            StylePoRec.SetRange("Style No.", Rec."Style No.");
            if StylePoRec.FindSet() then begin
                StylePoRec.CalcSums("Sawing Out Qty");
                HDTotal := StylePoRec."Sawing Out Qty";
            end;


            if FinDTotal > HDTotal then begin
                Error('Hourly Finishing Value greater than Hourly Sewing');
            end;

        end;
    end;

    procedure CalTotal()
    var

        HourlyProdLinesRec3: Record "Hourly Production Lines";
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

            // if HourlyProdLinesRec.Item = 'DEFECT PCS' then begin
            //     TotDefectPcsHour1 += HourlyProdLinesRec."Hour 01";
            //     TotDefectPcsHour2 += HourlyProdLinesRec."Hour 02";
            //     TotDefectPcsHour3 += HourlyProdLinesRec."Hour 03";
            //     TotDefectPcsHour4 += HourlyProdLinesRec."Hour 04";
            //     TotDefectPcsHour5 += HourlyProdLinesRec."Hour 05";
            //     TotDefectPcsHour6 += HourlyProdLinesRec."Hour 06";
            //     TotDefectPcsHour7 += HourlyProdLinesRec."Hour 07";
            //     TotDefectPcsHour8 += HourlyProdLinesRec."Hour 08";
            //     TotDefectPcsHour9 += HourlyProdLinesRec."Hour 09";
            //     TotDefectPcsHour10 += HourlyProdLinesRec."Hour 10";
            //     TotDefectPcsHour11 += HourlyProdLinesRec."Hour 11";
            //     TotDefectPcsHour12 += HourlyProdLinesRec."Hour 12";
            //     TotDefectPcsHour13 += HourlyProdLinesRec."Hour 13";
            // end;

            // if HourlyProdLinesRec.Item = 'DHU' then begin
            //     TotDHUPcsHour1 += HourlyProdLinesRec."Hour 01";
            //     TotDHUPcsHour2 += HourlyProdLinesRec."Hour 02";
            //     TotDHUPcsHour3 += HourlyProdLinesRec."Hour 03";
            //     TotDHUPcsHour4 += HourlyProdLinesRec."Hour 04";
            //     TotDHUPcsHour5 += HourlyProdLinesRec."Hour 05";
            //     TotDHUPcsHour6 += HourlyProdLinesRec."Hour 06";
            //     TotDHUPcsHour7 += HourlyProdLinesRec."Hour 07";
            //     TotDHUPcsHour8 += HourlyProdLinesRec."Hour 08";
            //     TotDHUPcsHour9 += HourlyProdLinesRec."Hour 09";
            //     TotDHUPcsHour10 += HourlyProdLinesRec."Hour 10";
            //     TotDHUPcsHour11 += HourlyProdLinesRec."Hour 11";
            //     TotDHUPcsHour12 += HourlyProdLinesRec."Hour 12";
            //     TotDHUPcsHour13 += HourlyProdLinesRec."Hour 13";
            // end;

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
            // HourlyProdLines1Rec.Reset();
            // HourlyProdLines1Rec.SetRange("No.", rec."No.");
            // HourlyProdLines1Rec.SetFilter("Factory No.", '=%1', '');
            // HourlyProdLines1Rec.SetRange("Style Name", 'DEFECT PCS (Total)');
            // HourlyProdLines1Rec.FindSet();

            // TotDefect := 0;
            // HourlyProdLines1Rec."Hour 01" := TotDefectPcsHour1;
            // HourlyProdLines1Rec."Hour 02" := TotDefectPcsHour2;
            // HourlyProdLines1Rec."Hour 03" := TotDefectPcsHour3;
            // HourlyProdLines1Rec."Hour 04" := TotDefectPcsHour4;
            // HourlyProdLines1Rec."Hour 05" := TotDefectPcsHour5;
            // HourlyProdLines1Rec."Hour 06" := TotDefectPcsHour6;
            // HourlyProdLines1Rec."Hour 07" := TotDefectPcsHour7;
            // HourlyProdLines1Rec."Hour 08" := TotDefectPcsHour8;
            // HourlyProdLines1Rec."Hour 09" := TotDefectPcsHour9;
            // HourlyProdLines1Rec."Hour 10" := TotDefectPcsHour10;
            // HourlyProdLines1Rec."Hour 11" := TotDefectPcsHour11;
            // HourlyProdLines1Rec."Hour 12" := TotDefectPcsHour12;
            // HourlyProdLines1Rec."Hour 13" := TotDefectPcsHour13;
            // TotDefect += TotDefectPcsHour1 + TotDefectPcsHour2 + TotDefectPcsHour3 + TotDefectPcsHour4 + TotDefectPcsHour5 + TotDefectPcsHour6 + TotDefectPcsHour7 + TotDefectPcsHour8 + TotDefectPcsHour9 + TotDefectPcsHour10 + TotDefectPcsHour11 + TotDefectPcsHour12 + TotDefectPcsHour13;
            // HourlyProdLines1Rec.Total := TotDefect;
            // HourlyProdLines1Rec.Modify();

            //Update DHU
            // HourlyProdLines1Rec.Reset();
            // HourlyProdLines1Rec.SetRange("No.", rec."No.");
            // HourlyProdLines1Rec.SetFilter("Factory No.", '=%1', '');
            // HourlyProdLines1Rec.SetRange("Style Name", 'DHU (Total)');
            // HourlyProdLines1Rec.FindSet();

            // TotDHU := 0;
            // HourlyProdLines1Rec."Hour 01" := TotDHUPcsHour1;
            // HourlyProdLines1Rec."Hour 02" := TotDHUPcsHour2;
            // HourlyProdLines1Rec."Hour 03" := TotDHUPcsHour3;
            // HourlyProdLines1Rec."Hour 04" := TotDHUPcsHour4;
            // HourlyProdLines1Rec."Hour 05" := TotDHUPcsHour5;
            // HourlyProdLines1Rec."Hour 06" := TotDHUPcsHour6;
            // HourlyProdLines1Rec."Hour 07" := TotDHUPcsHour7;
            // HourlyProdLines1Rec."Hour 08" := TotDHUPcsHour8;
            // HourlyProdLines1Rec."Hour 09" := TotDHUPcsHour9;
            // HourlyProdLines1Rec."Hour 10" := TotDHUPcsHour10;
            // HourlyProdLines1Rec."Hour 11" := TotDHUPcsHour11;
            // HourlyProdLines1Rec."Hour 12" := TotDHUPcsHour12;
            // HourlyProdLines1Rec."Hour 13" := TotDHUPcsHour13;
            // TotDHU += TotDHUPcsHour1 + TotDHUPcsHour2 + TotDHUPcsHour3 + TotDHUPcsHour4 + TotDHUPcsHour5 + TotDHUPcsHour6 + TotDHUPcsHour7 + TotDHUPcsHour8 + TotDHUPcsHour9 + TotDHUPcsHour10 + TotDHUPcsHour11 + TotDHUPcsHour12 + TotDHUPcsHour13;
            // HourlyProdLines1Rec.Total := TotDHU;
            // HourlyProdLines1Rec.Modify();

            HourlyProdLinesRec3.Reset();
            HourlyProdLinesRec3.SetRange("Prod Date", Rec."Prod Date");
            HourlyProdLinesRec3.SetRange("Factory No.", Rec."Factory No.");
            HourlyProdLinesRec3.SetRange("Style No.", Rec."Style No.");
            HourlyProdLinesRec3.SetFilter(Type, '=%1', HourlyProdLinesRec3.Type::Sewing);
            if HourlyProdLinesRec3.FindSet() then begin
                HourlyProdLinesRec3.CalcSums("Hour 01")

            end;
        end;




        //Get sewing line in qty/out qty
        // InputQtyVar := 0;
        // OutQtyVar := 0;
        // ProdOutHeaderRec.Reset();
        // ProdOutHeaderRec.SetRange("Resource No.", rec."Work Center No.");
        // ProdOutHeaderRec.SetRange("Factory Code", Rec."Factory No.");
        // ProdOutHeaderRec.SetRange("Style No.", Rec."Style No.");

        // if rec.Type = rec.Type::Sewing then
        //     ProdOutHeaderRec.SetFilter(Type, '=%1', ProdOutHeaderRec.Type::Saw);

        // if rec.Type = rec.Type::Finishing then
        //     ProdOutHeaderRec.SetFilter(Type, '=%1', ProdOutHeaderRec.Type::Fin);

        // if ProdOutHeaderRec.FindSet() then begin
        //     repeat
        //         InputQtyVar += ProdOutHeaderRec."Input Qty";
        //         OutQtyVar += ProdOutHeaderRec."Output Qty";
        //     until ProdOutHeaderRec.Next() = 0;
        // end;

        // if (InputQtyVar - OutQtyVar) < rec.Total then
        //     Error('Hourly Production Total is greater than balance Sew. In Qty/Sew. Out Qty.');

        // CurrPage.Update();

    end;

    trigger OnDeleteRecord(): Boolean
    var
        HourlyProdLineRec: Record "Hourly Production Lines";
        HourlyRec: Record "Hourly Production Master";
    begin
        HourlyRec.Reset();
        HourlyRec.SetRange("No.", Rec."No.");
        HourlyRec.SetFilter(Type, '=%1', Rec.Type::Finishing);
        if HourlyRec.FindSet() then begin
            repeat
                HourlyProdLineRec.Reset();
                HourlyProdLineRec.SetRange("No.", HourlyRec."No.");
                HourlyProdLineRec.SetRange("Style No.", Rec."Style No.");
                HourlyProdLineRec.SetRange("Work Center Seq No", Rec."Work Center Seq No");
                if HourlyProdLineRec.FindSet() then begin
                    if (HourlyProdLineRec."Factory No." = '') AND (HourlyProdLineRec."Prod Date" = 0D) AND (HourlyProdLineRec.Type = HourlyProdLineRec.Type::Sewing) then begin
                        Error('You Cannot delete this Line');
                    end;
                    HourlyProdLineRec.DeleteAll();
                end;
                CurrPage.Update();
            Until HourlyRec.Next() = 0;
        end;
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

        if Rec."Style Name" = '' then
            EditableGB := true
        else
            EditableGB := false;
    end;

    var
        EditableGB: Boolean;
        FinDTotal: Integer;
        HDTotal: Integer;
        FinTotal: Integer;
        HTotal: Integer;
        FD1Tot: Integer;
        FD2Tot: Integer;
        FD3Tot: Integer;
        FD4Tot: Integer;
        FD5Tot: Integer;
        FD6Tot: Integer;
        FD7Tot: Integer;
        FD8Tot: Integer;
        FD9Tot: Integer;
        FD10Tot: Integer;
        FD11Tot: Integer;
        FD12Tot: Integer;
        FD13Tot: Integer;
        HD1Tot: Integer;
        HD2Tot: Integer;
        HD3Tot: Integer;
        HD4Tot: Integer;
        HD5Tot: Integer;
        HD6Tot: Integer;
        HD7Tot: Integer;
        HD8Tot: Integer;
        HD9Tot: Integer;
        HD10Tot: Integer;
        HD11Tot: Integer;
        HD12Tot: Integer;
        HD13Tot: Integer;
        F1Tot: Integer;
        F2Tot: Integer;
        F3Tot: Integer;
        F4Tot: Integer;
        F5Tot: Integer;
        F6Tot: Integer;
        F7Tot: Integer;
        F8Tot: Integer;
        F9Tot: Integer;
        F10Tot: Integer;
        F11Tot: Integer;
        F12Tot: Integer;
        F13Tot: Integer;
        H1Tot: Integer;
        H2Tot: Integer;
        H3Tot: Integer;
        H4Tot: Integer;
        H5Tot: Integer;
        H6Tot: Integer;
        H7Tot: Integer;
        H8Tot: Integer;
        H9Tot: Integer;
        H10Tot: Integer;
        H11Tot: Integer;
        H12Tot: Integer;
        H13Tot: Integer;
        TotPass: Integer;
        TotDHU: Integer;
        TotDefect: Integer;
        StyleExprTxt: Text[50];
        ChangeColor: Codeunit NavAppCodeUnit;
        SetEdit: Boolean;


}