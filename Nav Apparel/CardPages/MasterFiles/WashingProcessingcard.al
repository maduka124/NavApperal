page 51441 "Washing Processing"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = WashingProcessing;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Processing Code"; Rec."Processing Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin

                        Rec."Processing Name" := Rec."Processing Code";
                        CurrPage.Update();

                    end;
                }

                field("Processing Name"; Rec."Processing Name")
                {
                    ApplicationArea = All;
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