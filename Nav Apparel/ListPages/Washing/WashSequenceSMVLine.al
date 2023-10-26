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
                }
            }
        }
    }
}