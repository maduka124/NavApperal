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
            column(Posting_Description; "Order No.")
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
            column(Vendor_Shipment_No_; "Vendor Shipment No.")
            { }
            column(PurchQty; PurchQty)
            { }
            column(Quality_Inspector_Name; "Quality Inspector Name")
            { }
            column(SystemCreatedAt; SystemCreatedAt)
            { }
            column(RecievedQty; RecievedQty)
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
                trigger OnAfterGetRecord()
                var

                begin
                    PoQty := 0;
                    StylePORec.Reset();
                    StylePORec.SetRange("Style No.", StyleNo);
                    if StylePORec.FindSet() then begin
                        repeat
                            PoQty += StylePORec.Qty;
                        until StylePORec.Next() = 0;
                    end;

                    StyleRec.Reset();
                    StyleRec.SetRange("No.", StyleNo);
                    if StyleRec.FindFirst() then begin
                        StyleName := StyleRec."Style No.";
                        GarmentType := StyleRec."Garment Type Name";
                    end;
                end;

            }
            trigger OnAfterGetRecord()

            begin
                comRec.Get;
                comRec.CalcFields(Picture);



                PurchRcptLineRec.Reset();
                PurchRcptLineRec.SetRange("Document No.", "No.");
                if PurchRcptLineRec.FindSet() then begin
                    repeat
                        PurchQty += PurchRcptLineRec.Quantity;
                    until PurchRcptLineRec.Next() = 0;

                    RecievedQty := PurchRcptLineRec."Qty. Rcd. Not Invoiced";
                    
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
        RecievedQty: Decimal;
        PurchQty: Decimal;
        PurchRcptLineRec: Record "Purch. Rcpt. Line";
        GarmentType: Text[50];
        StyleName: Text[50];
        StyleRec: Record "Style Master";
        GRNNo: Code[20];
        PoQty: BigInteger;
        comRec: Record "Company Information";
        StylePORec: Record "Style Master PO";
}