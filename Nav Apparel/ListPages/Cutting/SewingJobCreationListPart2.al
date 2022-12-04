page 50590 "Sewing Job Creation ListPart2"
{
    PageType = ListPart;
    AutoSplitKey = true;
    SourceTable = SewingJobCreationLine2;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                    Caption = 'Lot No';
                }

                field("PO No."; Rec."PO No.")
                {
                    ApplicationArea = All;
                    Caption = 'PO No';
                }

                field("Line Name"; Rec."Line Name")
                {
                    ApplicationArea = All;
                    Caption = 'Line';
                }

                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Allocated Qty"; Rec."Allocated Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Extra Cut %"; Rec."Extra Cut %")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Total Qty"; Rec."Total Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Day Max Target"; Rec."Day Max Target")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}