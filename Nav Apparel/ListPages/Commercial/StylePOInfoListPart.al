page 51211 "Style PO Info ListPart"
{
    PageType = ListPart;
    SourceTable = UDStylePOinformation;
    Editable = false;


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("PO NO"; rec."PO No")
                {
                    ApplicationArea = All;
                    Caption = 'PO No';
                }

                field("Order Qty"; rec."Order Qty")
                {
                    ApplicationArea = All;
                }

                field("Unit Price"; rec."Unit Price")
                {
                    ApplicationArea = All;
                }

                field("Ship Date"; rec."Ship Date")
                {
                    ApplicationArea = All;
                }

                field(Values; rec.Values)
                {
                    ApplicationArea = All;
                    Caption = 'Value';
                }

                field("Ship Qty"; rec."Ship Qty")
                {
                    ApplicationArea = All;
                }

                field("Ship Values"; rec."Ship Values")
                {
                    ApplicationArea = All;
                    Caption = 'Ship Value';
                }
            }
        }
    }
}