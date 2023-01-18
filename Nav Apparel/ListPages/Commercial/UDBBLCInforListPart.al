page 51212 "BBL LC Infor ListPart"
{
    PageType = ListPart;
    SourceTable = UDBBLcInformation;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Issue Bank"; rec."Issue Bank")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(BBLC; Rec.BBLCValue)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'BBLC Value';
                }

                field("Supplier Name"; Rec."Supplier Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("LC Amount"; rec."LC Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Open Date"; rec."Open Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Expice Date"; rec."Expice Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Payment Mode"; rec."Payment Mode")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(UD; rec.UD)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}