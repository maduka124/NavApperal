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

            group("Pattern/Cutting")
            {
                Caption = 'Pattern Cutting';

                part("SampleProdLinePattCuttListPart"; "SampleProdLinePattCuttListPart")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                }
            }

            group("Fabric Cutting")
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

            group("Quality Checking")
            {
                part("SampleProdLineQCListPart"; SampleProdLineQCListPart)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                }
            }

            group("Send To Merchandiser For Washing")
            {
                part(SampleProdLineSendWashListPart; SampleProdLineSendWashListPart)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                }
            }

            group("Receive Wash From Merchandiser")
            {
                part(SampleProdLineReceWashListPart; SampleProdLineReceWashListPart)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                }
            }

            group("Finishing")
            {
                part(SampleProdLineFinishListPart; SampleProdLineFinishListPart)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                }
            }

            group("Quality1")
            {
                Caption = 'Quality Finishing';

                part("SampleProdLineQCFinishListPart"; SampleProdLineQCFinishListPart)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                }
            }
        }
    }
}