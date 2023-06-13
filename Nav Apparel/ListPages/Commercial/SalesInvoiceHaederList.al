page 51321 "Sales Invoice Header List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sales Invoice Header";
    Editable = false;
    SourceTableView = where("Export Ref No." = filter(''));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No';

                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ApplicationArea = All;
                    Caption = 'Customer Name';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;

                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;

                }
                field("Order No."; Rec."PO No")
                {
                    ApplicationArea = All;

                }
                field("Your Reference"; Rec."Your Reference")
                {
                    ApplicationArea = All;
                    Caption = 'Factory Inv No';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;

                }
                field("UD No"; Rec."UD No")
                {
                    ApplicationArea = All;

                }
            }
        }
    }



}