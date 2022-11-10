report 50647 MaterialRequition
{
    RDLCLayout = 'Report_Layouts/Production/MaterialRequition.rdl';
    DefaultLayout = RDLC;
    // ApplicationArea = Manufacturing;
    Caption = 'Material Requisition Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Production Order"; "Production Order")
        {
            DataItemTableView = SORTING(Status, "No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = Status, "No.", "Source Type";
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
                // column(RemainingQty_ProdOrderComp; rema)
                // {
                //     IncludeCaption = true;
                // }
                // column(Scrap_ProdOrderComp; "Scrap %")
                // {
                //     IncludeCaption = true;
                // }
                // column(DueDate_ProdOrderComp; Format("Due Date"))
                // {
                //     IncludeCaption = false;
                // }
                column(LocationCode_ProdOrderComp; "Location Code")
                {
                    IncludeCaption = true;
                }


            }
            trigger OnAfterGetRecord()
            begin

                comRec.Get;
                comRec.CalcFields(Picture);

                with ReservationEntry do begin
                    SetCurrentKey("Source ID", "Source Ref. No.", "Source Type", "Source Subtype");

                    SetRange("Source Type", DATABASE::"Prod. Order Component");
                    SetRange("Source ID", "Production Order"."No.");
                    // SetRange("Source Ref. No.", "Line No.");
                    SetRange("Source Subtype", Status);
                    SetRange("Source Batch Name", '');
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
                end;
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
        ReservationEntry: Record "Reservation Entry";
        ReservationEntry2: Record "Reservation Entry";
        ProdOrderFilter: Text;
        RemainingQtyReserved: Decimal;
        ProdOrderMaterialRqstnCaptLbl: Label 'Prod. Order - Material Requisition';
        CurrReportPageNoCaptLbl: Label 'Page';
        comRec: Record "Company Information";
}
