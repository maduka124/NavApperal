page 50686 "FabShrinkageTestListPart"
{
    PageType = ListPart;
    SourceTable = FabShrinkageTestLine;
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Pattern Code"; rec."Pattern Code")
                {
                    ApplicationArea = All;
                    Caption = 'Pattern';

                    trigger OnValidate()
                    var

                    begin
                        if Get_Count() = 1 then
                            Error('Pattern Code duplicated.');

                        rec."Pattern Name" := rec."Pattern Code";
                    end;
                }

                field("Pattern Name"; rec."Pattern Name")
                {
                    ApplicationArea = All;
                    Caption = 'Pattern';
                    Visible = false;
                }

                field(SHRINKAGE; rec.SHRINKAGE)
                {
                    ApplicationArea = All;
                    Caption = 'Shrinkage';
                }

                field("From Length%"; rec."From Length%")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        rec."Length%" := format(rec."From Length%") + ' To ' + format(rec."To Length%");
                        rec."Avg Pattern% Length" := (rec."From Length%" + rec."To Length%") / 2;
                    end;
                }

                field("To Length%"; rec."To Length%")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        rec."Length%" := format(rec."From Length%") + ' To ' + format(rec."To Length%");
                        rec."Avg Pattern% Length" := (rec."From Length%" + rec."To Length%") / 2;
                    end;
                }

                field("Length%"; rec."Length%")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Avg Pattern% Length"; rec."Avg Pattern% Length")
                {
                    ApplicationArea = All;
                    Caption = 'Avg Pattern%';
                    Editable = false;
                }

                field("PTN VARI Length"; rec."PTN VARI Length")
                {
                    ApplicationArea = All;
                    Caption = 'PTN Variation';
                }

                field("From WiDth%"; rec."From WiDth%")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        rec."WiDth%" := format(rec."From WiDth%") + ' To ' + format(rec."To WiDth%");
                        rec."Avg Pattern% Width" := (rec."From WiDth%" + rec."To WiDth%") / 2;
                    end;
                }

                field("To WiDth%"; rec."To WiDth%")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        rec."WiDth%" := format(rec."From WiDth%") + ' To ' + format(rec."To WiDth%");
                        rec."Avg Pattern% Width" := (rec."From WiDth%" + rec."To WiDth%") / 2;
                    end;
                }

                field("WiDth%"; rec."WiDth%")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Avg Pattern% Width"; rec."Avg Pattern% Width")
                {
                    ApplicationArea = All;
                    Caption = 'Avg Pattern%';
                    Editable = false;
                }

                field("PTN VARI WiDth"; rec."PTN VARI WiDth")
                {
                    ApplicationArea = All;
                    Caption = 'PTN Variation';
                }
            }
        }
    }


    procedure Get_Count(): Integer
    var
        FabShrTestLineRec: Record FabShrinkageTestLine;
    begin
        FabShrTestLineRec.Reset();
        FabShrTestLineRec.SetRange("FabShrTestNo.", rec."FabShrTestNo.");
        FabShrTestLineRec.SetFilter("Pattern Code", '=%1', rec."Pattern Code");
        if FabShrTestLineRec.FindSet() then
            exit(FabShrTestLineRec.Count)
        else
            exit(0);
    end;
}