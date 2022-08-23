report 50634 BundleGuideReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Bundle Guide Report';
    RDLCLayout = 'Report_Layouts/Cutting/BundleGuideReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(BundleGuideHeader; BundleGuideHeader)
        {
            DataItemTableView = sorting("BundleGuideNo.");

            column(Style_Name; "Style Name")
            { }
            column(Cut_No; "Cut No")
            { }
            column(Created_Date; "Created Date")
            { }
            column(Quantity; Quantity)
            { }
            column(CompLogo; comRec.Picture)
            { }
            // test
            dataitem(BundleGuideLine; BundleGuideLine)
            {
                DataItemLinkReference = BundleGuideHeader;
                DataItemLink = "BundleGuideNo." = field("BundleGuideNo.");
                DataItemTableView = sorting("Line No");
                column(Bundle_No; "Bundle No")
                { }
                column(Color_Name; "Color Name")
                { }
                column(Shade_Name; "Shade Name")
                { }
                column(Sticker_Sequence; "Sticker Sequence")
                { }
                column(Role_ID; "Role ID")
                { }
                column(Size; Size)
                { }
                column(BQty; Qty)
                { }
                //  column()
                // {}
                //  column()
                // {}

                trigger OnAfterGetRecord()

                begin
                    styleRec.SetRange("No.", BundleGuideHeader."Style No.");
                    if styleRec.FindFirst() then begin
                        Quantity := styleRec."Order Qty";
                    end;

                end;
            }
            trigger OnAfterGetRecord()

            begin
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
                    Caption = 'Filter By';
                    field(BundleGuideNo; BundleGuideNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Bundle Guide No';
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
        styleRec: Record "Style Master";
        Quantity: BigInteger;
        comRec: Record "Company Information";
        BundleGuideNo: code[50];
}