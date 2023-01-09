page 50476 "Maning Levels Listpart"
{
    PageType = ListPart;
    SourceTable = "Maning Levels Line";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Seq No';
                }

                field(Code; rec.Code)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Op Code';
                }

                field("RefGPartName"; rec.RefGPartName)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Garment Part';
                }

                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Machine Name"; rec."Machine Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Machine';
                }

                field("Department Name"; rec."Department Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Department';
                }

                field("SMV Machine"; rec."SMV Machine")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("SMV Manual"; rec."SMV Manual")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Target Per Hour"; rec."Target Per Hour")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Theo MO"; rec."Theo MO")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Theoretical MO';
                }

                field("Theo HP"; rec."Theo HP")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Theoretical HP';
                }

                field("Act MO"; rec."Act MO")
                {
                    ApplicationArea = All;
                    Caption = 'Actual MO';

                    trigger OnValidate()
                    var
                    begin
                        rec."Act MC" := rec."Act MO";
                    end;
                }

                field("Act HP"; rec."Act HP")
                {
                    ApplicationArea = All;
                    Caption = 'Actual HP';
                }

                field("Act MC"; rec."Act MC")
                {
                    ApplicationArea = All;
                    Caption = 'Actual MC';
                    Editable = false;
                }

                field(Comments; rec.Comments)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Calculate Maning Levels")
            {
                ApplicationArea = All;
                Image = Calculate;

                trigger OnAction()
                var
                    ManingLevelsLineRec: Record "Maning Levels Line";
                    ManingLevelRec: Record "Maning Level";
                    ActMOTotal: Decimal;
                    ActHPTotal: Decimal;

                begin

                    //Calculate Actual values
                    ManingLevelsLineRec.Reset();
                    ManingLevelsLineRec.SetRange("No.", rec."No.");

                    if ManingLevelsLineRec.FindSet() then begin
                        repeat
                            ActMOTotal += ManingLevelsLineRec."Act MO";
                            ActHPTotal += ManingLevelsLineRec."Act HP";
                        until ManingLevelsLineRec.Next() = 0;
                    end;


                    //Update Master table
                    ManingLevelRec.Reset();
                    ManingLevelRec.SetRange("No.", rec."No.");

                    if ManingLevelRec.FindSet() then begin

                        ManingLevelRec.MOAct := ActMOTotal;
                        ManingLevelRec.HPAct := ActHPTotal;
                        ManingLevelRec.MODiff := ActMOTotal - ManingLevelRec.MOTheo;

                        if ManingLevelRec.MOTheo <> 0 then
                            ManingLevelRec.MOBil := ((ActMOTotal - ManingLevelRec.MOTheo) / ManingLevelRec.MOTheo) / 100
                        else
                            ManingLevelRec.MOBil := 0;

                        ManingLevelRec.HPODiff := ActHPTotal - ManingLevelRec.HPTheo;

                        if ManingLevelRec.HPTheo <> 0 then
                            ManingLevelRec.HPBil := ((ActHPTotal - ManingLevelRec.HPTheo) / ManingLevelRec.HPTheo) / 100
                        else
                            ManingLevelRec.HPBil := 0;

                        ManingLevelRec.Modify();

                    end;

                end;
            }
        }
    }
}