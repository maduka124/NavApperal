page 51052 "Proforma Invoice Details List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "PI Details Header";
    CardPageId = "PI Details Card";
    SourceTableView = sorting("No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Doc No';
                }

                field("PI No"; rec."PI No")
                {
                    ApplicationArea = All;
                }

                field("PI Date"; rec."PI Date")
                {
                    ApplicationArea = All;
                }

                field("PI Value"; rec."PI Value")
                {
                    ApplicationArea = All;
                }

                field("Supplier Name"; rec."Supplier Name")
                {
                    ApplicationArea = All;
                    Caption = 'Supplier';
                }

                field("Payment Mode Name"; rec."Payment Mode Name")
                {
                    ApplicationArea = All;
                    Caption = 'Payment Mode';
                }

                field("Shipment Date"; rec."Shipment Date")
                {
                    ApplicationArea = All;
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Store Name"; rec."Store Name")
                {
                    ApplicationArea = All;
                    Caption = 'Store';
                }

                field("Season Name"; rec."Season Name")
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
        PIPoDetailsRec.SetRange("PI No.", rec."PI No");
        PIPoDetailsRec.DeleteAll();

        PIPoItemsDetailsRec.SetRange("PI No.", rec."PI No");
        PIPoItemsDetailsRec.DeleteAll();
    end;
}