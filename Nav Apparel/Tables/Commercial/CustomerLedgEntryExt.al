tableextension 51202 CustomerLedgEntryExt extends "Cust. Ledger Entry"
{
    fields
    {
        field(50001; "Invoice No"; Code[50])
        {
        }

        field(50002; "BankRefNo"; Code[50])
        {
        }

        field(50003; "Factory Inv. No"; Text[35])
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Header"."Your Reference" where("No." = field("Document No.")));
        }
    }
}

