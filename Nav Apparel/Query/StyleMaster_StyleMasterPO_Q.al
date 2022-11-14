query 50772 "StyleMaster_StyleMasterPO_Q"
{
    Caption = 'StyleMaster_StyleMasterPO';
    OrderBy = ascending(Style_No, PONo);

    elements
    {
        dataitem(StyleMaster; "Style Master")
        {
            DataItemTableFilter = Status = filter(Confirmed), SMV = filter(> 0);

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
            column(BPCD; BPCD)
            {
            }
            column(SMV; SMV)
            {
            }
            column(Buyer_Name; "Buyer Name")
            {
            }

            dataitem(StyleMasterPO; "Style Master PO")
            {
                DataItemLink = "Style No." = StyleMaster."No.";
                DataItemTableFilter = PlannedStatus = filter(false);

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
            }
        }
    }
}