report 50607 BundleCardReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Bundle Card Report';
    // RDLCLayout = 'Report_Layouts/Cutting/BundleCardBarCode.rdl';
    RDLCLayout = 'Report_Layouts/Cutting/BundleCardBarCode1.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(BundleCardTable; BundleCardTable)
        {
            DataItemTableView = sorting("Bundle Card No");

            dataitem(BundleGuideLine; BundleGuideLine)
            {
                DataItemLinkReference = BundleCardTable;
                DataItemLink = "BundleGuideNo." = field("Bundle Guide Header No");
                DataItemTableView = sorting("Bundle No");

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
                column(Cut_No; "Cut No New")
                { }
                column(Style_Name; "Style Name")
                { }
                column(Buyer; Buyer)
                { }
                column(Barcode; Barcode)
                { }
                column(Shade_Name; "Shade Name")
                { }

                dataitem(GarmentPartsBundleCard2Right; GarmentPartsBundleCard2Right)
                {
                    DataItemLinkReference = BundleCardTable;
                    DataItemLink = BundleCardNo = field("Bundle Card No");

                    column(GMTPartNo; Description)
                    { }
                    column(No_; "No.")
                    { }
                }

                trigger OnAfterGetRecord()
                begin
                    StyleRec.Reset();
                    StyleRec.SetRange("Style No.", "Style Name");
                    if StyleRec.FindFirst() then
                        Buyer := StyleRec."Buyer Name";
                end;
            }

            trigger OnPreDataItem()
            begin
                SetRange("Bundle Card No", BundleFilter);
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
                    field(BundleFilter; BundleFilter)
                    {
                        ApplicationArea = All;
                        Editable = false;
                        Caption = 'Bundle Guide No';
                    }
                }
            }
        }
    }

    procedure PassParameters(BundleNo: Code[20]);
    var
    begin
        BundleFilter := BundleNo;
    end;

    var
        GMTPartName: Text[100];
        GMTPartRec: Record GarmentPartsBundleCard2Right;
        BundleFilter: Code[20];
        StyleRec: Record "Style Master";
        Buyer: Text[50];
}