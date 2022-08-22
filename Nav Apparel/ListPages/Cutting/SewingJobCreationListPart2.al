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
                field("Lot No."; "Lot No.")
                {
                    ApplicationArea = All;
                    Caption = 'Lot No';
                }

                field("PO No."; "PO No.")
                {
                    ApplicationArea = All;
                    Caption = 'PO No';
                }

                field("Line Name"; "Line Name")
                {
                    ApplicationArea = All;
                    Caption = 'Line';
                }

                field("Start Date"; "Start Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("End Date"; "End Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Allocated Qty"; "Allocated Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Extra Cut %"; "Extra Cut %")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Total Qty"; "Total Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Day Max Target"; "Day Max Target")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}