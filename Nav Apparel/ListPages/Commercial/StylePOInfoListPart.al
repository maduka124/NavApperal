page 51211 "Style PO Info ListPart"
{
    PageType = ListPart;
    SourceTable =;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Lot No."; rec."Lot No.")
                {
                    ApplicationArea = All;
                    Caption = 'Lot No';
                }

                field("PO No."; rec."PO No.")
                {
                    ApplicationArea = All;
                    Caption = 'PO No';
                }

                field(Qty; rec.Qty)
                {
                    ApplicationArea = All;
                }

                field(Mode; rec.Mode)
                {
                    ApplicationArea = All;
                }

                field(BPCD; rec.BPCD)
                {
                    ApplicationArea = All;
                }

                field("Ship Date"; rec."Ship Date")
                {
                    ApplicationArea = All;
                }

                field(SID; rec.SID)
                {
                    ApplicationArea = All;
                }

                field("Unit Price"; rec."Unit Price")
                {
                    ApplicationArea = All;
                }

                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                }

                field("Confirm Date"; rec."Confirm Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}