tableextension 51090 "Customer Extension" extends Customer
{
    fields
    {
        field(50001; "Fab Inspection Level"; Decimal)
        {
        }

        field(50002; "Group Id"; Code[20])
        {
            TableRelation = MerchandizingGroupTable."Group Id";
        }
    }

    trigger OnBeforeDelete()
    var
        StyleRec: Record "Style Master";
    begin
        //Check for Exsistance
        StyleRec.Reset();
        StyleRec.SetRange("Buyer No.", "No.");
        if StyleRec.FindSet() then
            Error('Customer : %1 already used in operations. Cannot delete.', Name);
    end;
}

