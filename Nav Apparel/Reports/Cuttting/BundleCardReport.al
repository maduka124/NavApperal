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
            column(GMTPartNo; GMTPartName)
            { }

            dataitem(BundleGuideLine; BundleGuideLine)
            {
                DataItemLinkReference = BundleCardTable;
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

            trigger OnPreDataItem()
            begin
                SetRange("Bundle Guide Header No", BundleFilter);
            end;

            trigger OnAfterGetRecord()
            begin
                GMTPartRec.Reset();
                GMTPartRec.SetRange(BundleCardNo, "Bundle Card No");
                if GMTPartRec.FindSet() then begin
                    repeat
                        GMTPartName := GMTPartRec.Description;
                    until GMTPartRec.Next() = 0;
                end;
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