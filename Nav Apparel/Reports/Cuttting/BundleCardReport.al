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
         
            dataitem(GarmentPartsBundleCard2Right; GarmentPartsBundleCard2Right)
            {
                DataItemLinkReference = BundleCardTable;
                DataItemLink = BundleCardNo = field("Bundle Card No");
                DataItemTableView = sorting(BundleCardNo, "No.");
                column(GMTPartNo; Description)
                { }
                column(No_; "No.")
                { }


                dataitem(BundleGuideLine; BundleGuideLine)
                {
                    DataItemLinkReference = GarmentPartsBundleCard2Right;
                    DataItemLink = "BundleGuideNo." = field("Bundle Guide Header No");
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
                        StyleRec.Reset();
                        StyleRec.SetRange("Style No.", "Style Name");
                        if StyleRec.FindFirst() then
                            Buyer := StyleRec."Buyer Name";

                        comRec.Get;
                        comRec.CalcFields(Picture);
                    end;
                }
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
        myInt: Integer;
        StyleRec: Record "Style Master";
        Buyer: Text[50];
        comRec: Record "Company Information";
}