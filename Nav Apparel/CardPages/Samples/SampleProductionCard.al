page 50434 "Sample Production"
{
    PageType = Card;
    // SourceTable = WIP;
    Caption = 'Sample Production';
    UsageCategory = Tasks;

    layout
    {
        area(Content)
        {
            group("Pattern")
            {
                part("SampleProdLinePatternListPart"; "SampleProdLinePatternListPart")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                }
            }

            group("Cutting")
            {
                part("SampleProdLineCutListPart"; SampleProdLineCutListPart)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                }
            }

            group("Sewing")
            {
                part("SampleProdLineSewListPart"; SampleProdLineSewListPart)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                }
            }

            group("Send Wash")
            {
                part(SampleProdLineSendWashListPart; SampleProdLineSendWashListPart)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                }
            }

            group("Receive Wash")
            {
                part(SampleProdLineReceWashListPart; SampleProdLineReceWashListPart)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                }
            }
        }
    }
}