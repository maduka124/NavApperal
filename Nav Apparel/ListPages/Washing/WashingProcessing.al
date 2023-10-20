page 51442 "Washing Processing List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = WashingProcessing;
    CardPageId = "Washing Processing";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Processing Code"; Rec."Processing Code")
                {
                    ApplicationArea = All;
                }

                field("Processing Name"; Rec."Processing Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(SMV; Rec.SMV)
                {
                    ApplicationArea = All;
                }

                field(Seq; Rec.Seq)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}