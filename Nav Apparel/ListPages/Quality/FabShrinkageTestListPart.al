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
                field("Pattern Code"; "Pattern Code")
                {
                    ApplicationArea = All;
                    Caption = 'Pattern';

                    trigger OnValidate()
                    var

                    begin
                        if Get_Count() = 1 then
                            Error('Pattern Code duplicated.');

                        "Pattern Name" := "Pattern Code";
                    end;
                }

                field("Pattern Name"; "Pattern Name")
                {
                    ApplicationArea = All;
                    Caption = 'Pattern';
                    Visible = false;
                }

                field(SHRINKAGE; SHRINKAGE)
                {
                    ApplicationArea = All;
                    Caption = 'Shrinkage';
                }

                field("From Length%"; "From Length%")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        "Length%" := format("From Length%") + ' To ' + format("To Length%");
                        "Avg Pattern% Length" := ("From Length%" + "To Length%") / 2;
                    end;
                }

                field("To Length%"; "To Length%")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        "Length%" := format("From Length%") + ' To ' + format("To Length%");
                        "Avg Pattern% Length" := ("From Length%" + "To Length%") / 2;
                    end;
                }

                field("Length%"; "Length%")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Avg Pattern% Length"; "Avg Pattern% Length")
                {
                    ApplicationArea = All;
                    Caption = 'Avg Pattern%';
                    Editable = false;
                }

                field("PTN VARI Length"; "PTN VARI Length")
                {
                    ApplicationArea = All;
                    Caption = 'PTN Variation';
                }

                field("From WiDth%"; "From WiDth%")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        "WiDth%" := format("From WiDth%") + ' To ' + format("To WiDth%");
                        "Avg Pattern% Width" := ("From WiDth%" + "To WiDth%") / 2;
                    end;
                }

                field("To WiDth%"; "To WiDth%")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        "WiDth%" := format("From WiDth%") + ' To ' + format("To WiDth%");
                        "Avg Pattern% Width" := ("From WiDth%" + "To WiDth%") / 2;
                    end;
                }

                field("WiDth%"; "WiDth%")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Avg Pattern% Width"; "Avg Pattern% Width")
                {
                    ApplicationArea = All;
                    Caption = 'Avg Pattern%';
                    Editable = false;
                }

                field("PTN VARI WiDth"; "PTN VARI WiDth")
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
        FabShrTestLineRec.SetRange("FabShrTestNo.", "FabShrTestNo.");
        FabShrTestLineRec.SetFilter("Pattern Code", '=%1', "Pattern Code");
        if FabShrTestLineRec.FindSet() then
            exit(FabShrTestLineRec.Count)
        else
            exit(0);
    end;
}