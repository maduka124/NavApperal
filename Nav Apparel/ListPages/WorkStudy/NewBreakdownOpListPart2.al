page 50466 "New Breakdown Op Listpart2"
{
    PageType = ListPart;
    SourceTable = "New Breakdown Op Line2";
    AutoSplitKey = true;
    SourceTableView = sorting("Line Position");

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Line Position"; Rec."Line Position")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                    Caption = 'Seq No1';
                }

                // field("Line No."; Rec."Line No.")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                //     Caption = 'Seq No2';
                //     StyleExpr = StyleExprTxt;
                // }

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
                    SMV: Decimal;
                    MachineTotal: Decimal;
                    HelperTotal: Decimal;
                    Status: code[50];
                    Style: code[20];
                begin

                    NewBreakdownRec.Reset();
                    NewBreakdownRec.SetRange("No.", rec."No.");
                    NewBreakdownRec.FindSet();
                    Status := NewBreakdownRec."Style Stage";
                    Style := NewBreakdownRec."Style No.";


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

                    StyleRec.Reset();
                    StyleRec.SetRange("No.", Style);

                    if StyleRec.FindSet() then begin

                        if Status = 'COSTING' then
                            StyleRec.CostingSMV := SMV
                        else
                            if Status = 'PRODUCTION' then
                                StyleRec.ProductionSMV := SMV
                            else
                                if Status = 'PLANNING' then
                                    StyleRec.PlanningSMV := SMV;

                        StyleRec.SMV := SMV;
                        StyleRec.Modify();
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
        Rec.SetCurrentKey("Line Position");
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

}