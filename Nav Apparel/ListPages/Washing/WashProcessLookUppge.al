page 51456 WashProcessLookup
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = WashSequenceSMVLine;
    Caption = 'Wash Production Sequence';
    InsertAllowed = false;
    DeleteAllowed = false;
    Editable = false;

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