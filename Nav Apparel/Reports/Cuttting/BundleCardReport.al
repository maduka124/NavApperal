report 50607 BundleCardReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Bundle Card Report';
    RDLCLayout = 'Report_Layouts/Cutting/BundleCardBarCode.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(BundleGuideLine; BundleGuideLine)
        {
            DataItemTableView = sorting("BundleGuideNo.");
            column(PO; PO)
            { }
            column(Color_Name; "Color Name")
            { }
            column(Lot; Lot)
            { }
            column(Size; Size)
            { }
            column(Qty; Qty)
            { }
            column(Bundle_No; "Bundle No")
            { }
            column(Sticker_Sequence; "Sticker Sequence")
            { }
            column(Cut_No; "Cut No")
            { }
            column(Style_Name; "Style Name")
            { }
            column(Buyer; Buyer)
            { }
            column(Barcode; Barcode)
            { }
            column(CompLogo; comRec.Picture)
            { }

            trigger OnAfterGetRecord()

            begin
                StyleRec.SetRange("Style No.", "Style Name");
                if StyleRec.FindFirst() then begin
                    Buyer := StyleRec."Buyer Name";
                end;
                comRec.Get;
                comRec.CalcFields(Picture);
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
                    // field(Name; SourceExpression)
                    // {
                    //     ApplicationArea = All;

                    // }
                }
            }
        }
    }


    var
        myInt: Integer;
        StyleRec: Record "Style Master";
        Buyer: Text[50];
        comRec: Record "Company Information";
}