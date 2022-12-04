report 50645 ProductionOrderReport
{

    RDLCLayout = 'Report_Layouts/Production/ProdOrderMatRequisition.rdl';
    DefaultLayout = RDLC;
    ApplicationArea = All;
    // ApplicationArea = Manufacturing;
    Caption = 'Production Order Report';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Production Order"; "Production Order")
        {
            DataItemTableView = SORTING(Status, "No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = Status, "No.", "Source Type", "Source No.";
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
            dataitem("Prod. Order Component"; "Prod. Order Component")
            {
                DataItemLink = Status = FIELD(Status), "Prod. Order No." = FIELD("No.");
                DataItemTableView = SORTING(Status, "Prod. Order No.", "Prod. Order Line No.", "Line No.");
                column(ItemNo_ProdOrderComp; "Item No.")
                {
                    IncludeCaption = true;
                }
                column(Desc_ProdOrderComp; Description)
                {
                    IncludeCaption = true;
                }
                column(Qtyper_ProdOrderComp; "Quantity per")
                {
                    IncludeCaption = true;
                }
                column(UOMCode_ProdOrderComp; "Unit of Measure Code")
                {
                    IncludeCaption = true;
                }
                column(RemainingQty_ProdOrderComp; "Remaining Quantity")
                {
                    IncludeCaption = true;
                }
                column(Scrap_ProdOrderComp; "Scrap %")
                {
                    IncludeCaption = true;
                }
                column(DueDate_ProdOrderComp; Format("Due Date"))
                {
                    IncludeCaption = false;
                }
                column(LocationCode_ProdOrderComp; "Location Code")
                {
                    IncludeCaption = true;
                }
                column(Size; Size)
                { }

                trigger OnAfterGetRecord()
                begin

                    comRec.Get;
                    comRec.CalcFields(Picture);


                    ItemRec.Reset();
                    ItemRec.SetRange("No.", "Item No.");
                    if ItemRec.FindFirst() then begin
                        Size := ItemRec."Size Range No.";
                    end;

                    //with ReservationEntry do begin
                    ReservationEntry.SetCurrentKey("Source ID", "Source Ref. No.", "Source Type", "Source Subtype");

                    ReservationEntry.SetRange("Source Type", DATABASE::"Prod. Order Component");
                    ReservationEntry.SetRange("Source ID", "Production Order"."No.");
                    ReservationEntry.SetRange("Source Ref. No.", "Line No.");
                    ReservationEntry.SetRange("Source Subtype", Status);
                    ReservationEntry.SetRange("Source Batch Name", '');
                    ReservationEntry.SetRange("Source Prod. Order Line", "Prod. Order Line No.");

                    if FindSet() then begin
                        RemainingQtyReserved := 0;
                        repeat
                            if ReservationEntry2.Get(ReservationEntry."Entry No.", not ReservationEntry.Positive) then
                                if (ReservationEntry2."Source Type" = DATABASE::"Prod. Order Line") and
                                   (ReservationEntry2."Source ID" = "Prod. Order Component"."Prod. Order No.")
                                then
                                    RemainingQtyReserved += ReservationEntry2."Quantity (Base)";
                        until Next() = 0;
                        if "Prod. Order Component"."Remaining Qty. (Base)" = RemainingQtyReserved then
                            CurrReport.Skip();
                    end;
                    //end;
                end;

                trigger OnPreDataItem()
                begin
                    SetFilter("Remaining Quantity", '<>0');
                end;
            }

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
        }

        actions
        {
        }
    }

    labels
    {
        ProdOrderCompDueDateCapt = 'Due Date';
    }

    var
        Size: Code[20];
        ItemRec: Record Item;
        ReservationEntry: Record "Reservation Entry";
        ReservationEntry2: Record "Reservation Entry";
        ProdOrderFilter: Text;
        RemainingQtyReserved: Decimal;
        ProdOrderMaterialRqstnCaptLbl: Label 'Prod. Order - Material Requisition';
        CurrReportPageNoCaptLbl: Label 'Page';
        comRec: Record "Company Information";
}
