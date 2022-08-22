report 50713 TestBarcode
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Barcode Report';
    RDLCLayout = 'Report_Layouts/TestBarcode.rdl';
    DefaultLayout = RDLC; 
    PdfFontEmbedding = Yes;

    dataset
    {
        dataitem("Action Type"; "Action Type")
        {
            RequestFilterFields = "No.";
            column(Barcode; Barcode)
            { }
            // column(BarcodeImage; BarcodeImage)
            // { }

            trigger OnAfterGetRecord()
            begin


            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }


}