page 50426 "Sample WIP Card"
{
    PageType = Card;
    SourceTable = WIP;
    Caption = 'Sample WIP';
    UsageCategory = Tasks;

    layout
    {
        area(Content)
        {
            group(" ")
            {
            }

            group("Sample Request")
            {
                part("Sample Request Header ListPart"; "Sample Request Header ListPart")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                }
            }

            group("Sample Request Details")
            {
                part("SampleReqLineListPartWIP"; SampleReqLineListPartWIP)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "No." = FIELD("Req No.");
                }
            }

            group("Style Documents")
            {
                part(SampleReqDocListPartWIP; SampleReqDocListPartWIP)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "No." = FIELD("Req No.");
                }
            }
        }
    }



    trigger OnOpenPage()
    begin
        if not rec.get() then begin
            rec.INIT();
            rec.INSERT();
        end;
    end;
}