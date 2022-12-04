page 50529 "GIT Based on LC ListPart"
{
    PageType = ListPart;
    SourceTable = GITBaseonLCLine;
    DeleteAllowed = false;
    InsertAllowed = false;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(PINo; Rec.PINo)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(PONo; Rec.PONo)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'PO No';
                }

                field("Main Category Name"; Rec."Main Category Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Main Category';
                }

                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Item No';
                }

                field("Item Name"; Rec."Item Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Item';
                }

                field("Unit Name"; Rec."Unit Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Unit';
                }

                field("Req Qty"; Rec."Req Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Currency Name"; Rec."Currency Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Currency';
                }

                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Total Value"; Rec."Total Value")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("GRN Qty"; Rec."GRN Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Rec. Value"; Rec."Rec. Value")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}