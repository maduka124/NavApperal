report 50626 CuttingChartReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Cutting Chart Report';
    RDLCLayout = 'Report_Layouts/Cutting/CuttingChartReport.rdl';
    DefaultLayout = RDLC;
    dataset
    {
        dataitem(BundleGuideHeader; BundleGuideHeader)
        {
            DataItemTableView = sorting("BundleGuideNo.");
            column(Style_No_; "Style Name")
            { }
            column(Cut_No; "Cut No")
            { }
            column(Color_Name; "Color Name")
            { }
            column(Created_Date; "Created Date")
            { }
            column(StoreName; StoreName)
            { }
            column(CompLogo; comRec.Picture)
            { }
            dataitem(BundleGuideLine; BundleGuideLine)
            {
                DataItemLinkReference = BundleGuideHeader;
                DataItemLink = "BundleGuideNo." = field("BundleGuideNo.");
                DataItemTableView = sorting("BundleGuideNo.");
                column(Bundle_No; "Bundle No")
                { }
                column(Qty; Qty)
                { }
                column(Sticker_Sequence; "Sticker Sequence")
                { }
                // column()
                // { }
                // column()
                // { }
                // column()
                // { }
            }
            trigger OnAfterGetRecord()

            begin
                StyleRec.Reset();
                StyleRec.SetRange("No.", "Style No.");
                if StyleRec.FindFirst() then begin
                    StoreName := StyleRec."Store Name";
                end;
                  comRec.Get;
                comRec.CalcFields(Picture);
            end;

            trigger OnPreDataItem()

            begin
                SetRange("BundleGuideNo.", BundleGuideNo);
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
                    Caption='Filter By';
                    field(BundleGuideNo; BundleGuideNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Bundleguide No';
                        TableRelation = BundleGuideHeader."BundleGuideNo.";

                    }
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


    var
        BundleGuideNo: code[50];
        StyleRec: Record "Style Master";
        StoreName: Text[50];
         comRec: Record "Company Information";
}