report 51259 TrimInspectionReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Trim Inspection Report';
    RDLCLayout = 'Report_Layouts/Merchandizing/TrimInspectionReport.rdl';
    DefaultLayout = RDLC;


    dataset
    {
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {
            DataItemTableView = where("Bal. Account Type" = filter('G/L Account'));
            column(CompLogo; comRec.Picture)
            { }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name")
            { }
            column(No_; "No.")
            { }
            column(Posting_Description; "Posting Description")
            { }
            column(PoQty; PoQty)
            { }
            column(Factory; "Ship-to Name")
            { }
            column(Supplier; "Pay-to Name")
            { }
            column(StyleName; StyleName)
            { }
            column(GarmentType; GarmentType)
            { }
            dataitem(TrimInspectionLine; TrimInspectionLine)
            {
                DataItemLinkReference = "Purch. Rcpt. Header";
                DataItemLink = "PurchRecNo." = field("No.");
                DataItemTableView = sorting("PurchRecNo.", "Line No");

                column(Item_Name; "Item Name")
                { }
                column(Color_Name; "Color Name")
                { }
                column(Size; Size)
                { }
                column(Item_No_; "Item No.")
                { }
                column(Sample_Qty; "Sample Qty")
                { }
                column(GRN_Qty; "GRN Qty")
                { }
                column(Accept; Accept)
                { }
                column(Reject; Reject)
                { }
                column(Status; Status)
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
                comRec.Get;
                comRec.CalcFields(Picture);

                PoQty := 0;
                StylePORec.Reset();
                StylePORec.SetRange("PO No.", "Posting Description");
                if StylePORec.FindSet() then begin
                    repeat
                        PoQty := StylePORec.Qty;
                    until StylePORec.Next() = 0;
                end;

                StyleRec.Reset();
                StyleRec.SetRange("PO No", "Posting Description");
                if StyleRec.FindFirst() then begin
                    StyleName := StyleRec."Style No.";
                    GarmentType := StyleRec."Garment Type Name";
                end;
            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                SetRange("No.", GRNNo);
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
                    field(GRNNo; GRNNo)
                    {
                        ApplicationArea = All;
                        Caption = 'GRN No';
                        TableRelation = "Purch. Rcpt. Header"."No.";

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
        GarmentType: Text[50];
        StyleName: Text[50];
        StyleRec: Record "Style Master";
        GRNNo: Code[20];
        PoQty: BigInteger;
        comRec: Record "Company Information";
        StylePORec: Record "Style Master PO";
}