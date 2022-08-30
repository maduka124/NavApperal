page 50466 "New Breakdown Op Listpart2"
{
    PageType = ListPart;
    SourceTable = "New Breakdown Op Line2";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Seq No';
                    StyleExpr = StyleExprTxt;
                }

                field(Code; Code)
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                    Caption = 'Op Code';
                }

                field(Description; Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field("Machine Name"; "Machine Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Machine';
                    StyleExpr = StyleExprTxt;
                }

                field(SMV; SMV)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        "Target Per Hour" := round((60 / SMV), 1);
                    end;
                }

                field("Target Per Hour"; "Target Per Hour")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field("Department Name"; "Department Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Department';
                    StyleExpr = StyleExprTxt;
                }

                field(Barcode; Barcode)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(Attachment; Attachment)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(LineType; LineType)
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
                    Status: Text[50];
                    Style: code[20];
                begin

                    NewBreakdownRec.Reset();
                    NewBreakdownRec.SetRange("No.", "No.");
                    NewBreakdownRec.FindSet();
                    Status := NewBreakdownRec."Style Stage";
                    Style := NewBreakdownRec."Style No.";


                    //Get SMV total/Machine SMV TOTAL/Helper SMV Total
                    NewBrOpLine2Rec.Reset();
                    NewBrOpLine2Rec.SetCurrentKey("No.");
                    NewBrOpLine2Rec.SetRange("No.", "No.");
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
                    NewBreakdownRec.Get("No.");
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
        }
    }

    trigger OnAfterGetRecord()
    var

    begin
        StyleExprTxt := ChangeColor.ChangeColor(Rec);
    end;

    var
        StyleExprTxt: Text[50];
        ChangeColor: Codeunit NavAppCodeUnit;

}