page 71012789 "Proforma Invoice Details List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "PI Details Header";
    CardPageId = "PI Details Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Doc No';
                }

                field("PI No"; "PI No")
                {
                    ApplicationArea = All;
                }

                field("PI Date"; "PI Date")
                {
                    ApplicationArea = All;
                }

                field("PI Value"; "PI Value")
                {
                    ApplicationArea = All;
                }

                field("Supplier Name"; "Supplier Name")
                {
                    ApplicationArea = All;
                    Caption = 'Supplier';
                }

                field("Payment Mode Name"; "Payment Mode Name")
                {
                    ApplicationArea = All;
                    Caption = 'Payment Mode';
                }

                field("Shipment Date"; "Shipment Date")
                {
                    ApplicationArea = All;
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Store Name"; "Store Name")
                {
                    ApplicationArea = All;
                    Caption = 'Store';
                }

                field("Season Name"; "Season Name")
                {
                    ApplicationArea = All;
                    Caption = 'Season';
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    var
        PIPoDetailsRec: Record "PI Po Details";
        PIPoItemsDetailsRec: Record "PI Po Item Details";
    begin
        PIPoDetailsRec.SetRange("PI No.", "PI No");
        PIPoDetailsRec.DeleteAll();

        PIPoItemsDetailsRec.SetRange("PI No.", "PI No");
        PIPoItemsDetailsRec.DeleteAll();
    end;
}