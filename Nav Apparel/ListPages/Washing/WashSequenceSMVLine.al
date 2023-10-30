page 51447 WashSequenceSMVLine
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = WashSequenceSMVLine;


    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Processing Name"; Rec."Processing Name")
                {
                    ApplicationArea = All;
                    Caption = 'Process';
                    Editable = false;
                }

                field(SMV; Rec.SMV)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        WashseqSmnLine: Record WashSequenceSMVLine;
                    begin

                        WashseqSmnLine.Reset();
                        WashseqSmnLine.SetRange(No, Rec.No);
                        WashseqSmnLine.SetFilter("Record Type", '=%1', 'T');

                        if WashseqSmnLine.FindSet() then begin
                            WashseqSmnLine.SMV := WashseqSmnLine.SMV + Rec.SMV;
                            WashseqSmnLine.Modify(true);
                        end;
                    end;
                }

                field(Seq; Rec.Seq)
                {
                    ApplicationArea = All;
                    Caption = 'Sequence';

                    trigger OnValidate()
                    var
                        WashSequenceSMVLineRec: Record WashSequenceSMVLine;
                    begin

                        WashSequenceSMVLineRec.Reset();
                        WashSequenceSMVLineRec.SetRange(No, Rec.No);

                        if WashSequenceSMVLineRec.FindSet() then begin

                            repeat
                                if Rec.Seq <> 0 then begin
                                    if Rec.Seq = WashSequenceSMVLineRec.Seq then
                                        Error('This Seuence no already used in %1', WashSequenceSMVLineRec."Processing Code");
                                end;
                            until WashSequenceSMVLineRec.Next() = 0;

                        end;

                    end;
                }
            }
        }
    }
}