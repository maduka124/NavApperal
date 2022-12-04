tableextension 50926 "ReservationEntry" extends "Reservation Entry"
{
    fields
    {
        field(50001; "Supplier Batch No."; Code[50])
        {
        }

        field(50002; "Shade No"; Code[20])
        {
            TableRelation = Shade."No.";
        }

        field(50003; "Shade"; Text[20])
        {
        }

        field(50004; "Length Tag"; Decimal)
        {
            InitValue = 0;
        }

        field(50005; "Length Act"; Decimal)
        {
            InitValue = 0;
        }

        field(50006; "Width Tag"; Decimal)
        {
            InitValue = 0;
        }

        field(50007; "Width Act"; Decimal)
        {
            InitValue = 0;
        }

        field(50008; "Selected"; Boolean)
        {

        }

        field(50009; "InvoiceNo"; Code[20])
        {

        }

        field(50010; "Color No"; Code[20])
        {

        }

        field(50011; "Color"; Code[20])
        {

        }
    }
}

