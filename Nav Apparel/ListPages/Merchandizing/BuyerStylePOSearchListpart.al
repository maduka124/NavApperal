page 51249 "Buyer Style PO Search Listpart"
{
    PageType = ListPart;
    SourceTable = "Buyer Style PO Search";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("PO No"; Rec."PO No")
                {
                    ApplicationArea = All;
                }

                field(Supplier; Rec.Supplier)
                {
                    ApplicationArea = All;
                }

                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                }

                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }

                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }

                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}