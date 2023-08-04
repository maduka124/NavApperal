pageextension 51382 ProductionOrderListExt extends "Production Order List"
{
    layout
    {
        addafter(Description)
        {
            field(PO; rec.PO)
            {
                ApplicationArea = all;
                Caption = 'PO No';
                Editable = false;
            }
        }
    }
}