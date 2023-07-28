page 50466 "New Breakdown Op Listpart2"
{
    PageType = ListPart;
    SourceTable = "New Breakdown Op Line2";
    AutoSplitKey = true;
    SourceTableView = sorting("GPart Position", "Line Position") order(ascending);

    layout
    {
        area(Content)
        {
            // group(" ")
            // {
            field(RowNo; RowNo)
            {
                ApplicationArea = all;
                Caption = 'To Position';

                trigger OnValidate()
                var
                    NewBrOpLine2Rec: Record "New Breakdown Op Line2";
                    NewBRLine: Record "New Breakdown Op Line2";
                    MoveBy: Integer;
                begin
                    if RowNo <= 0 then
                        Error('Invalid Position');

                    if rec.LineType = 'H' then
                        Error('Cannot move header record');

                    //Validate entered row no's Line type/Garment part type
                    NewBrOpLine2Rec.Reset();
                    NewBrOpLine2Rec.SetRange("No.", rec."No.");
                    NewBrOpLine2Rec.SetRange("Line Position", RowNo);
                    if NewBrOpLine2Rec.FindSet() then begin
                        if NewBrOpLine2Rec.LineType = 'H' then
                            Error('Invalid Position');

                        if NewBrOpLine2Rec.RefGPartName <> rec.RefGPartName then
                            Error('Cannot move the current item to a different Garment Part');
                    end
                    else
                        Error('Invalid Position');

                    MoveBy := 0;
                    NewBrOpLine2Rec.Reset();
                    NewBrOpLine2Rec.SetRange("No.", rec."No.");
                    NewBrOpLine2Rec.SetCurrentKey("Line Position");
                    NewBrOpLine2Rec.Ascending(false);
                    if NewBrOpLine2Rec.FindFirst() then begin
                        if RowNo > NewBrOpLine2Rec."Line Position" then
                            Error('Invalid Position');

                        if RowNo <> rec."Line Position" then begin
                            NewBRLine.Reset();
                            NewBRLine.SetRange("No.", Rec."No.");
                            if RowNo > rec."Line Position" then begin
                                NewBRLine.SetRange("Line Position", Rec."Line Position" + 1, Rec."Line Position" + (RowNo - Rec."Line Position"));
                                MoveBy := -1;
                            end
                            else begin
                                NewBRLine.SetRange("Line Position", Rec."Line Position" + (RowNo - Rec."Line Position"), Rec."Line Position" - 1);
                                MoveBy := 1;
                            end;
                            if NewBRLine.FindSet() then begin
                                //Assign Temp value to current row 
                                Rec."Line Position" := 99999;
                                Rec.Modify();

                                repeat
                                    NewBRLine."Line Position" += MoveBy;
                                    NewBRLine.Modify();
                                until NewBRLine.Next() = 0;

                                Rec."Line Position" := RowNo;
                                Rec.Modify();
                                CurrPage.Update();
                            end;
                        end;
                    end
                    else
                        Error('No records in the breakdown list.');
                end;
            }
            // }

            repeater(General)
            {
                field("Line Position"; Rec."Line Position")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                    Caption = 'Seq No';
                }

                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                    Caption = 'Op Code';
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field("Machine Name"; Rec."Machine Name")
                {
                    ApplicationArea = All;
                    Caption = 'Machine';
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                        MachineRec: Record "Machine Master";
                    begin
                        MachineRec.Reset();
                        MachineRec.SetRange("Machine Description", rec."Machine Name");
                        if MachineRec.FindSet() then
                            rec."Machine No." := MachineRec."Machine No.";
                    end;
                }

                field(SMV; Rec.SMV)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        rec."Target Per Hour" := round((60 / rec.SMV), 1);
                    end;
                }

                field("Target Per Hour"; Rec."Target Per Hour")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Department';
                    StyleExpr = StyleExprTxt;
                }

                field(Barcode; Rec.Barcode)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(Attachment; Rec.Attachment)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(LineType; Rec.LineType)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = 'Data Head';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Refersh")
            {
                Caption = 'Refresh';
                ApplicationArea = All;
                Image = Refresh;

                trigger OnAction()
                begin
                    CurrPage.Update();
                end;
            }

            action("Caculate SMV")
            {
                ApplicationArea = All;
                Image = Calculate;

                trigger OnAction()
                var
                    NewBrOpLine2Rec: Record "New Breakdown Op Line2";
                    NewBreakdownRec: Record "New Breakdown";
                    StyleRec: Record "Style Master";
                    EstimateCostRec: Record "BOM Estimate Cost";
                    SwingProductionRec: Record ProductionOutHeader;
                    SwingProduction2Rec: Record ProductionOutHeader;
                    NavapPlaningLineRec: Record "NavApp Planning Lines";
                    NavapProductionplandetails: Record "NavApp Prod Plans Details";
                    SMV: Decimal;
                    MachineTotal: Decimal;
                    HelperTotal: Decimal;
                    Stage: code[50];
                    Style: code[20];
                    DateRange: Integer;
                begin

                    NewBreakdownRec.Reset();
                    NewBreakdownRec.SetRange("No.", rec."No.");
                    NewBreakdownRec.FindSet();
                    // Status := NewBreakdownRec."Style Stage";
                    Style := NewBreakdownRec."Style No.";

                    //Done By Sachith on 04/05/23
                    SwingProduction2Rec.Reset();
                    SwingProduction2Rec.SetRange("Style No.", Style);
                    SwingProduction2Rec.SetRange(Type, SwingProduction2Rec.Type::Saw);

                    if SwingProduction2Rec.FindSet() then begin
                        if SwingProduction2Rec."Input Qty" <> 0 then begin

                            DateRange := Today - SwingProduction2Rec."Prod Date";
                            if DateRange >= 10 then
                                Error('Can not caculate SMV.because of more than ten days after Production');
                        end;
                    end;

                    EstimateCostRec.Reset();
                    EstimateCostRec.SetRange("Style No.", Style);
                    EstimateCostRec.SetRange(Status, EstimateCostRec.Status::Approved);

                    if EstimateCostRec.FindSet() then begin

                        Stage := 'COSTING';

                        SwingProductionRec.Reset();
                        SwingProductionRec.SetRange("Style No.", Style);
                        SwingProductionRec.SetRange(Type, SwingProductionRec.Type::Saw);

                        if SwingProductionRec.FindSet() then begin

                            Stage := 'PLANNING';

                            if SwingProductionRec."Input Qty" <> 0 then begin
                                Stage := 'PRODUCTION';

                            end
                            else
                                Stage := 'PLANNING';
                        end
                        else
                            Stage := 'COSTING';
                    end
                    else
                        Stage := 'COSTING';

                    //Get SMV total/Machine SMV TOTAL/Helper SMV Total
                    NewBrOpLine2Rec.Reset();
                    NewBrOpLine2Rec.SetCurrentKey("No.");
                    NewBrOpLine2Rec.SetRange("No.", rec."No.");
                    NewBrOpLine2Rec.FindSet();

                    repeat
                        SMV += NewBrOpLine2Rec.SMV;

                        if NewBrOpLine2Rec.MachineType = 'Machine' then
                            MachineTotal += NewBrOpLine2Rec.SMV;

                        if NewBrOpLine2Rec.MachineType = 'Helper' then
                            HelperTotal += NewBrOpLine2Rec.SMV;

                    until NewBrOpLine2Rec.Next() = 0;


                    NewBreakdownRec.Reset();
                    NewBreakdownRec.SetCurrentKey("No.");
                    NewBreakdownRec.Get(rec."No.");
                    NewBreakdownRec."Total SMV" := SMV;
                    NewBreakdownRec.Machine := MachineTotal;
                    NewBreakdownRec.Manual := HelperTotal;
                    NewBreakdownRec.Modify();

                    //Done By Sachith on 04/05/23
                    StyleRec.Reset();
                    StyleRec.SetRange("No.", Style);

                    if StyleRec.FindSet() then begin

                        if Stage = 'COSTING' then begin
                            StyleRec.CostingSMV := SMV;
                            NewBreakdownRec."Style Stage" := Stage;
                            NewBreakdownRec.Modify();
                        end
                        else
                            if Stage = 'PLANNING' then begin
                                StyleRec.PlanningSMV := SMV;
                                NewBreakdownRec."Style Stage" := Stage;
                                NewBreakdownRec.Modify();
                            end
                            else
                                if Stage = 'PRODUCTION' then begin
                                    StyleRec.ProductionSMV := SMV;
                                    NewBreakdownRec."Style Stage" := Stage;
                                    NewBreakdownRec.Modify();
                                end;

                        StyleRec.SMV := SMV;
                        StyleRec.Modify();

                        //Done By Sachith on 08/05/23
                        NavapPlaningLineRec.Reset();
                        NavapPlaningLineRec.SetRange("Style No.", Style);

                        if NavapPlaningLineRec.FindFirst() then begin
                            repeat

                                NavapPlaningLineRec.SMV := SMV;
                                NavapPlaningLineRec.Modify();

                                NavapProductionplandetails.Reset();
                                NavapProductionplandetails.SetRange("Line No.", NavapPlaningLineRec."Line No.");

                                if NavapProductionplandetails.FindFirst() then begin
                                    repeat
                                        NavapProductionplandetails.SMV := SMV;
                                        NavapProductionplandetails.Modify();
                                    until NavapProductionplandetails.Next() = 0;
                                end;

                            until NavapPlaningLineRec.Next() = 0;
                        end;
                    end;
                    Message('Calculation completed.');


                    // //Machine SMV total
                    // NewBrOpLine2Rec.Reset();
                    // NewBrOpLine2Rec.SetRange("No.", "No.");
                    // NewBrOpLine2Rec.SetFilter(MachineType, '=%1', 'Machine');

                    // if NewBrOpLine2Rec.FindSet() then begin
                    //     repeat
                    //         MachineTotal += NewBrOpLine2Rec.SMV;
                    //     until NewBrOpLine2Rec.Next() = 0;
                    // end;


                    // //Helper SMV total
                    // NewBrOpLine2Rec.Reset();
                    // NewBrOpLine2Rec.SetRange("No.", "No.");
                    // NewBrOpLine2Rec.SetFilter(MachineType, '=%1', 'Machine');

                    // if NewBrOpLine2Rec.FindSet() then begin
                    //     repeat
                    //         HelperTotal += NewBrOpLine2Rec.SMV;
                    //     until NewBrOpLine2Rec.Next() = 0;
                    // end;

                end;
            }

            action("Move Up")
            {
                Caption = 'Move Up';
                ApplicationArea = All;
                Image = MoveUp;
                // Promoted = true;
                // PromotedCategory = Process;
                // PromotedIsBig = true;
                ToolTip = 'Move current line up.';

                trigger OnAction()
                begin
                    MoveLine(-1);
                end;
            }
            action("Move Down")
            {
                Caption = 'Move Down';
                ApplicationArea = All;
                Image = MoveDown;
                // Promoted = true;
                // PromotedCategory = Process;
                // PromotedIsBig = true;
                ToolTip = 'Move current line down.';

                trigger OnAction()
                begin
                    MoveLine(1);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
    begin
        StyleExprTxt := ChangeColor.ChangeColor(Rec);
    end;


    trigger OnOpenPage()
    begin
        Rec.SetCurrentKey("GPart Position", "Line Position");
        Rec.Ascending(true);
    end;


    Local procedure MoveLine(MoveBy: Integer)
    var
        NewBRLine: Record "New Breakdown Op Line2";
    begin
        NewBRLine.Reset();
        NewBRLine.SetRange("No.", Rec."No.");
        NewBRLine.SetRange("Line Position", Rec."Line Position" + MoveBy);
        if NewBRLine.FindFirst then begin
            NewBRLine."Line Position" -= MoveBy;
            NewBRLine.Modify();
            Rec."Line Position" += MoveBy;
            Rec.Modify();
        end;
    end;


    var
        StyleExprTxt: Text[50];
        ChangeColor: Codeunit NavAppCodeUnit;
        RowNo: Integer;
}