report 51199 MaterialIssueRequitionCard
{
    RDLCLayout = 'Report_Layouts/Warehouse/MatRequisitionIssue.rdl';
    DefaultLayout = RDLC;
    // ApplicationArea = Manufacturing;
    Caption = 'Material Requisition Issue Report';
    UsageCategory = ReportsAndAnalysis;
    // ApplicationArea = All;

    dataset
    {
        dataitem("Production Order"; "Production Order")
        {

            DataItemTableView = where(Status = filter('Released'));
            PrintOnlyIfDetail = true;

            // RequestFilterFields = "No.";

            column(TodayFormatted; Format(Today, 0, 4))
            {
            }
            column(CompanyName; COMPANYPROPERTY.DisplayName)
            {
            }
            column(ProdOrderTableCaptionFilter; TableCaption + ':' + ProdOrderFilter)
            {
            }
            column(No_ProdOrder; "No.")
            {
            }
            column(Desc_ProdOrder; Description)
            {
            }
            column(SourceNo_ProdOrder; "Source No.")
            {
                IncludeCaption = true;
            }
            column(Status_ProdOrder; Status)
            {
            }
            column(Qty_ProdOrder; Quantity)
            {
                IncludeCaption = true;
            }
            column(Filter_ProdOrder; ProdOrderFilter)
            {
            }
            column(ProdOrderMaterialRqstnCapt; ProdOrderMaterialRqstnCaptLbl)
            {
            }
            column(CurrReportPageNoCapt; CurrReportPageNoCaptLbl)
            {
            }
            column(CompLogo; comRec.Picture)
            { }
            column(Buyer; Buyer)
            { }
            column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code")
            { }
            column(Style_Name; "Style Name")
            { }
            column(PoNo; PO)
            { }


            dataitem("Item Journal Line"; "Item Journal Line")
            {

                DataItemLinkReference = "Production Order";
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Item No.", "Posting Date");
                // RequestFilterFields = "Document No.";
                // DataItemLink = Status = FIELD(Status), "Prod. Order No." = FIELD("No.");
                // DataItemTableView = SORTING(Status, "Prod. Order No.", "Prod. Order Line No.", "Line No.");
                column(ItemNo_ProdOrderComp; "Item No.")
                {
                    IncludeCaption = true;
                }
                column(Desc_ProdOrderComp; Description)
                {
                    IncludeCaption = true;
                }
                column(Qtyper_ProdOrderComp; Quantity)
                {
                    IncludeCaption = true;
                }
                column(UOMCode_ProdOrderComp; "Unit of Measure Code")
                {
                    IncludeCaption = true;
                }

                column(LocationCode_ProdOrderComp; "Location Code")
                {
                    IncludeCaption = true;
                }
                column(Size; Size)
                { }
                column(Mat_Issue_No; "Daily Consumption Doc. No.")
                { }
                column(Request_Qty; "Request Qty")
                { }
                column(IssueDate; SystemCreatedAt)
                { }

                trigger OnPreDataItem()

                begin
                    SetRange("Document No.", JournalNo);
                    SetRange("Journal Batch Name", JournalBatchFilter);
                    SetRange("Daily Consumption Doc. No.", DocNumber);

                end;

                trigger OnAfterGetRecord()

                begin
                    ProductionLineRec.Reset();
                    ProductionLineRec.SetRange("Prod. Order No.", "Document No.");
                    ProductionLineRec.SetRange("Line No.", "Order Line No.");
                    if ProductionLineRec.FindFirst() then begin
                        ItemCode := ProductionLineRec."Item No.";
                    end;
                    ItemRec.Reset();
                    ItemRec.SetRange("No.", ItemCode);
                    if ItemRec.FindFirst() then begin
                        Size := ItemRec."Size Range No."
                    end;

                end;

            }
            trigger OnAfterGetRecord()
            begin

                comRec.Get;
                comRec.CalcFields(Picture);

                //with ReservationEntry do begin
                ReservationEntry.SetCurrentKey("Source ID", "Source Ref. No.", "Source Type", "Source Subtype");

                ReservationEntry.SetRange(ReservationEntry."Source Type", DATABASE::"Prod. Order Component");
                ReservationEntry.SetRange("Source ID", "Production Order"."No.");
                // SetRange("Source Ref. No.", "Line No.");
                ReservationEntry.SetRange("Source Subtype", Status);
                ReservationEntry.SetRange("Source Batch Name", '');
                // SetRange("Source Prod. Order Line", "Prod. Order Line No.");

                // if FindSet() then begin
                //     RemainingQtyReserved := 0;
                //     repeat
                //         if ReservationEntry2.Get("Entry No.", not Positive) then
                //             if (ReservationEntry2."Source Type" = DATABASE::"Prod. Order Line") and
                //                (ReservationEntry2."Source ID" = "Prod. Order Component"."Prod. Order No.")
                //             then
                //                 RemainingQtyReserved += ReservationEntry2."Quantity (Base)";
                //     until Next() = 0;
                //     if "Prod. Order Component"."Remaining Qty. (Base)" = RemainingQtyReserved then
                //         CurrReport.Skip();
                // end;
                //end;


            end;

            // trigger OnPreDataItem()
            // begin
            //     // SetFilter("Remaining Quantity", '<>0');
            // end;

            trigger OnPreDataItem()
            begin
                ProdOrderFilter := GetFilters;

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
                    field(JournalNo; JournalNo)
                    {
                        ApplicationArea = All;
                        Caption = 'No';
                        TableRelation = "Production Order"."No.";

                    }
                    field(JournalBatchFilter; JournalBatchFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Batch';
                        // TableRelation = "Item Journal Line"."Journal Batch Name";
                        Visible = false;

                    }
                    field(DocNumber; DocNumber)
                    {
                        ApplicationArea = All;
                        Caption = 'Daily Consumption Doc No';
                        // TableRelation = "Item Journal Line"."Journal Batch Name";
                        Visible = false;

                    }

                }
            }
        }
    }
    labels
    {
        ProdOrderCompDueDateCapt = 'Due Date';
    }
    procedure Set_Value(Journal: Code[20])
    var
    begin
        JournalNo := Journal;
    end;

    procedure Set_Batch(JournalBatch: Code[10])
    var
    begin
        JournalBatchFilter := JournalBatch;
    end;

    procedure Set_Doc(DocNo: Code[20])
    var
    begin
        DocNumber := DocNo;
    end;




    var
        DocNumber: Code[20];
        JournalBatchFilter: Code[10];
        Size: Code[20];
        ItemRec: Record Item;
        ItemCode: Code[20];
        ProductionLineRec: Record "Prod. Order Line";
        JournalNo: Code[20];
        ReservationEntry: Record "Reservation Entry";
        ReservationEntry2: Record "Reservation Entry";
        ProdOrderFilter: Text;
        RemainingQtyReserved: Decimal;
        ProdOrderMaterialRqstnCaptLbl: Label 'Prod. Order - Material Requisition';
        CurrReportPageNoCaptLbl: Label 'Page';
        comRec: Record "Company Information";
}
