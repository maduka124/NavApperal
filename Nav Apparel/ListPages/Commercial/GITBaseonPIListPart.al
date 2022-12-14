page 50534 "GIT Based on PI ListPart"
{
    PageType = ListPart;
    SourceTable = GITBaseonPILine;
    DeleteAllowed = false;
    InsertAllowed = false;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field(PINo; PINo)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Main Category Name"; "Main Category Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Main Category';
                }

                field("Item Name"; "Item Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Item';
                }

                field("Unit Name"; "Unit Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Unit';
                }

                field("Req Qty"; "Req Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Currency Name"; "Currency Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Currency';
                }

                field("Unit Price"; "Unit Price")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Total Value"; "Total Value")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("GRN Qty"; "GRN Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Rec. Value"; "Rec. Value")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}