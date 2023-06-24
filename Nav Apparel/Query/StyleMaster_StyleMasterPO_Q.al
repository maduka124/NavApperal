query 50772 "StyleMaster_StyleMasterPO_Q"
{
    Caption = 'StyleMaster_StyleMasterPO';
    OrderBy = ascending(Style_No, PONo);

    elements
    {
        dataitem(StyleMaster; "Style Master")
        {
            DataItemTableFilter = SMV = filter(> 0);

            column(Select; Select)
            {
            }
            column(No; "No.")
            {
                Caption = 'Style No';
            }
            column(Style_No; "Style No.")
            {
                Caption = 'Style Name';
            }
            column(SMV; SMV)
            {
            }
            column(Buyer_Name; "Buyer Name")
            {
            }
            column(Production_File_Handover_Date; "Production File Handover Date")
            {
            }

            dataitem(StyleMasterPO; "Style Master PO")
            {
                DataItemLink = "Style No." = StyleMaster."No.";
                DataItemTableFilter = PlannedStatus = filter(false), "PO Complete" = filter(false);

                column(Lot_No; "Lot No.")
                {
                }
                column(PONo; "PO No.")
                {
                }
                column(Mode; Mode)
                {
                }
                column(Qty; Qty)
                {
                }
                column(ShipDate; "Ship Date")
                {
                }
                column(SID; SID)
                {
                }
                column(UnitPrice; "Unit Price")
                {
                }
                column(Status; Status)
                {
                }
                column(ConfirmDate; "Confirm Date")
                {
                }
                column(PlannedStatus; PlannedStatus)
                {
                }
                column(BPCD; BPCD)
                {
                }

                column(PlannedQty; PlannedQty)
                {
                }

                column(SawingOutQty; "Sawing Out Qty")
                {
                }

            }
        }
    }

    var
        PO_Qty: BigInteger;

}