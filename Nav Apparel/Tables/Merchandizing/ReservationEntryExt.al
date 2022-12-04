tableextension 50926 "ReservationEntry" extends "Reservation Entry"
{
    fields
    {
        field(71012581; "Supplier Batch No."; Code[50])
        {
        }

        field(71012582; "Shade No"; Code[20])
        {
            TableRelation = Shade."No.";
        }

        field(71012583; "Shade"; Text[20])
        {
        }

        field(71012584; "Length Tag"; Decimal)
        {
            InitValue = 0;
        }

        field(71012585; "Length Act"; Decimal)
        {
            InitValue = 0;
        }

        field(71012586; "Width Tag"; Decimal)
        {
            InitValue = 0;
        }

        field(71012587; "Width Act"; Decimal)
        {
            InitValue = 0;
        }

        field(71012588; "Selected"; Boolean)
        {

        }

        field(71012589; "InvoiceNo"; Code[20])
        {

        }

        field(71012590; "Color No"; Code[20])
        {

        }

        field(71012591; "Color"; Code[20])
        {

        }
    }
}

